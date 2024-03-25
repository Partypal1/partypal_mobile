import 'package:flutter/material.dart';
import 'package:partypal/models/event_model.dart';
import 'package:partypal/models/user_model.dart';

class EventProvider extends ChangeNotifier{
  List<Event> eventsHappeningThisWeek = [];
  List<Event> eventsBasedOnYourLocation = [];
  bool isFetching = false;

  void fetchEvents() async {
    isFetching = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 5));
    eventsBasedOnYourLocation = [
      Event(
        name: 'Bluette',
        dateTime: DateTime.now().add(const Duration(days: 15)),
        location: 'Quilox',
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
        imageUrl: "https://t4.ftcdn.net/jpg/02/61/84/27/360_F_261842772_jayDgtm4z4FTuFFzjAALnmLAbXDqsYpS.jpg",
        isLiked: false
      ),
      Event(
        name: 'Tranquility',
        dateTime: DateTime.now().add(const Duration(days: 15)),
        location: 'Club 57',
        creator: User(
          firstName: 'Davey',
          lastName: 'Brownley',
          userName: 'David',
          email: 'david@gmail.com',
          phoneNumber: '0901267438',
          profileImageUrl: "https://images.unsplash.com/photo-1522529599102-193c0d76b5b6?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8YmxhY2slMjBndXl8ZW58MHx8MHx8fDA%3D",
          partypalPoints: 68,
          userType: UserType.promoter,
          isFollowing: false
        ),
        imageUrl: "https://milcomurban.files.wordpress.com/2016/12/night-club.jpg?w=1124&h=750&crop=1",
        isLiked: false
      ),
      Event(
        name: 'Emergence',
        dateTime: DateTime.now().add(const Duration(days: 15)),
        location: 'Club 57',
        creator: User(
          firstName: 'Davey',
          lastName: 'Brownley',
          userName: 'David',
          email: 'david@gmail.com',
          phoneNumber: '0901267438',
          profileImageUrl: "https://images.unsplash.com/photo-1522529599102-193c0d76b5b6?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8YmxhY2slMjBndXl8ZW58MHx8MHx8fDA%3D",
          partypalPoints: 68,
          userType: UserType.promoter,
          isFollowing: false
        ),
        imageUrl: "https://www.morningadvertiser.co.uk/var/wrbm_gb_hospitality/storage/images/_aliases/wrbm_large/publications/hospitality/morningadvertiser.co.uk/article/2023/10/04/why-are-so-many-nightclubs-closing/6152639-1-eng-GB/Why-are-so-many-nightclubs-closing.jpg",
        isLiked: false
      ),
    ];

    eventsHappeningThisWeek = [
      Event(
        name: 'Tranquility',
        dateTime: DateTime.now().add(const Duration(days: 15)),
        location: 'Club 57',
        creator: User(
          firstName: 'Davey',
          lastName: 'Brownley',
          userName: 'David',
          email: 'david@gmail.com',
          phoneNumber: '0901267438',
          profileImageUrl: "https://images.unsplash.com/photo-1522529599102-193c0d76b5b6?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8YmxhY2slMjBndXl8ZW58MHx8MHx8fDA%3D",
          partypalPoints: 68,
          userType: UserType.promoter,
          isFollowing: false
        ),
        imageUrl: "https://www.morningadvertiser.co.uk/var/wrbm_gb_hospitality/storage/images/_aliases/wrbm_large/publications/hospitality/morningadvertiser.co.uk/article/2023/10/04/why-are-so-many-nightclubs-closing/6152639-1-eng-GB/Why-are-so-many-nightclubs-closing.jpg",
        isLiked: false
      ),
      Event(
        name: 'Emergence',
        dateTime: DateTime.now().add(const Duration(days: 15)),
        location: 'Club 57',
        creator: User(
          firstName: 'Davey',
          lastName: 'Brownley',
          userName: 'David',
          email: 'david@gmail.com',
          phoneNumber: '0901267438',
          profileImageUrl: "https://images.unsplash.com/photo-1522529599102-193c0d76b5b6?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8YmxhY2slMjBndXl8ZW58MHx8MHx8fDA%3D",
          partypalPoints: 68,
          userType: UserType.promoter,
          isFollowing: false
        ),
        imageUrl: "https://milcomurban.files.wordpress.com/2016/12/night-club.jpg?w=1124&h=750&crop=1",
        isLiked: false
      ),
      Event(
        name: 'Bluette',
        dateTime: DateTime.now().add(const Duration(days: 15)),
        location: 'Quilox',
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
        imageUrl: "https://t4.ftcdn.net/jpg/02/61/84/27/360_F_261842772_jayDgtm4z4FTuFFzjAALnmLAbXDqsYpS.jpg",
        isLiked: false
      ),
    ];
    isFetching = false;
    notifyListeners();
  }
}