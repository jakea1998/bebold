part of 'audio_video_bloc.dart';

enum VerseAudioVideoStatus { loading, loaded, initial, error }

class AudioVideoState extends Equatable {
  final List<FirebaseFile>? networkAudios;
  final List<FirebaseFile>? networkVideos;
  final List<ItemHolder>? localAudios;
  final List<ItemHolder>? localVideos;
  final bool? permissionGranted;
  final VerseAudioVideoStatus? status;
  final WitnessType? currentWitnessType;
  const AudioVideoState(
      {this.networkAudios,
      this.networkVideos,
      this.localAudios,
      this.localVideos,
      this.permissionGranted,
      this.currentWitnessType,
      this.status});
  factory AudioVideoState.initial() {
    return AudioVideoState(
        networkAudios: [],
        networkVideos: [],
        localAudios: [],
        localVideos: [],
        permissionGranted: false,
        currentWitnessType: null,
        status: VerseAudioVideoStatus.initial);
  }
  AudioVideoState copyWith(
      {List<FirebaseFile>? networkAudios,
      List<FirebaseFile>? networkVideos,
      List<ItemHolder>? localAudios,
      List<ItemHolder>? localVideos,
      bool? permissionGranted,
      VerseAudioVideoStatus? status,
      WitnessType? currentWitnessType}) {
    return AudioVideoState(
        networkAudios: networkAudios ?? this.networkAudios,
        networkVideos: networkVideos ?? this.networkVideos,
        permissionGranted: permissionGranted?? this.permissionGranted,
        localAudios: localAudios ?? this.localAudios,
        localVideos: localVideos ?? this.localVideos,
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
        status
      ];
}
