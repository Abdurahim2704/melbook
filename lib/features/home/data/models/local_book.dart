import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../service/local_audio_service.dart';

class LocalBook extends Equatable {
  final String name;
  final List<LocalAudio> audios;
  final String description;
  final String author;

  const LocalBook({
    required this.name,
    required this.audios,
    required this.description,
    required this.author,
  });

  Map<String, Object?> toJson() => {
        'name': name,
        'audios': jsonEncode(audios.map((audio) => audio.toSql()).toList()),
        'description': description,
        'author': author,
      };

  // Convert a Map into a LocalBook. The Map must contain all the keys as returned by toJson.
  factory LocalBook.fromJson(Map<String, Object?> json) {
    try {
      final name = json["name"] as String;
      final audios = (jsonDecode(json['audios'] as String) as List)
          .map((audioJson) => LocalAudio.fromSql(audioJson))
          .toSet()
          .toList();
      // audios.sort(
      //   (a, b) {
      //     try {
      //       RegExp regExp = RegExp(r'\d+\.\d+');

      //       RegExpMatch matches1 = regExp.allMatches(a.name).first;
      //       RegExpMatch matches2 = regExp.allMatches(b.name).first;
      //       final number1 = double.parse(matches1.group(0) ?? "0");
      //       final number2 = double.parse(matches2.group(0) ?? "0");
      //       return number1.compareTo(number2);
      //     } catch (e) {
      //       print(e);
      //     }

      //     return 0;
      //   },
      // );
      final description = json["description"] as String;
      final author = json["author"] as String;

      return LocalBook(
        name: name,
        audios: audios,
        description: description,
        author: author,
      );
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }

  @override
  List<Object?> get props => [name, author, description];
}
