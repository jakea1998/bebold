import 'dart:io';
import 'dart:ui';


class PortFunctions {
  static void unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }
  @pragma('vm:entry-point')
  static void downloadCallback(
    String id,
    int status,
    int progress,
  ) {
    
    if (Platform.isAndroid) {
     Future.delayed(const Duration(milliseconds:300));
    }
    final send = IsolateNameServer.lookupPortByName('downloader_send_port')
        ;
    send?.send([id, status, progress]);
  }
  
 
}