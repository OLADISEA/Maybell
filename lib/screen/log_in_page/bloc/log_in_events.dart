class SignInEvents{}


class ToggleVisibilityEvents extends SignInEvents{
  bool isVisible;
  ToggleVisibilityEvents({this.isVisible=true});
}

class LoginButtonPressed extends SignInEvents{
  final String email;
  final String password;

  LoginButtonPressed({
    required this.email,
    required this.password,
  });
}



class EmailAndPassEvents extends SignInEvents{
  final String email;
  EmailAndPassEvents({
    required this.email
  });
}



