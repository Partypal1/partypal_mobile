import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partypal/configs/asset_paths.dart';
import 'package:partypal/configs/route_paths.dart';
import 'package:partypal/configs/router_config.dart';
import 'package:partypal/models/user_model.dart';
import 'package:partypal/providers/auth_provider.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpScreen extends StatefulWidget {
  final UserType userType;
  const SignUpScreen({
    required this.userType,
    super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool passwordVisible = true;
  final _formKey = GlobalKey<FormState>();
  
  String firstName = '';
  String lastName = '';
  String email = '';
  String phoneNumber = '';
  String countryCode = '+234';
  String password = '';

  late FocusNode firstNameFocus;
  late FocusNode lastNameFocus;
  late FocusNode emailFocus;
  late FocusNode phoneNumberFocus;
  late FocusNode passwordFocus;
  late AuthProider auth;

  @override
  void initState(){
    super.initState();
    auth = AuthProider()..addListener(() {
      setState(() {});
    });
    firstNameFocus = FocusNode();
    lastNameFocus = FocusNode();
    emailFocus = FocusNode();
    phoneNumberFocus = FocusNode();
    passwordFocus = FocusNode();
  }

  @override
  void dispose(){
    auth.dispose();
    firstNameFocus.dispose();
    lastNameFocus.dispose();
    emailFocus.dispose();
    phoneNumberFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(0.05.sw),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                0.03.sh.verticalSpace,
          
                Row( // appbar 
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){
                        routerConfig.pop(context);
                      },
                      child: const SizedBox.square(
                        dimension: 40,
                        child: Icon(Icons.arrow_back_ios)
                      )
                    ),
                    const Expanded(child: SizedBox()),
                    Text(
                      'Create your account',
                      style:  Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                  ],
                ),
          
                0.03.sh.verticalSpace,
          
                Row( // go to login
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'have an account?',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    GestureDetector(
                      onTap: (){
                        routerConfig.pushReplacement(RoutePaths.signInScreen, extra: {'userType': widget.userType});
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'login',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary
                          ),
                        ),
                      ),
                    )
                  ],
                ),
          
                0.03.sh.verticalSpace,
          
                AutofillGroup(
                  child: Row( // names
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          child: TextFormField(
                            focusNode: firstNameFocus,
                            autofillHints: const [AutofillHints.givenName],
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              labelText: 'First name',
                              hintText: 'Enter first name',
                              hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: Theme.of(context).textTheme.labelLarge?.color?.withOpacity(0.5)
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)
                              )
                            ),
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return 'First name is required';
                              }
                              firstName = value;                         
                              return null;
                            },
                            onFieldSubmitted: (value){
                              FocusScope.of(context).requestFocus(lastNameFocus);
                            },
                          ),
                        ),
                      ),
                          
                      20.horizontalSpace,
                          
                      Expanded(
                        child: SizedBox(
                          child: TextFormField(
                            focusNode: lastNameFocus,
                            autofillHints: const [AutofillHints.familyName],
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              labelText: 'Last name',
                              hintText: 'Enter last name',
                              hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: Theme.of(context).textTheme.labelLarge?.color?.withOpacity(0.5)
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)
                              )
                            ),
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return 'Last name is required';
                              }
                              lastName = value;      
                              return null;
                            },
                            onFieldSubmitted: (value){
                              FocusScope.of(context).requestFocus(emailFocus);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          
                0.03.sh.verticalSpace,
          
                AutofillGroup(
                  child: TextFormField( // email
                    focusNode: emailFocus,
                    autofillHints: const [AutofillHints.email, AutofillHints.username],
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'example@email.com',
                      hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).textTheme.labelLarge?.color?.withOpacity(0.5)
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      
                    ),
                    validator: (value){
                      String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                      RegExp regex = RegExp(pattern);
                      if (value == null || !regex.hasMatch(value)){
                        return 'Enter a valid email';
                      }
                      email = value;
                      return null;
                    },
                    onFieldSubmitted: (value){
                      FocusScope.of(context).requestFocus(phoneNumberFocus);
                    },
                  ),
                ),
          
                0.03.sh.verticalSpace,
          
                AutofillGroup(
                  child: TextFormField( // phone number
                    focusNode: phoneNumberFocus,
                    autofillHints: const [AutofillHints.telephoneNumber],
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Phone number',
                      hintText: '000-000-0000',
                      hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).textTheme.labelLarge?.color?.withOpacity(0.5)
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      prefixIcon:  CountryCodePicker(
                        initialSelection: 'NG',
                        onChanged: (value){
                          countryCode = value.toString();
                        },
                      ),
                    ),
                    validator: (value){
                      if(value == null || value.length < 4 || value.length > 15 || (int.tryParse(value) == null)){
                        return 'Enter a valid Phone number';
                      }
                      phoneNumber = value;
                      return null;
                    },
                    onFieldSubmitted: (value){
                      FocusScope.of(context).requestFocus(passwordFocus);
                    },
                  ),
                ),
          
                0.03.sh.verticalSpace,
          
                AutofillGroup(
                  child: TextFormField( // password
                    focusNode: passwordFocus,
                    autocorrect: false,
                    autofillHints: const [AutofillHints.password],
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: passwordVisible,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'At least 8 characters',
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
                      if(value == null || value.length < 8){
                        return 'password should be 8 characters or more';
                      }
                      password = value;
                      return null;
                    },
                    onFieldSubmitted: (value){
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                  ),
                ),

                0.05.sh.verticalSpace,

                SizedBox( // sign up button
                  height: 60,
                  child: InkWell(
                    onTap: _signUp,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Theme.of(context).colorScheme.onSurface
                      ),
                      child: Center(
                        child: Text(
                          'Sign up',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Theme.of(context).colorScheme.surface
                          )
                        ),
                      ),
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

                InkWell( // sign up with google
                  onTap: (){
                    // TODO: sign up with google
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
                                'Sign up with google',
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
          )
        )
      ),
    );
  }
  void _signUp(){
    log('signing up ...');
    if(_formKey.currentState!.validate()){
      //TODO: implement sign up
      log(firstName);
      log(lastName);
      log(email);
      log(countryCode + phoneNumber);
      log(password);
      log(widget.userType.name);
      routerConfig.push(RoutePaths.verificationScreen, extra: {'email': email});
    }
  }
}