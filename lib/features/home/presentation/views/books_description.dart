import 'package:flutter/material.dart';

class BookDescriptionContainer extends StatelessWidget {
  final String data;

  const BookDescriptionContainer({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          data,
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}
