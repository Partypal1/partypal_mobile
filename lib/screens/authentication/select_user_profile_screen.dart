import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:partypal/configs/asset_paths.dart';
import 'package:partypal/configs/route_paths.dart';
import 'package:partypal/configs/router_config.dart';
import 'package:partypal/models/user_model.dart';
class SelectUserProfileScreen extends StatelessWidget {
  const SelectUserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) { //TODO: work on the profile selection
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(0.05.sw),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            0.03.sh.verticalSpace,

            Text(
              'Select User Profile',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold
              ),
            ),

            0.03.sh.verticalSpace,

            ListTile(
              leading: SvgPicture.asset(
                AssetPaths.userIcon,
                colorFilter: ColorFilter.mode( Theme.of(context).colorScheme.primary, BlendMode.srcIn),
              ),
              title: Text('User', style: Theme.of(context).textTheme.bodyLarge,),
              subtitle: Text(
                'Discover the hottest places around you',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              onTap: (){
                routerConfig.push(RoutePaths.signUpScreen, extra: {'userType': UserType.user});
              },
            ),

            0.015.sh.verticalSpace,
            const Divider(),
            0.015.sh.verticalSpace,

            ListTile(
              leading: SvgPicture.asset(
                AssetPaths.promoterIcon,
                colorFilter: ColorFilter.mode( Theme.of(context).colorScheme.primary, BlendMode.srcIn),
              ),
              title: Text('Promoter', style: Theme.of(context).textTheme.bodyLarge,),
              subtitle: Text(
                'Create and list your events',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              onTap: (){
                routerConfig.push(RoutePaths.signUpScreen, extra: {'userType': UserType.promoter});
              },
            ),
          ],
        ),
      ),
    );
  }
}