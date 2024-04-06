import 'package:be_bold/constants/colors.dart';
import 'package:be_bold/ui/widgets/continue_button.dart';
import 'package:be_bold/ui/widgets/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:just_audio/just_audio.dart';

import '../../models/task_info.dart';
import '../widgets/audio_video_progress_bar.dart';
import 'affirmation_page.dart';

class AudioPage extends StatefulWidget {
  final TaskInfo2 file;
  final bool isDownloaded;
  const AudioPage({Key? key, required this.file, required this.isDownloaded})
      : super(key: key);

  @override
  State<AudioPage> createState() => AudioPageState();
}

class AudioPageState extends State<AudioPage> with WidgetsBindingObserver {
  double currentvol = 0.5;

  AudioPlayer audioPlayer = AudioPlayer();

  void initSource() async {
    if (widget.isDownloaded) {
      try {
        await audioPlayer.setFilePath(widget.file.filePath);
      } on PlayerException catch (e) {
        showDialog(
            context: context,
            builder: (context) => ErrorDialog(
                title: "Error",
                text: "Error occurred while loading audio: ${e.message}."));
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) => const ErrorDialog(
                title: "Error",
                text: "Unknown Error occurred while loading audio."));
      }
    } else {
      try {
        await audioPlayer.setUrl(widget.file.link.replaceAll(" ", "%20"));
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) => const ErrorDialog(
                title: "Error",
                text: "An unknown error occured with the audio player."));
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      audioPlayer.stop();
    }
  }

  @override
  void initState() {
    super.initState();
    ambiguate(WidgetsBinding.instance)!.addObserver(this);
    initSource();
    audioPlayer.setVolume(currentvol);
    audioPlayer.volumeStream.listen((volume) {
      if (mounted) {
        setState(() {
          currentvol = volume;
        });
      }
    });

    audioPlayer.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace st) {
      if (e is PlayerException) {
        showDialog(
            context: context,
            builder: (context) => ErrorDialog(
                title: "Error", text: "Error playing media: ${e.message}"));
      } else if (e is PlayerInterruptedException) {
        // This call was interrupted since another audio source was loaded or the
        // player was stopped or disposed before this audio source could complete
        // loading.

        showDialog(
            context: context,
            builder: (context) => ErrorDialog(
                title: "Error",
                text: "Connection lost with Audio Player: ${e.message}"));
      } else {
        // Fallback for all other errors
        showDialog(
            context: context,
            builder: (context) => const ErrorDialog(
                title: "Error", text: "An error occurred with Audio Player."));
      }
    });
  }

  Widget replayButton() => IconButton(
        padding: EdgeInsets.zero,
        onPressed: () async {
          await audioPlayer.seek(Duration.zero);
          await audioPlayer.play();
        },
        icon: Icon(
          Icons.replay,
          size: 30,
          color: Colors.grey[700],
        ),
      );
  Widget playButton() => IconButton(
        padding: EdgeInsets.zero,
        onPressed: () async {
          await audioPlayer.play();
        },
        icon: Icon(
          Icons.play_arrow,
          size: 30,
          color: Colors.grey[700],
        ),
      );
  Widget pauseButton() => IconButton(
      padding: EdgeInsets.zero,
      onPressed: () async {
        await audioPlayer.pause();
      },
      icon: Icon(
        Icons.pause,
        size: 30,
        color: Colors.grey[700],
      ));
  Widget loadingIcon() => const SizedBox(
        width: 30,
        height: 30,
        child: GFLoader(
          type: GFLoaderType.ios,
        ),
      );

  @override
  void dispose() {
    ambiguate(WidgetsBinding.instance)!.removeObserver(this);

    audioPlayer.stop();
    audioPlayer.dispose();
    super.dispose();
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      widget.file.displayName.toString().replaceAll(".mp3", ""),
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 18),
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8, right: 8, top: 8.0),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 6, right: 6),
                          width: 35,
                          height: 35,
                          child: StreamBuilder<PlayerState>(
                              stream: audioPlayer.playerStateStream,
                              initialData:
                                  PlayerState(false, ProcessingState.loading),
                              builder: (context, snapshot) {
                                final state = snapshot.data!;

                                switch (state.processingState) {
                                  case ProcessingState.buffering:
                                    return state.playing
                                        ? pauseButton()
                                        : loadingIcon();

                                  case ProcessingState.completed:
                                    return replayButton();

                                  case ProcessingState.idle:
                                    return state.playing
                                        ? pauseButton()
                                        : playButton();

                                  case ProcessingState.loading:
                                    return state.playing
                                        ? pauseButton()
                                        : loadingIcon();

                                  case ProcessingState.ready:
                                    return state.playing
                                        ? pauseButton()
                                        : playButton();
                                }
                              }),
                        ),
                        Expanded(
                            child: StreamBuilder<Duration>(
                                stream: audioPlayer.positionStream,
                                builder: (context, snapshot) {
                                  return ProgressBar(
                                      progress: audioPlayer.position,
                                      barHeight: 8,
                                      thumbRadius: 0,
                                      buffered: audioPlayer.bufferedPosition,
                                      bufferedBarColor: Colors.grey[500],
                                      onSeek: (value) =>
                                          audioPlayer.seek(value),
                                      thumbGlowColor: Colors.transparent,
                                      thumbColor: Colors.transparent,
                                      baseBarColor: Colors.grey[600],
                                      timeLabelLocation:
                                          TimeLabelLocation.sides,
                                      total:
                                          audioPlayer.duration ?? Duration.zero,
                                      barCapShape: BarCapShape.round);
                                })),
                        Icon(
                          Icons.volume_down,
                          size: 30,
                          color: Colors.grey[700],
                        ),
                        SizedBox(
                            width: 100,
                            height: double.infinity,
                            child: Align(
                              alignment: Alignment.center,
                              child: ProgressBar(
                                progress: Duration(
                                    milliseconds: (currentvol * 1000).toInt()),
                                barHeight: 8,
                                thumbRadius: 0,
                                onSeek: (value) => audioPlayer.setVolume(
                                    ((value.inMilliseconds) / 1000).toDouble()),
                                thumbGlowColor: Colors.transparent,
                                thumbColor: Colors.transparent,
                                baseBarColor: Colors.grey[600],
                                timeLabelLocation: TimeLabelLocation.sides,
                                timeLabelPadding: 0,
                                timeLabelTextStyle: const TextStyle(
                                    fontSize: 0, color: Colors.transparent),
                                total: const Duration(seconds: 1),
                                barCapShape: BarCapShape.round,
                              ),
                            )),
                      ]),
                ),
              ),
              ContinueButton(onTapped: () {
                audioPlayer.stop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AffirmationPage()));
              })
            ],
          )),
    );
  }

  T? ambiguate<T>(T? value) => value;
}
