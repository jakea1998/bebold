import 'dart:io';
import 'dart:ui';

import 'package:flutter_downloader/flutter_downloader.dart';

class PortFunctions {
  static void unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }
  @pragma('vm:entry-point')
  static void downloadCallback(
    String id,
    DownloadTaskStatus status,
    int progress,
  ) {
    print(
      'Callback on background isolate: '
      'task ($id) is in status ($status) and process ($progress)',
    );
    if (Platform.isAndroid) {
     Future.delayed(const Duration(milliseconds:300));
    }
    final send = IsolateNameServer.lookupPortByName('downloader_send_port')
        ;
    send?.send([id, status, progress]);
  }
  
 
}