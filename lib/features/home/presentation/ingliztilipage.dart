import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
      print("I am here");

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
      if (mounted && !widget.book.bought) {
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 50.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
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
                        Hero(
                          tag: widget.book.id,
                          child: Transform.scale(
                            scaleY: 1.8,
                            scaleX: 1.8,
                            child: CachedNetworkImage(
                              width: 200.w,
                              imageUrl: widget.book.photoUrl,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.book.name,
                              style: TextStyle(
                                fontSize: 30.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              widget.book.author,
                              style: TextStyle(
                                fontSize: 22.sp,
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
                                  width: 15.w,
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
                                        margin: const EdgeInsets.only(top: 10),
                                        padding: EdgeInsets.all(10.sp),
                                        decoration: const BoxDecoration(
                                          color: Colors.amber,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          state.audios.length ==
                                                  (widget.book.audios ?? [])
                                                      .length
                                              ? Icons.check
                                              : Icons.download,
                                          color: Colors.white,
                                          size: 28.sp,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(width: 18),
                                BlocBuilder<LocalStorageBloc,
                                    LocalStorageState>(
                                  builder: (context, state) {
                                    if (state is Progress) {
                                      return CircularProgressIndicator(
                                        value: state.progress /
                                            widget.book.audios!.length,
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
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Color(0xFFF2F2F2),
            ),
            child: BookDescriptionContainer(data: widget.book.description),
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
