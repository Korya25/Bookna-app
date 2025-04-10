import 'package:bookna_app/features/books/domain/usecase/get_books_by_title_use_case.dart';
import 'package:bookna_app/features/search/presentation/controller/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchState> {
  final GetBooksByTitleUseCase getBooksByTitleUseCase;

  SearchCubit(this.getBooksByTitleUseCase) : super(SearchBooksInitial());

  Future<void> getBooksByTitle(String title) async {
    if (title.isEmpty) {
      emit(SearchBooksInitial());
      return;
    }

    emit(SearchBooksLoading());

    final result = await getBooksByTitleUseCase(title);

    result.fold(
      (failure) => emit(SearchBooksError(failure.message.toString())),
      (books) => emit(SearchBooksLoaded(books)),
    );
  }
}
