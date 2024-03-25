import 'package:flutter/material.dart';
import 'package:partypal/models/moment_model.dart';
import 'package:partypal/models/user_model.dart';

class MomentProvider extends ChangeNotifier{
  List<Moment> moments = [];
  bool isFetching = false;
  void fetchMoments() async {
    isFetching = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 5));
    moments = [
      Moment(
        creator: User(
          firstName: 'Olasunkanmi',
          lastName: 'Beckley',
          userName: 'Sunkanm1',
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
      Moment(
        creator: User(
          firstName: 'David',
          lastName: 'Atuluku',
          userName: 'Dave',
          email: 'adavid@gmail.com',
          phoneNumber: '09053221541',
          profileImageUrl: "https://images.unsplash.com/photo-1511367461989-f85a21fda167?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D",
          partypalPoints: 68,
          userType: UserType.promoter,
          isFollowing: false
        ),
        dateTime: DateTime.now().subtract(const Duration(hours: 1)),
        imageUrls: [
          "https://assets.unation.com/wp-content/uploads/2023/02/1-4.png",
          "https://assets.unation.com/wp-content/uploads/2023/02/1-4.png",
        ],
        caption: "Such a nice place",
        isLiked: false
      ),
    ];
    isFetching = false;
    notifyListeners();
  }
}
