import 'package:flutter/material.dart';
import 'package:partypal/theme/color_swatch_generator.dart';

MaterialColor primaryColor = createColorSwatch(const Color(0xff8F0C65));
MaterialColor secondaryColor = createColorSwatch(const Color(0xff470A69));
MaterialColor tertiaryColor = createColorSwatch(const Color(0xff3C1BE3));
MaterialColor errorColor = createColorSwatch(const Color(0xffb90e0a));
MaterialColor neutralColor = createColorSwatch(const Color(0xff222021));
MaterialColor neutralVariantColor = createColorSwatch(const Color(0xff333333));
Color shadowColor = const Color(0xff373737);

ColorScheme lightScheme =  ColorScheme.light(
  primary: primaryColor[40]!,
  onPrimary: primaryColor[100]!,
  primaryContainer: primaryColor[90],
  onPrimaryContainer: primaryColor[10],
  inversePrimary: primaryColor[80],

  secondary: secondaryColor[40]!,
  onSecondary: secondaryColor[100]!,
  secondaryContainer: secondaryColor[90],
  onSecondaryContainer: secondaryColor[10],

  tertiary: tertiaryColor[40],
  onTertiary: tertiaryColor[100],
  tertiaryContainer: tertiaryColor[90],
  onTertiaryContainer: tertiaryColor[10],

  error: errorColor[40]!,
  onError: errorColor[100]!,
  errorContainer: errorColor[90],
  onErrorContainer: errorColor[10],

  outline: neutralVariantColor[50],
  outlineVariant: neutralVariantColor[80],

  surface: neutralColor[98]!,
  onSurface: neutralColor[10]!,

  inverseSurface: neutralColor[20],
  onInverseSurface: neutralColor[95],

  shadow: shadowColor.withOpacity(0.25)
);

ColorScheme darkScheme =  ColorScheme.dark(
  primary: primaryColor[80]!,
  onPrimary: primaryColor[20]!,
  primaryContainer: primaryColor[30],
  onPrimaryContainer: primaryColor[90],
  inversePrimary: primaryColor[40],

  secondary: secondaryColor[80]!,
  onSecondary: secondaryColor[20]!,
  secondaryContainer: secondaryColor[30],
  onSecondaryContainer: secondaryColor[90],

  tertiary: tertiaryColor[80],
  onTertiary: tertiaryColor[20],
  tertiaryContainer: tertiaryColor[30],
  onTertiaryContainer: tertiaryColor[90],

  error: errorColor[80]!,
  onError: errorColor[20]!,
  errorContainer: errorColor[30],
  onErrorContainer: errorColor[90],

  outline: neutralVariantColor[60],
  outlineVariant: neutralVariantColor[30],

  surface: neutralColor[6]!,
  onSurface: neutralColor[90]!,

  inverseSurface: neutralColor[80],
  onInverseSurface: neutralColor[5],

  shadow: shadowColor
);
class UIColors{
  bool darkMode;
  UIColors({
    this.darkMode=false,
  });

  final MaterialColor _primaryColor = createColorSwatch(const Color(0xff8F0C65));
  final MaterialColor _secondaryColor = createColorSwatch(const Color(0xff470A69));
  final MaterialColor _tertiaryColor = createColorSwatch(const Color(0xff3C1BE3));
  final MaterialColor _errorColor = createColorSwatch(const Color(0xffb90e0a));
  final MaterialColor _neutralColor = createColorSwatch(const Color(0xff6D6C6D));
  final MaterialColor _neutralVariantColor = createColorSwatch(const Color(0xff333333));
  final Color _shadowColor = const Color(0xff373737);

  Color get primary => darkMode ? _primaryColor[80]! : _primaryColor[40]!;
  Color get onPrimary => darkMode ? _primaryColor[20]! : _primaryColor[100]!;
  Color get primaryContainer => darkMode ? _primaryColor[30]! : _primaryColor[90]!;
  Color get onPrimaryContainer => darkMode ? _primaryColor[90]! : _primaryColor[10]!;
  Color get inversePrimary => darkMode ? _primaryColor[40]! : _primaryColor[80]!;

  Color get secondary => darkMode ? _secondaryColor[80]! : _secondaryColor[40]!;
  Color get onSecondary => darkMode ? _secondaryColor[20]! : _secondaryColor[100]!;
  Color get secondaryContainer => darkMode ? _secondaryColor[30]! : _secondaryColor[90]!;
  Color get onSecondaryContainer => darkMode ? _secondaryColor[90]! : _secondaryColor[10]!;

  Color get tertiary => darkMode ? _tertiaryColor[80]! : _tertiaryColor[40]!;
  Color get onTertiary => darkMode ? _tertiaryColor[20]! : _tertiaryColor[100]!;
  Color get tertiaryContainer => darkMode ? _tertiaryColor[30]! : _tertiaryColor[90]!;
  Color get onTertiaryContainer => darkMode ? _tertiaryColor[90]! : _tertiaryColor[10]!;

  Color get error => darkMode ? _errorColor[80]! : _errorColor[40]!;
  Color get onError => darkMode ? _errorColor[20]! : _errorColor[100]!;
  Color get errorContainer => darkMode ? _errorColor[30]! : _errorColor[90]!;
  Color get onErrorContainer => darkMode ? _errorColor[90]! : _errorColor[10]!;

  Color get background => darkMode ? _neutralColor[10]! : _neutralColor[99]!;
  Color get onBackground => darkMode ? _neutralColor[90]! : _neutralColor[10]!;

  Color get surface => darkMode ? _neutralColor[10]! : _neutralColor[99]!;
  Color get onSurface => darkMode ? _neutralColor[90]! : _neutralColor[10]!;
  Color get surfaceVariant => darkMode ? _neutralVariantColor[30]! : _neutralVariantColor[90]!;
  Color get onSurfaceVariant => darkMode ? _neutralVariantColor[80]! : _neutralVariantColor[30]!;
  Color get inverseSurface => darkMode ? _neutralColor[90]! : _neutralColor[20]!;
  Color get onInverseSurface => darkMode ? _neutralColor[5]! : _neutralColor[95]!;

  Color get outline => darkMode ? _neutralVariantColor[60]! : _neutralVariantColor[50]!;
  Color get shadow => _shadowColor.withOpacity(0.25);
}