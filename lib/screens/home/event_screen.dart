import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:partypal/constants/route_paths.dart';
import 'package:partypal/models/event_model.dart';
import 'package:partypal/widgets/cards/person_card.dart';
import 'package:partypal/widgets/others/placeholders.dart';
import 'package:partypal/widgets/others/tonal_elevation.dart';

class EventScreen extends StatelessWidget {
  final Event event;
  const EventScreen({
    required this.event,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
          slivers: [
          
            SliverPersistentHeader(
              delegate: _EventAppBar(event: event),
              pinned: true,
            ),
      
            SliverToBoxAdapter(child: 0.05.sw.verticalSpace),
      
            SliverToBoxAdapter( // Entry options
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 0.03.sw,
                      vertical: 0.01.sw
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Theme.of(context).colorScheme.surface.tonalElevation(Elevation.level2, context)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: Text(
                          'Entry options',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 0.03.sw,
                      vertical: 0.01.sw
                    ),
                    child: ListTile(
                      title: const Text('Ticket'),
                      trailing: const Icon(CupertinoIcons.forward),
                      tileColor: Theme.of(context).colorScheme.surface.tonalElevation(Elevation.level3, context),
                      onTap: (){
                        GoRouter.of(context).push(RoutePaths.ticketScreen, extra: {'event': event});
                      },
                    ),
                  ),
            
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 0.03.sw,
                      vertical: 0.01.sw
                    ),
                    child: ListTile(
                      title: const Text('Dress code'),
                      trailing: const Icon(CupertinoIcons.forward),
                      tileColor: Theme.of(context).colorScheme.surface.tonalElevation(Elevation.level3, context),
                      onTap: (){
                        GoRouter.of(context).push(RoutePaths.dressCodeScreen, extra: {'event': event});
                      },
                    ),
                  ),
                ],
              ),
            ),
      
            SliverToBoxAdapter(child: 0.05.sw.verticalSpace),
      
            SliverToBoxAdapter( // promoter
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 0.03.sw,
                      vertical: 0.01.sw
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Theme.of(context).colorScheme.surface.tonalElevation(Elevation.level2, context)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: Text(
                          'Promoter',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 0.03.sw,
                      vertical: 0.01.sw
                    ),
                    child: PersonCard(user: event.creator),
                  ),
                ],
              ),
            ),
      
            SliverToBoxAdapter(child: 1.sw.verticalSpace)
          ],
      ),
    );
  }
}

class _EventAppBar extends SliverPersistentHeaderDelegate{
  final Event event;
  _EventAppBar({
    required this.event
  });

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

  @override
  double get maxExtent => 1.sw;

  @override
  double get minExtent => 100;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent){
    return Stack(
      children: [
        Opacity( // image
          opacity: min(1, max(0, 1 - shrinkOffset / (maxExtent - minExtent))),
          child: CachedNetworkImage(
            imageUrl: event.imageURL,
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
            fit: BoxFit.cover,
            placeholder: ((context, url) => const ImagePlaceholder()),
          ),
        ),

        // Opacity( // app bar
        //   opacity: min(1, max(0, shrinkOffset / (maxExtent - minExtent))),
        //   child: Container(
        //     color: Theme.of(context).colorScheme.surface.tonalElevation(Elevation.level1, context),
        //   ),
        // ),

        Align( // back button
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              top: 40
            ),
            child: GestureDetector(
              onTap: GoRouter.of(context).pop,
              child: SizedBox.square(
                dimension: 40,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface.tonalElevation(Elevation.level2, context).withOpacity(0.4),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: const Icon(CupertinoIcons.xmark),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}