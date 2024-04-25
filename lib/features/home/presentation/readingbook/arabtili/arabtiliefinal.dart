import 'package:flutter/material.dart';
import 'package:melbook/features/home/presentation/readingbook/arabtili/arabtilireading.dart';
import 'package:page_flip/page_flip.dart';

class FinalArabtiliView extends StatefulWidget {
  const FinalArabtiliView({super.key});

  @override
  State<FinalArabtiliView> createState() => _FinalArabtiliViewState();
}

class _FinalArabtiliViewState extends State<FinalArabtiliView> {
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
          for (var i = 0; i < 420; i++) ArabTileReading(page: i),
        ],
      ),
    );
  }
}