import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partypal/widgets/tonal_elevation.dart';

class PlacesCard extends StatelessWidget {
  final String placeName;
  final String placeType;
  final String imagePath;
  final bool isPopularWithFriends; //TODO: accept a place object instead

  const PlacesCard({
    required this.placeName,
    required this.placeType,
    required this.imagePath,
    this.isPopularWithFriends = false,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Theme.of(context).colorScheme.surface.tonalElevation(Elevation.level3, context)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Row(
          children: [
            SizedBox.square(
              dimension: 50,
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            10.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    placeName,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    placeType,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  isPopularWithFriends //TODO: check for: (num friends going / num total friends) instead
                    ? Text(
                        'popular with friends',
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    : Text(
                        'not popular with friends',
                        style:  Theme.of(context).textTheme.bodySmall,
                      ),
                ],
              ),
            ),
             SizedBox( // follow button
              height: 40,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).colorScheme.inverseSurface
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Center(
                    child: Text(
                      'Follow',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onInverseSurface
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}