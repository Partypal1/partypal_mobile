import 'package:flutter/material.dart';
import 'package:partypal/models/user_model.dart';
import 'package:partypal/network/network.dart';

enum VerificationPurpose{registration, forgotPassword}
class AuthProider extends ChangeNotifier{

   Future<NetworkResponse> signUp({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String email,
    required String password,
    required UserType userType,
    }) async {

    NetworkResponse response = await Network.post(
      endpoint: 'auth/register-user',
      body: { 'firstname': firstName,
        'lastname': lastName,
        'phoneNumber': phoneNumber,      
        'email': email,
        'password': password,
        'userType': userType.name,
      }
    );
    return response;
  }

    Future<NetworkResponse> signIn({
      required String email,
      required String password
    }) async {
    NetworkResponse response = await Network.post(
      endpoint: 'auth/login-user',
      body: {
        'email': email,
        'password': password,
      }
    );
    return response;
  }

  Future<NetworkResponse> verifyOTP({
    required String email,
    required String otp,
    required VerificationPurpose purpose
  }) async {
    String query = switch(purpose){
      VerificationPurpose.registration => 'purpose=registration',
      VerificationPurpose.forgotPassword => 'purpose=forgot-password'
    };

    NetworkResponse response = await Network.patch(
      endpoint: 'auth/verify-otp',
      query: query,
      body: {
        'email': email,
        'otp': otp,
      }
    );
    return response;
  }

  Future<NetworkResponse> resendOTP({
    required String email,
    required VerificationPurpose purpose
  }) async {
    String purposeString = switch(purpose){
      VerificationPurpose.registration => 'registration',
      VerificationPurpose.forgotPassword => 'forgot-password'
    };
    NetworkResponse response = await Network.get(
      endpoint: 'auth/resend-otp',
      query: 'email=$email&purpose=$purposeString'
    );
    return response;
  } 
}