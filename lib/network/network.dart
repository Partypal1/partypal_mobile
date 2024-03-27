import 'dart:convert';
import 'dart:developer';
import 'package:partypal/network/network_errors.dart';
import 'package:partypal/network/network_response.dart';
import 'package:partypal/network/network_utils.dart';
import 'package:http/http.dart' as http;
import 'package:partypal/utils/toasts.dart';
export 'network_response.dart';

class Network{
  static const String baseUrl = 'https://party-pal-be.uc.r.appspot.com/';

  static Map<String, String> get headers {
    return {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      'accept': '*/*',
    };
  }

  static Future<NetworkResponse> get({
    required String endpoint,
    Map<String, String>? queryParameters,
    String? authToken
  }) async {
    if(await NetworkUtils.hasConnection()){
      try{
        var url = Uri.parse(baseUrl + endpoint);
        url = url.replace(queryParameters: queryParameters);
        var headers = Network.headers
          ..addAll(authToken == null ? {} : {'Authorization': 'Bearer $authToken'});
        http.Response response = await http.get(url, headers: headers);
        if(response.statusCode.toString().startsWith('2')){ 
          log(response.body);
          return NetworkResponse(
            successful: true,
            body: jsonDecode(response.body)
          );
        }
        else{
          NetworkErrors.handleNetworkErrors(response);
          return NetworkResponse(
            successful: false,
            body: jsonDecode(response.body)
          );
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

  static Future<NetworkResponse> post({
    required String endpoint,
    required Map<String, String> body,
    Map<String, String>? queryParameters,
    String? authToken
  }) async {
    if(await NetworkUtils.hasConnection()){
      try{
        var url = Uri.parse(baseUrl + endpoint);
        url = url.replace(queryParameters: queryParameters);
        var headers = Network.headers
          ..addAll(authToken == null ? {} : {'Authorization': 'Bearer $authToken'});
        http.Response response = await http.post(url, headers: headers, body: jsonEncode(body));
        if(response.statusCode.toString().startsWith('2')){
          log(response.body);
          return NetworkResponse(
            successful: true,
            body: jsonDecode(response.body)
          );
        }
        else{
          NetworkErrors.handleNetworkErrors(response);
          return NetworkResponse(
            successful: false,
            body: jsonDecode(response.body)
          );
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

  static Future<NetworkResponse> patch ({
    required String endpoint,
    required Map<String, dynamic> body,
    Map<String, String>? queryParameters,
    String? authToken
  }) async {
    if(await NetworkUtils.hasConnection()){
      try{
        var url = Uri.parse(baseUrl + endpoint);
        url = url.replace(queryParameters: queryParameters);
        var headers = Network.headers
          ..addAll(authToken == null ? {} : {'Authorization': 'Bearer $authToken'});
        http.Response response = await http.patch(url, headers: headers, body: jsonEncode(body));
        if(response.statusCode.toString().startsWith('2')){
          log(response.body);
          return NetworkResponse(
            successful: true,
            body: jsonDecode(response.body)
          );
        }
        else{
          NetworkErrors.handleNetworkErrors(response);
          return NetworkResponse(
            successful: false,
            body: jsonDecode(response.body)
          );
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

  static Future<NetworkResponse> multipart ({
    required String method,
    required String endpoint,
    required http.MultipartFile file,
    Map<String, String>? queryParameters,
    Map <String, String>? fields,
    String? authToken
  }) async {
    if(await NetworkUtils.hasConnection()){
      try{
        var url = Uri.parse(baseUrl + endpoint);
        url = url.replace(queryParameters: queryParameters);
        var headers = Network.headers
          ..addAll(authToken == null ? {} : {'Authorization': 'Bearer $authToken'})
          ..['Content-Type'] = 'multipart/form-data';
        var request = http.MultipartRequest(method, url);
        request.headers.addAll(headers);
        request.fields.addAll(fields ?? {});
        request.files.add(file);
        http.Response response = await http.Response.fromStream(await request.send());
        if(response.statusCode.toString().startsWith('2')){
          log(response.body);
          return NetworkResponse(
            successful: true,
            body: jsonDecode(response.body)
          );
        }
        else{
          NetworkErrors.handleNetworkErrors(response);
          return NetworkResponse(
            successful: false,
            body: jsonDecode(response.body)
          );
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