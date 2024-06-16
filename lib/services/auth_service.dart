import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:partypal/utils/toasts.dart';

class AuthService extends ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? get user => FirebaseAuth.instance.currentUser;
  bool get isSignedIn => FirebaseAuth.instance.currentUser != null;

  Future<bool> googleSignInSilently() async {
    try {
      return _googleSignIn.signInSilently().then((account) => account != null);
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> googleSignIn() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
      AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken
      );
      final userCredential = await FirebaseAuth.instance.signInWithCredential(authCredential);
      if (userCredential.user != null) {
        notifyListeners();
        log('signed in with google');
        return true;
      }
      else {
        log('something went wrong');
        return false;
      }
    } catch (e) {
      log(e.toString());
      Toasts.showToast('something went wrong');
      return false;
    }
  }

  Future<bool> createAccountWithEmailAndPassword(String email, password) async {
    try{
      return FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
      ).then((userCredential){
        if(userCredential.user != null){
          FirebaseAuth.instance.currentUser?.sendEmailVerification();
          return true;
        }
        else{
          log('something went wrong');
          Toasts.showToast('something went wrong');
          return false;
        }
      });
    }
    catch(e){
      log(e.toString());
      Toasts.showToast('something went wrong');
      return false;
    }
  }

  Future<bool> signInWithEmailAndPassword(String email, password) async {
    try{
      return FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
      ).then((userCredential){
        if(userCredential.user != null){
          log('signed in with email and password');
          return true;
        }
        else{
          log('something went wrong');
          return false;
        }
      });
    }
    catch(e){
      log(e.toString());
      Toasts.showToast('something went wrong');
      return false;
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      log('reset email sent');
      Toasts.showToast('we sent a reset link to your email');
    }
    catch(e){
      log(e.toString());
      Toasts.showToast('something went wrong');
    }
  }

  Future<bool> signOut() async {
    await _googleSignIn.signOut();
    notifyListeners();
    log('signed out');
    return true;
  } 
}
