import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melbook/features/home/data/service/local_audio_service.dart';

class DialogMaker extends StatefulWidget {
  final List<DialogPairs> dialogs;

  const DialogMaker({super.key, required this.dialogs});

  @override
  State<DialogMaker> createState() => _DialogMakerState();
}

class _DialogMakerState extends State<DialogMaker> {
  final double horPadding = 30;
  final double spaceBetween = 10;

  Widget boldMaker(String text, Color color) {
    final textParts = text.split(":");
    if (textParts.length == 1) {
      return textParts.single.isEmpty
          ? const SizedBox.shrink()
          : Text(
              textParts.single,
              style: TextStyle(fontSize: 25, color: color),
            );
    }
    return Text.rich(
        TextSpan(style: TextStyle(fontSize: 25, color: color), children: [
      TextSpan(
        text: "${textParts.first}: ",
        style: const TextStyle(fontWeight: FontWeight.w800),
      ),
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
        for (int i = 0; i < widget.dialogs.length; i++) ...[
          SizedBox(
            height: 5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: (width - 2 * horPadding - spaceBetween) / 2,
                child: boldMaker(widget.dialogs[i].line, Colors.black),
              ),
              SizedBox(
                width: (width - 2 * horPadding - spaceBetween) / 2,
                child: boldMaker(widget.dialogs[i].translation, Colors.black),
              )
            ],
          )
        ]
      ],
    );
  }
}
