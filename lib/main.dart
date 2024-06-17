import 'package:flutter/material.dart';
import 'package:partypal/configs/router_config.dart';
import 'package:partypal/configs/supported_locales.dart';
import 'package:partypal/services/auth_service.dart';
import 'package:partypal/services/category_provider.dart';
import 'package:partypal/services/event_provider.dart';
import 'package:partypal/services/moment_provider.dart';
import 'package:partypal/services/place_provider_service.dart';
import 'package:partypal/services/profile_management_service.dart';
import 'package:partypal/services/session_manager.dart';
import 'package:partypal/theme/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  ScreenUtil.ensureScreenSize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Partypal());
}

class Partypal extends StatelessWidget {
  const Partypal({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return MultiProvider(
      providers: [
        ListenableProvider<AuthService>(create: (_) => AuthService()),
        ListenableProvider<ProfileManagementService>(create: (_) => ProfileManagementService()),
        ListenableProvider<CategoryProvider>(create: (_) => CategoryProvider()),
        ListenableProvider<EventProvider>(create: (_) => EventProvider()),
        ListenableProvider<MomentProvider>(create: (_) => MomentProvider()),
        ListenableProvider<PlaceProviderService>(create: (_) => PlaceProviderService()),
        ListenableProvider<SessionManager>(create: (_) => SessionManager()),
      ],
      child: MaterialApp.router(
        title: 'Partypal',
        theme: theme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        routerConfig: routerConfig,
        supportedLocales: supportedLocales,
        localizationsDelegates: localizationsDelegates
      ),
    );
  }
}