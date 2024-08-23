import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:partypal/models/event_model.dart';
import 'package:partypal/services/profile_management_service.dart';
import 'package:provider/provider.dart';

class EventProvider extends ChangeNotifier{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference<Event> get _eventReference => _firestore.collection('events')
      .withConverter<Event>(
        fromFirestore: (value, options){
          var v = value.data()!;
          v.addAll({'id': value.id});
          return Event.fromMap(v);
        },
        toFirestore: (value, options){
          var v = value.toMap();
          v.remove('id');
          return v;
        }
      );

  Future<List<Event>?> fetchEvents(BuildContext context) async {
    try {
      if (Provider
          .of<ProfileManagementService>(context, listen: false)
          .isSignedIn) {
        final res = await _eventReference.get();
        return res.docs.map((e) => e.data()).toList();
      }
      return null;
    }
    catch (e){
      log(e.toString());
      return null;
    }
  }
}