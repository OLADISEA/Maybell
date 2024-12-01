import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../screen/home_page/user_screens/common/models/activity_data.dart';

class ActivityRepository{
  String baseUrl = "https://maybell.onrender.com";
  String trackedPlatformUrl = "/api/v1/socials/tracked-platform-login/";


  Future<List<ActivityData>> fetchActivities() async {
    // Retrieve the access token from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');

    if (accessToken == null) {
      throw Exception('Access token not found in shared preferences');
    }

    // Make HTTP GET request to fetch activities
    final response = await http.get(
      Uri.parse(baseUrl + trackedPlatformUrl),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      // Parse the response JSON and convert it into a list of ActivityData
      List<dynamic> jsonData = jsonDecode(response.body);
      List<ActivityData> activities = jsonData.map((json) => ActivityData.fromJson(json)).toList();
      return activities;
    } else if(response.statusCode == 401){
      throw TokenExpiredException('Access token has expired');

    }
    else {
      print(response.statusCode);
      // If the request fails, throw an exception with the error message
      throw Exception('Failed to load activities: ${response.statusCode}');
    }
  }
}

class TokenExpiredException implements Exception {
  final String message;

  TokenExpiredException(this.message);
}