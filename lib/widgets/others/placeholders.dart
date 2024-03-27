import 'package:flutter/material.dart';
import 'package:partypal/widgets/others/tonal_elevation.dart';
class ImagePlaceholder extends StatelessWidget {
  final double? width, height, radius;
  const ImagePlaceholder({
    this.width,
    this.height,
    this.radius,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: height,
        width: width,
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: radius != null
              ? BorderRadius.circular(radius!)
              : null,
            color: Colors.black12
          ),
        ),
      ),
    );
  }
}

class TextPlaceHolder extends StatelessWidget {
  final double height, width;
  final Color? color;
  const TextPlaceHolder({
    required this.height,
    required this.width,
    this.color,
    super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(height/2),
          color: color ?? Theme.of(context).colorScheme.surfaceVariant.tonalElevation(Elevation.level1, context)
        ),
      )
    );
  }
}