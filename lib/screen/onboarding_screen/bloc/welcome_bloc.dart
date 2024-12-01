import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maybell_apk/screen/onboarding_screen/bloc/welcome_events.dart';
import 'package:maybell_apk/screen/onboarding_screen/bloc/welcome_states.dart';





class WelcomeBloc extends Bloc<WelcomeEvents,WelcomeStates>{
  WelcomeBloc():super(WelcomeStates()){
    on<WelcomeEvents>((event, emit){
      emit(WelcomeStates(counter: state.counter));
    });
  }
}