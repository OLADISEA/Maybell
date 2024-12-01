import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repository/auth_repository.dart';
import 'log_in_events.dart';
import 'log_in_states.dart';

class SignInBloc extends Bloc<SignInEvents,SignInState>{
  SignInBloc():super(SignInState()){
    on<LoginButtonPressed>((event, emit) async{
     await _validateLogin(emit,event.email, event.password);


    });

    on<EmailAndPassEvents>((event, emit){
      final String email = event.email;

      // Check email format
      if (!_isValidEmail(email)) {
        emit(EmailState(emailError: "Invalid email format"));
        return;
      }else{
        emit(EmailState(emailError: ""));
      }

    });


    on<ToggleVisibilityEvents>((event, emit) {
      print("event activated");
      print(state.isVisible);
      emit(state.copyWith(isVisible: !(state.isVisible)));
    });



  }


  Future <void> _validateLogin(Emitter<SignInState> emit, String email, String password) async{
    // Check if email and password are not empty
    if (email.isEmpty || password.isEmpty) {
      print("Empty field, please fill");
      emit(SignInErrorState(errorMessage: "Email and Password are required"));
      //emit(state.copyWith(error: "Email and Password are required"));
      return;
    }else{
      try{
        emit(SignInLoadingState());
        String statusCode = await AuthRepository().signIn(email,password);
        if(statusCode == "200") {
          emit(SignInSuccess(successMessage: "Successfuly logged in"));
          print("Sign up successful");
        }
        // }else if (statusCode == "400"){
        //   emit(EmailVerifyState(userEmail: email));
        // }
        // emit(SignInSuccess());

        //UserProfile userProfile = await AuthRepository().getUserProfile();
        //emit(state.copyWith(userId: userProfile));
      }catch(e){
        emit(SignInErrorState(errorMessage: "Unable to sign in"));
        print("an unknown error has occurred");
      }
    }
  }


  bool _isValidEmail(String email) {
    // Regular expression for email validation
    final RegExp emailRegex =
    RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }


}


