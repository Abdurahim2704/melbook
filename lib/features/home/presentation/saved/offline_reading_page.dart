import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melbook/features/home/data/models/local_book.dart';
import 'package:melbook/features/home/presentation/bloc/local_storage/local_storage_bloc.dart';
import 'package:melbook/features/home/presentation/readingbook/ingliztili/finalview.dart';
import 'package:melbook/features/home/presentation/views/books_description.dart';

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
    print("I am here");
    print(widget.book.audios.length);
    print(context.read<LocalStorageBloc>().state.audios);
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
                              tag: widget.book.name,
                              child: Image.asset(
                                "assets/images/ingliztili.png",
                                width: w * 0.24,
                              ),
                            ),
                          ),
                          SizedBox(width: w * 0.02),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.book.name,
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                widget.book.author,
                                style: const TextStyle(
                                  fontSize: 20,
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
                                        horizontal: w * 0.07,
                                        vertical: h * 0.001,
                                      ),
                                      margin: const EdgeInsets.only(top: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius: BorderRadius.circular(70),
                                      ),
                                      child: const Text(
                                        "O'qish",
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  const SizedBox(width: 18),
                                  BlocBuilder<LocalStorageBloc,
                                      LocalStorageState>(
                                    builder: (context, state) {
                                      if (state is Progress) {
                                        return Text((state.progress /
                                                widget.book.audios.length)
                                            .toString());
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
      ),
    );
  }
}
