import 'package:audioplayers/audioplayers.dart';
import 'package:be_bold/constants/colors.dart';
import 'package:be_bold/models/firebase_file.dart';
import 'package:be_bold/ui/widgets/continue_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';

import '../../models/task_info.dart';
import 'reaffirmation_page.dart';

class AudioPage extends StatefulWidget {
  final TaskInfo file;
  final bool isDownloaded;
  const AudioPage({Key? key, required this.file, required this.isDownloaded})
      : super(key: key);

  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  bool isPlaying = false;
  Duration duration = Duration.zero;
  int time = 0;
  double currentvol = 0.5;
  String timeLeft = "";
  double progress = 0.0;
  final audioPlayer = AudioPlayer();
  bool isStarted = false;
  startPlaying() async {
    if (!isStarted) {
      if(widget.isDownloaded){
        await audioPlayer.play(DeviceFileSource(widget.file.filePath ));
      } else {
        await audioPlayer.play(UrlSource(widget.file.link ?? ""));
      }
      
      isStarted = true;
    } else
      await audioPlayer.resume();
    // time  = await audioPlayer.getDuration();
  }

  getTimeLeft() {
    if (duration == null) {
      setState(() {
        timeLeft = "Time Left 0s";
      });
    } else {
      setState(() {
        timeLeft = "Time Left ${duration.inSeconds}s";
      });
    }
  }

  getProgress() {
    if (time == null || duration == null) {
      setState(() {
        progress = 0.0;
      });
    } else {
      setState(() {
        progress = time / (duration.inMilliseconds);
      });
    }
  }

  void initSource() async {
    if(widget.isDownloaded){
      await audioPlayer.setSourceDeviceFile(widget.file.filePath.replaceAll(" ", "%20"));
    } else {
      await audioPlayer.setSourceUrl(widget.file.link ?? "");
    }
    
    final d1 = await audioPlayer.getDuration();
    time = d1?.inMilliseconds ?? 0;
    print(time);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    PerfectVolumeControl.hideUI =
        false; //set if system UI is hided or not on volume up/down
    Future.delayed(Duration.zero, () async {
      currentvol = await PerfectVolumeControl.getVolume();
      setState(() {
        //refresh UI
      });
    });
    initSource();
    PerfectVolumeControl.stream.listen((volume) {
      print(volume);
      setState(() {
        currentvol = volume;
      });
    });
    audioPlayer.onPositionChanged.listen((Duration p) async {
      if (mounted) {
        final d = await audioPlayer.getDuration();
        time = d?.inMilliseconds ?? 0;
        duration = p;
        if (duration == null) {
          timeLeft = "Time Left 0s/0s";
        } else {
          timeLeft = "Time Left ${duration.inSeconds}s/${time / 1000}s";
        }
        if (time == null || duration == null) {
          progress = 0.0;
        } else {
          progress = (duration.inMilliseconds) / time;
        }

        setState(() {});
      }
    });
    audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      print("$state");
      if (state == PlayerState.playing) {
        setState(() {
          isPlaying = true;
        });
      } else {
        if (mounted) {
          setState(() {
            isPlaying = false;
          });
        }
      }
    });
  }

  @override
  void dispose() async {
    super.dispose();
    await audioPlayer.release();
    await audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(appBarTheme: AppBarTheme(color: darkBlueColor1)),
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
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      widget.file.name?.toString().replaceAll(".mp3", "") ?? "",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(bottom: 15, left: 15, right: 15),
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8, right: 8, top: 8.0),
                  child: Row(children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        isPlaying ? audioPlayer.pause() : startPlaying();
                        setState(() {});
                      },
                      icon: isPlaying
                          ? Icon(
                              Icons.pause,
                              size: 35,
                              color: Colors.grey[700],
                            )
                          : Icon(
                              Icons.play_arrow,
                              size: 35,
                              color: Colors.grey[700],
                            ),
                    ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: LinearProgressIndicator(
                          backgroundColor: Colors.grey[600],
                          color: lightBlueColor1 ?? Colors.blue,
                          value: progress,
                          minHeight: 8,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                          '${(time / 60000).toInt()}:${(((time % 60000) / 1000).round().toInt()).toString().padLeft(2, '0')}'),
                    ),
                    Icon(
                      Icons.volume_down,
                      size: 30,
                      color: Colors.grey[700],
                    ),
                    SizedBox(
                      width: 60,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: LinearProgressIndicator(
                          backgroundColor: Colors.grey[600],
                          color: lightBlueColor1 ?? Colors.blue,
                          value: currentvol,
                          minHeight: 8,
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
              ContinueButton(onTapped: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReaffirmationPage()));
              })
            ],
          )),
    );
  }
}
