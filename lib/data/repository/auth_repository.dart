import 'dart:convert';
import 'package:http/http.dart';
import 'package:maybell_apk/data/repository/user_tokens.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user_profile.dart';
import 'package:device_info_plus/device_info_plus.dart';




class AuthRepository{
  String baseUrl = "https://maybell.onrender.com";
  String registerUrl = "/api/v1/accounts/register/";
  String signInUrl = "/api/v1/accounts/sign-in/";
  String verifyAccountUrl ="/api/v1/accounts/verify-account/";
  String userProfileUrl = "/api/v1/accounts/profile/";
  String forgotPasswordUrl = "/api/v1/accounts/forgot-password/";
  String resetPasswordUrl = "/api/v1/accounts/reset-password/";
  String authorizeAccountUrl = "/api/v1/socials/connect-mimi-to-maybell/";


  Future<String> signUp(String name, String email, String password) async {
    try {
      final response = await post(
        Uri.parse(baseUrl + registerUrl),
        body: {
          'name': name,
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 201) {
        print("Sign up is successful");
        return 'success';
      } else {
        final responseMessage = jsonDecode(response.body);
        if (response.statusCode == 400) {
          String emailMessage = responseMessage["errors"]["details"];
          if (emailMessage == "Enter a valid email address.") {
            print("Enter a valid email address");
            return emailMessage;
          } else if (emailMessage == "custom user with this email already exists.") {
            print("User Exists");
            return emailMessage;
          }
        }
        print("Response status code: ${response.statusCode}");
        print("Response body: ${response.body}");
        throw Exception(responseMessage);
      }
    } catch (e) {
      print("Error occurred during sign up: $e");
      throw Exception('Error occurred during sign up: $e');
    }
  }








  Future<String> signIn(String email, String password)async{
      try{
        Response response = await post(Uri.parse(baseUrl+signInUrl),
            body:{
              "email": email,
              "password":password
            }

        );

        if(response.statusCode == 200){
          final success = jsonDecode(response.body);
          final accessToken = success["access_token"];
          final userId = success["profile"]["id"];
          final user_email = success["profile"]["email"];
          final user_name = success["profile"]["name"];
          print(userId);
          print(accessToken);
          print("Successfully logged in");

          //now let's save the access token to the shared preference
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString("username", user_name);
          await prefs.setString("user_email", user_email);
          await prefs.setString("userId", userId);
          await prefs.setString("accessToken", accessToken);
          await prefs.setBool("isLoggedIn", true);
          return response.statusCode.toString();
        }else{
          throw Exception(response.reasonPhrase);
        }
      }catch(e){
        throw Exception('Error occurred during login: $e');
      }
    }
    
    Future<String?> authorizeAccount(
        String email,
        String password,
        String socialMediaName
        ) async{


      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print(androidInfo.id);

      try{
      Response response = await post(Uri.parse(baseUrl + authorizeAccountUrl),
        body: {
          'social_media_name':socialMediaName,
          'email':email,
          'password':password,
          'phone_model': androidInfo.model

        }
      );
      if(response.statusCode == 200){
        // Parse the JSON response
        Map<String, dynamic> parsedResponse = jsonDecode(response.body);

        // Access the "name" value
        String name = parsedResponse['profile']['name'];

        //bool success = true;
        return name;
      }
      print(response.statusCode);
        return null;
    }catch(e){
      print("error is here");
      return null;
    }
    }


  Future<String> verifyEmailOTP(
      String email,
      String otp
      ) async{
    try{
      Response response = await post(Uri.parse(baseUrl+verifyAccountUrl),
          body: {
            'email': email,
            'verification_code':otp,

          }
      );

      if(response.statusCode == 200){
        final success = jsonDecode(response.body);
        print("Email verification Successful");
        return response.statusCode.toString();
      }else if(response.statusCode == 400){
        print("Incorrect pin provided");
        return response.statusCode.toString();
      }

      else {
        print(response.statusCode);
        print("not successful");
        // Other unforeseen errors
        throw Exception(response.reasonPhrase);
      }

    }catch(e){
      throw Exception('Error occurred during login: $e');

    }
  }




Future<String> forgotPassword(String email) async{
  try{
    Response response = await post(Uri.parse(baseUrl+forgotPasswordUrl),
        body: {
          'email': email,
        }
    );

    if(response.statusCode == 200){
      final success = jsonDecode(response.body);
      print("Passcode sent Successful");
      return response.statusCode.toString();
    }else if(response.statusCode == 400){
      print("Unknown error");
      return response.statusCode.toString();
    }

    else {
      print(response.statusCode);
      print("not successful");
      // Other unforeseen errors
      throw Exception(response.reasonPhrase);
    }

  }catch(e){
    throw Exception('Error occurred during login: $e');

  }

}



  Future<UserProfile> getUserProfile() async {
    try {
      // Retrieve access token from shared preferences
      String? accessToken = await AccessTokenProvider.getAccessToken();

      if (accessToken == null) {
        throw Exception('Access token not found');
      }

      // Make a request to the user profile API with the access token
      Response response = await get(
        Uri.parse(baseUrl + userProfileUrl),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        final userProfileJson = jsonDecode(response.body);
        final userProfile = UserProfile.fromJson(userProfileJson);

        print('User Profile: $userProfile');
        return userProfile;
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      throw Exception('Error occurred while getting user profile: $e');
    }
  }



  Future<bool> createPasscode({required String passcode}) async{
    String baseUrl = "https://maybell.onrender.com";
    String addPasscodeUrl = "/api/v1/accounts/add-passcode-to-account/";
    String url = '$baseUrl$addPasscodeUrl';
    String? accessToken = await AccessTokenProvider.getAccessToken();



    Response response = await put(
      Uri.parse(url),
        headers: {'Authorization': 'Bearer $accessToken'},
        body: {
        "passcode": passcode
        }

    );
    print(response.statusCode);
    if(response.statusCode == 200){
      return true;
    }
    return true;
  }

}