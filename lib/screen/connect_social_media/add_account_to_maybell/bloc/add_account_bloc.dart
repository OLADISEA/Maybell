import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/social_media_name_repo.dart';
import 'add_account_event.dart';
import 'add_account_state.dart';

class AddSocialMediaNameBloc extends Bloc<AddSocialMediaNameEvent, AddSocialMediaNameState>{
  SocialMediaNameRepo socialMediaNameRepo = SocialMediaNameRepo();
  AddSocialMediaNameBloc({required this.socialMediaNameRepo}):super(AddSocialMediaNameState()){

    on<AddSocialMediaNameToMayBell>((event, emit) async{
      print("Loading state is activated");
      emit(SocialMediaNameLoadingState());
      try{
        String success = await socialMediaNameRepo.addSocialMediaNameRepo(event.socialMediaName);
        if(success == "success"){
          print("successful");
          emit(SocialMediaNameSuccessState());
        }else{
          print(success);
          print("not successful");
          emit(SocialMediaNameErrorState());
        }

      }catch(error){
        emit(SocialMediaNameErrorState());
      }
    });
  }
}