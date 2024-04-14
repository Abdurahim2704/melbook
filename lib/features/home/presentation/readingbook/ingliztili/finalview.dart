import 'package:flutter/material.dart';
import 'package:melbook/features/home/presentation/readingbook/ingliztili/englishreading.dart';
import 'package:page_flip/page_flip.dart';

class FinalView extends StatefulWidget {
  const FinalView({super.key});

  @override
  State<FinalView> createState() => _FinalViewState();
}

class _FinalViewState extends State<FinalView> {
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
          for (var i = 0; i < 420; i++) IngliztiliReading(page: i),
        ],
      ),
    );
  }
}
