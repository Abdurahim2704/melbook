import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melbook/features/home/presentation/views/book_container.dart';

import 'bloc/book/book_bloc.dart';

class Bookpage extends StatefulWidget {
  const Bookpage({super.key});

  @override
  State<Bookpage> createState() => _BookpageState();
}

class _BookpageState extends State<Bookpage> {
  final TextEditingController _controller = TextEditingController();

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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double containerHeight = screenHeight * 0.8;
    double containerWidth = screenWidth * 0.95;
    double imageWidth = screenWidth * 0.25;
    double bookImageWidth = screenWidth * 0.6;

    return Scaffold(
      backgroundColor: Colors.black38,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Kitoblar",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(
          Icons.last_page_outlined,
          color: Colors.white,
          size: 30,
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.headphones, size: 30, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
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
                      TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: 'Qidirish...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(37),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Color(0xFFF2F2F2),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                        ),
                        onChanged: (text) {
                          setState(() {});
                        },
                      ),
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
                                    scrollDirection: Axis.vertical,
                                    itemCount: state.books.length,
                                    itemBuilder: (context, index) {
                                      final book = state.books[index];
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
