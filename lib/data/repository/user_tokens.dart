import 'package:shared_preferences/shared_preferences.dart';

class AccessTokenProvider {
  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("accessToken");
  }

  static Future<String?> getUserEmail() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("user_email");
  }


  static Future<String?> getUserName() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("username");
  }
}


// String? accessToken = await AccessTokenProvider.getAccessToken();
//
// if (accessToken != null) {
// // Access token is available, you can use it for authenticated requests
// print("Access Token: $accessToken");
// } else {
// // Access token not found, handle the situation accordingly
// print("Access token not found");
// }
