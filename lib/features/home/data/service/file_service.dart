import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'local_service.dart';

String link =
    "https://cdn.mel-book.uz/9526d9b0-e61f-11ee-8f75-f9d1644ebbbc.pdf";
String appDocPath2 = "";

class LocalService {
  Future<void> requestPermissions() async {
    await Permission.storage.request();
    print(await Permission.storage.isGranted);
    await Permission.mediaLibrary.request();
  }

  Future<String> getFilePath(String filename) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    appDocPath2 = appDocDir.path;
    return join(appDocPath, filename);
  }

  Future<Stream<int>> downloadFile(
      LocalBookService service, String fileName) async {
    final filePath = await getFilePath(fileName);
    final downloadStream = StreamController<int>();
    final file = File(filePath);
    downloadStream.add(0);
    final result = await Dio().download(
      link,
      filePath,
      onReceiveProgress: (count, total) {
        if (total <= 0) return;
        downloadStream.add(((count / total) * 100).toInt());
      },
    );
    if (result.statusCode == 200) {
      final file = File(filePath);
      final size = _getFileSize(file);
      print("I am here");
      await service.insertLocalBook(
          LocalBook(name: fileName, location: filePath, size: size.toString()));
    }

    return downloadStream.stream;
  }

  double _getFileSize(File file) {
    int sizeInBytes = file.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    return sizeInMb;
  }

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
