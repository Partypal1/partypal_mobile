import 'dart:developer';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:partypal/utils/toasts.dart';

class NetworkUtils{
  static Future<bool> hasConnection() async {
    return InternetConnectionChecker().hasConnection;

  }

  static void handleConnectionStatusChange(){
    InternetConnectionChecker().onStatusChange.listen(
      (connStatus) {
        log('internet is ${connStatus.name}');
        Toasts.showToast('internet is ${connStatus.name}');
      }
    );
  }
}