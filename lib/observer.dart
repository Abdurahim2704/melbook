import 'package:bloc/bloc.dart';

class MyObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print("${bloc.runtimeType} ${event.runtimeType}");
  }
}
