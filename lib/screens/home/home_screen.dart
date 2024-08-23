import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partypal/models/place_model.dart';
import 'package:partypal/services/category_provider.dart';
import 'package:partypal/services/event_provider.dart';
import 'package:partypal/services/place_provider_service.dart';
import 'package:partypal/services/profile_management_service.dart';
import 'package:partypal/widgets/app_bars/app_bar.dart';
import 'package:partypal/widgets/cards/category_card.dart';
import 'package:partypal/widgets/cards/event_card.dart';
import 'package:partypal/widgets/cards/place_card.dart';
import 'package:partypal/widgets/others/placeholders.dart';
import 'package:partypal/widgets/others/scrim.dart';
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
  List<Place>? highEnergyPlaces;

  @override
  void initState(){
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<EventProvider>(context, listen: false).fetchEvents(context);// TODO: keep an eye on this
      Provider.of<CategoryProvider>(context, listen: false).fetchCategories();
      _fetchHighEnergyPlaces();
    });
  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
  }

  void _fetchHighEnergyPlaces(){
    Provider.of<PlaceProviderService>(context, listen: false)
      .getPlaces()
      .then((p){
        highEnergyPlaces = p;
        if(mounted) setState((){});
      });
  }

  @override
  void dispose(){
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final profileService = Provider.of<ProfileManagementService>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface.tonalElevation(Elevation.level1, context),
      body: RefreshIndicator(
          onRefresh: () async{
            setState(() => _isRefreshing = true);
            await Future.wait([
              profileService.fetchCurrentUserProfile(),
            ]).then((_){
              setState(() => _isRefreshing = false);
            });
            return Future.delayed(Duration.zero);
          },
        child: Scrim(
          active: _isRefreshing,
          child: CustomScrollView(
                controller: _scrollController,
                // physics: snapshot.data == null ? const NeverScrollableScrollPhysics() : null,
                slivers: [
                  const HomeAppBar(),

                  SliverToBoxAdapter( // events happening this week
                        child: FutureBuilder(
                          future: eventProvider.fetchEvents(context),
                          builder: (context, snapshot) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 0.03.sw, top: 0.03.sw),
                                  child: snapshot.data == null
                                  ? const TextPlaceHolder(height: 20, width: 200)
                                  : Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Theme.of(context).colorScheme.surface.tonalElevation(Elevation.level3, context)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                        child: Text(
                                          'Events happening this week',
                                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          ),
                                        ),
                                      ),
                                  ),
                                ),
                                0.03.sw.verticalSpace,
                                SizedBox(
                                  height: 200,
                                  child: ListView.builder(
                                    padding: EdgeInsets.symmetric(horizontal: 0.01.sw),
                                    scrollDirection: Axis.horizontal,
                                    physics: snapshot.data == null
                                      ? const NeverScrollableScrollPhysics()
                                      : const BouncingScrollPhysics(),
                                    itemCount: snapshot.data == null
                                      ? 3
                                      : snapshot.data!.length,
                                    itemBuilder: (context, index){
                                      return Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                                        child: snapshot.data == null
                                        ? const EventCardLoading()
                                        : EventCard(event: snapshot.data![index]),
                                      );
                                    }
                                  )
                                ),
                              ]
                            );
                          }
                        )
                      ),

                  SliverToBoxAdapter(child: 0.05.sw.verticalSpace),

                  SliverToBoxAdapter( // events based on your location
                    child: FutureBuilder(
                      future: eventProvider.fetchEvents(context),
                      builder: (context, snapshot){return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 0.03.sw, top: 0.03.sw),
                            child:
                              snapshot.data == null
                              ? const TextPlaceHolder(height: 20, width: 180)
                              : Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Theme.of(context).colorScheme.surface.tonalElevation(Elevation.level3, context)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                  child: Text(
                                    'Events based on your location',
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    ),
                                  ),
                                ),
                            ),
                          ),
                          0.03.sw.verticalSpace,
                          SizedBox(
                            height: 200,
                            child: ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 0.01.sw),
                              scrollDirection: Axis.horizontal,
                              physics: snapshot.data == null
                                ? const NeverScrollableScrollPhysics()
                                : const BouncingScrollPhysics(),
                              itemCount: snapshot.data == null
                                ? 3
                                : snapshot.data!.length,
                              itemBuilder: (context, index){
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                                  child: snapshot.data == null
                                  ? const EventCardLoading()
                                  : EventCard(event: snapshot.data![index]),
                                );
                              }
                            )
                          ),
                        ]
                      );
                      }
                    )
                  ),

                  SliverToBoxAdapter(child: 0.05.sw.verticalSpace),
                  SliverToBoxAdapter( // categories
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 0.03.sw, top: 0.03.sw),
                          child: categoryProvider.isFetching
                          ? const TextPlaceHolder(height: 20, width: 120)
                          : Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Theme.of(context).colorScheme.surface.tonalElevation(Elevation.level3, context)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                child: Text(
                                  'Categories',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  ),
                                ),
                            ),
                          ),
                        ),
                        0.03.sw.verticalSpace,
                        SizedBox(
                          height: 250,
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 0.01.sw),
                            scrollDirection: Axis.horizontal,
                            physics: categoryProvider.isFetching
                              ? const NeverScrollableScrollPhysics()
                              : const BouncingScrollPhysics(),
                            itemCount: categoryProvider.isFetching
                              ? 3
                              : categoryProvider.categories.length,
                            itemBuilder: (context, index){
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                                child: categoryProvider.isFetching
                                ? const CategoryCardLoading()
                                : CategoryCard(category: categoryProvider.categories[index]),
                              );
                            }
                          )
                        ),
                      ]
                    )
                  ),

                  SliverToBoxAdapter(child: 0.05.sw.verticalSpace),

                  SliverToBoxAdapter( // high energy places
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 0.03.sw, top: 0.03.sw),
                          child: highEnergyPlaces == null
                          ? const TextPlaceHolder(height: 20, width: 180)
                          : Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Theme.of(context).colorScheme.surface.tonalElevation(Elevation.level3, context)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                child: Text(
                                  'High energy places',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  ),
                                ),
                              ),
                            )
                        ),
                        0.03.sw.verticalSpace,
                      ]
                    )
                  ),
                  SliverList.builder(
                      itemCount: highEnergyPlaces == null
                        ? 3
                        : highEnergyPlaces!.length,
                      itemBuilder: (context, index){
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 0.02.sw, horizontal: 0.03.sw),
                          child: highEnergyPlaces == null
                          ? const PlaceLoadingCard()
                          : PlaceCard(place: highEnergyPlaces![index]),
                        );
                      }
                  ),

                  SliverToBoxAdapter(child: 0.03.sw.verticalSpace),

                ],
              ),
        ),
      ),
    );
  }
}
