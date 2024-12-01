import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_account_model.dart';

class UserAccountRepo {
  String baseUrl = "https://maybell.onrender.com";
  String getUserSocialMediaAccount = "/api/v1/socials/social/";

  Future<List<UserAccountData>> getSocialMediaNames() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');

    if (accessToken == null) {
      throw Exception('Access token not found in shared preferences');
    }

    Response response = await get(
      Uri.parse(baseUrl + getUserSocialMediaAccount),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      print("User social media account generated");
      List<dynamic> jsonData = jsonDecode(response.body);
      List<UserAccountData> userAccounts = jsonData
          .map((json) => UserAccountData.fromJson(json))
          .toList(); // Map JSON to UserAccountData objects
      print(userAccounts);
      return userAccounts;
    } else {
      throw Exception('Failed to fetch social media accounts');
    }
  }
}
