import 'package:partypal/models/user_model.dart';

class Event{
  final String name;
  final DateTime dateTime;
  final String location;
  final User creator;
  final String imageUrl;
  final bool isLiked;

  Event({
    required this.name,
    required this.dateTime,
    required this.location,
    required this.creator,
    required this.imageUrl,
    required this.isLiked
  });
}