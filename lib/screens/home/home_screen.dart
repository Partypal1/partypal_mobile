import 'package:flutter/material.dart';
import 'package:partypal/constants/asset_paths.dart';
import 'package:partypal/widgets/app_bar.dart';
import 'package:partypal/widgets/event_card.dart';
import 'package:partypal/widgets/places_card.dart';
import 'package:partypal/widgets/tonal_elevation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;
  final List<String> imagePaths = [
    AssetPaths.onboardingBackgroundImage1,
    AssetPaths.onboardingBackgroundImage2,
    AssetPaths.onboardingBackgroundImage3,
    AssetPaths.onboardingBackgroundImage1,
    AssetPaths.onboardingBackgroundImage2,
    AssetPaths.onboardingBackgroundImage3,
    AssetPaths.onboardingBackgroundImage1,
    AssetPaths.onboardingBackgroundImage2,
    AssetPaths.onboardingBackgroundImage3,
  ];
  @override
  void initState(){
    super.initState();
    _scrollController = ScrollController();
  }

  bool get _isAppBarExpanded{
    return _scrollController.hasClients && _scrollController.offset > 200 - kToolbarHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface.tonalElevation(Elevation.level0, context),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          const HomeAppBar(name: 'Sunkanmi',),
        
          SliverToBoxAdapter( // events happening this week
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: Text(
                    'Events happening this week',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      ...List.generate(4, (index) => Padding(
                          padding: const EdgeInsets.all(15),
                          child: EventCard(
                            imagePath: imagePaths[index],
                            date: DateTime.now(),
                            title: 'Bluette',
                            location: 'Quilox',
                            creator: 'Yomi'
                          ),
                        )
                      ),
                     
                    ],
                  ),
                ),
              ],
            ),
          ),
         
          SliverToBoxAdapter( // events based on your location
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: Text(
                    'Events based on your location',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      ...List.generate(4, (index) => Padding(
                          padding: const EdgeInsets.all(15),
                          child: EventCard(
                            imagePath: imagePaths[index + 1],
                            date: DateTime.now(),
                            title: 'Bluette',
                            location: 'Quilox',
                            creator: 'Yomi'
                          ),
                        )
                      ),
                     
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: Text(
                    'High energy places',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                ...List.generate(5, (index){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: PlacesCard(
                      placeName: 'Quilox',
                      placeType: 'nightclub',
                      imagePath: imagePaths[index],
                    )
                  );
                })
              ],
            )
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 500,
            ),
          )
        ],
      ),
    );
  }
}
