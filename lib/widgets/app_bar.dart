import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partypal/configs/router_config.dart';
import 'package:partypal/constants/asset_paths.dart';
import 'package:partypal/widgets/tonal_elevation.dart';

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
  const HomeAppBar({required this.name, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.black),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 40,
          bottom: 20,
          left: 10,
          right: 10,
        ),
        child: Row(
          children: [
            SizedBox.square(
                dimension: 50,
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25)),
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: Image.asset(AssetPaths.logoImage),
                    ))),
            20.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Hi $name',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Where would you like to explore next?',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.white),
                ),
              ],
            ),
            const Expanded(child: SizedBox()),
            const Icon(
              Icons.notifications,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}


class HomeBar extends StatelessWidget {
  final String name;
  const HomeBar({
    required this.name,
    super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      // leading: Container(
      //   decoration: BoxDecoration(
      //     color: Colors.white, borderRadius: BorderRadius.circular(40)),
      //   child: Padding(
      //     padding: const EdgeInsets.all(2.5),
      //     child: Image.asset(AssetPaths.logoImage),
      //   )
      // ),
     
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Hi $name',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          // Text(
          //   'Where would you like to explore next?',
          //   style: Theme.of(context)
          //       .textTheme
          //       .bodySmall
          //       ?.copyWith(color: Colors.white),
          // ),
        ],
      ),
      // bottom: AppBar(title: Text('this is the bottom'),),
      // flexibleSpace: FlexibleSpaceBar(
      //   // background: Container(color: Colors.blue,),
      //   title: Text('Sunkanmi'),
      // ),
      backgroundColor: Colors.black,
      floating: true,
      // pinned: true,
      // expandedHeight: 150,s
      
    );
  }
}
