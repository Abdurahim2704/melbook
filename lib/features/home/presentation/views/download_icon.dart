import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melbook/features/home/data/models/bookdata.dart';

import '../../data/service/local_audio_service.dart';
import '../bloc/local_storage/local_storage_bloc.dart';

class DownloadIcon extends StatelessWidget {
  final BookData book;
  final List<LocalAudio> audios;

  const DownloadIcon({super.key, required this.book, required this.audios});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (audios.length != (book.audios ?? []).length) {
          context.read<LocalStorageBloc>().add(
                DownloadAllAudios(
                  audios: book.audios ?? [],
                  book: book.name,
                  imageUrl: book.photoUrl,
                  description: book.description,
                  author: book.author,
                ),
              );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Resurslar yuklab olingan")));
        }
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.amber,
          shape: BoxShape.circle,
        ),
        child: Icon(
          audios.length == (book.audios ?? []).length
              ? Icons.check
              : Icons.download,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }
}
