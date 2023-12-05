import 'package:flutter/material.dart';
import 'package:partypal/theme/color_swatch_generator.dart';

MaterialColor primaryColor = createColorSwatch(const Color(0xff470A69)); 
MaterialColor secondaryColor = createColorSwatch(const Color(0xff3C1BE3));
MaterialColor tertiaryColor = createColorSwatch(const Color(0xff8F0C65));
MaterialColor errorColor = createColorSwatch(const Color(0xffb90e0a));
MaterialColor neutralColor = createColorSwatch(const Color(0xff6D6C6D));
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
  
  surfaceVariant: neutralVariantColor[90],
  onSurfaceVariant: neutralVariantColor[30],

  inverseSurface: neutralColor[20],
  onInverseSurface: neutralColor[95],

  background: neutralColor[98]!,
  onBackground: neutralColor[10]!,

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

  surfaceVariant: neutralVariantColor[20],
  onSurfaceVariant: neutralVariantColor[80],

  inverseSurface: neutralColor[80],
  onInverseSurface: neutralColor[5],

  background: neutralColor[6]!,
  onBackground: neutralColor[90]!,

  shadow: shadowColor
);
class LightAppColor{
  static Color primary = primaryColor[40]!;
  static Color onPrimary = primaryColor[100]!;
  static Color primaryContainer = primaryColor[90]!;
  static Color onPrimaryContainer = primaryColor[10]!;
  static Color inversePrimary = primaryColor[80]!;

  static Color secondary = secondaryColor[40]!;
  static Color onSecondary = secondaryColor[100]!;
  static Color secondaryContainer = secondaryColor[90]!;
  static Color onSecondaryContainer = secondaryColor[10]!;

  static Color tertiary = tertiaryColor[40]!;
  static Color onTertiary = tertiaryColor[100]!;
  static Color tertiaryContainer = tertiaryColor[90]!;
  static Color onTertiaryContainer = tertiaryColor[10]!;

  static Color error = errorColor[40]!;
  static Color onError= errorColor[100]!;
  static Color errorContainer = errorColor[90]!;
  static Color onErrorContainer = errorColor[10]!;

  static Color surface = neutralColor[98]!;
  static Color surfaceBright = neutralColor[98]!;
  static Color surfaceDim = neutralColor[87]!;
  
  static Color surfaceContainerLowest = neutralColor[100]!;
  static Color surfaceContainerLow = neutralColor[96]!;
  static Color surfaceContainer = neutralColor[94]!;
  static Color surfaceContainerHigh = neutralColor[92]!;
  static Color surfaceContainerHighest = neutralColor[90]!;

  static Color onSurface = neutralColor[10]!;
  static Color onSurfaceVariant = neutralVariantColor[30]!;

  static Color inverseSurface = neutralColor[20]!;
  static Color onInverseSurface = neutralColor[95]!;
  
  static Color outline = neutralVariantColor[50]!;
  static Color outlineVariant = neutralVariantColor[80]!;
}