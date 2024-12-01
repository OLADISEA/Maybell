import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maybell_apk/screen/start_up_screen/start_up.dart';

import '../../bloc/app_bloc.dart';
import '../../bloc/app_events.dart';
import '../../bloc/app_states.dart';
import '../home_page/home_page.dart';
import '../log_in_page/auth_screens/returning_user_page.dart';
import '../sign_up_screen/sign_up_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    super.initState();
    // AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    //   if(!isAllowed){
    //     AwesomeNotifications().requestPermissionToSendNotifications();
    //   }
    // });
    context.read<AppBloc>().add(AppStarted());
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {

        if (state is OnBoardingState) {
          return StartUp();
        } else if (state is HomePageState) {
          return const HomePage();
        } else if (state is WelcomeBackState) {
          return ReturningUserPage();
        } else if(state is LogInState){
          return SignUp();
        }
        else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
