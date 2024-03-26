import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:partypal/models/event_model.dart';
import 'package:partypal/utils/toasts.dart';
import 'package:partypal/widgets/others/placeholders.dart';
import 'package:partypal/widgets/others/shimmer.dart';
import 'package:partypal/widgets/others/tonal_elevation.dart';

class EventCard extends StatefulWidget {
  final Event event;

  const EventCard({
    required this.event,
    super.key});

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  bool isFavourite = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 200,
        width: 0.8.sw,
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.tonalElevation(Elevation.level3, context),
            borderRadius: BorderRadius.circular(20),
            
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: widget.event.imageUrl,
                imageBuilder: (context, imageProvider){
                  return Container(
                    decoration: BoxDecoration(
                      // gradient: const LinearGradient(
                      //   colors: [Colors.transparent,  Color.fromRGBO(0, 0, 0, 0.9)],
                      //   begin: Alignment.topCenter,
                      //   end: Alignment.bottomCenter
                      // ),
                      image: DecorationImage(
                        image: imageProvider,
                        
                        colorFilter: ColorFilter.mode(Color.fromRGBO(0, 0, 0, 0.5), BlendMode.colorBurn),
                        fit: BoxFit.cover
                      )
                    ),
                  );
                },
                placeholder: (context, url) => const ImagePlaceholder(),
                fit: BoxFit.cover,
              ),
              // Container(
              //   decoration: const BoxDecoration(
              //     gradient: LinearGradient(
              //       colors: [Colors.transparent,  Color.fromRGBO(0, 0, 0, 0.9)],
              //       begin: Alignment.topCenter,
              //       end: Alignment.bottomCenter
              //     )
              //   ),
              // ),
             
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.event.name,
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                      Text(
                        DateFormat('hh:mm a - d MMM, yyyy').format(widget.event.dateTime),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white
                        ),
                      ),
                      // 2.verticalSpace,
                      Row( // location
                      mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.location_pin,
                            color: Colors.white,
                            size: 16,
                          ),
                          5.horizontalSpace,
                          Text(
                            widget.event.location,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white
                            ),
                          )
                        ],
                      ),
                      // 2.verticalSpace,
                      Row( // creator
                      mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.person_rounded,
                            color: Colors.white,
                            size: 16,
                          ),
                          5.horizontalSpace,
                          Text(
                            widget.event.creator.username,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                isFavourite = !isFavourite;
                              });
                            },
                            child: isFavourite
                              ? const Icon(
                                  Icons.favorite,
                                  color: Colors.white,
                                )
                              : const Icon(
                                  Icons.favorite_outline,
                                  color: Colors.white,
                                ),
                          ),
                          10.horizontalSpace,
                          GestureDetector(
                            onTap: (){
                              //TODO: share
                              Toasts.showToast('Sharing ...');
                            },
                            child: const Icon(
                              Icons.share,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EventCardLoading extends StatelessWidget {
  const EventCardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      isLoading: true,
      child: Center(
        child: SizedBox(
          height: 200,
          width: 0.8.sw,
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface.tonalElevation(Elevation.level3, context),
              borderRadius: BorderRadius.circular(20),
              
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 36,
                      width: 150,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceVariant.tonalElevation(Elevation.level1, context),
                          borderRadius: BorderRadius.circular(25)
              
                        ),
                      ),
                    ),
                    10.verticalSpace,
                    SizedBox(
                      height: 14,
                      width: 175,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceVariant.tonalElevation(Elevation.level1, context),
                          borderRadius: BorderRadius.circular(10)
              
                        ),
                      ),
                    ),
                    10.verticalSpace,
                    SizedBox(
                      height: 14,
                      width: 80,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceVariant.tonalElevation(Elevation.level1, context),
                          borderRadius: BorderRadius.circular(10)
              
                        ),
                      ),
                    ),
                    10.verticalSpace,
                    SizedBox(
                      height: 14,
                      width: 100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceVariant.tonalElevation(Elevation.level1, context),
                          borderRadius: BorderRadius.circular(10)
                  
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ),
      )
    );
  }
}