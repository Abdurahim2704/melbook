import 'package:flutter/material.dart';
import 'package:melbook/features/home/presentation/readingbook/ingliztili/finalview.dart';
import 'package:melbook/features/home/presentation/views/books_description.dart';

import '../../data/models/local_book.dart';

class OfflineReadingPage extends StatefulWidget {
  final LocalBook book;

  const OfflineReadingPage({super.key, required this.book});

  @override
  State<OfflineReadingPage> createState() => _IngliztilipageState();
}

class _IngliztilipageState extends State<OfflineReadingPage> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _buyButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FinalView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final h = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: h * 0.06),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.01),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      size: h * 0.03,
                    ),
                  ),
                  SizedBox(width: w * 0.01),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(36),
                          topLeft: Radius.circular(36),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: _buyButton,
                            child: Hero(
                              tag: widget.book.name,
                              child: Image.asset(
                                "assets/images/ingliztili.png",
                                width: w * 0.2,
                              ),
                            ),
                          ),
                          SizedBox(width: w * 0.04),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.book.name,
                                style: TextStyle(
                                  fontSize: w * 0.045,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                widget.book.author,
                                style: TextStyle(
                                  fontSize: w * 0.035,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    onTap: _buyButton,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: w * 0.07,
                                        vertical: h * 0.007,
                                      ),
                                      margin: const EdgeInsets.only(top: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius: BorderRadius.circular(70),
                                      ),
                                      child: const Text(
                                        "O'qish",
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: h * 0.02),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color(0xFFF2F2F2),
              ),
              child: BookDescriptionContainer(data: widget.book.description),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void deactivate() {
    super.deactivate();
  }
}
