part of 'user_bloc.dart';

enum UserStatus { loading, loaded, initial, error }

class UserState extends Equatable {
  final UserStatus? userStatus;
  final UserModel? userModel;
  const UserState({this.userStatus, this.userModel});
  factory UserState.initial() {
    return UserState(userModel: null, userStatus: UserStatus.initial);
  }
  UserState copyWith({UserStatus? userStatus, UserModel? userModel}) {
    return UserState(
        userModel: userModel ?? this.userModel,
        userStatus: userStatus ?? this.userStatus);
  }

  @override
  List<Object?> get props => [userModel,userStatus];
}


