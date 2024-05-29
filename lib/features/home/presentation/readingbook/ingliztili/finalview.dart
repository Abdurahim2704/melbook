import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melbook/features/home/data/service/last_read.dart';
import 'package:melbook/features/home/presentation/readingbook/ingliztili/englishreading.dart';
import 'package:page_flip/page_flip.dart';

import '../../../../../locator.dart';
import '../../bloc/local_storage/local_storage_bloc.dart';

class FinalView extends StatefulWidget {
  const FinalView({super.key});

  @override
  State<FinalView> createState() => _FinalViewState();
}

class _FinalViewState extends State<FinalView> {
  final _controller = GlobalKey<PageFlipWidgetState>();
  int maxPoints = 23;

  @override
  Widget build(BuildContext context) {
    getIt<SharedPreferenceService>()
        .getLastPage()
        .then((value) => print("Last index:$value"));
    return Scaffold(
      body: BlocBuilder<LocalStorageBloc, LocalStorageState>(
        builder: (context, state) {
          return FutureBuilder<int>(
              future: getIt<SharedPreferenceService>().getLastPage(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return PageFlipWidget(
                    key: _controller,
                    initialIndex: (snapshot.data ?? -1) + 1,
                    lastPage: Container(
                      color: Colors.white,
                      child: const Center(
                        child: Text(
                          "E'tiboringiz uchun rahmat!",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    children: <Widget>[
                      for (var i = 0; i < state.books.first.slices.length; i++)
                        IngliztiliReading(
                          slice: state.books.first.slices[i],
                          lastText: state.books.first.slices[i].lastText,
                          index: i,
                        ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              });

          //     PageView(
          //   physics: PageScrollPhysics(),
          //   children: <Widget>[
          //     for (var i = 0; i < slices.length; i++)
          //       IngliztiliReading(
          //         slice: slices[i],
          //         lastText: slices[i].lastText,
          //         index: i,
          //       ),
          //   ],
          // );
        },
      ),
    );
  }
}
