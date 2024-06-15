import 'package:flutter/material.dart';
import 'package:partypal/widgets/app_bars/app_bar.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> with SingleTickerProviderStateMixin{
  late TabController _tabController;

  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: 3, vsync: this)
      ..addListener(() {
        setState((){});
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
            delegate: CustomSliverAppBar(title: 'Notifications'),
            pinned: true,
          ),
          SliverPersistentHeader(delegate: _NotificationTab(tabController: _tabController))
        ],
      ),
      floatingActionButton: _tabController.index == 0
        ? FloatingActionButton(
            tooltip: 'Create alert',
            onPressed: (){
              //TODO: navigate to the create alert page
            },
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            child: const Icon(Icons.add),
          )
        : null,
    );
  }
}

class _NotificationTab extends SliverPersistentHeaderDelegate{
  final TabController tabController;
  _NotificationTab({
    required this.tabController,
  });

  @override
  double get minExtent => 80;

  @override
  double get maxExtent => 80;

  @override
  bool shouldRebuild(_NotificationTab oldDelegate){
    return false;
  }
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent){
    return SizedBox(
      height: 50,
      child: TabBar(
        controller: tabController,
        splashBorderRadius: BorderRadius.circular(4),
        tabs: const [
          SizedBox(
            height: 40,
            child: Center(
              child: Text('Alerts'),
            ),
          ),
          SizedBox(
            height: 40,
            child: Center(
              child: Text('Orders'),
            ),
          ),
          SizedBox(
            height: 40,
            child: Center(
              child: Text('Feeds'),
            ),
          ),
        ],
      ),
    );
  }
}