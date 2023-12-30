import 'package:partypal/constants/preference_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

//TODO: switch to the hive package
class SessionManager{

  static Future<bool> get isFirstRun async {
    // this getter decides whether the user is running the app for the first time
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(PreferenceKeys.isFirstRun) ?? true;
  }

  static Future<void> setFirstRun(bool value) async{
    // call this function with [value: false] after the user has seen everything in onboarding screen
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(PreferenceKeys.isFirstRun, value);
  }
}
