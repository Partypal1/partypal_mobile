import 'package:flutter/material.dart';
import 'package:partypal/configs/router_config.dart';
import 'package:partypal/constants/route_paths.dart';
import 'package:partypal/services/session_manager.dart';
import 'package:partypal/utils/router_util.dart';
import 'package:partypal/widgets/app_bars/app_bar.dart';
import 'package:partypal/widgets/buttons/filled_button.dart';
import 'package:partypal/widgets/others/tonal_elevation.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface.tonalElevation(Elevation.level1, context),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: SliverCustomAppBarDelegate(title: 'Settings'),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: CustomFilledButton(
              label: 'Sign out',
              iconData: Icons.logout,
              backgroundColor: Theme.of(context).colorScheme.errorContainer,
              labelColor: Theme.of(context).colorScheme.onErrorContainer,
              onTap: (){
                Provider.of<SessionManager>(context, listen: false).setAccessToken(null);
                Provider.of<SessionManager>(context, listen: false).setRefreshToken(null);
                routerConfig.clearAndNavigate(RoutePaths.selectUserProfileScreen);
              },
            )
          )
        ],
      ),
     );
  }
}