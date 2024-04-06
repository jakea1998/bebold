import 'dart:async';

import 'package:be_bold/blocs/lives_changed/lives_changed_bloc.dart';
import 'package:be_bold/blocs/reports/reports_bloc.dart';
import 'package:be_bold/blocs/repos/user_repo.dart';
import 'package:be_bold/models/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserRepo userRepo = UserRepo();
  StreamSubscription<UserModel>? _stream;
  final _auth = FirebaseAuth.instance;
  UserBloc() : super(UserState.initial()) {
    on<UserEventCreateUser>((event, emit) async {
      // TODO: implement event handler
      await userRepo.createUser(user: event.userModel);
    });
    on<UserEventLoadUser>((event, emit) async {
      if (_auth.currentUser == null) {
        emit(state.copyWith(userExists: false, userStatus: UserStatus.loaded));
      } else {
        if (_stream != null) _stream == null;
        _stream = userRepo
            .loadUser(uid: _auth.currentUser?.uid ?? "")
            .listen((event) {
          add(UserEventUpdateUser(userModel: event));
        });
        event.livesChangedBloc.add(LivesChangedEventLoadLives());
      }
    });
    on<UserEventUpdateUser>((event, emit) {
      emit(state.copyWith(
          userModel: event.userModel, userExists: _auth.currentUser != null,userStatus: UserStatus.loaded));
    });
    on<UserEventLogoutUser>((event, emit) async {
      emit(state.copyWith(userStatus: UserStatus.loading));
      try {
        await _auth.signOut();
        event.livesChangedBloc.add(LivesChangedEventClearLives());
        emit(state.copyWith(
            userStatus: UserStatus.loaded,
            userExists: false,
            userModel: UserModel()));
      } catch (e) {
        emit(state.copyWith(userStatus: UserStatus.error));
      }
    });
    on<UserEventDeleteUser>((event, emit) async {
      try {
        emit(state.copyWith(userStatus: UserStatus.loading));
        _stream = null;

        await userRepo.deleteUser(user: event.userModel);
        event.livesChangedBloc.add(LivesChangedEventClearLives());
        await _auth.currentUser?.delete();
        emit(state.copyWith(userModel: null, userStatus: UserStatus.loaded));
      } catch (e) {
        emit(state.copyWith(userStatus: UserStatus.error));
      }
    });
  }
}
