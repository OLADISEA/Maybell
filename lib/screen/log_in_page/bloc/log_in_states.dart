class SignInState {
  String name;
  String email;
  String password;
  bool isVisible;
  String incorrectPass;
  final bool isLoading;


  SignInState({
    this.name="",
    this.email = '',
    this.password = '',
    this.isVisible = true,
    this.incorrectPass = "",
    this.isLoading = false
  });


  SignInState copyWith({
    String? name,

    String? email,
    String? password,
    bool? isVisible,
    String? incorrectPass,
    bool? isLoading
  }) {
    return SignInState(
        name: name?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
        isVisible: isVisible ?? this.isVisible,
        incorrectPass: incorrectPass?? this.incorrectPass,
        isLoading: isLoading?? this.isLoading

    );
  }
}

class EmailState extends SignInState{
  final String emailError;
  EmailState({this.emailError=""});
}

class SignInSuccess extends SignInState{
  final String successMessage;

  SignInSuccess({ this.successMessage = ""});
}
class SignInLoadingState extends SignInState{
  @override
  bool get isLoading => true;
}
class IncorrectPassState extends SignInState{
}
class SignInErrorState extends SignInState{
  String errorMessage;
  SignInErrorState({this.errorMessage =""});
}




