import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partypal/widgets/tonal_elevation.dart';

class PlacesCard extends StatefulWidget {
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
  State<PlacesCard> createState() => _PlacesCardState();
}

class _PlacesCardState extends State<PlacesCard> {
  late bool isFollowing;

  @override
  void initState(){
    super.initState();
    //TOOD: get isFollowing from backend
    isFollowing = false;
  }

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
                  widget.imagePath,
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
                    widget.placeName,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    widget.placeType,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  widget.isPopularWithFriends //TODO: check for: (num friends going / num total friends) instead
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
             GestureDetector(
              onTap: _changeFollowingState,
               child: isFollowing
                ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                      'Unfollow',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold
                      )
                    ),
                )
                : SizedBox( // follow button
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
                  ),
            )
          ],
        ),
      ),
    );
  }
  void _changeFollowingState(){
    //TODO: follow or unfollow from backend
    setState(() {
      isFollowing = !isFollowing;
    });
  }
}