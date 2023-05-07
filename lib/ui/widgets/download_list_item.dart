import 'package:be_bold/models/item_holder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import '../../models/task_info.dart';

class DownloadListItem extends StatelessWidget {
  const DownloadListItem({
    Key? key,
    required this.data,
    required this.leading,
    required this.onDownloadedTap,
    required this.onNotDownloadedTap,
    this.onActionTap,
    this.onCancel,
  }) : super(key: key);

  final ItemHolder data;
  final Function(TaskInfo) onDownloadedTap;
  final Function(TaskInfo) onNotDownloadedTap;
  final Widget leading;
  final Function(TaskInfo)? onActionTap;
  final Function(TaskInfo)? onCancel;

  Widget? _buildTrailing(TaskInfo task) {
    if (task.status == DownloadTaskStatus.undefined) {
      return IconButton(
        onPressed: () => onActionTap?.call(task),
        constraints: const BoxConstraints(minHeight: 32, minWidth: 32),
        icon: const Icon(Icons.file_download),
        tooltip: 'Start',
      );
    } else if (task.status == DownloadTaskStatus.running) {
      return Row(
        children: [
          Text('${task.progress}%'),
          IconButton(
            onPressed: () => onActionTap?.call(task),
            constraints: const BoxConstraints(minHeight: 32, minWidth: 32),
            icon: const Icon(Icons.pause, color: Colors.yellow),
            tooltip: 'Pause',
          ),
        ],
      );
    } else if (task.status == DownloadTaskStatus.paused) {
      return Row(
        children: [
          Text('${task.progress}%'),
          IconButton(
            onPressed: () => onActionTap?.call(task),
            constraints: const BoxConstraints(minHeight: 20, minWidth: 20),
            icon: const Icon(Icons.play_arrow, color: Colors.green),
            tooltip: 'Resume',
          ),
          /* if (onCancel != null)
            IconButton(
              onPressed: () => onCancel?.call(task),
              constraints: const BoxConstraints(minHeight: 20, minWidth: 20),
              icon: const Icon(Icons.cancel, color: Colors.red),
              tooltip: 'Cancel',
            ), */
        ],
      );
    } else if (task.status == DownloadTaskStatus.complete) {
      return IconButton(
        onPressed: () => onActionTap?.call(task),
        constraints: const BoxConstraints(minHeight: 32, minWidth: 32),
        icon: const Icon(Icons.delete),
        tooltip: 'Delete',
      );
    } else if (task.status == DownloadTaskStatus.canceled) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text('Canceled', style: TextStyle(color: Colors.red)),
          if (onActionTap != null)
            IconButton(
              onPressed: () => onActionTap?.call(task),
              constraints: const BoxConstraints(minHeight: 32, minWidth: 32),
              icon: const Icon(Icons.cancel),
              tooltip: 'Cancel',
            )
        ],
      );
    } else if (task.status == DownloadTaskStatus.failed) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text('Failed', style: TextStyle(color: Colors.red)),
          IconButton(
            onPressed: () => onActionTap?.call(task),
            constraints: const BoxConstraints(minHeight: 32, minWidth: 32),
            icon: const Icon(Icons.refresh, color: Colors.green),
            tooltip: 'Refresh',
          )
        ],
      );
    } else if (task.status == DownloadTaskStatus.enqueued) {
      return const Text('Pending', style: TextStyle(color: Colors.orange));
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(
          child: ListTile(
        onTap: data.task!.status == DownloadTaskStatus.complete
            ? () {
                print("filepath1:");
                print(data.task?.filePath);

                onDownloadedTap(data.task!);
              }
            : () {
                onNotDownloadedTap(data!.task!);
              },
        contentPadding: EdgeInsets.all(12),
        leading: Container(
          height: 80,
          width: 80,
          child: Center(
              child: Icon(
            Icons.play_circle_outline_outlined,
            color: Colors.grey[500],
            size: 30,
          )),
          color: Colors.grey[300],
        ),
        title: Text(data!.name!.replaceAll('.mp4', ""),
            maxLines: 1, softWrap: true, overflow: TextOverflow.ellipsis),
        trailing: SizedBox(
          width: 100,
          child: Row(
            children: [
              SizedBox(
                  width: 80, child: _buildTrailing(data!.task!) ?? Container()),
              Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: Colors.grey,
              ),
            ],
          )
        ),
      )),
      const Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        child: Divider(
          indent: 10,
          endIndent: 10,
          color: Colors.grey,
        ),
      ),
      if (data.task!.status == DownloadTaskStatus.running ||
          data.task!.status == DownloadTaskStatus.paused)
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: LinearProgressIndicator(
              minHeight: 3,
              value: data.task!.progress! / 100,
            ),
          ),
        )
    ]);
    
  }
}
