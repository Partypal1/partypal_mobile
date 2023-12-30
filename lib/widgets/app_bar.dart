import 'package:flutter/material.dart';
import 'package:partypal/configs/router_config.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool hasBackButton;
  const CustomAppBar({
    required this.title,
    this.subtitle,
    this.hasBackButton = true,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 40,
          bottom: 20,
          left: 10,
          right: 10,
          
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            hasBackButton
            ? GestureDetector(
                onTap: (){
                  routerConfig.pop(context);
                },
                child: const SizedBox.square(
                  dimension: 40,
                  child: Icon(Icons.arrow_back_ios)
                )
              )
            : const SizedBox.shrink(),
            const Expanded(child: SizedBox()),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold
                  ),
                ),
                subtitle != null
                ? Text(
                    subtitle!,
                    style: Theme.of(context).textTheme.titleSmall,
                  )
                : const SizedBox.shrink(),
              ],
            ),
            const Expanded(child: SizedBox())
          ],
        ),
      ),
    );
  }
}

class SliverCustomAppBarDelegate extends SliverPersistentHeaderDelegate{
  final String title;
  final String? subtitle;
  final bool hasBackButton;
  SliverCustomAppBarDelegate({
    required this.title,
    this.subtitle,
    this.hasBackButton = true
  });

  @override
  double get maxExtent => 100;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(SliverCustomAppBarDelegate oldDelegate) {
    return false;
  }
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent){
    return CustomAppBar(
      title: title,
      subtitle: subtitle,
      hasBackButton: hasBackButton,
    );
  }
}