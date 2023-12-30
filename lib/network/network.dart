import 'dart:convert';
import 'dart:developer';
import 'package:partypal/network/network_errors.dart';
import 'package:partypal/network/network_response.dart';
import 'package:partypal/network/network_utils.dart';
import 'package:http/http.dart' as http;
import 'package:partypal/utils/toasts.dart';
export 'network_response.dart';

class Network{
  static const String baseUrl = 'https://partypalbe-dev.up.railway.app/';

  static Map<String, String> get headers {
    return {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      'accept': '*/*',
    };
  }

  static Future<NetworkResponse> get(String endpoint) async {
    if(await NetworkUtils.hasConnection()){
      try{
        final url = Uri.parse(baseUrl + endpoint);
        http.Response response = await http.get(url, headers: Network.headers);
        if(response.statusCode.toString().startsWith('2')){ 
          log(response.body);
          return NetworkResponse(
            successful: true,
            body: jsonDecode(response.body)
          );
        }
        else{
          NetworkErrors.handleNetworkErrors(response);
        }
      } catch(e){
        log(e.toString());
      }
    }
    else {
      Toasts.showToast('No internet connection');
    }
    return NetworkResponse(successful: false);
  }

  static Future<NetworkResponse> post(String endpoint, Map<String, String> body) async {
    if(await NetworkUtils.hasConnection()){
      try{
        final url = Uri.parse(baseUrl + endpoint);
        http.Response response = await http.post(url, headers: Network.headers, body: jsonEncode(body));
        if(response.statusCode.toString().startsWith('2')){
          log(response.body);
          return NetworkResponse(
            successful: true,
            body: jsonDecode(response.body)
          );
        }
        else{
          NetworkErrors.handleNetworkErrors(response);
        }
      } catch(e){
        log(e.toString());
      }
    }
    else {
      Toasts.showToast('No internet connection');
    }
    return NetworkResponse(successful: false);
  }
}