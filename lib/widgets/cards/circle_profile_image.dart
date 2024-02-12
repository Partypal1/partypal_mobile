import 'package:flutter/material.dart';

class CircleProfileImage extends StatelessWidget {
  final String imagePath;
  final double radius;
  const CircleProfileImage({
    required this.imagePath,
    this.radius = 25,
    super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        //TODO: navigate to the profile screen of the user that is tapped
      },
      child: SizedBox.square(
        dimension: 2 * radius,
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius)
          ),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          )
        ),
      ),
    );
  }
}