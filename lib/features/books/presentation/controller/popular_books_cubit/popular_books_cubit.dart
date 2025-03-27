import 'package:bookna_app/features/books/domain/usecase/get_all_popular_books_use_case.dart';
import 'package:bookna_app/features/books/presentation/controller/popular_books_cubit/popular_books_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularBooksCubit extends Cubit<PopularBooksState> {
  final GetAllPopularBooksUseCase getAllPopularBooksUseCase;

  PopularBooksCubit(this.getAllPopularBooksUseCase)
    : super(PopularBooksInitial());

  Future<void> getPopularBooks(int pageNumber) async {
    emit(PopularBooksLoading());
    final result = await getAllPopularBooksUseCase(pageNumber);
    result.fold(
      (failure) => emit(PopularBooksError(failure.message.toString())),
      (books) => emit(PopularBooksLoaded(books)),
    );
  }
}
