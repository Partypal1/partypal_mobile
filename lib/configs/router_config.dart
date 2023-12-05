
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:partypal/configs/route_paths.dart';
import 'package:partypal/screens/splash_screen.dart';

final GoRouter routerConfig = GoRouter(
  initialLocation: RoutePaths.splashScreen,
  errorBuilder: (context, state) => const Placeholder(),
  routes: [
    GoRoute(
      path: RoutePaths.splashScreen,
      pageBuilder: (context, state) => CupertinoPage<void>(
        child: const SplashScreen(),
        key: state.pageKey,
      ),
    ),
  ]
);