import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:partypal/constants/route_paths.dart';
import 'package:partypal/network/network.dart';
import 'package:partypal/services/auth_provider.dart';
import 'package:partypal/services/session_manager.dart';
import 'package:partypal/utils/router_util.dart';
import 'package:partypal/widgets/app_bars/app_bar.dart';
import 'package:partypal/widgets/buttons/outlined_button.dart';
import 'package:partypal/widgets/buttons/wide_button.dart';
import 'package:partypal/widgets/others/tonal_elevation.dart';
import 'package:provider/provider.dart';

class VerificationScreen extends StatefulWidget {
  final String email;
  final String password;
  const VerificationScreen({
    required this.email,
    required this.password,
    super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  int numDigits = 5;
  bool codeIsValid = false;
  bool _isVerifying = false;
  bool _isResendingOTP = false;
  Duration countdownDuration = const Duration(minutes: 1);
  late List<FocusNode> digitNodes;
  late List<TextEditingController> digitControllers;
  late Timer resendTimer;
  late Stopwatch resendStopwatch;

  @override
  void initState(){
    super.initState();
    digitNodes = List.generate(numDigits, (index) => FocusNode());
    digitControllers = List.generate(numDigits, (index) => TextEditingController());
    for (var cnt in digitControllers){
      cnt.addListener(() {
        setState(() {
          String code = '';
          for(var cnt in digitControllers){
            code += cnt.text;
          }
          code = code.trim();
          codeIsValid = (code.length == numDigits) && (int.tryParse(code) != null);
        });
      });
    }
    resendStopwatch = Stopwatch() .. start();
    resendTimer = Timer.periodic(
      const Duration(seconds:1),
      (t) {
        if(resendStopwatch.elapsed >= countdownDuration){
          resendStopwatch.stop();
          t.cancel();
        }
        setState(() {});
      }
    );
  }

  @override
  void dispose(){
    digitNodes.map((e) => e.dispose());
    digitControllers.map((e) => e.dispose());
    resendTimer.cancel();
    resendStopwatch.stop();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface.tonalElevation(Elevation.level0, context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomAppBar(title: 'Verification'),
            Padding(
              padding: EdgeInsets.all(0.03.sw),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [           
                  Text(
                    "We've emailed you a \n$numDigits-digit code",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                  ),
              
                  0.03.sh.verticalSpace,
              
                  Text(
                    "please check ${widget.email} and enter the otp code here",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 20
                    ),
                    textAlign: TextAlign.center,
                  ),
              
                  0.03.sh.verticalSpace,
              
                  Row( // code input
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(numDigits, (index){
                      return DigitBox(
                        focusNode: digitNodes[index],
                        controller: digitControllers[index],
                        previousNode: (index > 0) ? digitNodes[index-1] : null,
                        nextNode: (index < numDigits - 1) ? digitNodes[index+1] : null,
                        previousController: (index > 0) ? digitControllers[index-1] : null,
                      );
                    }),
                  ),
              
                  0.05.sh.verticalSpace,
                  
                  _isVerifying
                  ? const SizedBox.square(
                      dimension: 40,
                      child: CircularProgressIndicator(),
                    )
                  : WideButton(
                      label: 'Verify account',
                      onTap: _verifyCode,
                      backgroundColor: codeIsValid
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.inverseSurface.withOpacity(0.6),
                      labelColor: codeIsValid
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onInverseSurface,
                    ),
            
                  0.03.sh.verticalSpace,
                  
                  _isVerifying
                  ? const SizedBox.shrink()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        resendStopwatch.isRunning
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('Resend code in'),
                                5.horizontalSpace,
                                Text( // minutes
                                  (countdownDuration - resendStopwatch.elapsed).inMinutes.toString().padLeft(2, '0'),
                                  style: Theme.of(context).textTheme.labelLarge,  
                                ),
                                Text(':', style: Theme.of(context).textTheme.labelLarge),
                                Text( // seconds
                                  ((countdownDuration - resendStopwatch.elapsed).inSeconds % 60).toString().padLeft(2, '0'),
                                  style: Theme.of(context).textTheme.labelLarge,  
                                ),
                              ],
                            )
                          
                          : CustomOutlinedButton(
                              label: 'Resend code',
                              onTap: _resendCode,
                            )
                      ],
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _verifyCode() async {
    if(codeIsValid){
      setState(() => _isVerifying = true);
      String otp = '';
      for (var cnt in digitControllers){
        otp += cnt.text;
      }
      AuthProider auth = Provider.of<AuthProider>(context, listen: false);
      NetworkResponse response = await auth.verifyOTP(
        email: widget.email,
        otp: otp,
        purpose: VerificationPurpose.registration
      );
      setState(() => _isVerifying = false);
      if(response.successful){
        _saveTokens(response);
        if(mounted){
          GoRouter.of(context).clearStackAndNavigate(RoutePaths.welcomeScreen);
        }
      }
    }
  }

  void _saveTokens(NetworkResponse response) async{
    SessionManager sessionManager = Provider.of<SessionManager>(context, listen: false);
    sessionManager.setAccessToken(response.body!['data']['accessToken']);
    sessionManager.setRefreshToken(response.body!['data']['refreshToken']);
  }

  void _resendCode() async {
    if(_isResendingOTP){ return; }
    _isResendingOTP = true;
    AuthProider auth = Provider.of<AuthProider>(context, listen: false);
    NetworkResponse response = await auth.resendOTP(
      email: widget.email,
      purpose: VerificationPurpose.registration
    );
    _isResendingOTP = false;
    if(response.successful){
      resendStopwatch.reset();
      resendStopwatch.start();
      resendTimer = Timer.periodic(
        const Duration(seconds:1),
        (t) {
          if(resendStopwatch.elapsed >= countdownDuration){
            resendStopwatch.stop();
            t.cancel();
          }
          setState(() {});
        }
      );
      for(var cnt in digitControllers){
        cnt.text = '';
      }
      setState(() { });
    }
  }
}

class DigitBox extends StatefulWidget {
  final FocusNode focusNode;
  final FocusNode? previousNode;
  final FocusNode? nextNode;
  final TextEditingController controller;
  final TextEditingController? previousController;
  const DigitBox({
    required this.focusNode,
    this.previousNode,
    this.nextNode,
    required this.controller,
    this.previousController,
    super.key});

  @override
  State<DigitBox> createState() => _DigitBoxState();
}

class _DigitBoxState extends State<DigitBox> {

  @override
  void initState(){
    super.initState();
    widget.focusNode.onKeyEvent = (node, event){
      if(HardwareKeyboard.instance.isLogicalKeyPressed(LogicalKeyboardKey.backspace)){
        if(widget.controller.text.isEmpty){
          widget.previousNode?.requestFocus();
          widget.previousController?.text = '';
        }
        else {
          widget.controller.text = '';
        }
        return KeyEventResult.handled;
      }
      return KeyEventResult.ignored;
    };
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        widget.focusNode.requestFocus();
      },
      child: SizedBox(
        width: 40,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: widget.focusNode.hasFocus ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.outline,
              width: widget.focusNode.hasFocus ? 3 : 1,
            ),
            borderRadius: BorderRadius.circular(5)
          ),
          child: TextField(
            focusNode: widget.focusNode,
            controller: widget.controller,
            maxLength: 1,
            buildCounter: (context, {required currentLength, required isFocused, maxLength}) => const SizedBox.shrink(),
            textAlign: TextAlign.center,
            showCursor: false,
            onChanged: (value){
              if(int.tryParse(widget.controller.text) == null){
                widget.controller.text = ''; // removes any text that is not an integer
              }
              else if(widget.nextNode != null && widget.controller.text.isNotEmpty){
                widget.nextNode?.requestFocus(); // shifts focus to the next node
              }
              else{
                FocusScope.of(context).requestFocus(FocusNode()); // collapses keyboard after the last node
              }

            },
            decoration: const InputDecoration(
              border: InputBorder.none
            ),
            keyboardType: TextInputType.number
          ),
        )
      ),
    );
  }
}