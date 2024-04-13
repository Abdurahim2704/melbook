part of 'main_bloc.dart';

sealed class MainEvent {
  const MainEvent();
}

class GetMainEvent extends MainEvent {}

class ChangePageEvent extends MainEvent {
  final int index;

  const ChangePageEvent({required this.index});
}
