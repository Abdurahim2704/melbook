part of 'book_bloc.dart';

@immutable
sealed class BookEvent {}

class GetAllBooks extends BookEvent {}

class GetBookById extends BookEvent {}
