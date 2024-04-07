import 'package:flutter/material.dart';
import 'package:partypal/models/place_model.dart';
import 'package:partypal/widgets/app_bars/app_bar.dart';
import 'package:partypal/widgets/others/tonal_elevation.dart';

class PlaceScreen extends StatefulWidget {
  final Place place;
  const PlaceScreen({
    required this.place,
    super.key});

  @override
  State<PlaceScreen> createState() => _PlaceScreenState();
}

class _PlaceScreenState extends State<PlaceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface.tonalElevation(Elevation.level1, context),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: SliverCustomAppBarDelegate(title: widget.place.name),
          )
        ],
      ),
    );
  }
}