import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:partypal/network/network.dart';
import 'package:partypal/services/session_manager.dart';
import 'package:provider/provider.dart';

class ProfileProvider extends ChangeNotifier{

  Future getProfile(BuildContext context, ) async {
    String? accessToken = await Provider.of<SessionManager>(context).accessToken;

    NetworkResponse response = await Network.get(
      endpoint: 'profile/get-user-profile',
      authToken: accessToken
    );
    log(response.body.toString());
    return response;
  }
}