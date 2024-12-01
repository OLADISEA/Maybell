class ForgotPasswordState{}

class ForgotPasswordLoadingState extends ForgotPasswordState{}

class ForgotPassVerifySuccessState extends ForgotPasswordState{
}



class ForgotPasswordSuccess extends ForgotPasswordState{
  final String successMessage;
  ForgotPasswordSuccess({this.successMessage = ""});
}
class ForgotPassErrorState extends ForgotPasswordState{
  final String errorMessage;
  ForgotPassErrorState({required this.errorMessage});
}