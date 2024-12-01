class AddSocialMediaNameEvent{}

class AddSocialMediaNameToMayBell extends AddSocialMediaNameEvent{
  final String socialMediaName;
  AddSocialMediaNameToMayBell({required this.socialMediaName});

}