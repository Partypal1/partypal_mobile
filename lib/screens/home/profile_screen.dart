import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partypal/constants/asset_paths.dart';
import 'package:partypal/widgets/app_bars/app_bar.dart';
import 'package:partypal/widgets/cards/circle_profile_image.dart';
import 'package:partypal/widgets/others/tonal_elevation.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface.tonalElevation(Elevation.level1, context),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: SliverCustomAppBarDelegate(
              title: 'Profile',
              hasBackButton: false
            )
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 80,
                child: Row(
                  children: [
                    CircleProfileImage(imagePath: AssetPaths.onboardingBackgroundImage2, radius: 40,),
                    10.horizontalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Olasunkanmi Beckley',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          'Sunkanmi',
                          style: Theme.of(context).textTheme.bodySmall
                        ),
                        Text(
                          'Partypal points: 0',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.secondary
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      )
     );
  }
}