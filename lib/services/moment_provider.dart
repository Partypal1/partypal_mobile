import 'package:flutter/material.dart';
import 'package:partypal/models/moment_model.dart';
import 'package:partypal/models/user_model.dart';

class MomentProvider extends ChangeNotifier{
  bool _disposed = false;
  List<Moment> moments = [];
  bool isFetching = false;
  void fetchMoments() async {
    isFetching = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 5));
    moments = [
      Moment(
        creator: PartypalUser(
          id: '',
          firstName: 'Olasunkanmi',
          lastName: 'Beckley',
          username: 'Sunkanm1',
          email: 'beckleysunkanmi@gmail.com',
          phoneNumber: '09053221941',
          profileImageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRLEPh3zspn0JSENlaxTjTC8SbtBtRp26M5bg&usqp=CAU",
          role: Role.promoter,
        ),
        dateTime: DateTime.now().subtract(const Duration(hours: 1)),
        imageURLs: [
          "https://static01.nyt.com/images/2022/02/15/fashion/15NYFWPARTIES-laquan-lead/15NYFWPARTIES-laquan-lead-mediumSquareAt3X.jpg"
        ],
        caption: "Best night ever",
        isLiked: false
      ),
      Moment(
        creator: PartypalUser(
          id: '',
          firstName: 'David',
          lastName: 'Atuluku',
          username: 'Dave',
          email: 'adavid@gmail.com',
          phoneNumber: '09053221541',
          profileImageURL: "https://images.unsplash.com/photo-1511367461989-f85a21fda167?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D",
          role: Role.promoter,
        ),
        dateTime: DateTime.now().subtract(const Duration(hours: 1)),
        imageURLs: [
          "https://static01.nyt.com/images/2022/02/15/fashion/15NYFWPARTIES-laquan-lead/15NYFWPARTIES-laquan-lead-mediumSquareAt3X.jpg",
          "https://static01.nyt.com/images/2022/02/15/fashion/15NYFWPARTIES-laquan-lead/15NYFWPARTIES-laquan-lead-mediumSquareAt3X.jpg",
        ],
        caption: "Such a nice place",
        isLiked: false
      ),
    ];
    isFetching = false;
    notifyListeners();
  }
  
  @override
  void notifyListeners(){
    if(!_disposed){
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
