import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:partypal/constants/asset_paths.dart';
import 'package:partypal/constants/route_paths.dart';
import 'package:partypal/configs/router_config.dart';
import 'package:partypal/models/user_model.dart';
import 'package:partypal/widgets/app_bar.dart';
class SelectUserProfileScreen extends StatelessWidget {
  const SelectUserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(title: 'Select user profile', hasBackButton: false,),
          Padding(
            padding: EdgeInsets.all(0.05.sw),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
        ],
      ),
    );
  }
}