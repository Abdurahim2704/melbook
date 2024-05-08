import 'package:flutter/material.dart';

class BookDescriptionContainer extends StatelessWidget {
  final String data;

  const BookDescriptionContainer({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final h = MediaQuery.sizeOf(context).height;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      margin: EdgeInsets.symmetric(vertical: h * 0.012, horizontal: w * 0.025),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        data,
        style: const TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}
