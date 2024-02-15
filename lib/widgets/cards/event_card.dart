import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:partypal/constants/elevation.dart';
import 'package:partypal/utils/toasts.dart';
import 'package:partypal/widgets/others/shimmer.dart';
import 'package:partypal/widgets/others/tonal_elevation.dart';

class EventCard extends StatefulWidget {
  final String imagePath;
  final DateTime date;
  final String title;
  final String location;
  final String creator; // change this to User
  const EventCard({
    required this.imagePath,
    required this.date,
    required this.title,
    required this.location,
    required this.creator,
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
              Image.asset(
                widget.imagePath,
                fit: BoxFit.cover,
              ),
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent,  Color.fromRGBO(0, 0, 0, 0.9)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter
                  )
                ),
              ),
             
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.title,
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                      Text(
                        DateFormat('hh:mm a - d MMM, yyyy').format(widget.date),
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
                            widget.location,
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
                            widget.creator,
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