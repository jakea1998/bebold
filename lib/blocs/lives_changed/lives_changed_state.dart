part of 'lives_changed_bloc.dart';

enum LivesChangedStatus { loading, loaded, error, initial }

@immutable
class LivesChangedState extends Equatable {
  final LivesChangedStatus? status;
  final List<UserModel>? models;
  LivesChangedState({this.status, this.models});
  factory LivesChangedState.initial() {
    return LivesChangedState(status: LivesChangedStatus.initial, models: null);
  }
  LivesChangedState copyWith(
      {LivesChangedStatus? status, List<UserModel>? models}) {
    return LivesChangedState(
        status: status ?? this.status, models: models ?? this.models);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status,models];
}
