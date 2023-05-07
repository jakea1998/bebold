import 'dart:io';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:be_bold/blocs/audio_video/audio_video_bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/task_info.dart';

class DownloaderFunctions {
  static Future<String?> getSavedDir() async {
    String? externalStorageDirPath;

    if (Platform.isAndroid) {
      try {
        externalStorageDirPath = await AndroidPathProvider.downloadsPath;
      } catch (err, st) {
        print('failed to get downloads path: $err, $st');

        final directory = await getExternalStorageDirectory();
        externalStorageDirPath = directory?.path;
      }
    } else if (Platform.isIOS) {
      externalStorageDirPath =
          (await getApplicationDocumentsDirectory()).absolute.path;
    }
    return externalStorageDirPath;
  }

  static Future<String> prepareSaveDir() async {
    final _localPath = (await getSavedDir())!;
    final savedDir = Directory(_localPath);
    if (!savedDir.existsSync()) {
      await savedDir.create();
    }
    return _localPath;
  }

  static Future<bool> checkPermission() async {
    if (Platform.isIOS) {
      return true;
    }

    if (Platform.isAndroid) {
      final info = await DeviceInfoPlugin().androidInfo;
      if (info.version.sdkInt > 28) {
        return true;
      }

      final status = await Permission.storage.status;
      if (status == PermissionStatus.granted) {
        
        return true;
      }

      final result = await Permission.storage.request();
      return result == PermissionStatus.granted;
    }

    throw StateError('unknown platform');
  }

  static Future<void> requestDownload(
      {required TaskInfo task,
      required String localPath,
      required bool saveInPublicStorage}) async {
    task.taskId = await FlutterDownloader.enqueue(
      url: task.link!,
      headers: {'auth': 'test_for_sql_encoding'},
      savedDir: localPath,
      saveInPublicStorage: saveInPublicStorage,
    );
  }

  static Future<void> pauseDownload({required TaskInfo task}) async {
    await FlutterDownloader.pause(taskId: task.taskId!);
  }

  static Future<void> resumeDownload(
      {required TaskInfo task, required BuildContext context}) async {
    final newTaskId = await FlutterDownloader.resume(taskId: task.taskId!);

    BlocProvider.of<AudioVideoBloc>(context).add(AudioVideoEventChangeTaskId(
        oldTaskId: task.taskId ?? "", newTaskId: newTaskId ?? ""));
  }

  static Future<void> retryDownload({required TaskInfo task,required BuildContext context}) async {
    final newTaskId = await FlutterDownloader.retry(taskId: task.taskId!);
    BlocProvider.of<AudioVideoBloc>(context).add(AudioVideoEventChangeTaskId(
        oldTaskId: task.taskId ?? "", newTaskId: newTaskId ?? ""));
  }

  static Future<bool> openDownloadedFile(TaskInfo? task) async {
    final taskId = task?.taskId;
    if (taskId == null) {
      return false;
    }

    return FlutterDownloader.open(taskId: taskId);
  }
}
