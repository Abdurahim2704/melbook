import 'package:bloc/bloc.dart';
import 'package:melbook/features/home/data/service/book_service.dart';
import 'package:meta/meta.dart';

import '../../../data/models/bookdata.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  BookBloc() : super(const BookInitial(books: [])) {
    on<GetAllBooks>(_getAllBooks);
  }

  Future<void> _getAllBooks(GetAllBooks event, Emitter<BookState> emit) async {
    emit(BookLoading(books: state.books));
    try {
      final books = await BookService().methodGetAllBooks();
      emit(BookFetchSuccess(books: books));
    } catch (e) {
      emit(BookFetchError(books: state.books, message: e.toString()));
    }
  }
}
