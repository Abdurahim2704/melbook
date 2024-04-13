
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melbook/shared/widgets/app_bar.dart';

class InsideBook extends StatefulWidget {
  const InsideBook({super.key});

  @override
  State<InsideBook> createState() => _InsideBookState();
}

class _InsideBookState extends State<InsideBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 80.w),
        child: Stack(
          children: [
            CustomAppBar(
              displayText: "Kitob haqida",
            ),
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackButton(),
                  IconButton(onPressed: () {

                  }, icon: Icon(Icons.headphones))
                ],
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Text(textAlign: TextAlign.justify,
              "The high demand for fairy tale books was further facilitated by the emergence of many new publishing houses during the late 19th and early 20th centuries. Then the onset of World War I brought about inflation, leading to resource rationing and a shortage of paper, consequently leading to a reduced book production.[20] The aftermath of the war, later coupled with the Great Depression, further exacerbated the situation, causing a decline in demand for both fairy tales and books in general.[21] A few years later, fairy tales quickly gained popularity again. In 1937, Walt Disney, being aware of the public's desire for an escape from the turmoil of a war-torn and economically strained world, introduced an era of fairy tale movies.and"
              "being aware of the public's desire for an escape from the turmoil of a war-torn and economically strained world, introduced an era of fairy tale movies.and  ",
          style: TextStyle(fontSize: 14.sp),),
        ),
      ),
    );
  }
}
