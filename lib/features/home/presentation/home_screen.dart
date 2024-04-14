import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:melbook/features/auth/domain/repositories/auth_repository.dart';
import 'package:melbook/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:melbook/features/home/presentation/notification/notification_screen.dart';
import 'package:melbook/features/home/presentation/views/book_tile.dart';
import 'package:melbook/features/home/widgets/header_carousel.dart';
import 'package:melbook/locator.dart';

import 'bloc/book/book_bloc.dart';

class HomePage1 extends StatefulWidget {
  HomePage1({super.key});

  final List<String> slideimages = [
    'assets/images/img_homeslide.png',
    'assets/images/img_homeslide.png',
    'assets/images/img_homeslide.png',
  ];

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  @override
  void initState() {
    super.initState();
    debugPrint("Salom");
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double containerHeight = screenHeight * 0.8;
    double containerWidth = screenWidth * 0.95;

    CarouselController carouselController = CarouselController();
    return Scaffold(
      backgroundColor: Colors.black38,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Xush kelibsiz ${getIt<AuthRepository>().user?.userName ?? ""}",
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: SvgPicture.asset(
              "assets/icons/ic_notification.svg",
              height: 17.sp,
              width: 17.sp,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationScreen(),
                ),
              );
            },
          ),
          const SizedBox(width: 2),
        ],
      ),
      body: SingleChildScrollView(
        primary: true,
        child: Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.14),
          // Padding relative to screen height
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 18.h),

                      /// #Header Banner
                      CarouselDemo(
                        carouselController: carouselController,
                      ),
                      SizedBox(height: 18.h),

                      /// #Sub Books
                      Container(
                        height: screenWidth > 795
                            ? (containerHeight * 1.1).h
                            : containerHeight.h,
                        width: containerWidth.w,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF2F2F2),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            Container(
                              margin: const EdgeInsets.only(left: 18),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Kitoblar',
                                style: TextStyle(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.3,
                                ),
                              ),
                            ),
                            BlocBuilder<BookBloc, BookState>(
                              builder: (context, state) {
                                return Expanded(
                                  child: Wrap(
                                    children: [
                                      for (int i = 0;
                                          i < state.books.length;
                                          i++)
                                        BookTile(book: state.books[i]),
                                    ],
                                  ),
                                  // child: GridView.builder(
                                  //   primary: false,
                                  //   padding: EdgeInsets.symmetric(
                                  //     horizontal: 10.w,
                                  //     vertical: 10.h,
                                  //   ),
                                  //   gridDelegate:
                                  //       SliverGridDelegateWithFixedCrossAxisCount(
                                  //     crossAxisCount: 2,
                                  //     // childAspectRatio: screenWidth > 795 ? (2 / 8).sp : (2 / 3.2).w,
                                  //     crossAxisSpacing: 10.w,
                                  //     mainAxisSpacing: 10.w,
                                  //   ),
                                  //   itemCount: state.books.length,
                                  //   physics:
                                  //       const NeverScrollableScrollPhysics(),
                                  //   itemBuilder: (context, index) {
                                  //     final book = state.books[index];
                                  //     return BookTile(book: book);
                                  //   },
                                  // ),
                                );
                              },
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
        ),
      ),
    );
  }
}
