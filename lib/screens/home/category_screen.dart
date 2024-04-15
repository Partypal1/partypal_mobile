import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partypal/services/places_provider.dart';
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

  @override
  void initState(){
    super.initState();
    searchFocus = FocusNode();
    searchController = TextEditingController();
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
            itemCount: Provider.of<PlacesProvider>(context).places.length,
            itemBuilder: (context, index){
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                child: PlaceCard(place: Provider.of<PlacesProvider>(context).places[index]),
              );
            }
          )
        ],
      ),
    );
  }
}