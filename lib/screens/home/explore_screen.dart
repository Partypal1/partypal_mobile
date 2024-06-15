import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  // late GoogleMapController _googleMapController;
  final LatLng _center = const LatLng(6.52704, 3.38874);

  void _onMapCreated(GoogleMapController controller){
    // _googleMapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child:GoogleMap(
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 15,
          ),
          onMapCreated: _onMapCreated,
        )
      ),
    );
  }
}