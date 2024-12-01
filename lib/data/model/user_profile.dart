class UserProfile {
  final String id;
  final String firstName;
  final String lastName;
  final String username;

  UserProfile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'] ?? '', // Handle the case where last_name is null
      username: json['username'],
    );
  }
}
