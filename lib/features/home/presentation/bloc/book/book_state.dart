part of 'book_bloc.dart';

@immutable
sealed class BookState {
  final List<BookData> books;

  const BookState({required this.books});
}

final class BookInitial extends BookState {
  const BookInitial({required super.books});
}

final class BookFetchSuccess extends BookState {
  const BookFetchSuccess({required super.books});
}

final class BookLoading extends BookState {
  const BookLoading({required super.books});
}

final class BookFetchError extends BookState {
  final String message;

  const BookFetchError({required super.books, required this.message});
}
