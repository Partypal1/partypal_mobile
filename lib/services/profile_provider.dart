import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:partypal/models/user_model.dart';
import 'package:partypal/network/network.dart';
import 'package:partypal/services/session_manager.dart';
import 'package:provider/provider.dart';

class ProfileProvider extends ChangeNotifier{
  User? user;

  Future<NetworkResponse> getProfile(BuildContext context) async {
    String? accessToken = await Provider.of<SessionManager>(context, listen: false).accessToken;
    if(accessToken == null){
      return NetworkResponse(successful: false);
    }
    NetworkResponse response = await Network.get(
      endpoint: 'profile/get-user-profile',
      authToken: accessToken
    );
    if(response.successful){
      user = User.fromMap(response.body!['data']);
      notifyListeners();
    }
    return response;
  }

  Future<NetworkResponse> uploadProfile({
    required BuildContext context,
    required String username,
    required String location,
    required String image}) async{
    String? accessToken = await Provider.of<SessionManager>(context, listen: false).accessToken;
    // List<int> imageBytes = image.readAsBytesSync();
    // String imageString = base64Encode(imageBytes);
    List<int> imageBytes = _generateFakeImage();
    var imagePart = MultipartFile.fromBytes(
      'image',
      imageBytes,
      filename: 'image.png',
      contentType: MediaType('image', 'png')
    );
    NetworkResponse response = await Network.multipart(
      method: 'PATCH',
      endpoint: 'profile/upload-profile',
      queryParameters: {
        'username': username,
        'location': location
      },
      file: imagePart,
      authToken: accessToken
    );
    return response;
  }
}

List<int> _generateFakeImage(){
   // Define the image dimensions
  int width = 100;
  int height = 100;

  // Create a Uint8List to hold the image bytes
  Uint8List imageBytes = Uint8List(4 * width * height);

  // Fill the image bytes with a black square
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      int index = 4 * (y * width + x);
      imageBytes[index] = 0; // Red channel
      imageBytes[index + 1] = 0; // Green channel
      imageBytes[index + 2] = 0; // Blue channel
      imageBytes[index + 3] = 255; // Alpha channel (fully opaque)
    }
  }
  return imageBytes;
}