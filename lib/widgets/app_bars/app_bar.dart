import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:partypal/constants/asset_paths.dart';
import 'package:partypal/services/profile_provider.dart';
import 'package:partypal/widgets/others/placeholders.dart';
import 'package:partypal/widgets/others/tonal_elevation.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool hasBackButton;
  const CustomAppBar(
      {required this.title,
      this.subtitle,
      this.hasBackButton = true,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Container(
        color: Theme.of(context).colorScheme.surface.tonalElevation(Elevation.level1, context),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 40,
            bottom: 20,
            left: 10,
            right: 10,
          ),
          child: Stack(
            children: [
              hasBackButton
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                          onTap: () {
                            GoRouter.of(context).pop();
                          },
                          child: const SizedBox.square(
                              dimension: 40,
                              child: Icon(Icons.arrow_back_ios))),
                    )
                  : const SizedBox.shrink(),
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    subtitle != null
                        ? Text(
                            subtitle!,
                            style: Theme.of(context).textTheme.titleSmall,
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSliverAppBar extends SliverPersistentHeaderDelegate {
  final String title;
  final String? subtitle;
  final bool hasBackButton;
  CustomSliverAppBar(
      {required this.title, this.subtitle, this.hasBackButton = true});

  @override
  double get maxExtent => 100;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(CustomSliverAppBar oldDelegate) {
    return false;
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return CustomAppBar(
      title: title,
      subtitle: subtitle,
      hasBackButton: hasBackButton,
    );
  }
}

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileProvider profile = Provider.of<ProfileProvider>(context);
    return SliverAppBar(
      toolbarHeight: 75,
      leadingWidth: 75,
      backgroundColor: Colors.black,
      floating: true,

      leading: Padding(
        padding: const EdgeInsets.all(12.5),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25)
          ),
          child: Image.asset(
            AssetPaths.logoImage,
            fit: BoxFit.cover,
          )
        ),
      ),
     
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          profile.user == null
          ? TextPlaceHolder(height: 30, width: 180, color: Colors.white.withOpacity(0.1),)
          :Text(
            profile.user!.firstName,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),

      actions: [
        IconButton(
          icon: const Icon(
            Icons.notifications,
            color: Colors.white,
          ),
          onPressed: (){
            //TODO: navigate to notification screen
          },
        )
      ],
    );
  }
}
