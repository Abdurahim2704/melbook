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
    print(widget.book.audios!.length);
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 50),
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
                              width: 200,
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
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              widget.book.author,
                              style: TextStyle(
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
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 45,
                                      vertical: 8,
                                    ),
                                    margin: const EdgeInsets.only(top: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(70),
                                    ),
                                    child: Text(
                                      "O'qish",
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
                                const SizedBox(width: 18),
                                BlocBuilder<LocalStorageBloc,
                                    LocalStorageState>(
                                  builder: (context, state) {
                                    if (state is Progress) {
                                      return Text((state.progress /
                                              widget.book.audios!.length)
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
    );
  }
}
