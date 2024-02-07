import 'package:flutter/material.dart';
import 'package:partypal/configs/router_config.dart';
import 'package:partypal/configs/supported_locales.dart';
import 'package:partypal/theme/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  ScreenUtil.ensureScreenSize();
  runApp(const Partypal());
}

class Partypal extends StatelessWidget {
  const Partypal({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return MaterialApp.router(
      title: 'Partypal',
      theme: theme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      routerConfig: routerConfig,
      supportedLocales: supportedLocales,
      localizationsDelegates: localizationsDelegates
    );
  }
}