import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maybell_apk/screen/home_page/user_screens/account_screen/bloc/user_account_event.dart';
import 'package:maybell_apk/screen/home_page/user_screens/account_screen/bloc/user_account_state.dart';

import '../data/user_account_repo.dart';
import '../models/user_account_model.dart';

class UserAccountBloc extends Bloc<UserAccountEvent, UserAccountState> {
  UserAccountRepo userAccountRepo = UserAccountRepo();

  UserAccountBloc({required this.userAccountRepo})
      : super(UserAccountLoadingState()) {
    on<TriggerUserAccount>((event, emit) async {
      try {

        List<UserAccountData> socialMediaAccounts =
        await userAccountRepo.getSocialMediaNames();
        print(" the length is ${socialMediaAccounts.length}");
        emit(UserAccountLoadedState(userAccounts: socialMediaAccounts));
      } catch (error) {
        emit(UserAccountErrorState(errorMessage: 'Unable to fetch social media account(s)'));
      }
    });
  }
}
