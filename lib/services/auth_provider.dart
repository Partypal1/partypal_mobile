import 'package:flutter/material.dart';
import 'package:partypal/models/user_model.dart';
import 'package:partypal/network/network.dart';

class AuthProider extends ChangeNotifier{
  // User? user;
  bool isAuthenticated = false;

   void signUp(
    String firstName,
    String lastName,
    String phoneNumber,
    String email,
    String password,
    UserType userType,
    String location) async {
    NetworkResponse networkResponse = await Network.post(
      'auth/register-user',
      { 'firstname': firstName,
        'lastname': lastName,
        'phoneNumber': phoneNumber,      
        'email': email,
        'password': password,
        'userType': userType.name,
        'location': location,
        }
    );
    if(networkResponse.successful){
      //TODO: notify listeners
    }
  }

  Future signIn(String email, String password) async {
    NetworkResponse networkResponse = await Network.post(
      'auth/login-user',
      { 'email': email,
        'password': password,}
    );
    if(networkResponse.successful){
      isAuthenticated = true;
      notifyListeners();
    }
  }

 
}