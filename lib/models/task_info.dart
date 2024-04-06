
import 'package:flutter_downloader/flutter_downloader.dart';

enum ItemType {Video,Audio,None}
class TaskInfo2 {
  TaskInfo2(
      {required this.type,
      required this.displayName,
      required this.link,
      required this.categoryName});
  String displayName;
  String? name;
  String categoryName;
  String link;
  ItemType type;

  String? taskId;
  int? progress = 0;
  String filePath = "";
  DownloadTaskStatus? status = DownloadTaskStatus.undefined;
  void clearLocalTask() {
    taskId = null;
    progress = 0;
    filePath = "";
    status = DownloadTaskStatus.undefined;
  }
}
