import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:melbook/features/home/presentation/bloc/local_storage/local_storage_bloc.dart';

class MyObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    debugPrint("${bloc.runtimeType} ${event.runtimeType}");
    if (bloc is LocalStorageBloc && bloc.state.books.isNotEmpty) {
      debugPrint("Audio counts: ${bloc.state.books.first.audios.length}");
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (bloc is LocalStorageBloc) {
      debugPrint("Current state: ${transition.currentState.runtimeType}");
      if (bloc.state is Progress) {
        debugPrint("Current progress: ${(bloc.state as Progress).progress}");
      }
      debugPrint(
          ("next state: ${transition.nextState.runtimeType}:Audios ${transition.nextState.books.length}:Books ${transition.nextState.books.length}"));
    }
  }
}
