class ResetPassStates{
  String password;
  bool isVisible;

  ResetPassStates({this.password = "",this.isVisible = true});


  ResetPassStates copyWith({String? password}){
    return ResetPassStates(password: password??this.password);
}
}

class ResetPasswordLoading extends ResetPassStates{}

class ResetPasswordSuccessState extends ResetPassStates{}

class ResetPasswordErrorState extends ResetPassStates{}