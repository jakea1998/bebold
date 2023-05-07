import 'dart:typed_data';
import 'dart:io';
import 'dart:async';
import 'package:be_bold/constants/colors.dart';
import 'package:be_bold/models/firebase_file.dart';
import 'package:be_bold/models/task_info.dart';
import 'package:be_bold/ui/pages/reaffirmation_page.dart';
import 'package:be_bold/ui/pages/verse_page.dart';
import 'package:be_bold/ui/widgets/continue_button.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ThumbnailRequest {
  final String video;
  final String thumbnailPath;
  final ImageFormat imageFormat;
  final int maxHeight;
  final int maxWidth;
  final int timeMs;
  final int quality;

  const ThumbnailRequest(
      {required this.video,
      required this.thumbnailPath,
      required this.imageFormat,
      required this.maxHeight,
      required this.maxWidth,
      required this.timeMs,
      required this.quality});
}

class ThumbnailResult {
  final Image image;
  final int? dataSize;
  final int? height;
  final int? width;
  const ThumbnailResult(
      {required this.image, this.dataSize, this.height, this.width});
}

class VideoPage extends StatefulWidget {
  final TaskInfo file;
  final bool isDownloaded;
  const VideoPage({Key? key, required this.file, required this.isDownloaded})
      : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _videoPlayerController;
  Image? thumbnailImage;
  bool videoStarted = false;
  ChewieController? chewieController;
  Future<ThumbnailResult> genThumbnail(ThumbnailRequest r) async {
    //WidgetsFlutterBinding.ensureInitialized();
    Uint8List? bytes;

    final Completer<ThumbnailResult> completer = Completer();
    print(r.video);
    final thumbnailPath = await VideoThumbnail.thumbnailFile(
        video: r.video,
        thumbnailPath: "${(await getTemporaryDirectory()).path}/",
        imageFormat: r.imageFormat,
        maxHeight: r.maxHeight,
        maxWidth: r.maxWidth,
        timeMs: r.timeMs,
        quality: r.quality);

    print("thumbnail file is located: $thumbnailPath");

    final file = File(thumbnailPath?.replaceAll("%20", " ") ?? "");
    bytes = file.readAsBytesSync();

    int _imageDataSize = bytes.length;
    print("image size: $_imageDataSize");

    final _image = Image.memory(bytes);
    _image.image
        .resolve(ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool _) {
      completer.complete(ThumbnailResult(
        image: _image,
        dataSize: _imageDataSize,
        height: info.image.height,
        width: info.image.width,
      ));
    }));
    return completer.future;
  }

  void setImage(BuildContext context) async {
    thumbnailImage = (await genThumbnail(ThumbnailRequest(
            video: widget.file.link.toString().replaceAll(" ", ""),
            thumbnailPath: "",
            imageFormat: ImageFormat.JPEG,
            maxHeight: 250,
            maxWidth: 400,
            timeMs: 0,
            quality: 75)))
        .image;
    setState(() {});
  }

  
  checkFileExists(File file) async {
    print("File Exists${await file.exists()}");
  } 

  Future<void> initVideoController() async {
    if (widget.isDownloaded) {
      
      final file = File(widget.file.filePath.replaceAll(" ", "%20").toString());
      checkFileExists(file);
      try {
        _videoPlayerController = VideoPlayerController.file(file);
      } on Exception catch (e) {
        print(e);
      }
    } else {
      _videoPlayerController = VideoPlayerController.network(
        widget.file.link ?? "",
      );
    }
    await _videoPlayerController.initialize();
    chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: _videoPlayerController.value.aspectRatio,
      autoInitialize: true,
      autoPlay: false,
      looping: false,
      errorBuilder: (context, errorMessage) {
      return Center(
        child: Text(
          errorMessage,
          style: TextStyle(color: Colors.white),
        ),
      );
    },
    );
    setState(() {
    });
  }

  @override
  void initState() {
    super.initState();
    

    initVideoController();

    print("downloaded:${widget.isDownloaded}");
    print(widget.file.filePath);

    //setImage(context);
    /*  _videoPlayerController
      ..initialize().then((_) {
        _videoPlayerController.setLooping(false);
        setState(() {});
      });
   /*  _vi */deoPlayerController
      ..addListener(() {
        if (!videoStarted)
          videoStarted = _videoPlayerController.value.isPlaying;
        print(_videoPlayerController.value.isBuffering);
        print(_videoPlayerController.value.isPlaying);
        setState(() {});
      }); */
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  Widget getVideoOrThumbnail(
      BuildContext context, VideoPlayerController _player, Image? image) {
    if ((videoStarted) && _player.value.isInitialized) {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: AspectRatio(
          aspectRatio: _player.value.aspectRatio,
          child: VideoPlayer(_player),
        ),
      );
    } else if (!_player.value.isPlaying &&
        image?.image != null &&
        videoStarted == false) {
      return Opacity(
        opacity: 0.8,
        child: Image(
          image: image!.image,
          fit: BoxFit.fitWidth,
          width: MediaQuery.of(context).size.width * 0.8,
          height: (MediaQuery.of(context).size.width * 0.8) *
              (1 / _player.value.aspectRatio),
        ),
      );
    } else
      return Container();
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
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      widget.file.name.toString().replaceAll(".mp4", ""),
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  )
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  chewieController != null &&
                          chewieController!
                              .videoPlayerController.value.isInitialized
                      ? SizedBox(
                         width:MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.width * 0.9*(1 / _videoPlayerController.value.aspectRatio),
                        child: Chewie(
                            controller: chewieController!,
                          ),
                      )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            CircularProgressIndicator(),
                            SizedBox(height: 20),
                            Text('Loading'),
                          ],
                        ),
                  /* getVideoOrThumbnail(
                      context, _videoPlayerController, thumbnailImage), */
                  /* GestureDetector(
                    onTap: () {
                      _videoPlayerController.value.isPlaying
                          ? _videoPlayerController.pause()
                          : _videoPlayerController.play();
                      setState(() {});
                    },
                    child: Container(
                      height: 50,
                      width: 70,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Icon(
                          _videoPlayerController.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ),
                  ) */
                ],
              ),
              Expanded(
                child: Column(children: [
                  ContinueButton(onTapped: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReaffirmationPage()));
                  }),
                  Spacer(
                    flex: 1,
                  ),
                ]),
              )
            ],
          )),
    );
  }
}
