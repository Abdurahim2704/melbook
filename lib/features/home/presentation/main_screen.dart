import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melbook/features/home/presentation/bloc/main_bloc/main_bloc.dart';
import 'package:melbook/features/home/presentation/profile/profile_creen.dart';
import 'package:melbook/features/home/presentation/views/my_bottom_item.dart';

import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<String> items = [
    "assets/icons/ic_main.svg",
    "assets/icons/ic_profile.svg",
  ];
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          return MyBottomNavigation(tabs: [
            MyBottomItem(image: items[0
            ], title: "Home"),
            MyBottomItem(image: items[1], title: "Profile"),
          ], selectedIndex: state.currentIndex, onPress: (value) {
            BlocProvider.of<MainBloc>(context).add(
              ChangePageEvent(index: value),
            );
            pageController.jumpToPage(value);
          },);
        },
      ),

      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: const [
          HomePage1(),
          ProfileScreen()
        ],
      ),
    );
  }
}


