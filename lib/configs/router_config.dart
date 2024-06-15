
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:partypal/constants/route_paths.dart';
import 'package:partypal/models/user_model.dart';
import 'package:partypal/screens/authentication/reset_password_screen.dart';
import 'package:partypal/screens/authentication/select_user_profile_screen.dart';
import 'package:partypal/screens/authentication/set_password_screen.dart';
import 'package:partypal/screens/authentication/sign_in_screen.dart';
import 'package:partypal/screens/authentication/sign_up_screen.dart';
import 'package:partypal/screens/home/category_screen.dart';
import 'package:partypal/screens/home/dress_code_screen.dart';
import 'package:partypal/screens/home/edit_profile_screen.dart';
import 'package:partypal/screens/home/event_screen.dart';
import 'package:partypal/screens/home/home.dart';
import 'package:partypal/screens/home/message_screen.dart';
import 'package:partypal/screens/home/notification_screen.dart';
import 'package:partypal/screens/home/place_screen.dart';
import 'package:partypal/screens/home/settings_screen.dart';
import 'package:partypal/screens/home/ticket_screen.dart';
import 'package:partypal/screens/onboarding/onboarding_screen.dart';
import 'package:partypal/screens/profile_setup/choose_favourite_clubs_screen.dart';
import 'package:partypal/screens/profile_setup/set_profile_screen.dart';
import 'package:partypal/screens/profile_setup/welcome_screen.dart';
import 'package:partypal/screens/splash_screen.dart';

