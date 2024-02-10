import 'package:flutter/material.dart';
import 'package:partypal/configs/router_config.dart';
import 'package:partypal/constants/asset_paths.dart';
import 'package:partypal/widgets/others/tonal_elevation.dart';

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
                            routerConfig.pop(context);
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

class SliverCustomAppBarDelegate extends SliverPersistentHeaderDelegate {
  final String title;
  final String? subtitle;
  final bool hasBackButton;
  SliverCustomAppBarDelegate(
      {required this.title, this.subtitle, this.hasBackButton = true});

  @override
  double get maxExtent => 100;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(SliverCustomAppBarDelegate oldDelegate) {
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
  final String name;
  const HomeAppBar({
    required this.name,
    super.key});

  @override
  Widget build(BuildContext context) {
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
          Text(
            'Hi $name',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            'Where would you like to explore next?',
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(color: Colors.white),
          ),
        ],
      ),

      actions: [
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: (){
            //TODO: navigate to notification screen
          },
        )
      ],
    );
  }
}
