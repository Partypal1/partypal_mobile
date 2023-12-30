
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:partypal/configs/route_paths.dart';
import 'package:partypal/models/user_model.dart';
import 'package:partypal/screens/authentication/reset_password_screen.dart';
import 'package:partypal/screens/authentication/select_user_profile_screen.dart';
import 'package:partypal/screens/authentication/sign_in_screen.dart';
import 'package:partypal/screens/authentication/sign_up_screen.dart';
import 'package:partypal/screens/authentication/verification_screen.dart';
import 'package:partypal/screens/onboarding/onboarding_screen.dart';
import 'package:partypal/screens/splash_screen.dart';

final GoRouter routerConfig = GoRouter( // TODO: add routing animations
  initialLocation: RoutePaths.splashScreen,
  errorBuilder: (context, state) => const ErrorBuilder(),
  routes: [
    GoRoute(
      path: RoutePaths.splashScreen,
      pageBuilder: (context, state) => CupertinoPage<void>(
        child: const SplashScreen(),
        key: state.pageKey,
      ),
    ),

    GoRoute(
      path: RoutePaths.onboaringScreen,
      pageBuilder: (context, state) => CupertinoPage<void>(
        child: const OnboaringScreen(),
        key: state.pageKey,
      ),
    ),

    GoRoute(
      path: RoutePaths.selectUserProfileScreen,
      pageBuilder: (context, state) => CupertinoPage<void>(
        child: const SelectUserProfileScreen(),
        key: state.pageKey,
      ),
    ),

    GoRoute(
      path: RoutePaths.signInScreen,
      pageBuilder: (context, state){
        if(state.extra != null){
          Map<String, dynamic> args = state.extra as Map<String, dynamic>;
          return CupertinoPage<void>(
            child: SignInScreen(
              userType: args['userType'] ?? UserType.user,
            ),
            key: state.pageKey,
          );
        }
        return CupertinoPage<void>(
          child: const ErrorBuilder(),
          key: state.pageKey
        );
      }
    ),
    
    GoRoute(
      path: RoutePaths.signUpScreen,
      pageBuilder: (context, state){
        if(state.extra != null){
          Map<String, dynamic> args = state.extra as Map<String, dynamic>;
          return CupertinoPage<void>(
            child: SignUpScreen(
              userType: args['userType'] ?? UserType.user,
            ),
            key: state.pageKey,
          );
        }
        return CupertinoPage<void>(
          child: const ErrorBuilder(),
          key: state.pageKey
        );
      }
    ),

    GoRoute(
      path: RoutePaths.verificationScreen,
      pageBuilder: (context, state){
        if (state.extra!=null){
          Map<String, dynamic> args = state.extra as Map<String, dynamic>;
          return CupertinoPage<void>(
            child: VerificationScreen(
              email: args['email'] ?? '',
            ),
            key: state.pageKey,
          );
        }
        return CupertinoPage<void>(
          child: const ErrorBuilder(),
          key: state.pageKey
        );
      }
    ),

    GoRoute(
      path: RoutePaths.forgotPasswordScreen,
      pageBuilder: (context, state) => CupertinoPage<void>(
        child: const ResetPasswordScreen(),
        key: state.pageKey,
      ),
    ),
  ]
);

class ErrorBuilder extends StatelessWidget {
  const ErrorBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Navigation error has occoured',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Theme.of(context).colorScheme.error
          ),
        ),
      ),
    );
  }
}