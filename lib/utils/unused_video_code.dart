import 'package:flutter/material.dart';
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
/* Future<ThumbnailResult> genThumbnail(ThumbnailRequest r) async {
    //WidgetsFlutterBinding.ensureInitialized();
    Uint8List? bytes;

    final Completer<ThumbnailResult> completer = Completer();

    final thumbnailPath = await VideoThumbnail.thumbnailFile(
        video: r.video,
        thumbnailPath: "${(await getTemporaryDirectory()).path}/",
        imageFormat: r.imageFormat,
        maxHeight: r.maxHeight,
        maxWidth: r.maxWidth,
        timeMs: r.timeMs,
        quality: r.quality);

    final file = File(thumbnailPath?.replaceAll("%20", " ") ?? "");
    bytes = file.readAsBytesSync();

    int _imageDataSize = bytes.length;

    final _image = Image.memory(bytes);
    _image.image
        .resolve(const ImageConfiguration())
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
  } */

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

Widget getVideoOrThumbnail(
    BuildContext context, VideoPlayerController player, Image? image) {
  bool videoStarted = false;
  if ((videoStarted) && player.value.isInitialized) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: AspectRatio(
        aspectRatio: player.value.aspectRatio,
        child: VideoPlayer(player),
      ),
    );
  } else if (!player.value.isPlaying &&
      image?.image != null &&
      videoStarted == false) {
    return Opacity(
      opacity: 0.8,
      child: Image(
        image: image!.image,
        fit: BoxFit.fitWidth,
        width: MediaQuery.of(context).size.width * 0.8,
        height: (MediaQuery.of(context).size.width * 0.8) *
            (1 / player.value.aspectRatio),
      ),
    );
  } else {
    return Container();
  }
}
