import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:partypal/constants/asset_paths.dart';
import 'package:partypal/constants/route_paths.dart';
import 'package:partypal/services/auth_service.dart';
import 'package:partypal/services/profile_service.dart';
import 'package:provider/provider.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () {
        Provider.of<AuthService>(context, listen: false).googleSignIn().then((signedIn) async {
          if (signedIn) {
            if (await Provider.of<ProfileService>(context).hasProfile && context.mounted) {
              context.pushReplacement(RoutePaths.home);
              log('signed in');
            } else if (context.mounted) {
              context.pushReplacement(RoutePaths.welcomeScreen);
            }
          }
        });
      },
      child: SizedBox(
        height: 40,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            border: Border.all(
              color: Theme.of(context).colorScheme.outline
            ),
            borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 24),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox.square(
                  dimension: 18,
                  child: SvgPicture.asset(AssetPaths.googleIcon)
                ),
                8.horizontalSpace,
                Text(
                  'sign in with google',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}