import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/repository/auth_repository.dart';
import 'authorization_events.dart';
import 'authorization_states.dart';

class AuthorizationBloc extends Bloc<AuthorizationEvents,AuthorizationState>{
  AuthorizationBloc():super(AuthorizationState()){
    on<VerifyAccountEvents>((event, emit) async{
      emit(AuthorizationLoading());
      print(event.email);
      print(event.socialMediaName);
      print(event.password);
      final String? name = await AuthRepository().authorizeAccount(event.email, event.password, event.socialMediaName);
      if(name != null && name.isNotEmpty){
        emit(AuthorizationSuccess(name));
      }else{
        print("An Error occurred");
      }
    });
  }
}