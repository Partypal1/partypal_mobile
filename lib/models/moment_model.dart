import 'package:partypal/models/user_model.dart';

class Moment{
  final PartypalUser creator;
  final DateTime dateTime;
  final List<String> imageUrls;
  final String? caption;
  final bool isLiked;

  Moment({
    required this.creator,
    required this.dateTime,
    required this.imageUrls,
    required this.caption,
    required this.isLiked,
  });
}