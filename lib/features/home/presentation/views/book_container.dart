import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:melbook/features/home/data/models/bookdata.dart';
import 'package:melbook/features/home/presentation/ingliztilipage.dart';

class BookContainer extends StatelessWidget {
  final BookData bookData;

  const BookContainer({super.key, required this.bookData});

  @override
  Widget build(BuildContext context) {
    void navigateToInglizTiliPage(){
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Ingliztilipage(
            book: bookData,
          ),
        ),
      );
    }
    return GestureDetector(
      onTap: navigateToInglizTiliPage,
      child: Container(
        height: 200,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            ClipRRect(
              clipBehavior: Clip.antiAlias,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: CachedNetworkImage(
                imageUrl: bookData.photoUrl,
                width: 170,
                height: 190,
                fit: BoxFit.fill,
                progressIndicatorBuilder: (context, __, _) => const CupertinoActivityIndicator(),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      bookData.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 27,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    alignment: Alignment.center,
                    height: 45,
                    width: 170,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Text(
                      bookData.bought ? "O'qish" : "Sotib olish",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: navigateToInglizTiliPage,
              child: Container(
                height: 50,
                width: 50,
                margin: const EdgeInsets.only(right: 5),
                padding: const EdgeInsets.all(7),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
