enum UserType {user, promoter}

class User{
  final String id;
  final String firstName;
  final String lastName;
  final String userName;
  final String email;
  final String phoneNumber;
  final String profileImageUrl;
  final int partypalPoints;
  final UserType userType;
  final bool isFollowing;
  final DateTime? birthday;
  final String? location;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.profileImageUrl,
    required this.partypalPoints,
    required this.userType,
    required this.isFollowing,
    this.birthday,
    this.location,
  });

  factory User.fromMap(Map data){
    return User(
      id: data['id'],
      firstName: data['firstname'],
      lastName: data['lastname'],
      userName: data['username'],
      email: data['email'],
      phoneNumber: data['phoneNumber'],
      profileImageUrl: data['imageUrl'],
      partypalPoints: 0,
      userType: data['role'] == 'USER' ? UserType.user : UserType.promoter,
      isFollowing: false,
      birthday: DateTime.tryParse(data['birthday']),
      location: data['location'],
    );
  }

  Map<String, dynamic> toMap(){

    return {
      'id': id,
      'firstname': firstName,
      'lastname': lastName,
      'username': userName,
      'email': email,
      'phoneNumber': phoneNumber,
      'imageUrl': profileImageUrl,
      //TODO: partypal points
      'role': userType == UserType.user ? 'USER' : 'PROMOTER',
      //TODO: isFollowing
      'birthday': birthday?.toIso8601String(),
      'location': location,

    };
  }
}