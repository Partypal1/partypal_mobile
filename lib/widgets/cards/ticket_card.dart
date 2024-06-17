import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:partypal/models/event_model.dart';
import 'package:partypal/utils/toasts.dart';
import 'package:partypal/widgets/others/placeholders.dart';
import 'package:partypal/widgets/others/tonal_elevation.dart';

class TicketCard extends StatefulWidget {
  final Event event;
  const TicketCard({
    required this.event,
    super.key});

  @override
  State<TicketCard> createState() => _TicketCardState();
}

class _TicketCardState extends State<TicketCard> {
  bool isFavourite = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 0.3.sw,
        width: 0.75.sw,
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.tonalElevation(Elevation.level3, context),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox.square(
                dimension: 0.3.sw,
                child: CachedNetworkImage(
                  imageUrl: widget.event.imageURL,
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
                  placeholder: (context, url) => const ImagePlaceholder(),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 0.45.sw,
                child: Padding(
                  padding: EdgeInsets.all(0.02.sw),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        widget.event.name,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        DateFormat('d MMM, yyyy - h a').format(widget.event.dateTime),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                          overflow: TextOverflow.ellipsis
                        ),
                      ),
                      Row( // location
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.location_pin,
                            color: Theme.of(context).colorScheme.onSurface,
                            size: 14,
                          ),
                          3.horizontalSpace,
                          Text(
                            widget.event.location,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface
                            ),
                          )
                        ],
                      ),
                      Row( // creator
                        mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.person_rounded,
                              color: Theme.of(context).colorScheme.onSurface,
                              size: 14,
                            ),
                            3.horizontalSpace,
                            Text(
                              widget.event.creator.username,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface
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
                                ? Icon(
                                    Icons.favorite,
                                    color: Theme.of(context).colorScheme.onSurface,
                                    size: 15,
                                  )
                                : Icon(
                                    Icons.favorite_outline,
                                    color: Theme.of(context).colorScheme.onSurface,
                                    size: 15,
                                  ),
                            ),
                            5.horizontalSpace,
                            GestureDetector(
                              onTap: (){
                                //TODO: share
                                Toasts.showToast('Sharing ...');
                              },
                              child: Icon(
                                Icons.share,
                                color: Theme.of(context).colorScheme.onSurface,
                                size: 15,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}