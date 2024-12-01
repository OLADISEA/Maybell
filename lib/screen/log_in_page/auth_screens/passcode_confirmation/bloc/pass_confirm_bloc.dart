import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maybell_apk/screen/log_in_page/auth_screens/passcode_confirmation/bloc/pass_confirm_event.dart';
import 'package:maybell_apk/screen/log_in_page/auth_screens/passcode_confirmation/bloc/pass_confirm_state.dart';

class PasscodeBloc extends Bloc<PassEvents, PassConfirmState>{

  PasscodeBloc():super(PassLoadingState()){
    on<ConfirmPasscode>((event, emit) {

    });
  }
}