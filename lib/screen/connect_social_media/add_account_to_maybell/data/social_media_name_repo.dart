import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SocialMediaNameRepo{
  String baseUrl = "https://maybell.onrender.com";
  String socialMediaNameUrl = "/api/v1/socials/social/";

  Future<String> addSocialMediaNameRepo(String socialMediaName) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString("accessToken");
    try{
      Response response = await post(Uri.parse(baseUrl+socialMediaNameUrl),
          headers: {
            'Authorization':'Bearer $accessToken'
          },
          body: {
            'social_media_name': socialMediaName,
          }
      );

      if(response.statusCode == 201){
        return 'success';
      }
      return response.statusCode.toString();
    }catch(error){
      throw Exception('An error occured while trying to add the social media name');
    }
  }
}