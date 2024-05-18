import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:melbook/features/home/data/service/book_service.dart';
import 'package:meta/meta.dart';

import '../../../../../config/exceptions/expired_token_exception.dart';
import '../../../../../locator.dart';
import '../../../../auth/domain/repositories/auth_repository.dart';
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
      print("Books: $books");
      emit(BookFetchSuccess(books: books));
    } catch (e) {
      if (e is ExpiredTokenException) {
        await getIt<AuthRepository>().resetToken();
        final books = await BookService().methodGetAllBooks();
        emit(BookFetchSuccess(books: books));
        return;
      }
      emit(BookFetchError(books: state.books, message: e.toString()));
    }
  }
}
