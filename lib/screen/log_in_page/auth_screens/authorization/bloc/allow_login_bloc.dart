import 'package:flutter_bloc/flutter_bloc.dart';


import '../data/allow_login_repo.dart';
import 'allow_login_event.dart';
import 'allow_login_state.dart';

class AllowLoginBloc extends Bloc<AllowLoginEvent, AllowLoginState> {
  final AllowLoginRepo allowLoginRepo;

  AllowLoginBloc({required this.allowLoginRepo}) : super(AllowLoginInitial()){
    on<AllowLoginRequested>((event, emit) async{
      print("initial state");
      emit(AllowLoginInitial());
      try {
        print("Here");
        final success = await allowLoginRepo.allowLogin(allowLogin: event.allowLogin,loginInfoId: event.loginInfoId);
        if (success) {
          print("successful");
          emit(AllowLoginSuccess(loginStatus: event.allowLogin?'Login Approved!': 'Login Declined!'));
        } else {
          print("unsuccessful");
          emit(AllowLoginFailure());
        }
      } catch (_) {
        emit(AllowLoginFailure());
      }
    }
    );
  }



}
