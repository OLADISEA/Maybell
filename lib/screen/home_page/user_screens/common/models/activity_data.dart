class ActivityData {
  ActivityData({
    required this.id,
    required this.user,
    required this.social,
    required this.trackedIpJsonData,
    required this.allowLogin,
    required this.createdAt,
    required this.loginDate,
    required this.loginTime,
  });

  final String? id;
  final User? user;
  final String? social;
  final TrackedIpJsonData? trackedIpJsonData;
  final bool allowLogin;
  final DateTime? createdAt;
  final DateTime? loginDate;
  final String loginTime;

  factory ActivityData.fromJson(Map<String, dynamic> json){
    return ActivityData(
      id: json["id"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      social: json["social"],
      trackedIpJsonData: json["tracked_ip_json_data"] == null ? null : TrackedIpJsonData.fromJson(json["tracked_ip_json_data"]),
      allowLogin: json["allow_login"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      loginDate: DateTime.tryParse(json["login_date"] ?? ""),
      loginTime: json["login_time"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user?.toJson(),
    "social": social,
    "tracked_ip_json_data": trackedIpJsonData?.toJson(),
    "allow_login": allowLogin,
    "created_at": createdAt?.toIso8601String(),
    "login_date": "${loginDate?.year.toString().padLeft(4,'0')}-${loginDate?.month.toString().padLeft(2,'0')}-${loginDate?.day.toString().padLeft(2, '0')}",
    "login_time": loginTime,
  };

}

class TrackedIpJsonData {
  TrackedIpJsonData({
    required this.ip,
    required this.isEu,
    required this.borders,
    required this.capital,
    required this.latitude,
    required this.longitude,
    required this.phoneCode,
    required this.countryCode,
    required this.countryName,
    required this.continentCode,
    required this.continentName,
    required this.countryFlagEmoj,
    required this.topLevelDomains,
    required this.countryNameNative,
    required this.officialCountryName,
    required this.countryFlagEmojUnicode,
  });

  final String? ip;
  final bool? isEu;
  final List<dynamic> borders;
  final String? capital;
  final double? latitude;
  final double? longitude;
  final String? phoneCode;
  final String? countryCode;
  final String? countryName;
  final String? continentCode;
  final String? continentName;
  final String? countryFlagEmoj;
  final List<String> topLevelDomains;
  final String? countryNameNative;
  final String? officialCountryName;
  final String? countryFlagEmojUnicode;

  factory TrackedIpJsonData.fromJson(Map<String, dynamic> json){
    return TrackedIpJsonData(
      ip: json["ip"],
      isEu: json["isEu"],
      borders: json["borders"] == null ? [] : List<dynamic>.from(json["borders"]!.map((x) => x)),
      capital: json["capital"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      phoneCode: json["phoneCode"],
      countryCode: json["countryCode"],
      countryName: json["countryName"],
      continentCode: json["continentCode"],
      continentName: json["continentName"],
      countryFlagEmoj: json["countryFlagEmoj"],
      topLevelDomains: json["topLevelDomains"] == null ? [] : List<String>.from(json["topLevelDomains"]!.map((x) => x)),
      countryNameNative: json["countryNameNative"],
      officialCountryName: json["officialCountryName"],
      countryFlagEmojUnicode: json["countryFlagEmojUnicode"],
    );
  }

  Map<String, dynamic> toJson() => {
    "ip": ip,
    "isEu": isEu,
    "borders": borders.map((x) => x).toList(),
    "capital": capital,
    "latitude": latitude,
    "longitude": longitude,
    "phoneCode": phoneCode,
    "countryCode": countryCode,
    "countryName": countryName,
    "continentCode": continentCode,
    "continentName": continentName,
    "countryFlagEmoj": countryFlagEmoj,
    "topLevelDomains": topLevelDomains.map((x) => x).toList(),
    "countryNameNative": countryNameNative,
    "officialCountryName": officialCountryName,
    "countryFlagEmojUnicode": countryFlagEmojUnicode,
  };

}

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
  });

  final String? id;
  final String? name;
  final String? email;

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json["id"],
      name: json["name"],
      email: json["email"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
  };

}
