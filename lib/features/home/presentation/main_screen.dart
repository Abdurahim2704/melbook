import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:melbook/features/home/presentation/bloc/main_bloc/main_bloc.dart';
import 'package:melbook/features/home/presentation/bookpage.dart';
import 'package:melbook/features/home/presentation/profile/profile_creen.dart';
import 'package:melbook/features/home/presentation/saved.dart';

import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<String> items = [
    "assets/icons/ic_book.svg",
    "assets/icons/ic_main.svg",
    "assets/icons/ic_saved.svg",
    "assets/icons/ic_profile.svg",
  ];
  PageController pageController = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        height: 70.h,
        elevation: 0,
        color: const Color(0xffffffff),
        shadowColor: Colors.black,
        child: BlocBuilder<MainBloc, MainState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                items.length,
                (index) => IconButton(
                  onPressed: () {
                    BlocProvider.of<MainBloc>(context).add(
                      ChangePageEvent(index: index),
                    );
                    pageController.jumpToPage(index);
                  },
                  icon: SvgPicture.asset(
                    items[index],
                    height: 50.h,
                    colorFilter: ColorFilter.mode(
                      state.currentIndex == index ? Colors.black : Colors.grey,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          const Bookpage(),
          HomePage1(),
          const Saved(),
          const ProfileScreen()
        ],
      ),
    );
  }
}
