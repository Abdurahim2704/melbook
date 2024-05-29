import 'package:bloc/bloc.dart';
import 'package:melbook/features/home/presentation/bloc/local_storage/local_storage_bloc.dart';

class MyObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print("${bloc.runtimeType} ${event.runtimeType}");
    if (bloc is LocalStorageBloc && bloc.state.books.isNotEmpty) {
      print("Audio counts: ${bloc.state.books.first.audios.length}");
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (bloc is LocalStorageBloc) {
      print("Current state: ${transition.currentState.runtimeType}");
      print(
          ("next state: ${transition.nextState.runtimeType}:Audios ${transition.nextState.books.length}:Books ${transition.nextState.books.length}"));
    }
  }
}
