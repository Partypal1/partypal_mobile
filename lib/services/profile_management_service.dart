import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:partypal/models/user_model.dart';
import 'package:partypal/utils/toasts.dart';

class ProfileManagementService extends ChangeNotifier{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

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
    String? imagePath,
    String? location
    
  }) async {
    try {
      if (isSignedIn) {
        Map<String, dynamic>? data = await _firestore
        .collection('users')
        .doc(_currentFirebaseUser!.uid)
        .get()
        .then((value) => value.data());

        final imageRef = _storage.ref().child('profileImages/${_currentFirebaseUser!.uid}.jpg');
        String? profileImageURL;
        if(imagePath != null){
          await imageRef.putFile(File(imagePath));
          profileImageURL = await imageRef.getDownloadURL();
        }

        return _firestore
        .collection('users')
        .doc(_currentFirebaseUser!.uid)
        .set({
          'firstName': firstName ?? data?['firstName'] ?? _splitName(_currentFirebaseUser?.displayName)[0],
          'lastName': lastName ?? data?['lastName'] ?? _splitName(_currentFirebaseUser?.displayName)[1],
          'phoneNumber': phoneNumber ?? data?['phoneNumber'] ?? _currentFirebaseUser?.phoneNumber,
          'email': email ?? data?['email'] ?? _currentFirebaseUser?.email,
          'role': role?.name ?? data?['role'] ?? 'user',
          'username': username ?? data?['username'] ?? _currentFirebaseUser?.displayName,
          'profileImageURL': profileImageURL ?? data?['profileImageURL'] ?? _currentFirebaseUser?.photoURL,
          'location': location ?? data?['location']
        }).then((_) {
          log('profile updated');
          fetchCurrentUserProfile();
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

  Future<void> fetchCurrentUserProfile() async {
    if(isSignedIn){
      getProfile(_currentFirebaseUser!.uid).then((u){
        _user = u;
        notifyListeners();
      });
    }
  }

  void removeCurrentUser(){
    log('deleted user ${_user?.id}');
    _user = null;
  }

  List<String?> _splitName(String? joinedName){
    if(joinedName == null){
      return [null, null];
    }
    else if(joinedName.split(' ').length > 1){
      List<String> split = joinedName.split(' ');
      return [split.first, split.last];
    }
    else{
      return [joinedName, null];
    }
  }
}