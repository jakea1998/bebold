import 'package:be_bold/blocs/repos/audio_video_repo.dart';
import 'package:be_bold/constants/enums.dart';
import 'package:be_bold/models/firebase_file.dart';
import 'package:be_bold/models/item_holder.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import '../../models/task_info.dart';

part 'audio_video_event.dart';
part 'audio_video_state.dart';

class AudioVideoBloc extends Bloc<AudioVideoEvent, AudioVideoState> {
  final repo = AudioVideoRepo();
  AudioVideoBloc() : super(AudioVideoState.initial()) {
    on<AudioVideoEventLoad>((event, emit) async {
      // TODO: implement event handler
      List<FirebaseFile> currentVideos = [];
      List<FirebaseFile> currentAudios = [];
      switch (event.type) {
        case WitnessType.acquaintance:
          currentAudios =
              await AudioVideoRepo().listAll(path: 'audios/Acquaintance/');
          currentVideos =
              await AudioVideoRepo().listAll(path: 'videos/Acquaintance/');
          break;
        case WitnessType.friend:
          currentAudios =
              await AudioVideoRepo().listAll(path: 'audios/Friend/');
          currentVideos =
              await AudioVideoRepo().listAll(path: 'videos/Friend/');
          break;
        case WitnessType.familyMember:
          currentAudios =
              await AudioVideoRepo().listAll(path: 'audios/Family Member/');
          currentVideos =
              await AudioVideoRepo().listAll(path: 'videos/Family Member/');
          break;
        case WitnessType.newConnection:
          currentAudios =
              await AudioVideoRepo().listAll(path: 'audios/New Connection/');
          currentVideos =
              await AudioVideoRepo().listAll(path: 'videos/New Connection/');
          break;
      }
      List<ItemHolder> items = await AudioVideoRepo()
          .loadLocalFiles(audios: currentAudios, videos: currentVideos);

      final localAudios = items
              .where(
                (element) => element.type == ItemType.Audio,
              )
              .toList() ??
          [];
      final localVideos = items
              .where(
                (element) => element.type == ItemType.Video,
              )
              .toList() ??
          [];

      emit(state.copyWith(
          networkAudios: currentAudios,
          networkVideos: currentVideos,
          localAudios: localAudios,
          localVideos: localVideos,
          status: VerseAudioVideoStatus.loaded,
          currentWitnessType: event.type));
    });
    on<AudioVideoEventUpdateLocalAudiosVideos>((event, emit) async {
      List<ItemHolder> items = await AudioVideoRepo().loadLocalFiles(
          audios: state.networkAudios ?? [], videos: state.networkVideos ?? []);
      
      final localVideos = items
              .where(
                (element) => element.type == ItemType.Video,
              )
              .toList() ??
          [];
      final localAudios = items
              .where(
                (element) => element.type == ItemType.Audio,
              )
              .toList() ??
          [];
      ItemType itemType = ItemType.None;
      final isAudio = localAudios.any((element) =>
          element.task?.taskId.toString() == event.taskId.toString());
      if (isAudio) itemType = ItemType.Audio;
      final isVideo = localVideos.any((element) =>
          element.task?.taskId.toString() == event.taskId.toString());
      if (isVideo) itemType = ItemType.Video;
      switch (itemType) {
        case ItemType.Audio:
          List<ItemHolder> localAudios1 = []..addAll(localAudios);
          final index1 = localAudios1.indexWhere(
              (x) => x.task?.taskId.toString() == event.taskId.toString());

          localAudios1[index1].task
            ?..progress = event.progress
            ..taskId = event.taskId
            ..status = event.status;
          emit(state.copyWith(
            localAudios: localAudios1,
            status: VerseAudioVideoStatus.loaded,
          ));
          break;
        case ItemType.Video:
          List<ItemHolder> localVideos1 = []..addAll(localVideos);
          final index1 = localVideos1.indexWhere(
              (x) => x.task?.taskId.toString() == event.taskId.toString());

          localVideos1[index1].task?.progress = event.progress;
          localVideos1[index1].task?.taskId = event.taskId;
          localVideos1[index1].task?.status = event.status;

          emit(state.copyWith(
            localVideos: localVideos1,
            status: VerseAudioVideoStatus.loaded,
          ));
          break;
        case ItemType.None:
          print('else');
          emit(state.copyWith(
            status: VerseAudioVideoStatus.loaded,
          ));
          break;
      }
     
    });
  
    on<AudioVideoEventChangeTaskId>((event, emit) {
      final audioIndex = state.localAudios?.indexWhere((element) =>
          element.task?.taskId.toString() == event.oldTaskId.toString());
      if (audioIndex != -1) {
        state.localAudios?[audioIndex!].task?.taskId = event.newTaskId;
      }
      final videoIndex = state.localVideos?.indexWhere((element) =>
          element.task?.taskId.toString() == event.oldTaskId.toString());
      if (videoIndex != -1) {
        state.localVideos?[videoIndex!].task?.taskId = event.newTaskId;
      }
      emit(state.copyWith(
          localAudios: state.localAudios,
          localVideos: state.localVideos,
          status: VerseAudioVideoStatus.loaded));
    });
  }
}
