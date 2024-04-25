import 'package:flutter/material.dart';
import 'package:melbook/features/home/presentation/readingbook/rustili/rustilireading.dart';
import 'package:page_flip/page_flip.dart';

class FinalrustiliVuew extends StatefulWidget {
  const FinalrustiliVuew({super.key});

  @override
  State<FinalrustiliVuew> createState() => _FinalrustiliVuewState();
}

class _FinalrustiliVuewState extends State<FinalrustiliVuew> {
  final _controller = GlobalKey<PageFlipWidgetState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageFlipWidget(
        key: _controller,
        initialIndex: 0,
        lastPage: Container(
            color: Colors.white,
            child: const Center(child: Text("E'tiboringiz uchun rahmat!"))),
        children: <Widget>[
          for (var i = 0; i < 420; i++) RustiliReading(page: i),
        ],
      ),
    );
  }
}