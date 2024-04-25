import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melbook/features/auth/domain/repositories/auth_repository.dart';
import 'package:melbook/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:melbook/features/home/presentation/views/book_tile.dart';
import 'package:melbook/locator.dart';

import 'bloc/book/book_bloc.dart';

class HomePage1 extends StatefulWidget {
  const HomePage1({super.key});

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  @override
  void initState() {
    super.initState();
    context.read<BookBloc>().add(GetAllBooks());
    context.read<AuthBloc>().stream.listen((event) {
      if (event.message != null && mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(event.message!)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(getIt<AuthRepository>().token);
    double screenHeight = MediaQuery.of(context).size.height;
    double containerHeight = screenHeight * 0.8;
    return Scaffold(
      backgroundColor: Colors.black38,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Xush kelibsiz, ${getIt<AuthRepository>().user?.userName ?? ""}",
          style: TextStyle(
            fontSize: 33.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        primary: true,
        child: Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.1),
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10.h),

                    /// #Sub Books
                    Container(
                      height: containerHeight.h * 1.4,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(34),
                          topRight: Radius.circular(34),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 15.h),
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Kitoblar',
                              style: TextStyle(
                                fontSize: 30.sp,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 3.w,
                              ),
                            ),
                          ),
                          BlocBuilder<BookBloc, BookState>(
                            builder: (context, state) {
                              List<String> images = [
                                "assets/images/rustili.jpg",
                                "assets/images/rustili.jpg",
                                "assets/images/arabtili.jpg",
                                "assets/images/koreystili.jpg",
                              ];
                              return Expanded(
                                child: GridView.builder(
                                  primary: false,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 10.h,
                                  ),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 2 / 3.1,
                                    crossAxisSpacing: 10.w,
                                    mainAxisSpacing: 10.w,
                                  ),
                                  itemCount: state.books.length,
                                  physics:
                                      const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final book = state.books[index];
                                    return BookTile(
                                      book: book,
                                      imagePath: images[index],
                                    );
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
            ],
          ),
        ),
      ),
    );
  }
}
