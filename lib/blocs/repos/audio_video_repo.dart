import 'package:be_bold/blocs/repos/base_audio_video_repo.dart';
import 'package:be_bold/constants/enums.dart';

import 'package:be_bold/models/task_info.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:be_bold/models/firebase_file.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

class AudioVideoRepo extends BaseAudioVideoRepo {
  @override
  Future<List<String>> getDownloadLinks({required List<Reference> refs}) async {
    // TODO: implement getDownloadLinks
    return Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());
  }

  @override
  Future<List<FirebaseFile>> listAll({required String path}) async {
    // TODO: implement listAll
    final ref = FirebaseStorage.instance.ref(path);
    final result = await ref.listAll();
    final urls = await getDownloadLinks(refs: result.items);
    return urls
        .asMap()
        .map((index, url) {
          final ref = result.items[index];
          final name = ref.name;
          final file =
              FirebaseFile(ref: ref, name: name, url: url, subPath: path);

          return MapEntry(index, file);
        })
        .values
        .toList();
  }

  @override
  Future<List<TaskInfo2>> loadLocalFilesConnected(
      {required List<TaskInfo2> blankDownloads}) async {
    final tasks = await FlutterDownloader.loadTasks();

    if (tasks == null) {
      return blankDownloads;
    }

    for (var i = 0; i < blankDownloads.length; i++) {
      try {
        final matching_task = tasks.firstWhere(
            (task_local) => task_local.url == blankDownloads[i].link);

        blankDownloads[i]
          ..taskId = matching_task.taskId
          ..status = matching_task.status
          ..filePath = "${matching_task.savedDir}/${matching_task.filename}"
          ..progress = matching_task.progress;
        print(blankDownloads[i].filePath);
      } on StateError catch (e) {
        print(e);
      }
    }

    return blankDownloads;
  }

  @override
  Future<List<TaskInfo2>> loadLocalFilesDisconnected({
    required WitnessType witnessType,
  }) async {
    final tasks = await FlutterDownloader.loadTasks();

    if (tasks == null) {
      return [];
    }
    final List<TaskInfo2> _tasks = [];
    for (var i = 0; i < tasks.length; i++) {
      final names = tasks[i].filename?.split("_");
      final cat_name = names?[1];

      final matches_type =
          matchesWitnessType(name: cat_name ?? "", type: witnessType);
      final fullyDownloaded = tasks[i].status == DownloadTaskStatus.complete;
      if (matches_type && fullyDownloaded) {
        final task_cat_name = "${[names![0], cat_name].join("_")}_";

        TaskInfo2 task = TaskInfo2(
            type: getItemType(item: names![0]),
            displayName: names[2],
            link: tasks[i].url,
            categoryName: task_cat_name);
        task
          ..taskId = tasks[i].taskId
          ..status = tasks[i].status
          ..filePath = "${tasks[i].savedDir}/${tasks[i].filename}"
          ..progress = tasks[i].progress;

        _tasks.add(task);
      }
    }
    return _tasks;
  }

  bool matchesWitnessType({required String name, required WitnessType type}) {
    switch (name) {
      case "Acquaintance":
        return type == WitnessType.acquaintance;

      case "Family Member":
        return type == WitnessType.familyMember;

      case "Friend":
        return type == WitnessType.friend;

      case "New Connection":
        return type == WitnessType.newConnection;

      default:
        return false;
    }
  }

  ItemType getItemType({required String item}) {
    return item == "audios"
        ? ItemType.Audio
        : (item == "videos" || item == "androidvideos")
            ? ItemType.Video
            : ItemType.None;
  }
}
