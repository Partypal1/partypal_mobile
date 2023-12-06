import 'package:flutter/material.dart';
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
    return const Scaffold(
      body: Center(
        child: Text('partypal'),
      ),
    );
  }
}