import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:be_bold/blocs/audio_video/audio_video_bloc.dart';
import 'package:be_bold/constants/enums.dart';
import 'package:be_bold/models/firebase_file.dart';
import 'package:be_bold/ui/pages/audio_page.dart';
import 'package:be_bold/ui/pages/verse_page.dart';
import 'package:be_bold/ui/pages/video_page.dart';
import 'package:be_bold/ui/widgets/app_bar.dart';
import 'package:be_bold/ui/widgets/download_list_item.dart';
import 'package:be_bold/ui/widgets/tab_bar.dart';
import 'package:be_bold/ui/widgets/verse_content.dart';
import 'package:be_bold/ui/widgets/verse_list_widget.dart';
import 'package:be_bold/ui/widgets/verse_title.dart';
import 'package:be_bold/utils/downloader_functions.dart';
import 'package:be_bold/utils/port_functions.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../models/item_holder.dart';
import '../../models/task_info.dart';

class WitnessPage extends StatefulWidget {
  final String title;
  const WitnessPage({Key? key, required this.title}) : super(key: key);

  @override
  State<WitnessPage> createState() => _WitnessPageState();
}

class _WitnessPageState extends State<WitnessPage>
    with TickerProviderStateMixin {
  TabController? tabBarController;
  late WitnessType type;
  final ReceivePort _port = ReceivePort();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPort();
    type = WitnessType.acquaintance;
    switch (widget.title) {
      case "Acquaintance":
        type = WitnessType.acquaintance;
        break;
      case "Family Member":
        type = WitnessType.familyMember;
        break;
      case "Friend":
        type = WitnessType.friend;
        break;
      case "New Connection":
        type = WitnessType.newConnection;
        break;
    }
    BlocProvider.of<AudioVideoBloc>(context)
        .add(AudioVideoEventLoad(type: type));

    tabBarController = TabController(length: 3, vsync: this);
  }

  initPort() {
    final isSuccess = IsolateNameServer.registerPortWithName(
      _port.sendPort,
      'downloader_send_port',
    );
    if (!isSuccess) {
      print("Not success");
      PortFunctions.unbindBackgroundIsolate();
      initPort();
      return;
    }
    _port.listen((dynamic data) {
      final taskId = (data as List<dynamic>)[0] as String;
      final status = data[1] as DownloadTaskStatus;
      final progress = data[2] as int;

      print(
        'Callback on UI isolate: '
        'task ($taskId) is in status ($status) and process ($progress)',
      );

      BlocProvider.of<AudioVideoBloc>(context).add(
          AudioVideoEventUpdateLocalAudiosVideos(
              taskId: taskId, progress: progress, status: status));
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    final port1Exists =
        IsolateNameServer.lookupPortByName("downloader_send_port") != null;
    if (port1Exists) {
      PortFunctions.unbindBackgroundIsolate();
    }
    /* final port2Exists = IsolateNameServer.lookupPortByName("downloader_send_port2") != null;
    if(port2Exists){
      PortFunctions.unbindBackgroundIsolate2();
    } */
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar1(
        title: widget.title,
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 50),
          child: AppTabBar(
            controller: tabBarController,
            tabItems: [
              TabItem(
                title: "Verses",
              ),
              TabItem(title: "Videos"),
              TabItem(
                title: "Audios",
              )
            ],
          ),
        ),
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: tabBarController,
          children: [
            VerseTab(),
            VideoTab(
              type: type,
            ),
            AudioTab(
              type: type,
            )
          ],
        ),
      ),
    );
  }
}

class VideoTab extends StatefulWidget {
  final WitnessType type;

