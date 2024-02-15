import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partypal/widgets/buttons/filled_button.dart';
import 'package:partypal/widgets/buttons/text_button.dart';
import 'package:partypal/widgets/others/shimmer.dart';
import 'package:partypal/widgets/others/tonal_elevation.dart';

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
    return Center(
      child: Container(
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
              isFollowing
              ? CustomTextButton(
                  label: 'Unfollow',
                  onTap: _changeFollowingState,
                )
              : CustomFilledButton(
                  label: 'follow',
                  onTap: _changeFollowingState,
                )
            ],
          ),
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

class PlacesLoadingCard extends StatelessWidget {
  const PlacesLoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      isLoading: true,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Theme.of(context).colorScheme.surface.tonalElevation(Elevation.level3, context)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox.square(
                dimension: 50,
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Theme.of(context).colorScheme.surfaceVariant.tonalElevation(Elevation.level1, context)
                  ),
                )
              ),
              10.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 14,
                    width: 50,
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Theme.of(context).colorScheme.surfaceVariant.tonalElevation(Elevation.level1, context)
                      ),
                    )
                  ),
                  5.verticalSpace,
                  SizedBox(
                    height: 12,
                    width: 100,
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Theme.of(context).colorScheme.surfaceVariant.tonalElevation(Elevation.level1, context)
                      ),
                    )
                  ),
                  5.verticalSpace,
                  SizedBox(
                    height: 10,
                    width: 180,
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Theme.of(context).colorScheme.surfaceVariant.tonalElevation(Elevation.level1, context)
                      ),
                    )
                  ),
                ],
              ),
            ]
          )
        )
      ),
    );
  }
}