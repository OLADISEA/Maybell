import 'package:equatable/equatable.dart';

class SignUpState extends Equatable{
  final String name;
  final String email;
  final String password;
  final bool isVisible;
  final String incorrectPass;
  final bool isButtonEnabled;
  final bool isLoading;

  const SignUpState({
    this.name="",
    this.email = '',
    this.password = '',
    this.isVisible = true,
    this.incorrectPass = "",
    this.isButtonEnabled = true,
    this.isLoading = false
  });


  SignUpState copyWith({
    String? name,
    String? email,
    String? password,
    bool? isVisible,
    String? incorrectPass,
    bool? isButtonEnabled,
    bool? isLoading
  }) {
    return SignUpState(
        name: name?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
        isVisible: isVisible ?? this.isVisible,
        incorrectPass: incorrectPass?? this.incorrectPass,
        isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
        isLoading: isLoading?? this.isLoading
    );
  }

  @override
  List<Object?> get props => [name, email, password, isVisible, incorrectPass, isButtonEnabled,isLoading];

}

class LoadingState extends SignUpState{
  @override
  bool get isButtonEnabled => false; // Override isButtonEnabled to return false
  @override
  bool get isLoading => true;
}

class EmailAndPassStates extends SignUpState{
  final String emailError;
  final String passwordError;
  const EmailAndPassStates({this.emailError="",this.passwordError=""});
}



class SignUpSuccess extends SignUpState{
 final String successMessage;


 SignUpSuccess({ this.successMessage = "",});


}

class IncorrectPassState extends SignUpState{
}
class ErrorState extends SignUpState{
  final String errorMessage;
  const ErrorState({this.errorMessage =""});

  @override
  List<Object?> get props => [errorMessage,isButtonEnabled];


  // @override
  // bool get isButtonEnabled => false; // Override isButtonEnabled to return false
}

class EmailVerifyState extends SignUpState{
  final String userEmail;
  EmailVerifyState({this.userEmail = ""});
}
