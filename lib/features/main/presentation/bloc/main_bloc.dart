
import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_event.dart';

part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainInitial(currentIndex: 1)) {
    on<GetMainEvent>(_getMain);
    on<ChangePageEvent>(_changeIndex);
  }

  void _getMain(GetMainEvent event, Emitter emit) {
    emit(MainInitial(currentIndex: state.currentIndex));
  }

  void _changeIndex(ChangePageEvent event, Emitter emit) {
    state.currentIndex = event.index;
    emit(MainInitial(currentIndex: state.currentIndex));
  }
}
