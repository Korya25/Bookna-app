import 'package:bookna_app/features/books/domain/usecase/get_books_by_category_path_use_case.dart';
import 'package:bookna_app/features/books/presentation/controller/similar_cubit/similar_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimilarCubit extends Cubit<SimilarState> {
  final GetBooksByCategoryPathUseCase getBooksByCategoryPathUseCase;

  SimilarCubit(this.getBooksByCategoryPathUseCase)
    : super(SimilarBooksInitial());

  Future<void> getBooksBycategory(String category) async {
    emit(SimilarBooksLoading());
    final result = await getBooksByCategoryPathUseCase(category);
    result.fold(
      (failure) => emit(SimilarBooksError(failure.message.toString())),
      (books) => emit(SimilarBooksLoaded(books)),
    );
  }
}