  const VideoTab({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  State<VideoTab> createState() => VideoTabState();
}

class VideoTabState extends State<VideoTab> {
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
    // TODO: implement dispose

    super.dispose();
  }

  _checkPermissionReady() async {
    final _permissionReady = await DownloaderFunctions.checkPermission();
    print('permission ready');
    print(_permissionReady);
    if (_permissionReady) {
      _localPath = await DownloaderFunctions.prepareSaveDir();
    }
    setState(() {});
  }

  /* void _bindBackgroundIsolate() {
    widget.port.listen((dynamic data) {
      final taskId = (data as List<dynamic>)[0] as String;
      final status = data[1] as DownloadTaskStatus;
      final progress = data[2] as int;

      print(
        'Callback on UI isolate: '
        'task ($taskId) is in status ($status) and process ($progress)',
      );

      BlocProvider.of<AudioVideoBloc>(context).add(
          AudioVideoEventUpdateLocalAudiosVideos(
              taskId: taskId, progress: progress, status: status));
    });
  } */

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

  Future<void> _delete(TaskInfo task) async {
    await FlutterDownloader.remove(
      taskId: task.taskId!,
      shouldDeleteContent: true,
    ).then((value) {
      BlocProvider.of<AudioVideoBloc>(context).add(
          AudioVideoEventUpdateLocalAudiosVideos(
              progress: 0,
              taskId: task.taskId ?? "",
              status: DownloadTaskStatus.undefined));
      BlocProvider.of<AudioVideoBloc>(context)
          .add(AudioVideoEventLoad(type: widget.type));
    });
  }

  Widget _buildList(
      {required List<FirebaseFile> videos,
      required List<ItemHolder> localVideos}) {
    List<Widget> videoListWidgets = [];
    for (int i = 0; i < (videos.length); i++) {
      late Widget videoWidget;

      videoWidget = Column(
        children: [
          DownloadListItem(
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
            onActionTap: (task) {
              if (task.status == DownloadTaskStatus.undefined) {
                DownloaderFunctions.requestDownload(
                    task: task,
                    localPath: _localPath,
                    saveInPublicStorage: false);
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
            data: localVideos[i],
            onDownloadedTap: (task) {
              print('filepath');
              print(task.filePath);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          VideoPage(file: task, isDownloaded: true)));
            },
            onNotDownloadedTap: (task) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          VideoPage(file: task, isDownloaded: false)));
            },
          )
        ],
      );
      videoListWidgets.add(videoWidget);
    }
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            children: [
              Text(
                "Videos",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Spacer(
                flex: 1,
              )
            ],
          ),
        ),
        ...videoListWidgets
      ],
    );
  }

  Widget _buildNotDownloadedList() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            children: [
              Text(
                "Videos",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Spacer(
                flex: 1,
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: BlocBuilder<AudioVideoBloc, AudioVideoState>(
        builder: (context, state) {
          return ListView(
            children: [
              _buildList(
                  videos: state.networkVideos ?? [],
                  localVideos: state.localVideos ?? [])
            ],
          );
        },
      ),
    );
  }
}

class AudioTab extends StatefulWidget {
  final WitnessType type;

