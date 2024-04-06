import 'package:be_bold/blocs/audio_video/audio_video_bloc.dart';
import 'package:be_bold/constants/enums.dart';
import 'package:be_bold/models/firebase_file.dart';

import 'package:be_bold/models/task_info.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class BaseAudioVideoRepo {
  Future<List<String>> getDownloadLinks({required List<Reference> refs});
  Future<List<FirebaseFile>> listAll({required String path});
  Future<List<TaskInfo2>> loadLocalFilesConnected(
      {required List<TaskInfo2> blankDownloads});
  
  Future<List<TaskInfo2>> loadLocalFilesDisconnected(
      {required WitnessType witnessType});
}
