import 'package:bookna_app/features/books/domain/entities/book.dart';

abstract class PopularBooksState {}

class PopularBooksInitial extends PopularBooksState {}

class PopularBooksLoading extends PopularBooksState {}

class PopularBooksLoaded extends PopularBooksState {
  final List<Book> books;
  PopularBooksLoaded(this.books);
}

class PopularBooksError extends PopularBooksState {
  final String message;
  PopularBooksError(this.message);
}
