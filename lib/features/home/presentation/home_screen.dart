import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:melbook/features/home/widgets/header_carousel.dart';

class HomePage1 extends StatefulWidget {
  HomePage1({super.key});

  final List<String> images = [
    'assets/images/ingliztili.png',
    'assets/images/rustili.jpg',
    'assets/images/koreystili.jpg',
    'assets/images/arabtili.jpg',
  ];

  final List<String> secondimages = [
    'assets/images/bookforcover.png',
    'assets/images/bookforcover.png',
    'assets/images/bookforcover.png',
    'assets/images/bookforcover.png',
    'assets/images/bookforcover.png',
  ];

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
  Widget build(BuildContext context) {
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
        title: const Text(
          "Xush kelibsiz",
          style: TextStyle(
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
            onPressed: () {},
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
                              SizedBox(
                                height: 150,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: widget.images.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height: 150,
                                      width: imageWidth,
                                      margin: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          image: DecorationImage(
                                            image: AssetImage(
                                                widget.images[index]),
                                            fit: BoxFit.cover,
                                          )),
                                    );
                                  },
                                ),
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
                              SizedBox(
                                height: 150,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: widget.secondimages.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      width: bookImageWidth,
                                      height: 114,
                                      margin: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            widget.secondimages[index],
                                            width: 73,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                          const SizedBox(width: 10),
                                          const Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    'English vocabulary in Use',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(Icons.star,
                                                        color: Colors.yellow),
                                                    Icon(Icons.star,
                                                        color: Colors.yellow),
                                                    Icon(Icons.star,
                                                        color: Colors.yellow),
                                                    Icon(Icons.star,
                                                        color: Colors.yellow),
                                                    Icon(Icons.star,
                                                        color: Colors.yellow),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                              padding: const EdgeInsets.all(7),
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.blue,
                                              ),
                                              child: const Icon(
                                                Icons.play_arrow,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
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
            ],
          ),
        ),
      ),
    );
  }
}
