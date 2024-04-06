import 'package:be_bold/blocs/repos/audio_video_repo.dart';
import 'package:be_bold/constants/enums.dart';
import 'package:be_bold/models/firebase_file.dart';

import 'package:be_bold/utils/connectivity.dart';
import 'package:be_bold/utils/downloader_functions.dart';
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
      emit(state.copyWith(status: VerseAudioVideoStatus.loading));
      final connected_to_internet = await getConnected();
      print(connected_to_internet);
      if (connected_to_internet) {
        List<FirebaseFile> networkVideos = [];
        List<FirebaseFile> networkAudios = [];
        // If Connected load network audios and videos based on category
        switch (event.type) {
          case WitnessType.acquaintance:
            networkAudios = await repo.listAll(path: 'audios/Acquaintance/');
            networkVideos = await repo.listAll(path: 'videos/Acquaintance/');
            break;
          case WitnessType.friend:
            networkAudios = await repo.listAll(path: 'audios/Friend/');
            networkVideos = await repo.listAll(path: 'videos/Friend/');
            break;
          case WitnessType.familyMember:
            networkAudios = await repo.listAll(path: 'audios/Family Member/');
            networkVideos = await repo.listAll(path: 'videos/Family Member/');
            break;
          case WitnessType.newConnection:
            networkAudios = await repo.listAll(path: 'audios/New Connection/');
            networkVideos = await repo.listAll(path: 'videos/New Connection/');
            break;
        }
        List<TaskInfo2> blankDownloads = [
          ...networkAudios.map((audio) => TaskInfo2(
              type: ItemType.Audio,
              displayName: audio.name,
              categoryName: audio.subPath.replaceAll("/", "_"),
              link: audio.url)),
          ...networkVideos.map((video) => TaskInfo2(
              type: ItemType.Video,
              displayName: video.name,
              categoryName: video.subPath.replaceAll("/", "_"),
              link: video.url))
        ];

        List<TaskInfo2> items =
            await repo.loadLocalFilesConnected(blankDownloads: blankDownloads);

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
            networkAudios: networkAudios,
            networkVideos: networkVideos,
            localAudios: localAudios,
            localVideos: localVideos,
            connectedToInternet: connected_to_internet,
            status: VerseAudioVideoStatus.loaded,
            currentWitnessType: event.type));
      } else {
        List<TaskInfo2> items =
            await repo.loadLocalFilesDisconnected(witnessType: event.type);

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
            networkAudios: [],
            networkVideos: [],
            localAudios: localAudios,
            localVideos: localVideos,
            connectedToInternet: connected_to_internet,
            status: VerseAudioVideoStatus.loaded,
            currentWitnessType: event.type));
      }
      // If not connected load from downloads
    });
    on<AudioVideoEventUpdateLocalAudiosVideos>((event, emit) async {
      final connected_to_internet = await getConnected();
      String? saved_directory;
      /* List<ItemHolder> items = await repo.loadLocalFiles(
          audios: state.networkAudios ?? [], videos: state.networkVideos ?? []); */
      List<TaskInfo2> items2 = []
        ..addAll(state.localAudios ?? [] as List<TaskInfo2>)
        ..addAll(state.localVideos ?? [] as List<TaskInfo2>);
      /* final items1 = await FlutterDownloader.loadTasksWithRawQuery(
          query: "SELECT * FROM task WHERE task_id=${event.taskId}");
      items1?.forEach((element) {
        print(element.filename);
        print(element.savedDir);
      }); */
      ItemType itemType1 = ItemType.None;
      try {
        emit(state.copyWith(status: VerseAudioVideoStatus.loading));
        final match_item = items2.firstWhere(
            (element) => element.taskId.toString() == event.taskId.toString());
        itemType1 = match_item.type ?? ItemType.None;
        items2.removeWhere((element) => element.type != itemType1);

        saved_directory ??= await DownloaderFunctions.prepareSaveDir();

        final index = items2.indexWhere((element) =>
            element.taskId.toString() == match_item.taskId.toString());
        items2[index]
          ..progress = event.progress
          ..taskId = event.taskId
          ..filePath = "$saved_directory/${match_item.name}"
          ..status = event.status;
        emit(state.copyWith(
          connectedToInternet: connected_to_internet,
          localVideos: itemType1 == ItemType.Video ? items2 : state.localVideos,
          localAudios: itemType1 == ItemType.Audio ? items2 : state.localAudios,
          status: VerseAudioVideoStatus.loaded,
        ));
      } on StateError catch (e) {
        print("None");
        //emit(state.copyWith(status: VerseAudioVideoStatus.loaded));
      }
    });

    on<AudioVideoEventChangeTaskId>((event, emit) {
      final audioIndex = state.localAudios?.indexWhere(
          (element) => element.taskId.toString() == event.oldTaskId.toString());
      if (audioIndex != -1) {
        state.localAudios?[audioIndex!].taskId = event.newTaskId;
      }
      final videoIndex = state.localVideos?.indexWhere(
          (element) => element.taskId.toString() == event.oldTaskId.toString());
      if (videoIndex != -1) {
        state.localVideos?[videoIndex!].taskId = event.newTaskId;
      }
      emit(state.copyWith(
          localAudios: state.localAudios,
          localVideos: state.localVideos,
          status: VerseAudioVideoStatus.loaded));
    });
    on<AudioVideoEventSetTaskId>((event, emit) {
      if (event.itemType == ItemType.Audio) {
        try {
          state.localAudios
              ?.firstWhere((element) => element.link == event.link)
              .taskId = event.newTaskId;
          emit(state.copyWith(localAudios: state.localAudios));
        } on StateError catch (e) {
          print("No audio found");
        }
      } else if (event.itemType == ItemType.Video) {
        try {
          state.localVideos
              ?.firstWhere((element) => element.link == event.link)
              .taskId = event.newTaskId;
          emit(state.copyWith(localVideos: state.localVideos));
        } on StateError catch (e) {
          print("No video found");
        }
      }
    });
    on<AudioVideoEventDeleteLocalAudioVideo>((event, emit) {
      emit(state.copyWith(status: VerseAudioVideoStatus.loading));
      if (event.itemType == ItemType.Audio) {
        try {
          state.localAudios
              ?.firstWhere((element) => element.taskId == event.taskId)
              .clearLocalTask();
          emit(state.copyWith(localAudios: state.localAudios,status: VerseAudioVideoStatus.loaded));
        } on StateError catch (e) {
          print("No audio found");
        }
      } else if (event.itemType == ItemType.Video) {
        try {
          state.localVideos
              ?.firstWhere((element) => element.taskId == event.taskId)
              .clearLocalTask();
          emit(state.copyWith(localVideos: state.localVideos,status:VerseAudioVideoStatus.loaded));
        } on StateError catch (e) {
          print("No video found");
        }
      }
     
    });
  }
}
