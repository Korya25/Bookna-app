import 'package:bookna_app/features/books/domain/usecase/get_all_top_rated_books_use_case.dart';
import 'package:bookna_app/features/books/presentation/controller/top_rated_cubit/top_rated_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedBooksCubit extends Cubit<TopRatedBooksState> {
  final GetAllTopRatedBooksUseCase getAllTopRatedBooksUseCase;

  TopRatedBooksCubit(this.getAllTopRatedBooksUseCase)
    : super(TopRatedBooksInitial());

  Future<void> getTopRatedBooks(int pageNumber) async {
    emit(TopRatedBooksLoading());
    final result = await getAllTopRatedBooksUseCase(pageNumber);
    result.fold(
      (failure) => emit(TopRatedBooksError(failure.message.toString())),
      (books) => emit(TopRatedBooksLoaded(books)),
    );
  }
}
