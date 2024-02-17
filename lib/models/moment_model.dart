import 'package:partypal/models/user_model.dart';

class Moment{
  final User creator;
  final DateTime dateTime;
  final List<String> imagePaths;
  final String? caption;
  final bool isLiked;

  Moment({
    required this.creator,
    required this.dateTime,
    required this.imagePaths,
    required this.caption,
    required this.isLiked,
  });
}