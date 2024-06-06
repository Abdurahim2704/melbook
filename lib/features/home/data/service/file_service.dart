import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:melbook/features/home/data/service/local_audio_service.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

String appDocPath2 = "";

class LocalService {
  final dio = Dio(BaseOptions(
      connectTimeout: const Duration(hours: 60),
      receiveTimeout: const Duration(hours: 20),
      receiveDataWhenStatusError: true));

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

  Future<double> downloadFile(String fileName, String link, String book,
      String description, String suffix) async {
    if (await Permission.storage.isDenied ||
        await Permission.mediaLibrary.isDenied) {
      await requestPermissions();
    }
    final filePath = await getFilePath(fileName, book);
    double value = -1;
    final result = await dio.download(
      link,
      "$filePath$suffix",
      onReceiveProgress: (count, total) {
        value = count / total;
      },
    );
    if (result.statusCode == 200) {
      // final file = File(filePath);
      await LocalAudioService.saveAudio(
          fileName, "$filePath.mp3", book, description);
    }

    return value;
  }

  // double _getFileSize(File file) {
  //   int sizeInBytes = file.lengthSync();
  //   double sizeInMb = sizeInBytes / (1024 * 1024);
  //   return sizeInMb;
  // }

  Future<void> deleteFile(List<String> filepaths) async {
    for (var filepath in filepaths) {
      final file = File(filepath);

      if (await file.exists()) {
        await file.delete();
        debugPrint("File deleted successfully.");
      } else {
        debugPrint("File does not exist.");
      }
    }
  }
}