  const AudioTab({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  State<AudioTab> createState() => AudioTabState();
}

class AudioTabState extends State<AudioTab> {
  late bool _permissionReady;

  late String _localPath;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    FlutterDownloader.registerCallback(PortFunctions.downloadCallback, step: 1);

    // _showContent = false;
    _permissionReady = false;
    // _saveInPublicStorage = false;
    _checkPermissionReady();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  _checkPermissionReady() async {
    final _permissionReady = await DownloaderFunctions.checkPermission();
    print('permission ready');
    print(_permissionReady);
    if (_permissionReady) {
      _localPath = await DownloaderFunctions.prepareSaveDir();
    }
    setState(() {});
  }

  void _bindBackgroundIsolate() {
    // _port.sendPort = IsolateNameServer.lookupPortByName("downloader_send_port2");
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

  Future<void> _delete(TaskInfo task) async {
    await FlutterDownloader.remove(
      taskId: task.taskId!,
      shouldDeleteContent: true,
    ).then((value) {
      BlocProvider.of<AudioVideoBloc>(context).add(
          AudioVideoEventUpdateLocalAudiosVideos(
              progress: 0,
              taskId: task.taskId ?? "",
              status: DownloadTaskStatus.undefined));
      BlocProvider.of<AudioVideoBloc>(context)
          .add(AudioVideoEventLoad(type: widget.type));
    });
  }

  Widget _buildList(
      {required List<FirebaseFile> audios,
      required List<ItemHolder> localAudios}) {
    List<Widget> audioListWidgets = [];

    print('build list');
    for (int i = 0; i < (audios.length); i++) {
      late Widget audioWidget;

      audioWidget = Column(
        children: [
          DownloadListItem(
            leading: Center(
                child: Icon(
              Icons.headphones,
              color: Colors.grey[500],
              size: 30,
            )),
            onActionTap: (task) {
              if (task.status == DownloadTaskStatus.undefined) {
                DownloaderFunctions.requestDownload(
                    task: task,
                    localPath: _localPath,
                    saveInPublicStorage: false);
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
            onDownloadedTap: (task) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AudioPage(file: task, isDownloaded: true)));
            },
            onNotDownloadedTap: (task) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AudioPage(file: task, isDownloaded: false)));
            },
            data: localAudios[i],
          )
        ],
      );
      audioListWidgets.add(audioWidget);
    }
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            children: [
              Text(
                "Audios",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Spacer(
                flex: 1,
              )
            ],
          ),
        ),
        ...audioListWidgets
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: BlocBuilder<AudioVideoBloc, AudioVideoState>(
        builder: (context, state) {
          return ListView(
            children: [
              _buildList(
                  audios: state.networkAudios ?? [],
                  localAudios: state.localAudios ?? [])
            ],
          );
        },
      ),
    );
  }
}

class VerseTab extends StatelessWidget {
  final List<String>? verses;

