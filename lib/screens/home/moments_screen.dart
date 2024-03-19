import 'package:flutter/material.dart';
import 'package:partypal/services/moment_provider.dart';
import 'package:partypal/widgets/app_bars/app_bar.dart';
import 'package:partypal/widgets/cards/moment_card.dart';
import 'package:partypal/widgets/others/shimmer.dart';
import 'package:partypal/widgets/others/tonal_elevation.dart';
import 'package:provider/provider.dart';

class MomentsScreen extends StatefulWidget {
  const MomentsScreen({super.key});

  @override
  State<MomentsScreen> createState() => _MomentsScreenState();
}

class _MomentsScreenState extends State<MomentsScreen> {

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<MomentProvider>(context, listen: false).fetchMoments();
    });
  }
  @override
  Widget build(BuildContext context) {
    MomentProvider momentProvider = Provider.of<MomentProvider>(context); 
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface.tonalElevation(Elevation.level1, context),
      body: Shimmer(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: SliverCustomAppBarDelegate(title: 'Moments', hasBackButton: false)
            ),
           SliverList.builder(
            itemCount: momentProvider.isFetching
              ? 3
              : momentProvider.moments.length,
            itemBuilder: (context, index){
              return Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  bottom: 50
                ),
                child:  momentProvider.isFetching
                  ? const MomentCardLoading()
                  : MomentCard(moment: momentProvider.moments[index]),
              );
            }),
            const SliverToBoxAdapter(child: SizedBox(height: 80,),) // to bridge over the bottom nav bar
          ],
        ),
      )
    );
  }
}