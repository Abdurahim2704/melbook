part of 'main_bloc.dart';

sealed class MainState{
   int currentIndex;

   MainState({ this.currentIndex=0});
}

final class MainInitial extends MainState {
   MainInitial({required super.currentIndex});
}
