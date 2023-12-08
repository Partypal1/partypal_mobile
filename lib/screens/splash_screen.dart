import 'package:flutter/material.dart';
import 'package:partypal/configs/asset_paths.dart';
import 'package:partypal/configs/session_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    Future.delayed(
      const Duration(seconds: 1),
      () async{
        if(await SessionManager.isFirstRun){  
          //TODO: pushReplacement to onboaring_screen
        } else {
          //TODO: pushReplacement to auth or home screen depending on authentication state
        }
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
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
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onInverseSurface
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}