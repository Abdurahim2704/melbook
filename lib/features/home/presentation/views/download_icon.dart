import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melbook/features/home/data/models/bookdata.dart';
import 'package:melbook/features/home/data/models/local_book.dart';

import '../bloc/local_storage/local_storage_bloc.dart';

class DownloadIcon extends StatelessWidget {
  final BookData book;
  final LocalBook? localBook;

  const DownloadIcon({
    super.key,
    required this.book,
    required this.localBook,
  });

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.sizeOf(context).height;
    return BlocBuilder<LocalStorageBloc, LocalStorageState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            if (state is DownloadWaiting || state is Progress) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Resurslar yuklab olinmoqda....")));
            } else if (localBook?.audios.length != (book.audios ?? []).length) {
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
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.amber,
              shape: BoxShape.circle,
            ),
            child: BlocBuilder<LocalStorageBloc, LocalStorageState>(
              builder: (context, state) {
                if (state.books.isEmpty) {
                  return Icon(
                    Icons.download,
                    color: Colors.white,
                    size: h * 0.025,
                  );
                }

                return Icon(
                  state.books.first.audios.length == (book.audios ?? []).length
                      ? Icons.check
                      : Icons.download,
                  color: Colors.white,
                  size: h * 0.025,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
