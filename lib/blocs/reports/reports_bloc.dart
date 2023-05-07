import 'package:be_bold/models/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'reports_event.dart';
part 'reports_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  ReportsBloc() : super(ReportsState.initial()) {
    on<ReportsEventUpdateUsers>((event, emit) {
      // TODO: implement event handler
      emit(state.copyWith(reportsStatus: ReportsStatus.loading));
      if (state.startDate == null && state.endDate == null) {
        final accepted = event.users.where(
          (element) => element.userStatus == UserStatus.accepted,
        );
        emit(state.copyWith(
          reportsStatus: ReportsStatus.loaded,
            totalUsers: event.users,
            witnessed: event.users,
            accepted: accepted.toList()));
      } else if (state.startDate == null) {
        final witnessed = event.users.where((element) =>
            element.creationDate?.isBefore(state.endDate ?? DateTime.now()) ??
            false);
        final accepted = witnessed.where(
          (element) => element.userStatus == UserStatus.accepted,
        );
        emit(state.copyWith(
            reportsStatus: ReportsStatus.loaded,
            totalUsers: event.users,
            witnessed: witnessed.toList(),
            accepted: accepted.toList()));
      } else if (state.endDate == null) {
        final witnessed = event.users.where((element) =>
            element.creationDate?.isAfter(state.startDate ?? DateTime.now()) ??
            false);
        final accepted = witnessed.where(
          (element) => element.userStatus == UserStatus.accepted,
        );
        emit(state.copyWith(
            totalUsers: event.users,
            reportsStatus: ReportsStatus.loaded,
            witnessed: witnessed.toList(),
            accepted: accepted.toList()));
      } else {
        final witnessed = event.users.where((element) =>
            (element.creationDate?.isBefore(state.endDate ?? DateTime.now()) ??
                false) &&
            (element.creationDate?.isAfter(state.startDate ?? DateTime.now()) ??
                false));
        final accepted = witnessed.where(
          (element) => element.userStatus == UserStatus.accepted,
        );
        emit(state.copyWith(
            totalUsers: event.users,
            reportsStatus: ReportsStatus.loaded,
            witnessed: witnessed.toList(),
            accepted: accepted.toList()));
      }
    });
    on<ReportsEventUpdateDate>((event, emit) {
        emit(state.copyWith(reportsStatus: ReportsStatus.loading));
      if (event.startDate == null && event.endDate == null) {
        final accepted = state.totalUsers?.where(
          (element) => element.userStatus == UserStatus.accepted,
        );
        emit(state.copyWith(
            startDate: event.startDate,
            endDate: event.endDate,
            reportsStatus: ReportsStatus.loaded,
            witnessed: state.totalUsers,
            accepted: accepted?.toList()));
      } else if (event.startDate == null) {
        final witnessed = state.totalUsers?.where((element) =>
            element.creationDate?.isBefore(event.endDate ?? DateTime.now()) ??
            false);
        final accepted = witnessed?.where(
          (element) => element.userStatus == UserStatus.accepted,
        );
        emit(state.copyWith(
            startDate: event.startDate,
            endDate: event.endDate,
            reportsStatus: ReportsStatus.loaded,
            witnessed: witnessed?.toList(),
            accepted: accepted?.toList()));
      } else if (state.endDate == null) {
        final witnessed = state.totalUsers?.where((element) =>
            element.creationDate?.isAfter(event.startDate ?? DateTime.now()) ??
            false);
        final accepted = witnessed?.where(
          (element) => element.userStatus == UserStatus.accepted,
        );
        emit(state.copyWith(
            startDate: event.startDate,
            endDate: event.endDate,
            reportsStatus: ReportsStatus.loaded,
            witnessed: witnessed?.toList(),
            accepted: accepted?.toList()));
      } else {
        final witnessed = state.totalUsers?.where((element) =>
            (element.creationDate?.isBefore(event.endDate ?? DateTime.now()) ??
                false) &&
            (element.creationDate?.isAfter(event.startDate ?? DateTime.now()) ??
                false));
        final accepted = witnessed?.where(
          (element) => element.userStatus == UserStatus.accepted,
        );
        emit(state.copyWith(
            startDate: event.startDate,
            endDate: event.endDate,
            reportsStatus: ReportsStatus.loaded,
            witnessed: witnessed?.toList(),
            accepted: accepted?.toList()));
      }
    });
  }
}
