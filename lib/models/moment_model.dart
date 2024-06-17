import 'package:partypal/models/user_model.dart';

class Moment{
  final PartypalUser creator;
  final DateTime dateTime;
  final List<String> imageURLs;
  final String? caption;
  final bool isLiked;

  Moment({
    required this.creator,
    required this.dateTime,
    required this.imageURLs,
    required this.caption,
    required this.isLiked,
  });
}