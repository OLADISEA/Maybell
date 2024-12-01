class UserAccountData {
  final String socialMediaName;
  final String id;

  UserAccountData({required this.id,required this.socialMediaName});

  factory UserAccountData.fromJson(Map<String, dynamic> json) {
    return UserAccountData(
      socialMediaName: json['social_media_name'] ?? 'Unknown',
      id: json['id']?? 'No id'
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'social_media_name': socialMediaName,
      'id': id
    };
  }
}
