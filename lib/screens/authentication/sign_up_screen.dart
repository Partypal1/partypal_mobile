import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:partypal/constants/route_paths.dart';
import 'package:partypal/models/user_model.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:partypal/services/auth_service.dart';
import 'package:partypal/services/profile_service.dart';
import 'package:partypal/utils/router_util.dart';
import 'package:partypal/widgets/app_bars/app_bar.dart';
import 'package:partypal/widgets/buttons/google_sign_in_button.dart';
import 'package:partypal/widgets/buttons/wide_button.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  final Role role;
  const SignUpScreen({
    required this.role,
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

  bool _isSigningUp = false;

  late FocusNode firstNameFocus;
  late FocusNode lastNameFocus;
  late FocusNode emailFocus;
  late FocusNode phoneNumberFocus;
  late FocusNode passwordFocus;

  @override
  void initState(){
    super.initState();
    firstNameFocus = FocusNode();
    lastNameFocus = FocusNode();
    emailFocus = FocusNode();
    phoneNumberFocus = FocusNode();
    passwordFocus = FocusNode();
  }

  @override
  void dispose(){
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
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomAppBar(title: 'Create your account'),
            Padding(
              padding: EdgeInsets.all(0.05.sw),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [              
                    Row( // go to login
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'have an account?',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        GestureDetector(
                          onTap: (){
                            GoRouter.of(context).pushReplacement(
                              RoutePaths.signInScreen,
                              extra: {'role': widget.role}
                            );
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
                          String pattern = r"""(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])""";
                          
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

                    _isSigningUp
                    ? const SizedBox.square(
                      dimension: 40,
                      child: CircularProgressIndicator(),
                    )
                    : WideButton(
                      label: 'Sign up',
                      onTap: _signUp,
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
            
                    const GoogleSignInButton()
                  ],
                )
              )
            ),
          ],
        ),
      ),
    );
  }
  void _signUp() async {
    AuthService auth = Provider.of<AuthService>(context, listen: false);
    ProfileService profile = Provider.of<ProfileService>(context, listen: false);
    FocusScope.of(context).requestFocus(FocusNode());
    if(_formKey.currentState!.validate()){
      setState(() {_isSigningUp = true;});
      bool successful = await auth.createAccountWithEmailAndPassword(email, password);
      setState(() {_isSigningUp = false;});
 
      if(successful){
        await profile.updateProfile(
          firstName: firstName,
          lastName: lastName,
          phoneNumber: phoneNumber,
          email: email,
          role: widget.role,
        );
        if(mounted){
          GoRouter.of(context).clearStackAndNavigate(RoutePaths.welcomeScreen);
        }
      }
    }
  }
}