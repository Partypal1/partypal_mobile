import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:partypal/widgets/others/tonal_elevation.dart';

class CircleImage extends StatelessWidget {
  final String imageUrl;
  final double radius;
  const CircleImage({
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
                return  Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius),
                    color: Theme.of(context).colorScheme.surface.tonalElevation(Elevation.level4, context)
                  ),
                  child: Center(
                    child: Icon(
                      Icons.error_rounded,
                      size: radius,
                      color: Theme.of(context).colorScheme.surfaceVariant.tonalElevation(Elevation.level2, context),
                    ),
                  ),
                );
              },
              imageBuilder: (context, imageProvider){
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
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

class CircleImageLoading extends StatelessWidget {
  final double radius;
  const CircleImageLoading({
    this.radius = 25,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
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
    );
  }
}