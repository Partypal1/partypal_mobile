import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:partypal/constants/asset_paths.dart';
import 'package:partypal/constants/route_paths.dart';
import 'package:partypal/configs/router_config.dart';
import 'package:partypal/models/user_model.dart';
import 'package:partypal/network/network.dart';
import 'package:partypal/services/auth_provider.dart';
import 'package:partypal/services/session_manager.dart';
import 'package:partypal/widgets/app_bars/app_bar.dart';
import 'package:partypal/widgets/buttons/wide_button.dart';
import 'package:provider/provider.dart';

import '../../widgets/others/tonal_elevation.dart';

class SignInScreen extends StatefulWidget {
  final UserType userType;
  const SignInScreen({
    required this.userType,
    super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String email = '';
  String password = '';
  bool passwordVisible = false;
  bool _isSigningIn = false;
  final _formKey = GlobalKey<FormState>();

  late FocusNode emailFocus = FocusNode();
  late FocusNode passwordFocus = FocusNode();
  late AuthProider auth;

  @override
  void initState(){
    super.initState();
    auth = AuthProider()..addListener(() {
      setState(() {});
    });
    emailFocus = FocusNode();
    passwordFocus = FocusNode();
  }

  @override
  void dispose(){
    auth.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface.tonalElevation(Elevation.level0, context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomAppBar(title: 'Sign in'),
            Padding(
              padding: EdgeInsets.all(0.05.sw),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox.square(
                          dimension: 40,
                          child: Image.asset(AssetPaths.logoImage),
                        ),
                        10.horizontalSpace,
                        Text(
                          'Partypal',
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface
                          ),
                        )
                      ],
                    ),
                    
                    0.01.sh.verticalSpace,
            
                    Text(
                      'Hey pal! Welcome Back.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary
                      ),
                    ),
            
                    0.05.sh.verticalSpace,
            
                    AutofillGroup(
                      child: TextFormField( // email
                        focusNode: emailFocus,
                        autofillHints: const [AutofillHints.email, AutofillHints.username],
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter your email',
                          hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Theme.of(context).textTheme.labelLarge?.color?.withOpacity(0.5)
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)
                          ),
                          
                        ),
                        validator: (value){
                    
                          if (value == null || value.isEmpty){
                            return 'Email is required';
                          }
                          email = value;
                          return null;
                        },
                        onFieldSubmitted: (value){
                          FocusScope.of(context).requestFocus(passwordFocus);
                        },
                      ),
                    ),
            
                    0.02.sh.verticalSpace,
            
                    AutofillGroup(
                      child: TextFormField( // password
                        focusNode: passwordFocus,
                        autocorrect: false,
                        autofillHints: const [AutofillHints.password],
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: passwordVisible,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                            child: Icon(
                              passwordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)
                          )
                        ),
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return 'Password is required';
                          }
                          password = value;
                          return null;
                        },
                        onFieldSubmitted: (value){
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                      ),
                    ),
            
                    0.03.sh.verticalSpace,

                    _isSigningIn
                    ? const SizedBox.square(
                        dimension: 40,
                        child: CircularProgressIndicator(),
                      )
                    : WideButton(
                        label: 'Sign in',
                        onTap: _signIn,
                      ),

                    0.03.sh.verticalSpace,
            
                    Row( // go to login
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'No account?',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        GestureDetector(
                          onTap: (){
                            routerConfig.pushReplacement(RoutePaths.signUpScreen, extra: {'userType': widget.userType});
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'sign up',
                              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: Theme.of(context).colorScheme.primary
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    0.01.sh.verticalSpace,
                    GestureDetector(
                      onTap: (){
                        routerConfig.push(RoutePaths.resetPasswordScreen);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'forgot your password?',
                          style: Theme.of(context).textTheme.labelLarge
                        ),
                      ),
                    ),
            
                    0.03.sh.verticalSpace,
            
                    const Row( // or
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('or'),
                        ),
                        Expanded(child: Divider())
                      ],
                    ),
            
                    0.03.sh.verticalSpace,
            
                    GestureDetector( // sign in with google
                      onTap: () {
                        //TODO: sign in with google
                      },
                      child: FittedBox( 
                        child: SizedBox(
                          height: 50,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 16,
                                right: 24
                              ),
                              child: Row(
                                children: [
                                  SizedBox.square(
                                    dimension: 24,
                                    child: SvgPicture.asset(AssetPaths.googleIcon)
                                  ),
                                  8.horizontalSpace,
                                  Text(
                                    'Sign in with google',
                                    style: Theme.of(context).textTheme.labelLarge,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
  void _signIn() async {
    FocusScope.of(context).requestFocus(FocusNode());
    if(_formKey.currentState!.validate()){
      setState(() => _isSigningIn = true);
      AuthProider auth = Provider.of<AuthProider>(context, listen: false);
      NetworkResponse response = await auth.signIn(
        email: email, 
        password: password
      );
      setState(() => _isSigningIn = false);
      if(response.successful){
        _saveTokens(response);
        routerConfig.push(RoutePaths.welcomeScreen);
      }
      else if(response.body?['data']['message'].toString().contains('not verified') ?? false){ // user not verified
        routerConfig.push(RoutePaths.verificationScreen, extra: {'email': email, 'password': password});
        auth.resendOTP(email: email, purpose: VerificationPurpose.registration);
      }
    }
  }

  void _saveTokens(NetworkResponse response) async{
    SessionManager sessionManager = Provider.of<SessionManager>(context, listen: false);
    sessionManager.setAccessToken(response.body!['data']['accessToken']);
    sessionManager.setRefreshToken(response.body!['data']['refreshToken']);
  }
}