part of 'lives_changed_bloc.dart';

@immutable
abstract class LivesChangedEvent extends Equatable {}

class LivesChangedEventAddLive extends LivesChangedEvent {
  final UserModel model;
  LivesChangedEventAddLive({required this.model});
  
  @override
  // TODO: implement props
  List<Object?> get props => [model];
}
class LivesChangedEventLoadLives extends LivesChangedEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class LivesChangedEventUpdateLives extends LivesChangedEvent {
  final List<UserModel> models;
  LivesChangedEventUpdateLives({required this.models});
  @override
  // TODO: implement props
  List<Object?> get props => [models];
}