final GoRouter routerConfig = GoRouter( // TODO: add routing animations
  initialLocation: RoutePaths.splashScreen,
  errorBuilder: (context, state) => const ErrorBuilder(),
  routes: [
    GoRoute(
      path: RoutePaths.splashScreen,
      pageBuilder: (context, state) => CupertinoPage(
        child: const SplashScreen(),
        key: state.pageKey,
      ),
    ),

    GoRoute(
      path: RoutePaths.onboaringScreen,
      pageBuilder: (context, state) => CupertinoPage(
        child: const OnboaringScreen(),
        key: state.pageKey,
      ),
    ),

    GoRoute(
      path: RoutePaths.selectUserProfileScreen,
      pageBuilder: (context, state) => CupertinoPage(
        child: const SelectUserProfileScreen(),
        key: state.pageKey,
      ),
    ),

    GoRoute(
      path: RoutePaths.signInScreen,
      pageBuilder: (context, state){
        if(state.extra != null){
          Map<String, dynamic> args = state.extra as Map<String, dynamic>;
          return CupertinoPage(
            child: SignInScreen(
              role: args['role'] ?? Role.user,
            ),
            key: state.pageKey,
          );
        }
        return CupertinoPage(
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
          return CupertinoPage(
            child: SignUpScreen(
              role: args['role'] ?? Role.user,
            ),
            key: state.pageKey,
          );
        }
        return CupertinoPage(
          child: const ErrorBuilder(),
          key: state.pageKey
        );
      }
    ),

    GoRoute(
      path: RoutePaths.resetPasswordScreen,
      pageBuilder: (context, state) => CupertinoPage(
        child: const ResetPasswordScreen(),
        key: state.pageKey,
      ),
    ),

    GoRoute(
      path: RoutePaths.setPasswordScreen,
      pageBuilder: (context, state) => CupertinoPage(
        child: const SetPasswordScreen(),
        key: state.pageKey,
      ),
    ),

    GoRoute(
      path: RoutePaths.welcomeScreen,
      pageBuilder: (context, state) => CupertinoPage(
        child: const WelcomeScreen(),
        key: state.pageKey,
      ),
    ),

    GoRoute(
      path: RoutePaths.chooseFavouriteClubsScreen,
      pageBuilder: (context, state) => CupertinoPage(
        child: const ChooseFavouriteClubs(),
        key: state.pageKey,
      ),
    ),

    GoRoute(
      path: RoutePaths.setProfileScreen,
      pageBuilder: (context, state) => CupertinoPage(
        child: const SetProfileScreen(),
        key: state.pageKey,
      ),
    ),

    GoRoute(
      path: RoutePaths.home,
      pageBuilder: ((context, state) {
        return CustomTransitionPage(
          child: const Home(),
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, _, child){
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          }
        );
      })
    ),

    GoRoute(
      path: RoutePaths.editProfileScreen,
      pageBuilder: (context, state) => CupertinoPage(
        child: const EditProfileScreen(),
        key: state.pageKey,
      ),
    ),

    GoRoute(
      path: RoutePaths.settingsScreen,
      pageBuilder: (context, state) => CupertinoPage(
        child: const SettingsScreen(),
        key: state.pageKey,
      ),
    ),

   GoRoute(
      path: RoutePaths.categoryScreen,
      pageBuilder: (context, state){
        if (state.extra!=null){
          Map<String, dynamic> args = state.extra as Map<String, dynamic>;
          return CustomTransitionPage(
            key: state.pageKey,
            child: CategoryScreen(
              categoryName: args['categoryName'],
            ),
            transitionsBuilder: (context, animation, _, child){
              return SlideTransition(
                position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(animation),
                child: child,
              );    
            }
          );
        }
        return CupertinoPage(
          child: const ErrorBuilder(),
          key: state.pageKey
        );
      }
    ),

   GoRoute(
      path: RoutePaths.placeScreen,
      pageBuilder: (context, state){
        if (state.extra!=null){
          Map<String, dynamic> args = state.extra as Map<String, dynamic>;
          return CustomTransitionPage(
            key: state.pageKey,
            child: PlaceScreen(
              place: args['place'],
            ),
            transitionsBuilder: (context, animation, _, child){
              return SlideTransition(
                position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(animation),
                child: child,
              );    
            }
          );
        }
        return CupertinoPage(
          child: const ErrorBuilder(),
          key: state.pageKey
        );
      }
    ),

   GoRoute(
      path: RoutePaths.eventScreen,
      pageBuilder: (context, state){
        if (state.extra!=null){
          Map<String, dynamic> args = state.extra as Map<String, dynamic>;
          return CustomTransitionPage(
            key: state.pageKey,
            child: EventScreen(
              event: args['event'],
            ),
            transitionsBuilder: (context, animation, _, child){
              return SlideTransition(
                position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(animation),
                child: child,
              );    
            }
          );
        }
        return CupertinoPage(
          child: const ErrorBuilder(),
          key: state.pageKey
        );
      }
    ),

   GoRoute(
      path: RoutePaths.ticketScreen,
      pageBuilder: (context, state){
        if (state.extra!=null){
          Map<String, dynamic> args = state.extra as Map<String, dynamic>;
          return CustomTransitionPage(
            key: state.pageKey,
            child: TicketScreen(
              event: args['event'],
            ),
            transitionsBuilder: (context, animation, _, child){
              return SlideTransition(
                position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(animation),
                child: child,
              );    
            }
          );
        }
        return CupertinoPage(
          child: const ErrorBuilder(),
          key: state.pageKey
        );
      }
    ),

   GoRoute(
      path: RoutePaths.dressCodeScreen,
      pageBuilder: (context, state){
        if (state.extra!=null){
          Map<String, dynamic> args = state.extra as Map<String, dynamic>;
          return CustomTransitionPage(
            key: state.pageKey,
            child: DressCodeScreen(
              event: args['event'],
            ),
            transitionsBuilder: (context, animation, _, child){
              return SlideTransition(
                position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(animation),
                child: child,
              );    
            }
          );
        }
        return CupertinoPage(
          child: const ErrorBuilder(),
          key: state.pageKey
        );
      }
    ),

    GoRoute(
      path: RoutePaths.notificationScreen,
      pageBuilder: ((context, state) {
        return CustomTransitionPage(
          child: const NotificationScreen(),
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, _, child){
            return SlideTransition(
              position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(animation),
              child: child,
            );  
          }
        );
      })
    ),
    GoRoute(
      path: RoutePaths.messageScreen,
      pageBuilder: ((context, state) {
        return CustomTransitionPage(
          child: const MessageScreen(),
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, _, child){
            return SlideTransition(
              position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(animation),
              child: child,
            );  
          }
        );
      })
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