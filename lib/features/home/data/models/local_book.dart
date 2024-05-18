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

  // Convert a LocalBook into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toJson() => {
        'name': name,
        'audios': jsonEncode(audios.map((audio) => audio.toSql()).toList()),
        'description': description,
        'author': author,
      };

  // Convert a Map into a LocalBook. The Map must contain all the keys as returned by toJson.
  factory LocalBook.fromJson(Map<String, dynamic> json) {
    final name = json["name"] as String;
    final audios = (jsonDecode(json['audios']) as List)
        .map((audioJson) => LocalAudio.fromSql(audioJson))
        .toList();

    audios.sort(
      (a, b) {
        try {
          RegExp regExp = RegExp(r'\d+\.\d+');

          RegExpMatch matches1 = regExp.allMatches(a.name).first;
          RegExpMatch matches2 = regExp.allMatches(b.name).first;

          return double.parse(matches1.group(0) ?? "0")
              .compareTo(double.parse(matches2.group(0) ?? "0"));
        } catch (e) {
          print(e);
        }

        return 0;
      },
    );
    print(audios.map((e) => e.name).join(", "));
    final description = json["description"] as String;
    final author = json["author"] as String;

    return LocalBook(
      name: name,
      audios: audios,
      description: description,
      author: author,
    );
  }

  @override
  List<Object?> get props => [name, author, description];
}
