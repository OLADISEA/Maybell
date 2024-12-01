import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maybell_apk/screen/connect_social_media/add_account_to_maybell/bloc/add_account_bloc.dart';
import 'package:maybell_apk/screen/connect_social_media/add_account_to_maybell/data/social_media_name_repo.dart';
import 'package:maybell_apk/screen/connect_social_media/authorization/bloc/authorization_bloc.dart';
import 'package:maybell_apk/screen/home_page/user_screens/account_screen/bloc/user_account_bloc.dart';
import 'package:maybell_apk/screen/home_page/user_screens/account_screen/data/user_account_repo.dart';
import 'package:maybell_apk/screen/home_page/user_screens/activity_screen/bloc/activity_bloc.dart';
import 'package:maybell_apk/screen/log_in_page/auth_screens/authorization/bloc/allow_login_bloc.dart';
import 'package:maybell_apk/screen/log_in_page/auth_screens/authorization/data/allow_login_repo.dart';
import 'package:maybell_apk/screen/log_in_page/bloc/log_in_bloc.dart';
import 'package:maybell_apk/screen/log_in_page/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:maybell_apk/screen/log_in_page/reset_password_screen/bloc/reset_bloc.dart';
import 'package:maybell_apk/screen/onboarding_screen/bloc/welcome_bloc.dart';
import 'package:maybell_apk/screen/sign_up_screen/bloc/signup_bloc.dart';
import 'package:maybell_apk/screen/sign_up_screen/verification/create_passcode/bloc/create_passcode_bloc.dart';
import 'package:maybell_apk/screen/start_up_screen/splash_screen.dart';

import 'bloc/app_bloc.dart';
import 'data/detect_unauthorized_access/notification_service.dart';
import 'data/detect_unauthorized_access/websocket/bloc/websocket_bloc.dart';
import 'data/detect_unauthorized_access/websocket/websocket_service.dart';
import 'data/repository/activity_repository.dart';
import 'data/repository/auth_repository.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initializeNotification();
  runApp(

      MultiBlocProvider(
          providers: [
            BlocProvider(create: (context)=>AppBloc()),
            BlocProvider(create: (context) => ActivityBloc(repository: ActivityRepository())),
            BlocProvider(create: (context)=>WelcomeBloc()),
            BlocProvider(create: (context) => SignUpBloc()),
            BlocProvider(create: (context) => SignInBloc()),
            BlocProvider(create: (context) => AllowLoginBloc(allowLoginRepo: AllowLoginRepo())),
            BlocProvider(create: (context) => AuthorizationBloc()),
            BlocProvider(create:(context) => AddSocialMediaNameBloc(socialMediaNameRepo: SocialMediaNameRepo())),
            BlocProvider(create:(context) => CreatePasscodeBloc(authRepository: AuthRepository())),
            BlocProvider(create: (context) => ResetPassBloc(authRepository: AuthRepository())),
            BlocProvider(create: (context) => ForgotPasswordBloc(authRepository: AuthRepository())),
            BlocProvider(create: (context) => UserAccountBloc(userAccountRepo: UserAccountRepo())),
            BlocProvider(
              create: (context) => WebSocketBloc(WebSocketService()),
            ),


          ],
          child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: const Size(430, 932),
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}

