import 'package:flutter/material.dart';
class ImagePlaceholder extends StatelessWidget {
  final double? width;
  final double? height;
  final double? radius;
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