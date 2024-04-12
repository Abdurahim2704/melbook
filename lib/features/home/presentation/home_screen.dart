import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:melbook/features/auth/domain/repositories/auth_repository.dart';
import 'package:melbook/features/home/presentation/views/book_tile.dart';
import 'package:melbook/features/home/widgets/header_carousel.dart';
import 'package:melbook/locator.dart';
import 'package:melbook/presentation/screens/notification/notification_screen.dart';

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
    context.read<BookBloc>().add(GetAllBooks());
  }

  @override
  Widget build(BuildContext context) {
    print(getIt<AuthRepository>().token);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double containerHeight = screenHeight * 0.8;
    double containerWidth = screenWidth * 0.95;
    double imageWidth = screenWidth * 0.25;
    double bookImageWidth = screenWidth * 0.6;
    CarouselController carouselController = CarouselController();
    return Scaffold(
      backgroundColor: Colors.black38,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Xush kelibsiz ${getIt<AuthRepository>().user?.userName ?? ""}",
          style: TextStyle(
            fontSize: 18.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {},
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: SvgPicture.asset(
              "assets/icons/ic_notification.svg",
              height: 20.sp,
              width: 20.sp,
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
        child: Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.15),
          // Padding relative to screen height
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(36),
                    topRight: Radius.circular(36),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Display sliding images at the top of the column
                      CarouselDemo(
                        carouselController: carouselController,
                      ),
                      const SizedBox(height: 18),
                      Container(
                        height: containerHeight,
                        width: containerWidth,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF2F2F2),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 47,
                                    width: screenWidth * 0.4,
                                    decoration: BoxDecoration(
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              'assets/images/frame1.png')),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  const SizedBox(width: 30),
                                  Container(
                                    height: 47,
                                    width: screenWidth * 0.3,
                                    decoration: BoxDecoration(
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              'assets/images/frame2.png')),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Container(
                                margin: const EdgeInsets.only(left: 18),
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  'Tavsiyalar',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.3),
                                ),
                              ),
                              const SizedBox(height: 12),
                              BlocBuilder<BookBloc, BookState>(
                                builder: (context, state) {
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: state.books.length,
                                      itemBuilder: (context, index) {
                                        final book = state.books[index];
                                        return Container(
                                          height: 150,
                                          width: imageWidth,
                                          margin: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              image: DecorationImage(
                                                image:
                                                    CachedNetworkImageProvider(
                                                        book.photoUrl),
                                                fit: BoxFit.cover,
                                              )),
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 20),
                              Container(
                                margin: const EdgeInsets.only(left: 18),
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  'Kitoblar',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.3),
                                ),
                              ),
                              const SizedBox(height: 12),
                              BlocBuilder<BookBloc, BookState>(
                                builder: (context, state) {
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: state.books.length,
                                      itemBuilder: (context, index) {
                                        final book = state.books[index];
                                        return BookTile(book: book);
                                      },
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
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
