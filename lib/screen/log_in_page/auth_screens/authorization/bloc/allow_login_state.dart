import 'package:flutter_bloc/flutter_bloc.dart';


// Define states
abstract class AllowLoginState {}

class AllowLoginInitial extends AllowLoginState {}

class AllowLoginFailure extends AllowLoginState {}

class AllowLoginSuccess extends AllowLoginState {
  final String loginStatus;
  AllowLoginSuccess({required this.loginStatus});
}

// Define bloc
