enum Role {user, promoter}

class PartypalUser{
  final String id;
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String phoneNumber;
  final String profileImageUrl;
  final Role role;
  final String? location;

  PartypalUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.profileImageUrl,
    required this.role,
    this.location,
  });

  factory PartypalUser.fromMap(String id, Map<String, dynamic> data){
    return PartypalUser(
      id: id,
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      username: data['username'] ?? '',
      email: data['email'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      profileImageUrl: data['profileImageUrl'] ?? '',
      role: (data['role'] ?? 'user') == 'user' ? Role.user : Role.promoter,
      location: data['location'] ?? '',
    );
  }

  Map<String, dynamic> toMap(){

    return {
      'id': id,
      'firstname': firstName,
      'lastname': lastName,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'imageUrl': profileImageUrl,
      'role': role == Role.user ? 'user' : 'promoter',
      'location': location,

    };
  }
}