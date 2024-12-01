class SignUpEvents{}


class ChangeVisibilityEvents extends SignUpEvents{
  bool isVisible;
  ChangeVisibilityEvents({this.isVisible=true});
}
class PasswordMatchEvents extends SignUpEvents{
  final String password;
  final String confirmPass;
  PasswordMatchEvents({required this.password, required this.confirmPass});
}

class SignUpCompletedEvents extends SignUpEvents{
  final String name;
  final String email;
  final String password;

  SignUpCompletedEvents({
    required this.name,
    required this.email,
    required this.password,
  });
}

class VerifyEmailEvents extends SignUpEvents{
  final String email;
  final String otp;
  VerifyEmailEvents({required this.email,required this.otp});
}

class EmailAndPasswordEvent extends SignUpEvents{
  final String email;
  final String password;
  EmailAndPasswordEvent({
    required this.email,
    required this.password,
  });


}

