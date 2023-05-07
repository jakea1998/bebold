import 'dart:io';

import 'package:be_bold/blocs/audio_video/audio_video_bloc.dart';
import 'package:be_bold/blocs/repos/base_audio_video_repo.dart';
import 'package:be_bold/models/item_holder.dart';
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
    print(result.items);
    final urls = await getDownloadLinks(refs: result.items);

    return urls
        .asMap()
        .map((index, url) {
          final ref = result.items[index];
          final name = ref.name;
          final file = FirebaseFile(ref: ref, name: name, url: url);

          return MapEntry(index, file);
        })
        .values
        .toList();
  }

  @override
  Future<List<ItemHolder>> loadLocalFiles(
      {required List<FirebaseFile> audios,
      required List<FirebaseFile> videos}) async {
    // TODO: implement loadLocalFiles
    final tasks = await FlutterDownloader.loadTasks();

    if (tasks == null) {
      print('No tasks were retrieved from the database.');
      return [];
    }

    var count = 0;
    List<TaskInfo> _tasks = [];
    List<ItemHolder> _items = [];

    _tasks.addAll(
      audios.map(
        (audio) => TaskInfo(name: audio.name, link: audio.url),
      ),
    );

    
    for (var i = count; i < _tasks.length; i++) {
      _items.add(ItemHolder(
          name: _tasks[i].name, task: _tasks[i], type: ItemType.Audio));
      count++;
    }

    _tasks.addAll(
      videos.map((video) => TaskInfo(name: video.name, link: video.url)),
    );

    
    for (var i = count; i < _tasks.length; i++) {
      _items.add(ItemHolder(
          name: _tasks[i].name, task: _tasks[i], type: ItemType.Video));
      count++;
    }
    tasks.forEach((element) {
      if (element.status == DownloadTaskStatus.running) {
        FlutterDownloader.resume(taskId: element.taskId);
      }
    });
    for (final task in tasks) {
      for (final info in _tasks) {
        if (info.link == task.url) {
          info
            ..taskId = task.taskId
            ..status = task.status
            ..filePath = "${task.savedDir}/${task.filename}"
            ..progress = task.progress;
        }
      }
    }

    return _items;
  }
}
