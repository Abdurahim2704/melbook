import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:melbook/features/home/data/models/bookdata.dart';
import 'package:melbook/features/home/presentation/ingliztilipage.dart';

class BookTile extends StatelessWidget {
  final String imagePath;
  final BookData book;

  const BookTile({
    super.key,
    required this.book,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Ingliztilipage(book: book),
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
              tag: book.id,
              child: Align(
                alignment: Alignment.centerLeft,
                child: CachedNetworkImage(
                  height: 250,
                  imageUrl: imagePath,
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
                  Text(
                    book.bought ? "Sotib olingan" : "Sotib olinmagan",
                    style: const TextStyle(
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
