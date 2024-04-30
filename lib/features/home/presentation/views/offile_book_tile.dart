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
    final w = MediaQuery.sizeOf(context).width;
    final h = MediaQuery.sizeOf(context).height;
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
        padding: EdgeInsets.symmetric(
          horizontal: w * 0.005,
          vertical: h * 0.001,
        ),
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
                  height: h * 0.18,
                ),
              ),
            ),
            SizedBox(width: w * 0.035),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: h * 0.05),
                  Text(
                    book.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.orange.shade800,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "O'qish",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 30,
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
