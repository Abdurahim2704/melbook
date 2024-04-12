import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:melbook/features/home/presentation/bookpage.dart';
import 'package:melbook/features/main/presentation/bloc/main_bloc.dart';

import '../../home/presentation/home_screen.dart';

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
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        height: 55.sp,
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
                            colorFilter: ColorFilter.mode(
                                state.currentIndex == index
                                    ? Colors.black
                                    : Colors.grey,
                                BlendMode.srcIn
                            ),
                          ),
                        )));
          },
        ),
      ),
      body: PageView(
        controller: pageController,
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.blue,
          ),
          Bookpage(),
          HomePage1(),
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.yellow,
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}
