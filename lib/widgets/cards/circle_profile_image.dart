import 'package:flutter/material.dart';
import 'package:partypal/widgets/others/shimmer.dart';
import 'package:partypal/widgets/others/tonal_elevation.dart';

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
      child: Center(
        child: SizedBox.square(
          dimension: 2 * radius,
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: Theme.of(context).colorScheme.surfaceVariant
            ),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            )
          ),
        ),
      ),
    );
  }
}

class CircleProfileImageLoading extends StatelessWidget {
  final double radius;
  const CircleProfileImageLoading({
    this.radius = 25,
    super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      isLoading: true,
      child: Center(
        child: SizedBox.square(
          dimension: 2 * radius,
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: Theme.of(context).colorScheme.surface.tonalElevation(Elevation.level3, context)
            ),
            child: Center(
              child: Icon(
                Icons.person_rounded,
                size: radius,
                color: Theme.of(context).colorScheme.surfaceVariant.tonalElevation(Elevation.level2, context),
              ),
            ),
          ),
        ),
      ),
    );
  }
}