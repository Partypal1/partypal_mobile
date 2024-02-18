enum UserType {user, promoter}

class User{
  final String firstName;
  final String lastName;
  final String userId;
  final String email;
  final String phoneNumber;
  final UserType userType;
  final bool isFollowing;

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