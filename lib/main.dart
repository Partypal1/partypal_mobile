import 'package:flutter/material.dart';
import 'package:partypal/configs/router_config.dart';
import 'package:partypal/theme/theme.dart';

void main() {
  runApp(const Partypal());
}

class Partypal extends StatelessWidget {
  const Partypal({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Partypal',
      theme: theme,
      debugShowCheckedModeBanner: false,
      routerConfig: routerConfig,
    );
  }
}