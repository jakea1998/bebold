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
    required this.connectedToInternet,
    this.onActionTap,
    this.onCancel,
  }) : super(key: key);

  final TaskInfo2 data;
  final bool connectedToInternet;
  final Function(TaskInfo2) onDownloadedTap;
  final Function(TaskInfo2) onNotDownloadedTap;
  final Widget leading;
  final Function(TaskInfo2)? onActionTap;
  final Function(TaskInfo2)? onCancel;

  Widget? _buildTrailing(TaskInfo2 task) {
    if (task.status == DownloadTaskStatus.undefined) {
      return IconButton(
        onPressed: () => onActionTap?.call(task),
        splashRadius: 2,
        constraints: const BoxConstraints(minHeight: 32, minWidth: 32),
        icon: const Icon(Icons.file_download),
        tooltip: 'Start',
      );
    } else if (task.status == DownloadTaskStatus.running) {
      return Center(
        child: Text('${task.progress}%',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      );
      /* IconButton(
            onPressed: () => onActionTap?.call(task),
            constraints: const BoxConstraints(minHeight: 32, minWidth: 32),
            icon: const Icon(Icons.pause, color: Colors.yellow),
            tooltip: 'Pause',
          ), */
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
      return const Text('Pending', style: TextStyle(color: Colors.green));
    } else {
      return null;
    }
  }

  void Function()? onTap() {
    if (data.status == DownloadTaskStatus.complete) {
      return () {
        onDownloadedTap(data);
      };
    } else if (data.status == DownloadTaskStatus.undefined &&
        connectedToInternet) {
      return () {
        onNotDownloadedTap(data);
      };
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(
          child: ListTile(
        onTap: onTap(),
        contentPadding: const EdgeInsets.all(12),
        leading: Container(
          height: 80,
          width: 80,
          color: Colors.grey[300],
          child: Center(
              child: Icon(
            Icons.play_circle_outline_outlined,
            color: Colors.grey[500],
            size: 30,
          )),
        ),
        title: Text(
            data.displayName.replaceAll('.mp4', "").replaceAll('.mp3', ""),
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis),
        trailing: SizedBox(
            width: 100,
            child: Row(
              children: [
                connectedToInternet
                    ? SizedBox(
                        width: 80, child: _buildTrailing(data) ?? Container())
                    : const SizedBox(
                        width: 80,
                      ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: Colors.grey,
                ),
              ],
            )),
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
      if ((data.status == DownloadTaskStatus.running && connectedToInternet) ||
          (data.status == DownloadTaskStatus.paused && connectedToInternet))
        Positioned(
          left: 0,
          right: 0,
          bottom: 3,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: LinearProgressIndicator(
              minHeight: 5,
              valueColor: const AlwaysStoppedAnimation(Colors.blue),
              value: data.progress! / 100,
            ),
          ),
        )
    ]);
  }
}
