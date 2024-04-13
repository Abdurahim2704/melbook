import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melbook/features/home/presentation/views/book_container.dart';

import 'bloc/book/book_bloc.dart';

class Saved extends StatefulWidget {
  const Saved({super.key});

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  @override
  void initState() {
    super.initState();
    context.read<BookBloc>().add(GetAllBooks());
    context.read<BookBloc>().stream.listen((event) {
      if (event is BookFetchError) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(event.message)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black38,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Saqlanganlar",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.15),
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(36),
                      topRight: Radius.circular(36)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 45,
                      ),
                      Container(
                        height: screenHeight,
                        width: screenHeight,
                        decoration: BoxDecoration(
                            color: Color(0xFFF2F2F2),
                            borderRadius: BorderRadius.circular(24)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BlocBuilder<BookBloc, BookState>(
                              builder: (context, state) {
                                return SizedBox(
                                  height: screenHeight,
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.vertical,
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: state.books
                                        .where((element) => element.bought)
                                        .length,
                                    itemBuilder: (context, index) {
                                      final book = state.books
                                          .where((element) => element.bought)
                                          .toList()[index];
                                      return BookContainer(bookData: book);
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
