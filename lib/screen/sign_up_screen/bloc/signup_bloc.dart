import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maybell_apk/screen/sign_up_screen/bloc/signup_events.dart';
import 'package:maybell_apk/screen/sign_up_screen/bloc/signup_states.dart';

import '../../../data/repository/auth_repository.dart';





class SignUpBloc extends Bloc<SignUpEvents,SignUpState>{
  SignUpBloc():super(SignUpState()) {
    on<ChangeVisibilityEvents>((event, emit) {
      print("event activated");
      print(state.isVisible);
      emit(state.copyWith(isVisible: !(state.isVisible)));
    });

    on<EmailAndPasswordEvent>((event, emit){
      final String email = event.email;
      final String password = event.password;

      // Check email format
      if (!_isValidEmail(email)) {
        emit(EmailAndPassStates(emailError: "Invalid email format"));
        //emit(ErrorState(errorMessage: "Invalid email format"));
        return;
      }

      // Check password strength
      if (!_isStrongPassword(password)) {
        emit(EmailAndPassStates(passwordError: "Password is not strong enough"));
        //emit(ErrorState(errorMessage: "Password is not strong enough"));
        return;
      }
    });


    on<PasswordMatchEvents>((event, emit){
      if(event.password != event.confirmPass){
        emit(IncorrectPassState());
      }
    });

    on<SignUpCompletedEvents>((event, emit) async {
      print("Triggered");
      emit(state.copyWith(email: event.email,isButtonEnabled: false));
      print('the state now should be false, let us see ${state.isButtonEnabled}');

      await _validateLogin(
          event.name,
          event.email,
          event.password,
          emit
      );
    });

    on<VerifyEmailEvents>((event, emit) async{
      print("Right in verify email events");
      if(event.otp.isNotEmpty && event.email.isNotEmpty){
        print("THis is true");
        try{
          String emailMessage = await AuthRepository().verifyEmailOTP(event.email, event.otp);
          if(emailMessage == "200"){
            emit(EmailVerifyState());
          }else if(emailMessage == "400"){
            emit(ErrorState(errorMessage: "Invalid pin"));
          }
        }catch(e){
          emit(ErrorState(errorMessage: "UnKnown error"));
        }
      }
    });




  }


  Future<void> _validateLogin(
      String name,
      String email,
      String password,
      Emitter<SignUpState> emit
      ) async{
    // Check if email and password are not empty
    if (email.isEmpty ||
        password.isEmpty
    )
    {
      emit(const ErrorState(errorMessage: "Email and Password are required",));
      print("empty textfield");
      //emit(state.copyWith(isButtonEnabled: true));

      return;
    }else{
      try{
        emit(LoadingState());
        print("Loading, please wait");
        String result = await AuthRepository().signUp(
          name,
          email,
          password,
        );
        print("The result is $result");
        if(result == "success"){
          emit(state.copyWith(isButtonEnabled: false));

          emit(SignUpSuccess(successMessage: "Registration successful"));
          print("Sign up successful");
        }else if (result == "custom user with this email already exists."){
          emit(const ErrorState(errorMessage: "Email exists"));
        }
        else{
          emit(state.copyWith(isButtonEnabled: true));

          emit(EmailVerifyState(userEmail: result));
        }

      }catch(e){
        emit(state.copyWith(isButtonEnabled: true));

        emit(ErrorState(errorMessage: "Unable to sign up"));
        print("catch error and unable to sign up");
      }
    }
  }
  bool _isValidEmail(String email) {
    // Regular expression for email validation
    final RegExp emailRegex =
    RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool _isStrongPassword(String password) {
    // A simple criteria for a strong password (e.g minimum length)
    return password.length >= 6; //Minimum length of 6 characters

  }

}