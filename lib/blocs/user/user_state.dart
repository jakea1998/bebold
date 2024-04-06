part of 'user_bloc.dart';

enum UserStatus { loading, loaded, initial, error }

class UserState extends Equatable {
  final UserStatus? userStatus;
  final bool? userExists;
  final UserModel? userModel;
  const UserState({this.userStatus, this.userExists, this.userModel});
  factory UserState.initial() {
    return const UserState(
        userModel: null, userExists: true, userStatus: UserStatus.initial);
  }
  UserState copyWith(
      {UserStatus? userStatus, bool? userExists, UserModel? userModel}) {
    return UserState(
        userModel: userModel ?? this.userModel,
        userExists: userExists ?? this.userExists,
        userStatus: userStatus ?? this.userStatus);
  }

  @override
  List<Object?> get props => [userModel, userExists, userStatus];
}
