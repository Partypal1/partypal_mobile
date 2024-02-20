import 'package:flutter/material.dart';
import 'package:partypal/configs/router_config.dart';
import 'package:partypal/configs/supported_locales.dart';
import 'package:partypal/services/auth_provider.dart';
import 'package:partypal/services/category_provider.dart';
import 'package:partypal/services/event_provider.dart';
import 'package:partypal/services/moment_provider.dart';
import 'package:partypal/theme/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
  ScreenUtil.ensureScreenSize();
  runApp(const Partypal());
}

class Partypal extends StatelessWidget {
  const Partypal({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return MultiProvider(
      providers: [
        Provider<AuthProider>(create: (_) => AuthProider()),
        Provider<CategoryProvider>(create: (_) => CategoryProvider()),
        Provider<EventProvider>(create: (_) => EventProvider()),
        Provider<MomentProvider>(create: (_) => MomentProvider())
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