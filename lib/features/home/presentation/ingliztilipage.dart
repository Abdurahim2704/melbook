import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melbook/features/home/data/models/book_types.dart';
import 'package:melbook/features/home/data/models/bookdata.dart';
import 'package:melbook/features/home/presentation/bloc/local_storage/local_storage_bloc.dart';
import 'package:melbook/features/home/presentation/bloc/payment_bloc/payment_bloc.dart';
import 'package:melbook/features/home/presentation/readingbook/arabtili/arabtiliefinal.dart';
import 'package:melbook/features/home/presentation/readingbook/ingliztili/finalview.dart';
import 'package:melbook/features/home/presentation/readingbook/koreystili/koreystilifinal.dart';
import 'package:melbook/features/home/presentation/readingbook/rustili/rustilifinal.dart';
import 'package:melbook/features/home/presentation/views/books_description.dart';
import 'package:melbook/features/home/presentation/views/click_sheet.dart';

import '../../../shared/widgets/custom_alert_dialog.dart';

class Ingliztilipage extends StatefulWidget {
  final BookData book;

  const Ingliztilipage({super.key, required this.book});

  @override
  State<Ingliztilipage> createState() => _IngliztilipageState();
}

class _IngliztilipageState extends State<Ingliztilipage> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    timer.cancel();
    super.dispose();
  }

  Widget returnBooks(String book) {
    if (book == BookTypes.english.name) {
      return const FinalView();
    } else if (book == BookTypes.arabian.name) {
      return const FinalArabtiliView();
    } else if (book == BookTypes.russian.name) {
      return const FinalrustiliVuew();
    }

    return const Koreystilifinal();
  }

  late Timer timer;

  void _buyButton() {
    if (widget.book.bought) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => returnBooks(widget.book.name),
        ),
      );
    } else {
      showClickSheet(context, widget.book.id);
    }
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      if (mounted) {
        context.read<PaymentBloc>().add(CheckPayment(times: timer.tick));
      }
    });
    context.read<PaymentBloc>().stream.listen((event) {
      if (event is PaymentSuccess) {
        showDialog(
          context: context,
          builder: (context) {
            return CustomAlertDialog(
              displayText: "To'landi",
              onPressed: () {
                Navigator.popUntil(
                  context,
                  (route) => !Navigator.canPop(context),
                );
              },
            );
          },
        );
        timer.cancel();
      } else if (event is PaymentCanceled) {
        showDialog(
          context: context,
          builder: (context) {
            return CustomAlertDialog(
              displayText: "To'lov bekor qilindi",
              onPressed: () {
                Navigator.popUntil(
                  context,
                  (route) => !Navigator.canPop(context),
                );
              },
            );
          },
        );
        timer.cancel();
        return;
      } else if (event is PaymentCreated) {
        showDialog(
          context: context,
          builder: (context) {
            return CustomAlertDialog(
              displayText: "To'lov so'rovi yuborildi! Clickni tekshiring",
              onPressed: () {
                Navigator.popUntil(
                  context,
                  (route) => !Navigator.canPop(context),
                );
              },
            );
          },
        );
      }
    });
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
                icon: Icon(
                  Icons.arrow_back,
                  size: 35.sp,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60),
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
                        ClipRRect(
                          clipBehavior: Clip.antiAlias,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                          child: Transform.scale(
                            scaleY: 1.6,
                            scaleX: 1.6,
                            child: CachedNetworkImage(
                              imageUrl: widget.book.photoUrl,
                              width: screenWidth * 0.25,
                            ),
                          ),
                        ),
                        const SizedBox(width: 30),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.book.name,
                              style: TextStyle(
                                fontSize: 35.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              widget.book.author,
                              style: TextStyle(
                                fontSize: 28.sp,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: _buyButton,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 45.w,
                                      vertical: 8.h,
                                    ),
                                    margin: const EdgeInsets.only(top: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(70),
                                    ),
                                    child: Text(
                                      widget.book.bought
                                          ? "O'qish"
                                          : "Sotib olish",
                                      style: TextStyle(
                                        fontSize: 25.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                BlocBuilder<LocalStorageBloc,
                                    LocalStorageState>(
                                  builder: (context, state) {
                                    return InkWell(
                                      onTap: () {
                                        context.read<LocalStorageBloc>().add(
                                              DownloadAllAudios(
                                                audios:
                                                    widget.book.audios ?? [],
                                                book: widget.book.name,
                                              ),
                                            );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        margin: const EdgeInsets.only(top: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.amber,
                                          borderRadius:
                                              BorderRadius.circular(70),
                                        ),
                                        child: Icon(
                                          state.audios.length ==
                                                  (widget.book.audios ?? [])
                                                      .length
                                              ? Icons.check
                                              : Icons.download,
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(width: 15),
                                BlocBuilder<LocalStorageBloc,
                                    LocalStorageState>(
                                  builder: (context, state) {
                                    if (state is Progress) {
                                      return Padding(
                                        padding: EdgeInsets.only(top: 12.0.h),
                                        child: CircularProgressIndicator(
                                          value: state.progress /
                                              widget.book.audios!.length,
                                        ),
                                      );
                                    }
                                    return const SizedBox.shrink();
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              color: Color(0xFFF2F2F2),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BookDescriptionContainer(data: widget.book.description),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void deactivate() {
    super.deactivate();
    timer.cancel();
  }
}
