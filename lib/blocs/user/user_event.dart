part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserEventCreateUser extends UserEvent {
  final UserModel userModel;
  const UserEventCreateUser({required this.userModel});
  @override
  List<Object> get props => [userModel];
}

class UserEventLoadUser extends UserEvent {
  final LivesChangedBloc livesChangedBloc;
  const UserEventLoadUser({required this.livesChangedBloc});
  @override
  List<Object> get props => [livesChangedBloc];
}

class UserEventUpdateUser extends UserEvent {
  final UserModel userModel;
  const UserEventUpdateUser({required this.userModel});
  @override
  List<Object> get props => [userModel];
}
class UserEventLogoutUser extends UserEvent {
  
  final LivesChangedBloc livesChangedBloc;
  
  const UserEventLogoutUser({required this.livesChangedBloc});
  @override
  List<Object> get props => [livesChangedBloc];
}
class UserEventDeleteUser extends UserEvent {
  final UserModel userModel;
  final LivesChangedBloc livesChangedBloc;
  const UserEventDeleteUser({required this.userModel,required this.livesChangedBloc});
  @override
  List<Object> get props => [userModel,livesChangedBloc];
}
