import 'package:flutter/material.dart';
import 'package:partypal/constants/elevation.dart';

BoxShadow customBoxShadow(Elevation level, BuildContext context){
  double elevation = switch (level) {
    Elevation.level0 => 0,
    Elevation.level1 => 1,
    Elevation.level2 => 3,
    Elevation.level3 => 6,
    Elevation.level4 => 8,
    Elevation.level5 => 12
  };
  return BoxShadow(
    color: Theme.of(context).colorScheme.shadow,
    spreadRadius: elevation * 0.1,
    blurRadius: elevation * 0.25,
    offset: Offset(0, elevation * 0.25),
  );
}