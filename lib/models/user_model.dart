enum UserType {user, promoter}

class User{
  String firstName;
  String lastName;
  String userId;
  String email;
  String phoneNumber;
  UserType userType;
  bool isFollowing;

  User({
    required this.firstName,
    required this.lastName,
    required this.userId,
    required this.email,
    required this.phoneNumber,
    required this.userType,
    required this.isFollowing,
  });
}