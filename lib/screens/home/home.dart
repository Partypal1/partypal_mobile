import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:partypal/configs/router_config.dart';
import 'package:partypal/constants/asset_paths.dart';
import 'package:partypal/constants/route_paths.dart';
import 'package:partypal/screens/home/explore_screen.dart';
import 'package:partypal/screens/home/home_screen.dart';
import 'package:partypal/screens/home/moments_screen.dart';
import 'package:partypal/screens/home/post_screen.dart';
import 'package:partypal/screens/home/profile_screen.dart';
import 'package:partypal/widgets/bottom_navigation_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Map<String, String> iconPaths = {
    'Home': AssetPaths.homeIcon,
    'Explore': AssetPaths.exploreIcon,
    'Post': AssetPaths.postIcon,
    'Moments': AssetPaths.momentsIcon,
    'Profile': AssetPaths.profileIcon
  };
  List<Widget> screens = const[
    HomeScreen(),
    // Scaffold(),
    ExploreScreen(),
    PostScreen(),
    MomentsScreen(),
    ProfileScreen()
  ];

  int screenIndex = 0;

  ValueNotifier<bool> bottomNavBarIsVisible = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        NotificationListener<ScrollUpdateNotification>(
          onNotification: (notification) {
            if(notification.dragDetails != null){
              if(notification.dragDetails!.delta.dy.isNegative && bottomNavBarIsVisible.value){
                bottomNavBarIsVisible.value = !bottomNavBarIsVisible.value;
              }
              else if(!notification.dragDetails!.delta.dy.isNegative && !bottomNavBarIsVisible.value){
                bottomNavBarIsVisible.value = !bottomNavBarIsVisible.value;
              }
            }
            return false;
          },
          child: screens[screenIndex]
        ),

        Align(
          alignment: Alignment.bottomCenter,
          child: CustomBottomNavBar(
            iconPaths: iconPaths.values.toList(),
            labels: iconPaths.keys.toList(),
            isVisible: bottomNavBarIsVisible,
            onTap: (i){
              if(i == 1){
                routerConfig.push(RoutePaths.exploreScreen);
              }
              else if(i == 2){
                routerConfig.push(RoutePaths.postScreen);
              }
              else{
                setState(() {
                  screenIndex = i;
                });
              }
            },
          ),
        ),
      ],
    );
  }
}