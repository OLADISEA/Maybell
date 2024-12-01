import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/repository/auth_repository.dart';
import 'forgot_password_event.dart';
import 'forgot_password_state.dart';


class ForgotPasswordBloc extends Bloc<ForgotPasswordEvents,ForgotPasswordState>{
  AuthRepository authRepository = AuthRepository();
  ForgotPasswordBloc({required this.authRepository}): super(ForgotPasswordLoadingState()){

    on<ForgotPasswordOTPEvents>((event,emit) async{
      emit(ForgotPasswordLoadingState());
      print("Passcode will be sent to the email soon");
      String statusCode = await authRepository.forgotPassword(event.email);
      if(statusCode == "200"){
        emit(ForgotPasswordSuccess(successMessage: "Passcode sent"));
      }
    });

    on<ForgotPassVerifyEvents>((event,emit) async{
      print("User has probably entered the passcode sent");
      if(event.otp.isNotEmpty && event.email.isNotEmpty){
        print("User has entered the passcode");
        try{
          String emailMessage = await AuthRepository().verifyEmailOTP(event.email, event.otp);
          if(emailMessage == "200"){
            emit(ForgotPassVerifySuccessState());
          }else if(emailMessage == "400"){
            emit(ForgotPassErrorState(errorMessage: "Invalid pin"));
          }
        }catch(e){
          emit(ForgotPassErrorState(errorMessage: "UnKnown error"));
        }
      }
    });
  }
}