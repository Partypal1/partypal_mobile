import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:partypal/widgets/others/shimmer.dart';
import 'package:partypal/widgets/others/tonal_elevation.dart';

class CircleProfileImage extends StatelessWidget {
  final String imageUrl;
  final double radius;
  const CircleProfileImage({
    required this.imageUrl,
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
            child:  CachedNetworkImage(
              imageUrl: imageUrl,
              errorWidget: (context,_, __){
                return  Center(
                  child: SizedBox.square(
                    dimension: 2 * radius,
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radius),
                        color: Theme.of(context).colorScheme.surface.tonalElevation(Elevation.level4, context)
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
                );
              },
              imageBuilder: (context, imageProvider){
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      colorFilter: const ColorFilter.mode(Color.fromRGBO(0, 0, 0, 0.5), BlendMode.colorBurn),
                      fit: BoxFit.cover
                    )
                  ),
                );
              },
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
                color: Theme.of(context).colorScheme.surfaceVariant.tonalElevation(Elevation.level1, context),
              ),
            ),
          ),
        ),
      ),
    );
  }
}