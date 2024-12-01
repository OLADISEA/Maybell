import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AllowLoginRepo {
  String baseUrl = "https://maybell.onrender.com";
  String allowLoginUrl = "/api/v1/socials/allow-or-reject-login/";


  Future<bool> allowLogin({required bool allowLogin, required String loginInfoId,}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    final String? email = prefs.getString("user_email");
    final String? id = prefs.getString('mimi_id');
    print(email);
    print(id);
    // Prepare the request body
    Map<String, dynamic> requestBody = {
      'allow_login': allowLogin,
      "social_media_id":id,
      'platform_email':email,
      // Assuming this is the format of the body
    };

    // The complete URL with user ID
    String url = '$baseUrl$allowLoginUrl$loginInfoId/';
    print(url);
    print(accessToken);
    print(loginInfoId);

    try {
      // Making the PUT request
      final response = await http.put(
        Uri.parse(url),
        body: jsonEncode(requestBody),
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(response.statusCode);

      // Check if the request was successful
      if (response.statusCode == 200) {
        print("status code is 201, success");
        // Return true if login was allowed successfully
        return true;
      } else {
        // Handle error cases
        print("Failed to allow login: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      // Handle exceptions
      print("Exception while allowing login: $e");
      return false;
    }
  }
}
