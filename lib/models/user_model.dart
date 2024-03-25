enum UserType {user, promoter}

class User{
  final String firstName;
  final String lastName;
  final String userName;
  final String email;
  final String phoneNumber;
  final String profileImageUrl;
  final int partypalPoints;
  final UserType userType;
  final bool isFollowing;

  User({
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.profileImageUrl,
    required this.partypalPoints,
    required this.userType,
    required this.isFollowing,
  });
}