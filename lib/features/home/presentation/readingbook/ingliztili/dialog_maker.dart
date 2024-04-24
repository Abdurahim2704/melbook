import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogMaker extends StatefulWidget {
  final String text;

  const DialogMaker({super.key, required this.text});

  @override
  State<DialogMaker> createState() => _DialogMakerState();
}

class _DialogMakerState extends State<DialogMaker> {
  final double horPadding = 30;
  final double spaceBetween = 10;

  List<String> descriptionSplitter() {
    final description = widget.text;
    return description.split("\n").toList();
  }

  Widget boldMaker(String text, Color color) {
    final textParts = text.split(":");
    if (textParts.length == 1) {
      return Text(
        textParts.single,
        style: TextStyle(fontSize: 25, color: color),
      );
    }
    return Text.rich(
        TextSpan(style: TextStyle(fontSize: 25, color: color), children: [
      TextSpan(
          text: "${textParts.first}: ",
          style: const TextStyle(fontWeight: FontWeight.w800)),
      TextSpan(
          text: textParts.last,
          style: const TextStyle(fontWeight: FontWeight.w400)),
    ]));
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        for (int i = 0; i < descriptionSplitter().length ~/ 2; i += 2) ...[
          SizedBox(
            height: 5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: (width - 2 * horPadding - spaceBetween) / 2,
                child: boldMaker(descriptionSplitter()[i], Colors.black),
              ),
              SizedBox(
                width: (width - 2 * horPadding - spaceBetween) / 2,
                child: boldMaker(descriptionSplitter()[i + 1], Colors.black),
              )
            ],
          )
        ]
      ],
    );
  }
}
