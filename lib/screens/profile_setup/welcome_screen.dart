import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partypal/configs/router_config.dart';
import 'package:partypal/constants/asset_paths.dart';
import 'package:partypal/constants/route_paths.dart';
import 'package:partypal/widgets/buttons/wide_button.dart';
import 'package:partypal/widgets/others/tonal_elevation.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin{
  late AnimationController partypalController;
  late AnimationController welcomeController;
  late AnimationController setProfileController;

  @override
  void initState(){
    super.initState();
    partypalController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500)
    );
    welcomeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200)
    );
    setProfileController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200)
    );
    partypalController.forward();
    partypalController.addStatusListener((status) {
      if (status == AnimationStatus.completed){
        welcomeController.forward();
      }
    });
    welcomeController.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        setProfileController.forward();
      }
    });
  }
  @override
  void dispose(){
    partypalController.dispose();
    welcomeController.dispose();
    setProfileController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface.tonalElevation(Elevation.level0, context),
      body: Padding(
        padding: EdgeInsets.all(0.05.sw),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder( // partypal
              animation: partypalController,
              builder: (context, child) {
                return Opacity(
                  opacity: partypalController.value,
                  child: child
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox.square(
                    dimension: 55,
                    child: Image.asset(AssetPaths.logoImage),
                  ),
                  10.horizontalSpace,
                  Text(
                    'Partypal',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface
                    ),
                  ),
                ],
              ),
            ),
          
            0.01.sh.verticalSpace,
          
            ScaleTransition(  // welcome image
              scale: welcomeController,
              child: AnimatedBuilder(
                animation: welcomeController,
                builder: (context, child) {
                  return Opacity(
                    opacity: welcomeController.value,
                    child: child
                  );
                },
                child: SizedBox(
                  width: 0.5.sw,
                  height: 0.25.sw,
                  child: Image.asset(AssetPaths.welcomeImage),
                ),
              ),
            ),
      
            0.05.sh.verticalSpace,
      
             ScaleTransition(  // set profile button
              scale: setProfileController,
               child: AnimatedBuilder(
                animation: setProfileController,
                 builder: (context, child) {
                  return Opacity(
                    opacity: setProfileController.value,
                    child: child
                  );
                },
                child: WideButton(
                  label: 'Set profile',
                  onTap: (){
                    routerConfig.push(RoutePaths.setProfileScreen);
                  },
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}