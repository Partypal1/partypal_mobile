import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partypal/constants/asset_paths.dart';
import 'package:partypal/widgets/app_bars/app_bar.dart';
import 'package:partypal/widgets/cards/moment_card.dart';
import 'package:partypal/widgets/others/tonal_elevation.dart';

class MomentsScreen extends StatelessWidget {
  const MomentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface.tonalElevation(Elevation.level1, context),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: SliverCustomAppBarDelegate(title: 'Moments', hasBackButton: false)
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                MomentCard(
                  username: 'Feyi',
                  profilePicturePath: AssetPaths.onboardingBackgroundImage1,
                  timeStamp: DateTime.now().subtract(const Duration(seconds: 2)),
                  imagePaths: [
                    AssetPaths.onboardingBackgroundImage1,
                    AssetPaths.onboardingBackgroundImage2,
                    AssetPaths.onboardingBackgroundImage3
                  ],
                  caption: 'Hello world',
                ),
                50.verticalSpace,
                MomentCard(
                  username: 'Sunkanmi',
                  profilePicturePath: AssetPaths.onboardingBackgroundImage3,
                  timeStamp: DateTime.now().subtract(const Duration(minutes: 5)),
                  imagePaths: [
                    AssetPaths.onboardingBackgroundImage3,
                    AssetPaths.onboardingBackgroundImage2,
                    AssetPaths.onboardingBackgroundImage1
                  ],
                  caption: 'Hello world',
                ),
                50.verticalSpace,
                MomentCard(
                  username: 'Yomi',
                  profilePicturePath: AssetPaths.onboardingBackgroundImage2,
                  timeStamp: DateTime.now().subtract(const Duration(hours: 2)),
                  imagePaths: [
                    AssetPaths.onboardingBackgroundImage2,
                    AssetPaths.onboardingBackgroundImage3,
                    AssetPaths.onboardingBackgroundImage1
                  ],
                  caption: 'Hello world',
                ),
                100.verticalSpace,
              ],
            ),
          )
        ],
      )
    );
  }
}