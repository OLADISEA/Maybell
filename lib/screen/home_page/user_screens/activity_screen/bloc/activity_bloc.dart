import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/repository/activity_repository.dart';
import 'activity_event.dart';
import 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  final ActivityRepository repository;

  ActivityBloc({required this.repository}) : super(ActivityLoadInProgress()){

 on<FetchActivities>((event, emit) async{
   emit(ActivityLoadInProgress());
   try {
     print('Activity list');
     final activities = await repository.fetchActivities();
     emit(ActivityLoadSuccess(activities));
     } catch (error) {
     if (error is TokenExpiredException) {
       // If it's a token expiration error, emit a state indicating that the access token has expired
       emit(AccessTokenExpired());
     }
       emit(ActivityLoadFailure());
     }
 });
  }

}
