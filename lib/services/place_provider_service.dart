import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:partypal/models/place_model.dart';

class PlaceProviderService extends ChangeNotifier{
  final _firestore = FirebaseFirestore.instance;

  CollectionReference<Place> get placesReference => _firestore
    .collection('places')
    .withConverter<Place>(
      fromFirestore: (snapshot, options) => Place.fromMap(snapshot.id, snapshot.data()!),
      toFirestore: (value, options){
        var v = value.toMap();
        v.remove('id'); // id is not needed on the firebase
        return v;
      }
    );

  Future<List<Place>> getPlaces({String? type}) async {
    if(type != null){
      return placesReference
        .where('type', isEqualTo: type)
        .get()
        .then((p){
          return p.docs.map((e) => e.data()).toList();
        });
    }
    else {
      return placesReference
        .get()
        .then((p){
          return p.docs.map((e) => e.data()).toList();
        });
    }
  }
}