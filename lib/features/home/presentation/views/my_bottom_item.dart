import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyBottomNavigation extends StatelessWidget {
  final List<MyBottomItem> tabs;
  final int selectedIndex;
  final Function(int value) onPress;

  const MyBottomNavigation({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Container(
        decoration: const BoxDecoration(
          color: CupertinoColors.systemGroupedBackground,
        ),
        height: 72,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: tabs.map((element) {
              return TabItem(
                item: element,
                onTap: (item) => onPress.call(item),
                index: tabs.indexOf(element),
                isSelected: selectedIndex == tabs.indexOf(element),
                length: tabs.length,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class TabItem extends StatelessWidget {
  const TabItem({
    super.key,
    required this.item,
    required this.onTap,
    required this.index,
    required this.length,
    required this.isSelected,
  });

  final Function(int) onTap;
  final MyBottomItem item;
  final int index;
  final int length;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () => onTap.call(index),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / length,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                item.image,
                height: 29,
                colorFilter: ColorFilter.mode(
                  isSelected ? Colors.green : Colors.grey,
                  BlendMode.srcIn,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  item.title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: isSelected ? Colors.green : Colors.grey,
                    fontSize: 15,
                  ),
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyBottomItem {
  String title;
  String image;

  MyBottomItem({
    required this.image,
    required this.title,
  });
}
