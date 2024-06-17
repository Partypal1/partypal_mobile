import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partypal/models/place_model.dart';
import 'package:partypal/services/place_provider_service.dart';
import 'package:partypal/widgets/app_bars/app_bar.dart';
import 'package:partypal/widgets/cards/place_card.dart';
import 'package:partypal/widgets/others/tonal_elevation.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  final String categoryName;
  const CategoryScreen({
    required this.categoryName,
    super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late FocusNode searchFocus;
  late TextEditingController searchController;
  List<Place>? places;
  List<Place>? placesToDisplay;
  List<Place>? searchResult;

  @override
  void initState(){
    super.initState();
    searchFocus = FocusNode();
    searchController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _fetchPlaces();
    });
  }

  void _fetchPlaces(){
    Provider.of<PlaceProviderService>(context, listen: false)
      .getPlaces(type: widget.categoryName)
      .then((p){
        places = p;
        placesToDisplay = places;
        if(mounted) setState((){});
      });
  }

  void _searchForPlace(String query){
    if (places == null){
      searchResult = [];
    }
    else{
      searchResult = places!
        .where((p) => p.name.toLowerCase().contains(query.toLowerCase())).toList();
    }

  }

  @override
  void dispose(){
    searchFocus.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: CustomSliverAppBar(title: widget.categoryName),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(
                height: 60,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface.tonalElevation(Elevation.level2, context),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: TextField(
                        controller: searchController,
                        focusNode: searchFocus,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: const Icon(Icons.search),
                          hintText: 'Search for ${widget.categoryName.toLowerCase()}'
                        ),
                        onTapOutside: (_) => FocusScope.of(context).requestFocus(FocusNode()),
                        onChanged: (value){
                          if (value.isEmpty){
                            setState(() {
                              placesToDisplay = places;
                            });
                          }
                          else{
                            _searchForPlace(value);
                            setState(() {
                              placesToDisplay = searchResult;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(child: 20.verticalSpace),

          // SliverToBoxAdapter( // TODO: put some buttons here
          //   child: SizedBox(
          //     height: 40,
          //     child: ListView.builder(
          //       itemCount: 4,
          //       scrollDirection: Axis.horizontal,
          //       itemBuilder: ((context, index) {
          //         return Padding(
          //           padding: const EdgeInsets.all(5),
          //           child: SizedBox.square(
          //             dimension: 30,
          //             child: Container(
          //               color: Colors.red,
          //             ),
          //           ),
          //         );
          //       })
          //     ),
          //   ),
          // ),

          SliverToBoxAdapter(child: 20.verticalSpace),
          SliverList.builder(
            itemCount: placesToDisplay == null ? 5 : placesToDisplay!.length,
            itemBuilder: (context, index){
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                child: placesToDisplay == null
                ? const PlaceLoadingCard()
                : PlaceCard(place: placesToDisplay![index]),
              );
            }
          )
        ],
      ),
    );
  }
}