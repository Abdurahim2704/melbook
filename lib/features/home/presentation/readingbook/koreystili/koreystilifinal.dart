import 'package:flutter/material.dart';
import 'package:melbook/features/home/presentation/readingbook/koreystili/koreystilireading.dart';
import 'package:page_flip/page_flip.dart';

class Koreystilifinal extends StatefulWidget {
  const Koreystilifinal({super.key});

  @override
  State<Koreystilifinal> createState() => _KoreystilifinalState();
}

class _KoreystilifinalState extends State<Koreystilifinal> {
  final _controller = GlobalKey<PageFlipWidgetState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageFlipWidget(
        key: _controller,
        backgroundColor: const Color.fromARGB(255, 139, 111, 111),
        initialIndex: 0,
        lastPage: Container(
            color: Colors.white,
            child: const Center(child: Text("E'tiboringiz uchun rahmat!"))),
        children: <Widget>[
          for (var i = 0; i < 420; i++) KoreystiliReading(page: i),
        ],
      ),
    );
  }
}