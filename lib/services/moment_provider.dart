import 'package:flutter/material.dart';
import 'package:partypal/models/moment_model.dart';
import 'package:partypal/models/user_model.dart';

class MomentProvider extends ChangeNotifier{
  List<Moment> moments = [];

  void fetchMoments(){
    moments = [
      Moment(
        creator: User(
          firstName: 'Olasunkanmi',
          lastName: 'Beckley',
          userId: 'Sunkanm1',
          email: 'beckleysunkanmi@gmail.com',
          phoneNumber: '09053221941',
          profileImageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRLEPh3zspn0JSENlaxTjTC8SbtBtRp26M5bg&usqp=CAU",
          partypalPoints: 68,
          userType: UserType.promoter,
          isFollowing: false
        ),
        dateTime: DateTime.now().subtract(const Duration(hours: 1)),
        imageUrls: [
          "https://assets.unation.com/wp-content/uploads/2023/02/1-4.png"
        ],
        caption: "Best night ever",
        isLiked: false
      ),
    ];
    notifyListeners();
  }
}
