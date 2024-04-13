import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melbook/features/home/data/models/bookdata.dart';
import 'package:melbook/features/home/presentation/inside_book.dart';
import 'package:melbook/features/home/presentation/readingbook/ingliztili/finalview.dart';
import 'package:melbook/features/home/presentation/views/books_description.dart';
import 'package:melbook/features/home/presentation/views/click_sheet.dart';
import 'package:melbook/features/home/presentation/views/container_audios_listening.dart';

class Ingliztilipage extends StatefulWidget {
  final BookData book;

  const Ingliztilipage({super.key, required this.book});

  @override
  State<Ingliztilipage> createState() => _IngliztilipageState();
}

class _IngliztilipageState extends State<Ingliztilipage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _changePage(int page) {
    setState(() {
      _currentPage = page;
    });
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  late Timer timer;

  void _paymentCreated() {
    // timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
    //   final result = await PaymentService().checkPayment(id: id, token: token);
    //   print("Timer: $result");
    //   if (result) {
    //     isVerified = result;
    //     setState(() {});
    //   }
    // });
    // context.read<AuthBloc>().stream.listen((event) {
    //   if (event is AuthErrorState) {
    //     ScaffoldMessenger.of(context)
    //         .showSnackBar(SnackBar(content: Text(event.message)));
    //   }
    //   print(isVerified);
    //   if (isVerified) {
    //     if (!isGone) {
    //       Navigator.pushReplacement(context, MaterialPageRoute(
    //         builder: (context) {
    //           return const ChatPage();
    //         },
    //       ));
    //       isGone = true;
    //     }
    //     timer.cancel();
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
              Padding(
                padding: EdgeInsets.only(top: 60.h),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(36),
                      topLeft: Radius.circular(36),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const InsideBook(),
                              ),
                            );
                          },
                          child: CachedNetworkImage(
                            imageUrl: widget.book.photoUrl,
                            width: screenWidth * 0.25,
                          ),
                        ),
                        const SizedBox(width: 13),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.book.name,
                              style: TextStyle(
                                fontSize: 21.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              widget.book.author,
                              style: TextStyle(
                                fontSize: 15.sp,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (widget.book.bought) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const FinalView(),
                                      ));
                                } else {
                                  showClickSheet(context, widget.book.id);
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(11),
                                margin: const EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(70),
                                ),
                                child: Text(
                                  widget.book.bought ? "O'qish" : "Sotib olish",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const CircleAvatar(
                          radius: 24,
                          backgroundColor: Color(0xFFF2F2F2),
                          child: Icon(Icons.share, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              color: const Color(0xFFF2F2F2),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 10.h),

                  /// #Header PageView Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: _currentPage == 0
                              ? Colors.black
                              : Colors.transparent,
                          fixedSize: Size(170.w, 30.h),
                        ),
                        onPressed: () => _changePage(0),
                        child: Text(
                          "Batafsil",
                          style: TextStyle(
                            color:
                                _currentPage == 0 ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: _currentPage == 1
                              ? Colors.black
                              : Colors.transparent,
                          fixedSize: Size(170.w, 30.h),
                        ),
                        onPressed: () => _changePage(1),
                        child: Text(
                          "Tinglab o'qish",
                          style: TextStyle(
                            color:
                                _currentPage == 1 ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10.h),

                  /// #PageView SubContent
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      children: [
                        BookDescriptionContainer(data: widget.book.description),
                        widget.book.bought
                            ? ContainerAudiosListening(bookData: widget.book)
                            : Center(
                                child: Text(
                                  "Tinglash uchun kitobni sotib oling",
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
