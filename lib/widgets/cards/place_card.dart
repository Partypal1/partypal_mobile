import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:partypal/constants/route_paths.dart';
import 'package:partypal/models/place_model.dart';
import 'package:partypal/widgets/buttons/filled_button.dart';
import 'package:partypal/widgets/buttons/text_button.dart';
import 'package:partypal/widgets/others/placeholders.dart';
import 'package:partypal/widgets/others/shimmer.dart';
import 'package:partypal/widgets/others/tonal_elevation.dart';

class PlaceCard extends StatefulWidget {
  final Place place;

  const PlaceCard({
    required this.place,
    super.key});

  @override
  State<PlaceCard> createState() => _PlaceCardState();
}

class _PlaceCardState extends State<PlaceCard> {
  late bool isFollowing;

  @override
  void initState(){
    super.initState();
    isFollowing = widget.place.isFollowing;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        GoRouter.of(context).push(
          RoutePaths.placeScreen,
          extra: {'place': widget.place}
        );
      },
      child: Center(
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
                    child: CachedNetworkImage(
                      imageUrl: widget.place.imageUrl,
                      placeholder: (context, url) => const ImagePlaceholder(),
                      fit: BoxFit.cover,
                    )
                  ),
                ),
                10.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.place.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        widget.place.type,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      widget.place.isPopularWithFriends //TODO: check for: (num friends going / num total friends) instead
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

class PlaceLoadingCard extends StatelessWidget {
  const PlaceLoadingCard({super.key});

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