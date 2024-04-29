import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melbook/features/auth/data/service/local_service.dart';
import 'package:melbook/features/home/presentation/bloc/local_storage/local_storage_bloc.dart';
import 'package:melbook/features/home/presentation/views/offile_book_tile.dart';
import 'package:melbook/shared/widgets/app_bar.dart';

class SavedPages extends StatefulWidget {
  const SavedPages({super.key});

  @override
  State<SavedPages> createState() => SavedPageState();
}

class SavedPageState extends State<SavedPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 90),
        child: FutureBuilder<String?>(
            future: LocalDBService.getUsername(),
            builder: (context, snapshot) {
              return CustomAppBar(
                displayText: "Xush kelibsiz, ${snapshot.data ?? ""}",
              );
            }),
      ),
      body: BlocBuilder<LocalStorageBloc, LocalStorageState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                ListView.separated(
                  itemBuilder: (context, index) {
                    final book = state.books[index];
                    return OfflineBookTile(
                      book: book,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 15);
                  },
                  itemCount: state.books.length,
                  shrinkWrap: true,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
