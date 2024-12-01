class AuthorizationEvents{}

class VerifyAccountEvents extends AuthorizationEvents{
  final String email;
  final String password;
  final String socialMediaName;
  VerifyAccountEvents({
    required this.email,
    required this.password,
    required this.socialMediaName
});
}