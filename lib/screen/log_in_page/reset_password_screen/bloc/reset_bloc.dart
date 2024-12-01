import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maybell_apk/screen/log_in_page/reset_password_screen/bloc/reset_events.dart';
import 'package:maybell_apk/screen/log_in_page/reset_password_screen/bloc/reset_states.dart';

import '../../../../data/repository/auth_repository.dart';


class ResetPassBloc extends Bloc<ResetPassEvents,ResetPassStates>{
  AuthRepository authRepository = AuthRepository();
  ResetPassBloc({required this.authRepository}): super(ResetPassStates()) {
    on<ConfirmPassEvents>((event, emit) {

    });

    on<ToggleEvents>((event, emit) {

    });

    on<TriggerResetPassword>((event, emit) {

    });
  }
}