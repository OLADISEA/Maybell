import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/repository/auth_repository.dart';
import 'create_passcode_event.dart';
import 'create_passcode_state.dart';

class CreatePasscodeBloc extends Bloc<CreatePasscodeEvents, CreatePasscodeState>{
  AuthRepository authRepository = AuthRepository();
  CreatePasscodeBloc({required this.authRepository}):super(PasscodeLoadingState()){
    on<TriggerPasscodeEvents>((event, emit) async{
      emit(PasscodeLoadingState());
      bool success = await authRepository.createPasscode(passcode: event.passcode);
      if(success){
        emit(PasscodeSuccessState());
      }else{
        emit(PasscodeErrorState());
      }
    });
  }
}