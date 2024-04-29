import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:melbook/features/home/data/models/local_book.dart';
import 'package:melbook/features/home/presentation/saved/offline_reading_page.dart';

class OfflineBookTile extends StatelessWidget {
  final LocalBook book;

  const OfflineBookTile({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OfflineReadingPage(book: book),
          ),
        );
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: CupertinoColors.systemGroupedBackground,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: book.name,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  "assets/images/ingliztili.png",
                  height: 250,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
                  Text(
                    book.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.orange.shade800,
                      fontSize: 23,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "O'qish",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 28,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
