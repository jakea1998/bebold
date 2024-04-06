part of 'audio_video_bloc.dart';

abstract class AudioVideoEvent extends Equatable {
  const AudioVideoEvent();

  @override
  List<Object> get props => [];
}

class AudioVideoEventLoad extends AudioVideoEvent {
  final WitnessType type;
  const AudioVideoEventLoad({required this.type});

  @override
  List<Object> get props => [type];
}

class AudioVideoEventUpdateLocalAudiosVideos extends AudioVideoEvent {
  final int progress;
  final String taskId;
  final DownloadTaskStatus status;

  const AudioVideoEventUpdateLocalAudiosVideos(
      {required this.progress, required this.taskId, required this.status});

  @override
  List<Object> get props => [progress, taskId, status];
}

class AudioVideoEventChangeTaskId extends AudioVideoEvent {
  final String oldTaskId;
  final String newTaskId;
  const AudioVideoEventChangeTaskId(
      {required this.oldTaskId, required this.newTaskId});

  @override
  List<Object> get props => [oldTaskId, newTaskId];
}

class AudioVideoEventSetTaskId extends AudioVideoEvent {
  final String link;
  final String newTaskId;
  final ItemType itemType;
  const AudioVideoEventSetTaskId(
      {required this.link, required this.newTaskId, required this.itemType});

  @override
  List<Object> get props => [link, newTaskId, itemType];
}

class AudioVideoEventDeleteLocalAudioVideo extends AudioVideoEvent {
  final String taskId;
  final ItemType itemType;
  const AudioVideoEventDeleteLocalAudioVideo({required this.taskId,required this.itemType});
  @override
  List<Object> get props => [taskId,itemType];
}
