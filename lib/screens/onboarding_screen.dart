import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:partypal/configs/asset_paths.dart';
import 'package:partypal/ui_components/onboarding_card.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboaringScreen extends StatefulWidget {
  const OnboaringScreen({super.key});

  @override
  State<OnboaringScreen> createState() => _OnboaringScreenState();
}

class _OnboaringScreenState extends State<OnboaringScreen> {
  List<String> titles = [
    "Discover nightlife like never before with Partypal",
    "Stay connected with friends and their nighlife",
    "Amplify Your Events and Parties with Partypal",
  ];
  List<String> bodies = [
    "you can now stay ahead of the party scene by discovering the hottest clubs, hour by hour. Our real-time data analysis and heat map technology ensure that you never miss out on the most happening spots in town.",
    "Stay connected with your party crew on Partypal. See where your friends are heading, coordinate plans, and make unforgettable memories together. Let's create epic nights out!",
    "Amplify your events with Partypal! Reach a wider audience, boost ticket sales, and create memorable experiences with our powerful marketing tools, seamless ticketing, and comprehensive analytics."
  ];
  List<String> backgroundImagePaths = [
    AssetPaths.onboardingBackgroundImage1,
    AssetPaths.onboardingBackgroundImage2,
    AssetPaths.onboardingBackgroundImage3,
  ];
  int activeIndex = 0;
  bool shouldAutoPlay = true;
  double imageOpacity = 1;
  
  @override
  void didChangeDependencies() {
    for (String path in backgroundImagePaths){ //precaching background images to avoid jitters
      precacheImage(AssetImage(path), context);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          DisplayBackgroundImage(
            imagePath: backgroundImagePaths[activeIndex],
            mediaQueryData: mediaQueryData
          ),
          CarouselSlider.builder(
            itemCount: titles.length,
            itemBuilder: (BuildContext context, int index, int realIndex){
              return buildCard(context, index, mediaQueryData);
            },
            options: CarouselOptions(
              height: double.infinity,
              autoPlay: shouldAutoPlay,
              autoPlayAnimationDuration: const Duration(milliseconds: 500),
              autoPlayCurve: Curves.easeIn,
              autoPlayInterval: const Duration(seconds: 5),
              onPageChanged: (index, reason) {
                
                setState(() {
                  activeIndex = index;
                });
                shouldAutoPlay = (index == (titles.length -1)) ? false : true;
              },
              enableInfiniteScroll: false,
              viewportFraction: 1,  
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: buildIndicator(activeIndex, titles.length),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: GestureDetector(
                onTap: (){
                  //TODO: navigate to auth selection screen
                },
                child: Text(
                  (activeIndex == titles.length - 1) ? 'Next' : 'Skip',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget buildCard(BuildContext context, int index, MediaQueryData mediaQueryData){
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 40,
            ),
            child: OnboardingCard(
              body: bodies[index],
              title: titles[index],
              mediaQueryData: mediaQueryData,
            ),
          ),
        )
      ],
    );
  }
  Widget buildIndicator(int activeIndex, int count){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: count,
        effect: WormEffect(
          activeDotColor: Theme.of(context).colorScheme.onSurfaceVariant,
          dotHeight: 12,
          dotWidth: 12,
          strokeWidth: 0,
        ),
      ),
    );
  }
}

class DisplayBackgroundImage extends StatefulWidget {
  final String imagePath;
  final MediaQueryData mediaQueryData;
  const DisplayBackgroundImage({
    required this.imagePath,
    required this.mediaQueryData,
    super.key});

  @override
  State<DisplayBackgroundImage> createState() => _DisplayBackgroundImageState();
}

class _DisplayBackgroundImageState extends State<DisplayBackgroundImage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(
        height: widget.mediaQueryData.size.height,
        width: widget.mediaQueryData.size.width
      ),
      child: Image.asset(widget.imagePath, fit: BoxFit.cover,),
    );
  }
}