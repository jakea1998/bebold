import 'dart:async';

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
    on<UserEventLoadUser>((event, emit) {
      if (_stream != null) _stream == null;
      _stream =
          userRepo.loadUser(uid: _auth.currentUser?.uid ?? "").listen((event) {
        add(UserEventUpdateUser(userModel: event));
      });
    });
    on<UserEventUpdateUser>((event, emit) {
      emit(state.copyWith(
          userModel: event.userModel, userStatus: UserStatus.loaded));
    });
    
  }
}
