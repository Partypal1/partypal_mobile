import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partypal/constants/asset_paths.dart';
import 'package:partypal/utils/datetime_util.dart';
import 'package:partypal/widgets/cards/circle_avatar.dart';
import 'package:partypal/widgets/others/tonal_elevation.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MomentCard extends StatefulWidget {
  final String username;
  final String profilePicturePath;
  final DateTime timeStamp;
  final List<String> imagePaths;
  final String? caption;

  const MomentCard({
    required this.username,
    required this.profilePicturePath,
    required this.timeStamp,
    required this.imagePaths,
    this.caption,
    super.key});

  @override
  State<MomentCard> createState() => _MomentCardState();
}

class _MomentCardState extends State<MomentCard> {
  bool isFavourite = false;
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            0.04.sw.horizontalSpace,
            CircleProfileImage(imagePath: AssetPaths.onboardingBackgroundImage2),
            10.horizontalSpace,
            Text(
              widget.username,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold
              ),
            ),
            10.horizontalSpace,
            Text(
              DateTimeUtils.timeDifference(widget.timeStamp),
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
          itemCount: widget.imagePaths.length,
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedSmoothIndicator(
            activeIndex: activeIndex,
            count: widget.imagePaths.length,
            effect: WormEffect(
              activeDotColor: Theme.of(context).colorScheme.inverseSurface,
              dotColor: Theme.of(context).colorScheme.surface.tonalElevation(Elevation.level5, context),
              dotHeight: 8,
              dotWidth: 8,
              strokeWidth: 0,
            ),
          ),
        ),
        Row(
          children: [
            0.04.sw.horizontalSpace,
            GestureDetector(
              onTap: (){
                setState(() {
                  isFavourite = !isFavourite;
                });
              },
              child: isFavourite
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
          child: Image.asset(
            widget.imagePaths[index],
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}