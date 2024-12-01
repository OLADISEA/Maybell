class ResetPassEvents{}


class ToggleEvents extends ResetPassEvents{
  bool isVisible;
  ToggleEvents({this.isVisible=true});
}


class ConfirmPassEvents extends ResetPassEvents{
  final String password;
  ConfirmPassEvents({required this.password});
}


class TriggerResetPassword extends ResetPassEvents{
  final String email;
  final String password;
  final String confirmPass;
  TriggerResetPassword({required this.email, required this.password, required this.confirmPass});
}





