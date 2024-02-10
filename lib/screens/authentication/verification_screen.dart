import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partypal/configs/router_config.dart';
import 'package:partypal/constants/route_paths.dart';
import 'package:partypal/widgets/app_bar.dart';
import 'package:partypal/widgets/tonal_elevation.dart';

class VerificationScreen extends StatefulWidget {
  final String email;
  const VerificationScreen({
    required this.email,
    super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  int numDigits = 5;
  bool codeIsValid = false;
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
              
                  SizedBox( // verify button
                    height: 60,
                    child: GestureDetector(
                      onTap: _verifyCode,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: codeIsValid
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.onSurface.withOpacity(0.7)
                        ),
                        child: Center(
                          child: Text(
                            'Verify account',
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Theme.of(context).colorScheme.surface
                            )
                          ),
                        ),
                      ),
                    ),
                  ),
            
                  0.03.sh.verticalSpace,
                  
                  Row(
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
                        
                        : FittedBox( // resend button
                          child: SizedBox( 
                            height: 40,
                            child: GestureDetector(
                              onTap: _resendCode,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Theme.of(context).colorScheme.outline
                                  ),
                                  
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 24),
                                  child: Center(
                                    child: Text(
                                      'Resend code',
                                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                        color: Theme.of(context).colorScheme.onSurface
                                      )
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
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

  void _verifyCode(){
    if(codeIsValid){
      //TODO: verify then navigate
      log('verified');
      routerConfig.push(RoutePaths.welcomeScreen);    
    }
  }
  void _resendCode(){
    log('resending code');
    //TODO: resend code
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
    widget.focusNode.onKey = (node, event){
      if(event.isKeyPressed(LogicalKeyboardKey.backspace)){
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