import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

const List<Locale> supportedLocales = [
  Locale('en', 'NG')
];

List<LocalizationsDelegate> localizationsDelegates = [
  CountryLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
];