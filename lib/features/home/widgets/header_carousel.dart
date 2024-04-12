import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melbook/features/home/data/models/banner.dart';
import 'package:melbook/features/home/data/service/network_service.dart';

class CarouselDemo extends StatefulWidget {
  final CarouselController carouselController;

  const CarouselDemo({super.key, required this.carouselController});

  @override
  State<CarouselDemo> createState() => _CarouselDemoState();
}

class _CarouselDemoState extends State<CarouselDemo> {
  late Future<List<BannerModel>> _bannerFuture;

  @override
  void initState() {
    super.initState();
    _bannerFuture = NetworkService().getBanners();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BannerModel>>(
      future: _bannerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: SizedBox(
              height: 150.h,
              child: const CircularProgressIndicator.adaptive(),
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('No banners available'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No banners available'),
          );
        } else {
          return Column(
            children: [
              FlutterCarousel(
                items: _buildBannerWidgets(snapshot.data!),
                options: CarouselOptions(
                  slideIndicator: CircularWaveSlideIndicator(
                    alignment: const Alignment(0, 3),
                    indicatorRadius: 3,
                  ),
                  height: 150.h,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 5),
                  autoPlayAnimationDuration: const Duration(milliseconds: 850),
                  enableInfiniteScroll: true,
                  controller: widget.carouselController,
                  enlargeCenterPage: true,
                  viewportFraction: 0.75.w,
                  initialPage: 1,
                ),
              ),
            ],
          );
        }
      },
    );
  }

  List<Widget> _buildBannerWidgets(List<BannerModel> banners) {
    return banners.map((banner) {
      return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Image.network(
          banner.photoUrl,
          fit: BoxFit.cover,
        ),
      );
    }).toList();
  }
}
