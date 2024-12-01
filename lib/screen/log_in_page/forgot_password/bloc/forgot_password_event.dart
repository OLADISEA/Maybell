class ForgotPasswordEvents{}

class ForgotPasswordOTPEvents extends ForgotPasswordEvents{
  final String email;
  ForgotPasswordOTPEvents({required this.email});
}

class ForgotPassVerifyEvents extends ForgotPasswordEvents{
  final String email;
  final String otp;
  ForgotPassVerifyEvents({required this.email,required this.otp});
}


