import 'package:flutter/material.dart';
import 'package:partypal/models/place_model.dart';

class PlacesProvider extends ChangeNotifier{
  List<Place> places = [];
  bool isFetching = false;

  void fetchPlaces() async {
    isFetching = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 5));
    places = [
      Place(
        name: 'Quilox',
        type: 'Night club',
        imageUrl: "https://ik.imagekit.io/bi5ihkjoby38/prod-activities/activities/256d9765-83c4-419a-8032-7a8c3fedf987/1d13afc3-31e9-457e-87bc-a5d5d09076cc/347818052_1210965799596088_4348261296103688690_n.jpg?tr=w-1920",
        isPopularWithFriends: true,
        isFollowing: false
      ),
      Place(
        name: 'The Library',
        type: 'Lounge',
        imageUrl: "https://dinesurf.s3.eu-central-1.amazonaws.com/vendor_images/L8WQmwM1SuMbGmblGMBdjqpPBtqR7POEXv3PrWwE.jpg",
        isPopularWithFriends: true,
        isFollowing: false
      ),
      Place(
        name: 'Landmark',
        type: 'Beach',
        imageUrl: "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/16/50/f3/54/getlstd-property-photo.jpg?w=1200&h=-1&s=1",
        isPopularWithFriends: true,
        isFollowing: false
      ),
    ];
    isFetching = false;
    notifyListeners();
  }
}
