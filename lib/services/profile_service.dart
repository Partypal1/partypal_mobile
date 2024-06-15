import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:partypal/models/user_model.dart';
import 'package:partypal/utils/toasts.dart';

class ProfileService extends ChangeNotifier{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  PartypalUser? _user;
  User? get _currentFirebaseUser => FirebaseAuth.instance.currentUser;
  bool get isSignedIn => _currentFirebaseUser != null;
  
  PartypalUser? get user{
    if(_user == null){
      fetchCurrentUserProfile();
    }
    return _user;
  }

  CollectionReference<PartypalUser> get usersReference => _firestore.collection('users')
    .withConverter<PartypalUser>(
      fromFirestore: (snapshot, options) => PartypalUser.fromMap(snapshot.id, snapshot.data()!),
      toFirestore: (value, options){
        var v = value.toMap();
        v.remove('id');
        return v;
      } 
    );

  Future<bool> get hasProfile async {
    try {
      return await _firestore
        .collection('users')
        .doc(_currentFirebaseUser?.uid)
        .get()
        .then((snapshot) => snapshot.exists);
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> usernameIsAvailable(String username) async {
    try {
      return await _firestore
        .collection('users')
        .where('username', isEqualTo: username)
        .count()
        .get()
        .then((value) => value.count != null && value.count! == 0);
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> updateProfile({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? email,
    Role? role,
    String? username,
    String? profileImageUrl,
    String? location
    
  }) async {
    try {
      if (isSignedIn) {
        Map<String, dynamic>? data = await _firestore
        .collection('users')
        .doc(_currentFirebaseUser!.uid)
        .get()
        .then((value) => value.data());

        return _firestore
        .collection('users')
        .doc(_currentFirebaseUser!.uid)
        .set({
          'firstName': firstName ?? data?['firstName'],
          'lastName': lastName ?? data?['lastName'],
          'phoneNumber': phoneNumber ?? data?['phoneNumber'],
          'email': email ?? data?['email'],
          'role': role?.name ?? data?['role'],
          'username': username ?? data?['username'],
          'profileImageUrl': profileImageUrl ?? data?['profileImageUrl'] ?? _currentFirebaseUser?.photoURL,
          'location': location ?? data?['location']
        }).then((_) {
          Toasts.showToast('profile updated');
          return true;
        });
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      Toasts.showToast('something went wrong');
      return false;
    }
  }

  Future<PartypalUser?> getProfile(String userId){
    return usersReference.doc(userId).get().then((u) => u.data());
  }

  void fetchCurrentUserProfile(){
    if(isSignedIn){
      getProfile(_currentFirebaseUser!.uid).then((u){
        _user = u;
        notifyListeners();
      });
    }
  }
}