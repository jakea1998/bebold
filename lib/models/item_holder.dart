import 'package:be_bold/models/task_info.dart';

enum ItemType { Audio, Video, None }

class ItemHolder {
  ItemHolder({this.name, this.task,this.type});

  final String? name;
  final TaskInfo? task;
  final ItemType? type;
}
