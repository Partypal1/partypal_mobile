import 'package:flutter/material.dart';
import 'package:partypal/constants/asset_paths.dart';
import 'package:partypal/constants/route_paths.dart';
import 'package:partypal/configs/router_config.dart';
import 'package:partypal/services/session_manager.dart';
import 'package:partypal/widgets/others/tonal_elevation.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    Future.wait([
      Provider.of<SessionManager>(context, listen: false).init(),
      Future.delayed(const Duration(seconds: 2)) //TODO: preload assets here instead
    ]).then((_) async {
      if(await Provider.of<SessionManager>(context, listen: false).isFirstRun){  
        routerConfig.pushReplacement(RoutePaths.onboaringScreen);
      } else {
        //TODO: pushReplacement to auth or home screen depending on authentication state
      }
    });    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface.tonalElevation(Elevation.level0, context),
      body: Stack(
        children: [
          //TODO: add the background image here
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox.square(
                  dimension: 50,
                  child: Image.asset(AssetPaths.logoImage)
                ),
                const SizedBox(width: 10,),
                Text(
                  'Partypal',
                  style: Theme.of(context).textTheme.headlineMedium
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}