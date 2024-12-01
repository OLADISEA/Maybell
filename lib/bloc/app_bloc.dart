

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_events.dart';
import 'app_states.dart';

class AppBloc extends Bloc<AppEvent, AppState> {

  AppBloc() : super(InitialState()){
    on<AppStarted>((event, emit) async{
      final prefs = await SharedPreferences.getInstance();
      final isFirstTime = prefs.getBool('isFirstTime')??true;
      final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      final bool isLoggedOut = prefs.getBool('isLogged0ut') ?? false;
      print('TRIGGERED');

      if(!isLoggedOut && !isLoggedIn && !isFirstTime){
        //emit(WelcomeBackState());
        emit(LogInState());

      }
      else if (isLoggedIn) {
        emit(HomePageState());
      } else if (isFirstTime){
        await prefs.setBool('isFirstTime',false);
        emit(OnBoardingState());
      }
      else {
        await prefs.setBool('isFirstTime',false);
        emit(LogInState());
      }
    });
  }

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield HomePageState();
    } else if (event is LoggedOut) {
      yield WelcomeBackState();
    }
  }

  Stream<AppState> _mapAppStartedToState() async* {
    final prefs = await SharedPreferences.getInstance();
    final isFirstTime = prefs.getBool('isFirstTime')??false;
    final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      yield HomePageState();
    } else if (isFirstTime){
      yield OnBoardingState();
    }
    else {
      await prefs.setBool('isFirstTime',false);
      yield LogInState();
    }
  }
}
