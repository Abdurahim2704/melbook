import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:melbook/features/home/data/service/local_audio_service.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

// String link =
//     "https://cdn.mel-book.uz/9526d9b0-e61f-11ee-8f75-f9d1644ebbbc.pdf";
String appDocPath2 = "";

class LocalService {
  Future<void> requestPermissions() async {
    await Permission.storage.request();
    await Permission.mediaLibrary.request();
  }

  Future<String> getFilePath(String filename, String book) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    appDocPath2 = appDocDir.path;
    return join(appDocPath, book, filename);
  }

  Future<double> downloadFile(
      String fileName, String link, String book, String description) async {
    if (await Permission.storage.isDenied ||
        await Permission.mediaLibrary.isDenied) {
      await requestPermissions();
    }
    final filePath = await getFilePath(fileName, book);
    double value = -1;
    final result = await Dio().download(
      link,
      "$filePath.mp3",
      onReceiveProgress: (count, total) {
        value = count / total;
      },
    );
    print("Status code: ${result.statusCode}");
    if (result.statusCode == 200) {
      // final file = File(filePath);
      await LocalAudioService.saveAudio(
          fileName, "$filePath.mp3", book, description);
      print(result);
    }

    return value;
  }

  // double _getFileSize(File file) {
  //   int sizeInBytes = file.lengthSync();
  //   double sizeInMb = sizeInBytes / (1024 * 1024);
  //   return sizeInMb;
  // }

  Future<void> deleteFile(String filePath) async {
    final file = File(filePath);

    if (await file.exists()) {
      await file.delete();
      print("File deleted successfully.");
    } else {
      print("File does not exist.");
    }
  }
}
