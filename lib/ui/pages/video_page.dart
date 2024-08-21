import 'dart:io';
import 'dart:async';
import 'package:be_bold/constants/colors.dart';
import 'package:be_bold/models/task_info.dart';
import 'package:be_bold/ui/pages/affirmation_page.dart';
import 'package:be_bold/ui/widgets/continue_button.dart';
import 'package:be_bold/ui/widgets/error_dialog.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

enum VideoPlayerTracking { loading, loaded, error }

class VideoPage extends StatefulWidget {
  final TaskInfo2 file;
  final bool isDownloaded;
  const VideoPage({Key? key, required this.file, required this.isDownloaded})
      : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _videoPlayerController;

  bool videoStarted = false;
  ChewieController? chewieController;

  VideoPlayerTracking _videoPlayerTracking = VideoPlayerTracking.loading;
  Future<bool> setLocalFileSource() async {
    final file = File(widget.file.filePath.replaceAll(" ", "%20").toString());
    if (await file.exists()) {
      try {
        _videoPlayerController = VideoPlayerController.file(file);
        return true;
      } catch (e) {
        return false;
      }
    } else {
      return false;
    }
  }

  bool setNetworkUrlSource() {
    try {
      _videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(widget.file.link));
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> initChewie() async {
    try {
      await _videoPlayerController.initialize();
      chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        aspectRatio: _videoPlayerController.value.aspectRatio,
        materialProgressColors: ChewieProgressColors(bufferedColor: Colors.blue[100] ?? Colors.blue,handleColor: Colors.white,playedColor: Colors.blue),
        autoInitialize: true,
        autoPlay: false,
        looping: false,
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              errorMessage,
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
      );

      return true;
    } on PlatformException catch (e) {
      showDialog(
          context: context,
          builder: (context) => ErrorDialog(
              title: "Error", text: "Error Occurred: ${e.message}."));
      return false;
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => const ErrorDialog(
              title: "Error", text: "Unknown Error Occurred."));
      return false;
    }
  }

  Future<void> initVideoController() async {
    bool succeeded = false;
    if (widget.isDownloaded) {
      succeeded = await setLocalFileSource();
      
      if (!succeeded) {
        succeeded = setNetworkUrlSource();
      }
    } else {
      succeeded = setNetworkUrlSource();
    }

    if (succeeded) {
      succeeded = await initChewie();
      if (succeeded) {
        setState(() {
          _videoPlayerTracking = VideoPlayerTracking.loaded;
        });
      } else {
        setState(() {
          _videoPlayerTracking = VideoPlayerTracking.error;
        });
      }
    } else {
      setState(() {
        _videoPlayerTracking = VideoPlayerTracking.error;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    initVideoController();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    chewieController?.dispose();
    super.dispose();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  _buildVideoPlayer() {
    if (_videoPlayerTracking == VideoPlayerTracking.loaded) {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.width *
            0.9 *
            (1 / _videoPlayerController.value.aspectRatio),
        child: Chewie(
          controller: chewieController!,
        ),
      );
    } else if (_videoPlayerTracking == VideoPlayerTracking.error) {
      return const SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
              color: Colors.blue,
              size: 25,
            ),
            SizedBox(width: 10),
            Text('Error playing Video'),
          ],
        ),
      );
    } else {
      return const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Colors.blue,
          ),
          SizedBox(height: 20),
          Text('Loading'),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(appBarTheme: const AppBarTheme(color: darkBlueColor1)),
      child: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      widget.file.displayName.toString().replaceAll(".mp4", ""),
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 18),
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  )
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: [_buildVideoPlayer()],
              ),
              Expanded(
                child: Column(children: [
                  ContinueButton(onTapped: () {
                    if (chewieController?.isPlaying ?? false) {
                      chewieController?.pause();
                    }

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AffirmationPage()));
                  }),
                  const Spacer(
                    flex: 1,
                  ),
                ]),
              )
            ],
          )),
    );
  }
}
