import 'package:flutter/material.dart';
import 'package:partypal/constants/preference_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionManager extends ChangeNotifier{
  late FlutterSecureStorage flutterSecureStorage;
  late SharedPreferences preferences;

  Future<void> init() async {
    AndroidOptions androidOptions = const AndroidOptions(encryptedSharedPreferences: true);
    flutterSecureStorage = FlutterSecureStorage(aOptions: androidOptions);
    preferences = await SharedPreferences.getInstance();
  }

  Future<bool> get isFirstRun async {
    return preferences.getBool(PreferenceKeys.isFirstRun) ?? true;
  }

  Future<void> setFirstRun(bool value) async{
    preferences.setBool(PreferenceKeys.isFirstRun, value);
  }

  Future<void> setAccessToken(String? token) async{
    flutterSecureStorage.write(key: SecureStorageKeys.accessToken, value: token);
  }

  Future<String?> get accessToken async {
    return flutterSecureStorage.read(key: SecureStorageKeys.accessToken);
  }

  Future<void> setRefreshToken(String? token) async{
    flutterSecureStorage.write(key: SecureStorageKeys.refreshToken, value: token);
  }

  Future<String?> get refreshToken async {
    return flutterSecureStorage.read(key: SecureStorageKeys.refreshToken);
  }
}
