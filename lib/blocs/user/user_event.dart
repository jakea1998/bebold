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
  
  
}
class UserEventUpdateUser extends UserEvent {
  final UserModel userModel;
  const UserEventUpdateUser({required this.userModel});
  @override
  List<Object> get props => [userModel];
}
