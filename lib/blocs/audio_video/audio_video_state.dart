part of 'audio_video_bloc.dart';

enum VerseAudioVideoStatus { loading, loaded, initial, error }

class AudioVideoState extends Equatable {
  final List<FirebaseFile>? networkAudios;
  final List<FirebaseFile>? networkVideos;
  final List<TaskInfo2>? localAudios;
  final List<TaskInfo2>? localVideos;
  final bool? permissionGranted;
  final VerseAudioVideoStatus? status;
  final WitnessType? currentWitnessType;
  final bool? connectedToInternet;

  const AudioVideoState(
      {this.networkAudios,
      this.networkVideos,
      this.localAudios,
      this.localVideos,
      this.permissionGranted,
      this.currentWitnessType,
      this.connectedToInternet,
      this.status});

  factory AudioVideoState.initial() {
    return const AudioVideoState(
        networkAudios: [],
        networkVideos: [],
        localAudios: [],
        localVideos: [],
        permissionGranted: false,
        currentWitnessType: null,
        connectedToInternet: true,
        status: VerseAudioVideoStatus.initial);
  }
  AudioVideoState copyWith(
      {List<FirebaseFile>? networkAudios,
      List<FirebaseFile>? networkVideos,
      List<TaskInfo2>? localAudios,
      List<TaskInfo2>? localVideos,
      bool? permissionGranted,
      VerseAudioVideoStatus? status,
      bool? connectedToInternet,
      WitnessType? currentWitnessType}) {
    return AudioVideoState(
        networkAudios: networkAudios ?? this.networkAudios,
        networkVideos: networkVideos ?? this.networkVideos,
        permissionGranted: permissionGranted ?? this.permissionGranted,
        localAudios: localAudios ?? this.localAudios,
        localVideos: localVideos ?? this.localVideos,
        connectedToInternet: connectedToInternet ?? this.connectedToInternet,
        currentWitnessType: currentWitnessType ?? this.currentWitnessType,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [
        networkAudios,
        networkVideos,
        localAudios,
        localVideos,
        permissionGranted,
        currentWitnessType,
        connectedToInternet,
        status
      ];
}
