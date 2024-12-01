import 'package:equatable/equatable.dart';

import '../../common/models/activity_data.dart';

abstract class ActivityState extends Equatable {
  const ActivityState();

  @override
  List<Object?> get props => [];
}

class ActivityLoadInProgress extends ActivityState {}

class AccessTokenExpired extends ActivityState{}

class ActivityLoadSuccess extends ActivityState {
  final List<ActivityData> activities;

  const ActivityLoadSuccess(this.activities);

  @override
  List<Object?> get props => [activities];
}

class ActivityLoadFailure extends ActivityState {}
