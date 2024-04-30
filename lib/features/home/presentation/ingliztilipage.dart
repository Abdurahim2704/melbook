import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melbook/features/home/data/models/bookdata.dart';
import 'package:melbook/features/home/presentation/bloc/book/book_bloc.dart';
import 'package:melbook/features/home/presentation/bloc/local_storage/local_storage_bloc.dart';
import 'package:melbook/features/home/presentation/bloc/payment_bloc/payment_bloc.dart';
import 'package:melbook/features/home/presentation/readingbook/ingliztili/finalview.dart';
import 'package:melbook/features/home/presentation/views/books_description.dart';
import 'package:melbook/features/home/presentation/views/click_sheet.dart';
import 'package:melbook/features/home/presentation/views/download_icon.dart';

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

  late Timer timer;

  void _buyButton() {
    if (widget.book.bought) {
      print(widget.book.audios!.length);
      print(context.read<LocalStorageBloc>().state.audios);
      if (context.read<LocalStorageBloc>().state.audios.length !=
          widget.book.audios!.length) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Iltimos avval resurslarni yuklang")));
        return;
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const FinalView(),
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
        context.read<BookBloc>().add(GetAllBooks());
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
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 35,
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
                        GestureDetector(
                          onTap: _buyButton,
                          child: Hero(
                            tag: widget.book.id,
                            child: CachedNetworkImage(
                              width: 200,
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
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              widget.book.author,
                              style: const TextStyle(
                                fontSize: 22,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: _buyButton,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 45,
                                      vertical: 8,
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
                                      style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                BlocBuilder<LocalStorageBloc,
                                    LocalStorageState>(
                                  builder: (context, state) {
                                    final books = state.books.where((element) =>
                                        widget.book.name == element.name);
                                    if (books.isEmpty) {
                                      return DownloadIcon(
                                          book: widget.book, localBook: null);
                                    }
                                    print(state.books.length);
                                    return DownloadIcon(
                                        book: widget.book,
                                        localBook: books.first);
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
                                        color: Colors.amber,
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
