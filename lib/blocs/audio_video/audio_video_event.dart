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
  const AudioVideoEventUpdateLocalAudiosVideos({required this.progress,required this.taskId,required this.status});

  @override
  List<Object> get props => [progress,taskId,status];
}



class AudioVideoEventChangeTaskId extends AudioVideoEvent {
  
  final String oldTaskId;
  final String newTaskId;
  const AudioVideoEventChangeTaskId({required this.oldTaskId,required this.newTaskId});

  @override
  List<Object> get props => [oldTaskId,newTaskId];
}