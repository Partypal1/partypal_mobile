import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partypal/widgets/app_bar.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  String email = '';
  bool passwordVisible = false;
  bool confirmPasswordVisible = false;
  final formKey = GlobalKey<FormState>();
  late FocusNode passwordNode;
  late FocusNode confirmPasswordNode;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  @override
  void initState(){
    super.initState();
    passwordNode = FocusNode();
    confirmPasswordNode = FocusNode();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose(){
    passwordNode.dispose();
    confirmPasswordNode.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(delegate: SliverCustomAppBarDelegate(title: 'Set password')),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(0.03.sw),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField( // password
                      focusNode: passwordNode,
                      controller: passwordController,
                      autocorrect: false,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !passwordVisible,
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
                            !passwordVisible
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
                        return null;
                      },
                      onFieldSubmitted: (value){
                        FocusScope.of(context).requestFocus(confirmPasswordNode);
                      },
                    ),

                    0.03.sh.verticalSpace,

                    TextFormField( // confirm password
                      focusNode: confirmPasswordNode,
                      controller: confirmPasswordController,
                      autocorrect: false,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !confirmPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Confirm password',
                        hintText: 'Retype your password',
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              confirmPasswordVisible = !confirmPasswordVisible;
                            });
                          },
                          child: Icon(
                            !confirmPasswordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                        )
                      ),
                      validator: (value){
                        if(value != passwordController.text){
                          return "The passwords don't match";
                        }
                        return null;
                      },
                      onFieldSubmitted: (value){
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                    ),
                    0.05.sh.verticalSpace,
                    SizedBox( // done button
                      height: 60,
                      child: GestureDetector(
                        onTap: _setPassword,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Theme.of(context).colorScheme.onSurface
                          ),
                          child: Center(
                            child: Text(
                              'Done',
                              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: Theme.of(context).colorScheme.surface
                              )
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  void _setPassword(){
    if(formKey.currentState!.validate()){
      FocusScope.of(context).requestFocus(FocusNode());
      log('resetting password');
      // TODO: reset password
    }
  }
}