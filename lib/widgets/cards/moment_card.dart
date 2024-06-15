import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partypal/models/moment_model.dart';
import 'package:partypal/utils/datetime_util.dart';
import 'package:partypal/widgets/cards/circle_image.dart';
import 'package:partypal/widgets/others/placeholders.dart';
import 'package:partypal/widgets/others/shimmer.dart';
import 'package:partypal/widgets/others/tonal_elevation.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MomentCard extends StatefulWidget {
  final Moment moment;

  const MomentCard({
    required this.moment,
    super.key});

  @override
  State<MomentCard> createState() => _MomentCardState();
}

class _MomentCardState extends State<MomentCard> {
  late bool isLiked;
  int activeIndex = 0;

  @override
  void initState(){
    super.initState();
    isLiked = widget.moment.isLiked;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            0.04.sw.horizontalSpace,
            CircleImage(imageUrl: widget.moment.creator.profileImageUrl),
            10.horizontalSpace,
            Text(
              widget.moment.creator.username,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold
              ),
            ),
            10.horizontalSpace,
            Text(
              DateTimeUtils.timeDifference(widget.moment.dateTime),
              style: Theme.of(context).textTheme.bodySmall
            ),
            const Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                onPressed: (){
                  // TODO: show a menu of stuff
                },
                icon: const Icon(Icons.more_horiz)
              ),
            )
          ],
        ),
        15.verticalSpace,
        CarouselSlider.builder(
          itemCount: widget.moment.imageUrls.length,
          itemBuilder: (context, index, realIndex) {
            return _buildImageCard(index);
          },
          options: CarouselOptions(
            enableInfiniteScroll: false,
            aspectRatio: 1,
            viewportFraction: 0.95,
            // enlargeCenterPage: true,
            // enlargeFactor: 0.3,
            padEnds: false,
            onPageChanged: (index, reason) {
              setState(() {
                activeIndex = index;
              });
            }
          )
        ),
        10.verticalSpace,
        widget.moment.imageUrls.length > 1
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: AnimatedSmoothIndicator(
              activeIndex: activeIndex,
              count: widget.moment.imageUrls.length,
              effect: WormEffect(
                activeDotColor: Theme.of(context).colorScheme.inverseSurface,
                dotColor: Theme.of(context).colorScheme.surface.tonalElevation(Elevation.level5, context),
                dotHeight: 8,
                dotWidth: 8,
                strokeWidth: 0,
              ),
            ),
          )
        : const SizedBox.shrink(),
        Row(
          children: [
            0.04.sw.horizontalSpace,
            GestureDetector(
              onTap: (){
                //TODO: add a heart animation
                setState(() {
                  isLiked = !isLiked;
                });
              },
              child: isLiked
                ? const Icon(
                    Icons.favorite,
                    // color: Colors.white,
                  )
                : const Icon(
                    Icons.favorite_outline,
                    // color: Colors.white,
                  ),
            ),
            10.horizontalSpace,
            GestureDetector(
              onTap: (){
                //TODO: comments
              },
              child: const Icon(
                Icons.mode_comment_outlined,
              ),
            ),
          ],
        )
      ],
    );
  }
  Widget _buildImageCard(int index){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        // height: ,
        width: 400,
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: CachedNetworkImage(
            imageUrl: widget.moment.imageUrls[index],
            placeholder: (context, url) => const ImagePlaceholder(),
            fit: BoxFit.cover,
          )
        ),
      ),
    );
  }
}

class MomentCardLoading extends StatelessWidget {
  const MomentCardLoading({super.key});

  @override
  Widget build(BuildContext context) {
     return ShimmerLoading(
      isLoading: true,
       child: Center(
         child: Column(
          children: [
            Row(
              children: [
                0.04.sw.horizontalSpace,
                SizedBox.square(
                  dimension: 50,
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Theme.of(context).colorScheme.surface.tonalElevation(Elevation.level3, context)
                    ),
                  )
                ),
                10.horizontalSpace,
                SizedBox(
                  height: 14,
                  width: 60,
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Theme.of(context).colorScheme.surface.tonalElevation(Elevation.level3, context)
                    ),
                  )
                ),
                10.horizontalSpace,
                SizedBox(
                  height: 12,
                  width: 20,
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Theme.of(context).colorScheme.surface.tonalElevation(Elevation.level3, context)
                    ),
                  )
                ),     
              ],
            ),
            15.verticalSpace,
            SizedBox(
              height: 1.sw,
              width: 0.95.sw,
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Theme.of(context).colorScheme.surface.tonalElevation(Elevation.level3, context)
                ),
              )
            ),
            10.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(3, (index){
                  return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: SizedBox.square(
                      dimension: 8,
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Theme.of(context).colorScheme.surface.tonalElevation(Elevation.level3, context)
                        ),
                      )
                    ),
                  );
                })
                
              ],
            ),
          ],
             ),
       ),
    );
  }
}