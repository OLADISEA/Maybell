import 'package:equatable/equatable.dart';

import '../models/user_account_model.dart';

class UserAccountState extends Equatable{
  @override

  List<Object?> get props => [];
}

class UserAccountLoadingState extends UserAccountState{}

class UserAccountLoadedState extends UserAccountState{
  final List<UserAccountData> userAccounts;
  UserAccountLoadedState({required this.userAccounts});
}

class UserAccountErrorState extends UserAccountState{
  final String errorMessage;
  UserAccountErrorState({required this.errorMessage});
}