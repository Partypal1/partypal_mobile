import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partypal/services/category_provider.dart';
import 'package:partypal/services/event_provider.dart';
import 'package:partypal/services/places_provider.dart';
import 'package:partypal/widgets/app_bars/app_bar.dart';
import 'package:partypal/widgets/cards/category_card.dart';
import 'package:partypal/widgets/cards/event_card.dart';
import 'package:partypal/widgets/cards/place_card.dart';
import 'package:partypal/widgets/others/placeholders.dart';
import 'package:partypal/widgets/others/scrim.dart';
import 'package:partypal/widgets/others/shimmer.dart';
import 'package:partypal/widgets/others/tonal_elevation.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;
  bool _isRefreshing = false;

  @override
  void initState(){
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<EventProvider>(context, listen: false).fetchEvents();
      Provider.of<CategoryProvider>(context, listen: false).fetchCategories();
      Provider.of<PlacesProvider>(context, listen: false).fetchPlaces();
    });
  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
  }

  @override
  void dispose(){
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    EventProvider eventProvider = Provider.of<EventProvider>(context);
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);
    PlacesProvider placeProvider = Provider.of<PlacesProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface.tonalElevation(Elevation.level0, context),
      body: Shimmer(
        child: RefreshIndicator(
            onRefresh: () async{
              setState(() => _isRefreshing = true);
              await Future.delayed(Durations.extralong4).then((_){
                setState(() => _isRefreshing = false);
              });
              // TODO: refresh home page content
              return Future.delayed(Duration.zero);
            },
          child: Scrim(
            active: _isRefreshing,
            child: CustomScrollView(
              controller: _scrollController,
              physics: _isRefreshing ? const NeverScrollableScrollPhysics() : null,
              slivers: [
                const HomeAppBar(),
              
                SliverToBoxAdapter( // events happening this week
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: eventProvider.isFetching 
                        ? const TextPlaceHolder(height: 20, width: 200)
                        : Text(
                          'Events happening this week',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      15.verticalSpace,
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          scrollDirection: Axis.horizontal,
                          physics: eventProvider.isFetching
                            ? const NeverScrollableScrollPhysics()
                            : const BouncingScrollPhysics(),
                          itemCount: eventProvider.isFetching
                            ? 3
                            : eventProvider.eventsHappeningThisWeek.length,
                          itemBuilder: (context, index){
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: eventProvider.isFetching
                              ? const EventCardLoading() 
                              : EventCard(event: eventProvider.eventsHappeningThisWeek[index]),
                            );
                          }
                        )
                      ),
                    ]
                  )
                ),
               
                SliverToBoxAdapter(child: 25.verticalSpace),
              
                SliverToBoxAdapter( // events based on your location
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: 
                          eventProvider.isFetching
                          ? const TextPlaceHolder(height: 20, width: 180)
                          : Text(
                            'Events based on your location',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold
                            ),
                          ),
                      ),
                      15.verticalSpace,
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          scrollDirection: Axis.horizontal,
                          physics: eventProvider.isFetching
                            ? const NeverScrollableScrollPhysics()
                            : const BouncingScrollPhysics(),
                          itemCount: eventProvider.isFetching
                            ? 3
                            : eventProvider.eventsBasedOnYourLocation.length,
                          itemBuilder: (context, index){
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: eventProvider.isFetching
                              ? const EventCardLoading() 
                              : EventCard(event: eventProvider.eventsBasedOnYourLocation[index]),
                            );
                          }
                        )
                      ),
                    ]
                  )
                ),
               
                SliverToBoxAdapter(child: 25.verticalSpace),
                SliverToBoxAdapter( // categories
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: categoryProvider.isFetching
                        ? const TextPlaceHolder(height: 20, width: 120)
                        : Text(
                          'Categories',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      15.verticalSpace,
                      SizedBox(
                        height: 250,
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          scrollDirection: Axis.horizontal,
                          physics: categoryProvider.isFetching
                            ? const NeverScrollableScrollPhysics()
                            : const BouncingScrollPhysics(),
                          itemCount: categoryProvider.isFetching
                            ? 3
                            : categoryProvider.categories.length,
                          itemBuilder: (context, index){
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: eventProvider.isFetching
                              ? const CategoryCardLoading() 
                              : CategoryCard(category: categoryProvider.categories[index]),
                            );
                          }
                        )
                      ),
                    ]
                  )
                ),
               
                SliverToBoxAdapter(child: 25.verticalSpace),
            
                SliverToBoxAdapter( // high energy places
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: placeProvider.isFetching 
                        ? const TextPlaceHolder(height: 20, width: 180)
                        : Text(
                          'High energy places',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      15.verticalSpace,
            
                    ]
                  )
                ),
                SliverList.builder(
                    itemCount: placeProvider.isFetching
                      ? 3
                      : placeProvider.places.length,
                    itemBuilder: (context, index){
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: placeProvider.isFetching
                        ? const PlaceLoadingCard() 
                        : PlaceCard(place: placeProvider.places[index]),
                      );
                    }
                ),
               
                SliverToBoxAdapter(child: 10.verticalSpace),
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}