  const VerseTab({Key? key, this.verses}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            children: [
              Text(
                "Verses",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Spacer(
                flex: 1,
              )
            ],
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              VerseListWidget(
                onTapped: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VersePage(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      VerseTitle(title: "Romans 5:12"),
                                      VerseContent(
                                          content:
                                              "Wherefore, as by one man sin entered into the world, and death by sin; and so death passed upon all men, for that all have sinned."),
                                      VerseTitle(
                                          title: "Scriptural Enlightenment:"),
                                      VerseContent(
                                          content:
                                              "Adam was the first man created by God.  He had God's nature.  When he disobeyed God in the garden, he missed the mark or sinned.  As a result, he lost God's nature and received the nature of sin.  Therefore, everyone born after him had his nature: a sin nature.  Sin led to spiritual death, and death passed from Adam to all mankind through his bloodline."),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      VerseTitle(title: "Romans 3:23"),
                                      VerseContent(
                                          content:
                                              "For all have sinned, and come short of the glory of God."),
                                      VerseTitle(
                                          title: "Scriptural Enlightenment:"),
                                      VerseContent(
                                          content:
                                              "Adam's decision to disobey God caused everyone to be born in sin and therefore made a sinner.  Thus sin caused everyone to lack or be deficient in obtaining the glory of God.  Only Jesus paying the price for mankind's sin, with His life and blood, could position mankind to be at peace and in oneness with God again.")
                                    ]),
                              )));
                },
                title: 'The Sin Issue',
                verses: ["Romans 5:12", "Romans 3:23"],
              ),
              VerseListWidget(
                onTapped: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VersePage(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      VerseTitle(title: "St. John 3:16"),
                                      VerseContent(
                                          content:
                                              "For God so loved the world, that he gave his only begotten Son, that whosoever believeth in him should not perish, but have everlasting life."),
                                      VerseTitle(
                                          title: "Scriptural Enlightenment:"),
                                      VerseContent(
                                          content:
                                              "God's undying, unwavering, and unfailing love for His creation caused Him to implement a plan to bring mankind back to Himself.  His plan cost Him His only Son, Jesus.  Nevertheless, He decided to give us His only Son.  His Son was without sin, but through obedience to God, He became sin so that we might receive a new nature: the nature of God.  With a new nature, we don't die; we receive everlasting life.  God asks us to have faith in His Son, Jesus, because He does not want us to perish or die; rather, He wants us to live eternally with Him."),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      VerseTitle(title: "Romans 6:23"),
                                      VerseContent(
                                          content:
                                              "For the wages of sin is death; but the gift of God is eternal life through Jesus Christ our Lord."),
                                      VerseTitle(
                                          title: "Scriptural Enlightenment:"),
                                      VerseContent(
                                          content:
                                              "At the end of every act of sin is a payment for the sin committed.  Sin always leads to death.  God released us from the payment of sin by giving us the gift of Jesus.  However, to reject the gift of Jesus is to keep the nature of sin.  The nature of sin is death, but receiving Jesus gives us eternal life.  Jesus is... God's gift to the world!"),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      VerseTitle(title: "Romans 5:8"),
                                      VerseContent(
                                          content:
                                              "But God commandeth his love toward us, in that, while we were yet sinners, Christ died for us."),
                                      VerseTitle(
                                          title: "Scriptural Enlightenment:"),
                                      VerseContent(
                                          content:
                                              "God introduced His love toward mankind by sending Jesus Christ to be our payment for sin.  When Jesus Christ died on the cross, he paid the price for mankind's sin.  He gave Himself as a sacrifice so that we might have a nature free of sin.")
                                    ]),
                              )));
                },
                title: 'The Rescue',
                verses: ["St. John 3:16", "Romans 6:23", "Romans 5:8"],
              ),
              VerseListWidget(
                onTapped: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VersePage(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  VerseTitle(title: "Acts 4:12"),
                                  VerseContent(
                                      content:
                                          "Neither is their salvation in any other: for there is none other name under heaven given among men, whereby we must be saved."),
                                  VerseTitle(
                                      title: "Scriptural Enlightenment:"),
                                  VerseContent(
                                      content:
                                          "Because Jesus is the sinless sacrifice who paid for our sins, His name is the only name by which mankind can be saved.  When someone is saved, they receive the free gifts of deliverance, protection, healing, and preservation.  They receive well-being, and they are made whole."),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  VerseTitle(title: "1 Peter 3:18"),
                                  VerseContent(
                                      content:
                                          "For Christ also hath once suffered for our sins, the just for the unjust, that he might bring us to God, being put to death in the flesh, but quickened by the Spirit."),
                                  VerseTitle(
                                      title: "Scriptural Enlightenment:"),
                                  VerseContent(
                                      content:
                                          "Jesus was innocent; yet, He suffered for the unrighteous.  Jesus was sinless; yet, He became sin to free us from it.  He was put to death on the cross of Calvary and went to Hell in our place to pay for mankind's sin.  However, He did not remain in Hell.  The Holy Spirit entered Hell on the third day and caused Jesus to be made alive.  At that time, Jesus defeated Satan in Hell and stripped him of all authority and power.  When someone receives Jesus Christ in their heart they are no longer separated from God but brought back into right standing and fellowship with God."),
                                ],
                              ))));
                },
                title: 'The Savior',
                verses: ["Acts 4:12", "1 Peter 3:18"],
              ),
              VerseListWidget(
                onTapped: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VersePage(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  VerseTitle(title: "Romans 10:9-10, 13"),
                                  VerseContent(
                                      content:
                                          "That if thou shalt confess with thy mouth the Lord Jesus, and shalt believe in thine heart that God hath raised him from the dead, thou shalt be saved.  For with the heart man believeth unto righteousness; and with the mouth confession is made unto salvation.  For whosoever shall call upon the name of the Lord shall be saved."),
                                  VerseTitle(
                                      title: "Scriptural Enlightenment:"),
                                  VerseContent(
                                      content:
                                          "Salvation is as close as our hearts and our mouths.  When someone acknowledges with their mouth that Jesus is the only Lord, and believes in their heart that God has raised Jesus from the dead, this person receives the salvation purchased by Jesus for them.  The person literally at that time receives deliverance, protection, healing, and preservation.  They are made whole from sin.\n\nAll of this happens through an exchange.  Jesus took our sin and we take His righteousness or right standing with God.  God no longer sees us in sin; He sees us with the shed blood of His Son.\n\nWOW! That's a lot to receive, and all we had do was believe it and take it!"),
                                ],
                              ))));
                },
                title: 'The New You',
                verses: ["Romans 10:9-10, 13"],
              ),
              VerseListWidget(
                onTapped: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VersePage(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      VerseTitle(title: "Ephesians 2:8-9"),
                                      VerseContent(
                                          content:
                                              "For by grace are ye saved through faith; and that not of yourselves: it is the gift of God: Not of works, lest any man should boast."),
                                      VerseTitle(
                                          title: "Scriptural Enlightenment:"),
                                      VerseContent(
                                          content:
                                              "God's grace provides deliverance, protection, preservation, salvation, healing and well-being, and it makes us whole.  God's grace is something that cannot be earned or bought.  He chose to give it to us.  When we receive His grace by faith, we activate all that God's grace has provided.  Our faith takes it!  Therefore, we cannot buy salvation nor can we work to be saved.  Salvation is a gift; no one can take credit for what they did not do."),
                                    ]),
                              )));
                },
                title: 'The Gift',
                verses: ["Ephesians 2:8-9"],
              ),
              VerseListWidget(
                onTapped: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VersePage(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  VerseTitle(title: "St. John 1:12"),
                                  VerseContent(
                                      content:
                                          "But as many as received him, to them gave he power to become the sons of God, even to them that believe on His name."),
                                  VerseTitle(
                                      title: "Scriptural Enlightenment:"),
                                  VerseContent(
                                      content:
                                          "To those who believe in and receive Jesus as their Lord and Savior, He gives them the privilege and ability to become sons and daughters of God.  Whoever receives Him receives a new nature: the nature of God.  Thereby, they become sons and daughters of God and receive the full benefits of being in God's Family.\n\nWhenever someone enters God's family, they enter a relationship with Him.  God desires to spend time with His children just as people spend time with their spouses, children, family, and friends.  They spend time in their presence talking with them or listening to them.\n\nGod wants that same kind of time devoted to Him; he wants you to develop a relationship with Him.  Take the time to talk to Him and share what's on your heart.  Also, listen on the inside for His voice.  He will guide you and help you throughout your life."),
                                ],
                              ))));
                },
                title: 'The Adoption',
                verses: ["St. John 1:12"],
              ),
              VerseListWidget(
                onTapped: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VersePage(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  VerseTitle(
                                      title:
                                          "Rededication/Out of Fellowship with God Scriptures:"),
                                  VerseTitle(title: "1 John 1:9"),
                                  VerseContent(
                                      content:
                                          "If we confess our sins, he is faithful and just to forgive us our sins, and to cleanse us from all unrighteousness."),
                                  VerseTitle(
                                      title: "Scriptural Enlightenment:"),
                                  VerseContent(
                                      content:
                                          "Just because a person receives Jesus in their heart, doesn't mean they are perfect and will never sin again.  No one is perfect but Jesus.  Therefore, all believers will sin after they receive salvation.  The good news is that God is trustworthy and fair.  As we confess or acknowledge our sins with a repentant heart, God forsakes or omits our sins as if we never committed them.  The blood of Jesus, which was shed for our sins, cleanses us from it."),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  VerseTitle(title: "1 John 2:1-2"),
                                  VerseContent(
                                      content:
                                          "My little children, these things write I unto you, that ye sin not.  And if any man sin, we have an advocate with the Father, Jesus Christ the righteous: And he is the propitiation for our sins: and not for our's only but also for the sins of the whole world."),
                                  VerseTitle(
                                      title: "Scriptural Enlightenment:"),
                                  VerseContent(
                                      content:
                                          "Just because Jesus has paid for all sin does not excuse His people to wilffully sin.  As children of God, we should not plan to sin; rather, we should strive not to sin.  Whenever we sin or miss the mark, we should know that Jesus acts as our advocate.  He becomes our atonement or compensation for our sins."),
                                ],
                              ))));
                },
                title: 'Rededication',
                verses: ["1 John 1:9"],
              ),
            ],
          ),
        )
      ],
    );
  }
}
