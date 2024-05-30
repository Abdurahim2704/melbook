import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../service/local_audio_service.dart';
import 'slice.dart';

class LocalBook extends Equatable {
  final String name;
  final List<LocalAudio> audios;
  final List<Slice> slices;
  final String description;
  final String author;

  const LocalBook({
    required this.name,
    required this.audios,
    required this.description,
    required this.author,
    required this.slices,
  });

  // Convert a LocalBook into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, Object?> toJson() => {
        'name': name,
        'audios': jsonEncode(audios.map((audio) => audio.toSql()).toList()),
        'description': description,
        'author': author,
        "slices": jsonEncode(slices.map((e) => e.toJson()).toList())
      };

  // Convert a Map into a LocalBook. The Map must contain all the keys as returned by toJson.
  factory LocalBook.fromJson(Map<String, Object?> json) {
    try {
      final name = json["name"] as String;
      final audios = (jsonDecode(json['audios'] as String) as List)
          .map((audioJson) => LocalAudio.fromSql(audioJson))
          .toSet()
          .toList();
      final slices = (jsonDecode((json['slices'] as String)) as List)
          .map((e) => Slice.fromJson(e as Map<String, Object?>))
          .toList();
      audios.sort(
        (a, b) {
          try {
            RegExp regExp = RegExp(r'\d+\.\d+');

            RegExpMatch matches1 = regExp.allMatches(a.name).first;
            RegExpMatch matches2 = regExp.allMatches(b.name).first;
            final number1 = double.parse(matches1.group(0) ?? "0");
            final number2 = double.parse(matches2.group(0) ?? "0");
            return number1.compareTo(number2);
          } catch (e) {
            print(e);
          }

          return 0;
        },
      );

      // audios.map((e) => e.name).forEach(
      //       (element) => print("Name: $element"),
      //     );
      print(slices.isEmpty);
      slices.map((e) => print(
          "Audio: ${e.audios.map((e) => e.name).join(",")}, Last: ${e.lastAudio?.name}"));
      final description = json["description"] as String;
      final author = json["author"] as String;

      return LocalBook(
        name: name,
        audios: audios,
        slices: slices,
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

//   int maxPoints = 230;
//   List<Slice> makeCut(List<LocalAudio> audios) {
//     final slices = <Slice>[];
//     List<LocalAudio> result = [];
//     List<DialogPairs>? remained;
//     int currentPoints = 0;
//     LocalAudio? currentOne;
//     try {
//       for (var audio in audios) {
//         currentOne = audio;

//         if (audio.name.contains("3.4") ||
//             audio.name.contains("4.5") ||
//             audio.name.contains("9.3")) {
//           print("hello");
//         }
//         final dialogs = audio.description; // audios dialogs
//         final diloagPoint = audio.description
//             .map((e) => e.points)
//             .reduce((value, element) => value + element);
//         if (diloagPoint >= maxPoints) {
//           final (partSlices, remainDialogs) =
//               getAmountSlices(dialogs, maxPoints, audio, remained ?? []);
//           partSlices[0].remained = remained;
//           remained = [...remainDialogs];
//           slices.addAll(partSlices);
//           continue;
//         }

//         final audiosPoints = audio.pointCount(); // current audios points
//         final remainedPoints = (remained ?? []).map((e) => e.points).fold<int>(
//               0,
//               (value, element) => value + element,
//             ); // remained points from previous

//         final totalPoints =
//             currentPoints + audiosPoints + remainedPoints; // sum of all points
//         if (totalPoints > maxPoints) {
//           final lastText = getLastDialogs(dialogs, maxPoints, currentPoints);
//           slices.add(Slice(
//             audios: result,
//             lastText: lastText,
//             lastAudio: audio,
//             remained: remained,
//           ));

//           remained = dialogs.sublist(lastText.length);
//           result = [];
//           currentPoints = 0;
//         } else if (totalPoints == maxPoints) {
//           result.add(audio);
//           slices.add(Slice(audios: result, remained: remained));

//           // reset values
//           remained = null;
//           result = [];
//           currentPoints = 0;
//         } else {
//           result.add(audio);
//           currentPoints +=
//               totalPoints; // Update currentPoints with the total points
//         }
//       }
//       if (result.isNotEmpty || remained != null) {
//         slices.add(Slice(audios: result, remained: remained));
//       }
//     } catch (e) {
//       print(currentOne?.description.length);
//       print(currentOne?.location);
//       print(currentOne?.name);
//     }
//     return slices;
//   }

//   List<DialogPairs> getLastDialogs(
//       List<DialogPairs> dialogs, int maxLines, int currentPoints) {
//     /// getting audios which fits in page

//     List<DialogPairs> list = [];
//     for (int i = 0; i < dialogs.length; i++) {
//       final listPoints = list
//           .map((e) => e.points)
//           .fold<int>(0, (value, element) => value + element);
//       if (dialogs[i].points + listPoints <= (maxLines - currentPoints)) {
//         list.add(dialogs[i]);
//       } else {
//         return list;
//       }
//     }
//     return list;
//   }

//   (List<Slice>, List<DialogPairs>) getAmountSlices(List<DialogPairs> dialogs,
//       int points, LocalAudio audio, List<DialogPairs> remained) {
//     /// getting audios which fits in page
//     List<Slice> slices = [];
//     if (audio.name.contains("3.4")) {
//       print("object");
//     }
//     List<DialogPairs> list = [];
//     for (int i = 0; i < dialogs.length; i++) {
//       final listPoints = list
//           .map((e) => e.points)
//           .fold<int>(0, (value, element) => value + element);
//       if (slices.isEmpty) {
//         if (dialogs[i].points +
//                 listPoints +
//                 remained
//                     .map((e) => e.points)
//                     .fold<int>(0, (value, element) => value + element) <=
//             points) {
//           list.add(dialogs[i]);
//         } else {
//           slices.add(Slice(audios: [], lastText: list));
//           list = [];
//         }
//       } else if (dialogs[i].points + listPoints <= points) {
//         list.add(dialogs[i]);
//       } else {
//         slices.add(Slice(audios: [], lastText: list));
//         list = [];
//       }
//     }
//     if (slices.isNotEmpty) {
//       slices.first.lastAudio = audio;
//     }
//     return (slices, list);
//   }
// }
