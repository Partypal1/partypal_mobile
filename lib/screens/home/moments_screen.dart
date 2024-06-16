import 'package:flutter/material.dart';
import 'package:partypal/services/moment_provider.dart';
import 'package:partypal/widgets/app_bars/app_bar.dart';
import 'package:partypal/widgets/cards/moment_card.dart';
import 'package:partypal/widgets/others/scrim.dart';
import 'package:provider/provider.dart';

class MomentsScreen extends StatefulWidget {
  const MomentsScreen({super.key});

  @override
  State<MomentsScreen> createState() => _MomentsScreenState();
}

class _MomentsScreenState extends State<MomentsScreen> {
  bool _isRefreshing = false;

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
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: RefreshIndicator(
          onRefresh: () async{
            setState(() => _isRefreshing = true);
            await Future.delayed(Durations.extralong4).then((_){
              setState(() => _isRefreshing = false);
            });
            // TODO: refresh moment page content
            return Future.delayed(Duration.zero);
          },
        child: Scrim(
          active: _isRefreshing,
          child: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                delegate: CustomSliverAppBar(title: 'Moments', hasBackButton: false),
                floating: true,
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
            ],
          ),
        ),
      )
    );
  }
}