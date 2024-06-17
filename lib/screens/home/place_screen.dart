import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partypal/models/place_model.dart';
import 'package:partypal/widgets/app_bars/app_bar.dart';
import 'package:partypal/widgets/cards/circle_image.dart';
import 'package:partypal/widgets/cards/place_heat_map_card.dart';
import 'package:partypal/widgets/others/placeholders.dart';

class PlaceScreen extends StatefulWidget {
  final Place place;
  const PlaceScreen({
    required this.place,
    super.key});

  @override
  State<PlaceScreen> createState() => _PlaceScreenState();
}

class _PlaceScreenState extends State<PlaceScreen> with SingleTickerProviderStateMixin{
  late List<Widget> _tabViews;
  late TabController _tabController;

  @override
  void initState(){
    super.initState();
    _tabViews = [
      PlaceHeatMapCard(place: widget.place),
      const SizedBox(height: 1000),
      const SizedBox(height: 1000),
    ];
    _tabController = TabController(length: 3, vsync: this)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose(){
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: CustomSliverAppBar(title: widget.place.name),
            floating: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                height: 80,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CircleImage(imageURL: widget.place.imageURL, radius: 40,),
                    10.horizontalSpace,
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextPlaceHolder(height: 14, width: 100),
                        TextPlaceHolder(height: 14, width: 120),
                        TextPlaceHolder(height: 14, width: 80),
                        // Text(
                        //   '',
                        //   style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        //     fontWeight: FontWeight.bold
                        //   ),
                        // ),
                        // Text(
                        //   '',
                        //   style: Theme.of(context).textTheme.bodySmall
                        // ),
                        // Text(
                        //   '',
                        //   style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        //     fontWeight: FontWeight.bold,
                        //     color: Theme.of(context).colorScheme.secondary
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverPersistentHeader(
            delegate: _PlaceTab(tabController: _tabController),
            pinned: true,
          ),
          SliverToBoxAdapter( // TODO: retain state without using indexedstack
            child: _tabViews[_tabController.index],
          )
        ],
      ),
    );
  }
}

class _PlaceTab extends SliverPersistentHeaderDelegate{
  final TabController tabController;
  _PlaceTab({
    required this.tabController,
  });

  @override
  double get minExtent => 80;

  @override
  double get maxExtent => 80;

  @override
  bool shouldRebuild(_PlaceTab oldDelegate){
    return false;
  }
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent){
    return SizedBox(
      height: 80,
      child: TabBar(
        controller: tabController,
        splashBorderRadius: BorderRadius.circular(4),
        tabs: const [
          SizedBox(
            height: 50,
            child: Center(
              child: Text('Overview'),
            ),
          ),
          SizedBox(
            height: 50,
            child: Center(
              child: Text('Events'),
            ),
          ),
          SizedBox(
            height: 50,
            child: Center(
              child: Text('Menu'),
            ),
          ),
        ],
      ),
    );
  }
}