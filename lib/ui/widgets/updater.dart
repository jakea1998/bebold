import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Update 1.1: Update File names to include category and file type
class Updater {
  Future<SharedPreferences> get prefs async =>
      await SharedPreferences.getInstance();
  Future<void> perform_file_name_update() async {
    const String update_key = "Update_1.1";
    final update_key_exists = (await prefs).containsKey(update_key);
    if (!update_key_exists) {
      try{
      (await FlutterDownloader.loadTasks())?.forEach((element) {
        if (!element.filename.toString().contains("_")) {
          FlutterDownloader.remove(
              taskId: element.taskId, shouldDeleteContent: true);
        }
      });
      (await prefs).setBool(update_key, true);
      } catch(e){
        (await prefs).setBool(update_key, false);
      }
      
    }
  }
}
