import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melbook/features/home/data/models/bookdata.dart';
import 'package:melbook/features/home/data/models/local_book.dart';

import '../bloc/local_storage/local_storage_bloc.dart';

class DownloadIcon extends StatelessWidget {
  final BookData book;
  final LocalBook? localBook;

  const DownloadIcon({super.key, required this.book, required this.localBook});

  @override
  Widget build(BuildContext context) {
    print(localBook?.audios.length);
    print("books");
    print(book.audios?.length);
    return InkWell(
      onTap: () {
        if (localBook?.audios.length != (book.audios ?? []).length) {
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
          localBook?.audios.length == (book.audios ?? []).length
              ? Icons.check
              : Icons.download,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }
}
