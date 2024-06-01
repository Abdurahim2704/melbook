import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melbook/features/home/data/service/last_read.dart';
import 'package:melbook/features/home/presentation/readingbook/ingliztili/englishreading.dart';

import '../../../../../locator.dart';
import '../../bloc/local_storage/local_storage_bloc.dart';

class FinalView extends StatefulWidget {
  const FinalView({super.key});

  @override
  State<FinalView> createState() => _FinalViewState();
}

class _FinalViewState extends State<FinalView> {
  int maxPoints = 23;

  @override
  Widget build(BuildContext context) {
    getIt<SharedPreferenceService>()
        .getLastPage()
        .then((value) => print("Last index:$value"));
    return Scaffold(
      body: BlocBuilder<LocalStorageBloc, LocalStorageState>(
        builder: (context, state) {
          return FutureBuilder<double>(
              future: getIt<SharedPreferenceService>().getLastPage(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return IngliztiliReading(
                    initialPosition: snapshot.data ?? 0.0,
                    audios: state.books.first.audios,
                  );
                }
                return const SizedBox.shrink();
              });
        },
      ),
    );
  }
}
