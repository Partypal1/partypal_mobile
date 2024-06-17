import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partypal/models/user_model.dart';
import 'package:partypal/widgets/buttons/filled_button.dart';
import 'package:partypal/widgets/buttons/text_button.dart';
import 'package:partypal/widgets/others/placeholders.dart';
import 'package:partypal/widgets/others/tonal_elevation.dart';

class PersonCard extends StatefulWidget {
  final PartypalUser user;

  const PersonCard({
    required this.user,
    super.key});

  @override
  State<PersonCard> createState() => _PersonCardState();
}

class _PersonCardState extends State<PersonCard> {
  late bool isFollowing;
  @override
  void initState(){
    super.initState();
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
                  child: CachedNetworkImage(
                    imageUrl: widget.user.profileImageURL,
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
                      "${widget.user.firstName} ${widget.user.lastName}",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      widget.user.username,
                      style: Theme.of(context).textTheme.bodyMedium,
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

class PeopleLoadingCard extends StatelessWidget {
  const PeopleLoadingCard({super.key});

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
                  width: 150,
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
                  width: 80,
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
                  width: 100,
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
    );
  }
}