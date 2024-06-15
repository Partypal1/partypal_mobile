import 'package:flutter/material.dart';
import 'dart:math' as math;

class Scaler {
  static double textScaleFactor(BuildContext context, {double minScaleFactor = 0.5, double maxScaleFactor = 2}) {
    final width = MediaQuery.of(context).size.width;
    double val = width / 400;
    return math.max(minScaleFactor, math.min(val, maxScaleFactor));
  }
}