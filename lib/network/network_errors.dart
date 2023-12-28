import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:partypal/utils/toasts.dart';
import 'dart:convert';

class NetworkErrors {
  static void handleNetworkErrors(http.Response response) {//TODO: handle different response codes
    final body = jsonDecode(response.body);
    
    if(response.statusCode.toString().startsWith('4')){
      Toasts.showToast(body['data']?['message'] ?? 'Something went wrong, try again');
      log('client error: $body');
    }
    else if (response.statusCode.toString().startsWith('5')){
      Toasts.showToast(body['data']?['message'] ?? 'A server error occoured, try again later');
      log('server error: $body');
    }
    else{
      Toasts.showToast(body['data']?['message'] ?? 'Oops, something went wrong');
      log('unknown error: $body');
    }
  }
}