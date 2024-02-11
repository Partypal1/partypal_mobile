import 'package:flutter/material.dart';

class CircleProfileImage extends StatelessWidget {
  final String imagePath;
  const CircleProfileImage({
    required this.imagePath,
    super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        //TODO: navigate to the profile screen of the user that is tapped
      },
      child: SizedBox.square(
        dimension: 50,
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25)
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