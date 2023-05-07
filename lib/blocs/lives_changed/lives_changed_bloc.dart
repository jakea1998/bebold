import 'dart:async';

import 'package:be_bold/blocs/reports/reports_bloc.dart';
import 'package:be_bold/blocs/repos/lives_changed_repo.dart';
import 'package:be_bold/models/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'lives_changed_event.dart';
part 'lives_changed_state.dart';

class LivesChangedBloc extends Bloc<LivesChangedEvent, LivesChangedState> {
  StreamSubscription<List<UserModel>>? livesChangedStream;
  final _auth = FirebaseAuth.instance;
  final repo = LivesChangedRepo();

  LivesChangedBloc({required ReportsBloc reportsBloc})
      : super(LivesChangedState.initial()) {
    on<LivesChangedEventAddLive>((event, emit) async {
      // TODO: implement event handler

      await repo.addLifeChanged(
          user: event.model, uid: _auth.currentUser?.uid ?? "");
    });
    on<LivesChangedEventLoadLives>((event, emit) {
      try {
        if (livesChangedStream != null) livesChangedStream = null;
        livesChangedStream = repo
            .loadLivesChanged(uid: _auth.currentUser?.uid ?? "")
            .listen((event) {
          add(LivesChangedEventUpdateLives(models: event));
        });
      } catch (e) {
        emit(state.copyWith(status: LivesChangedStatus.error));
      }
    });
    on<LivesChangedEventUpdateLives>((event, emit) {
      reportsBloc.add(ReportsEventUpdateUsers(users: event.models));
      emit(state.copyWith(
          status: LivesChangedStatus.loaded, models: event.models));
    });
  }
}
