import 'package:be_bold/blocs/audio_video/audio_video_bloc.dart';
import 'package:be_bold/constants/enums.dart';
import 'package:be_bold/models/firebase_file.dart';
import 'package:be_bold/models/task_info.dart';
import 'package:be_bold/ui/pages/audio_page.dart';
import 'package:be_bold/ui/pages/video_page.dart';
import 'package:be_bold/ui/widgets/download_list_item.dart';
import 'package:be_bold/utils/downloader_functions.dart';
import 'package:be_bold/utils/port_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';



class BaseTab extends StatefulWidget {
  final WitnessType witnessType;
  final ItemType itemType;
  final String witnessCategory;
  const BaseTab({
    Key? key,
    required this.itemType,
    required this.witnessType,
    required this.witnessCategory,
  }) : super(key: key);

  @override
  State<BaseTab> createState() => BaseTabState();
}

class BaseTabState extends State<BaseTab> {
  late bool _permissionReady;

  late String _localPath;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    // _bindBackgroundIsolate();

    FlutterDownloader.registerCallback(PortFunctions.downloadCallback, step: 1);

    // _showContent = false;
    _permissionReady = false;
    // _saveInPublicStorage = false;
    _checkPermissionReady();
  }

  @override
  void dispose() {
   

    super.dispose();
  }

  _checkPermissionReady() async {
    _permissionReady = await DownloaderFunctions.checkPermission();

    if (_permissionReady) {
      _localPath = await DownloaderFunctions.prepareSaveDir();
    }
    setState(() {});
  }

  Widget _buildNoPermissionWarning() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Grant storage permission to continue',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.blueGrey, fontSize: 18),
            ),
          ),
          const SizedBox(height: 32),
          TextButton(
            onPressed: _retryRequestPermission,
            child: const Text(
              'Retry',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _retryRequestPermission() async {
    final hasGranted = await DownloaderFunctions.checkPermission();

    if (hasGranted) {
      _localPath = await DownloaderFunctions.prepareSaveDir();
    }
    setState(() {
      _permissionReady = hasGranted;
    });
  }

  Future<void> _delete(TaskInfo2 task) async {
    final taskId = task.taskId!;
    await FlutterDownloader.remove(
      taskId: task.taskId!,
      shouldDeleteContent: true,
    ).then((value) {
      
       BlocProvider.of<AudioVideoBloc>(context)
          .add(AudioVideoEventDeleteLocalAudioVideo(itemType: widget.itemType,taskId: taskId)); 
    });
  }

  Widget _buildList(
      {required bool connectedToInternet,
      required List<TaskInfo2> localFiles}) {
    List<Widget> listWidgets = [];
    for (int i = 0; i < (localFiles.length); i++) {
      late Widget listWidget;

      listWidget = Column(
        children: [
          DownloadListItem(
            connectedToInternet: connectedToInternet,
            leading: widget.itemType == ItemType.Video
                ? Container(
                    height: 80,
                    width: 80,
                    color: Colors.grey[300],
                    child: Center(
                        child: Icon(
                      Icons.play_circle_outline_outlined,
                      color: Colors.grey[500],
                      size: 30,
                    )),
                  )
                : Center(
                    child: Icon(
                    Icons.headphones,
                    color: Colors.grey[500],
                    size: 30,
                  )),
            onActionTap: (task) async {
              if (task.status == DownloadTaskStatus.undefined) {
                final id1 = await DownloaderFunctions.requestDownload(
                    task: task,
                    localPath: _localPath,
                    saveInPublicStorage: false);

                BlocProvider.of<AudioVideoBloc>(context).add(
                    AudioVideoEventSetTaskId(
                        link: task.link ?? "",
                        newTaskId: id1,
                        itemType: widget.itemType));
              } else if (task.status == DownloadTaskStatus.running) {
                DownloaderFunctions.pauseDownload(task: task);
              } else if (task.status == DownloadTaskStatus.paused) {
                DownloaderFunctions.resumeDownload(
                    task: task, context: context);
              } else if (task.status == DownloadTaskStatus.complete ||
                  task.status == DownloadTaskStatus.canceled) {
                _delete(task);
              } else if (task.status == DownloadTaskStatus.failed) {
                DownloaderFunctions.retryDownload(task: task, context: context);
              }
            },
            onCancel: (info) {},
            data: localFiles[i],
            onDownloadedTap: (task) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => widget.itemType == ItemType.Video
                          ? VideoPage(file: task, isDownloaded: true)
                          : AudioPage(file: task, isDownloaded: true)));
            },
            onNotDownloadedTap: (task) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => widget.itemType == ItemType.Video
                          ? VideoPage(file: task, isDownloaded: false)
                          : AudioPage(file: task, isDownloaded: false)));
            },
          )
        ],
      );
      listWidgets.add(listWidget);
    }
    if (!connectedToInternet && listWidgets.isEmpty) {
      listWidgets.add(Text(
        widget.itemType == ItemType.Video
            ? "No Videos downloaded"
            : "No Audios downloaded",
        style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
      ));
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Text(
                widget.itemType == ItemType.Video ? "Videos" : "Audios",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const Spacer(
                flex: 1,
              )
            ],
          ),
        ),
        ...listWidgets,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioVideoBloc, AudioVideoState>(
      builder: (context, state) {
        return ListView(
          children: [
            _buildList(
                connectedToInternet: state.connectedToInternet ?? true,
                localFiles: widget.itemType == ItemType.Video
                    ? state.localVideos ?? []
                    : state.localAudios ?? [])
          ],
        );
      },
    );
  }
}
