import 'dart:async';
import 'package:bookna_app/features/books/presentation/widget/author_section_widget.dart';
import 'package:bookna_app/features/books/presentation/widget/book_details_section.dart';
import 'package:bookna_app/features/books/presentation/widget/overview_section_widget.dart';
import 'package:bookna_app/features/books/presentation/widget/similar_books_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookna_app/core/presentation/widget/loading_widget.dart';
import 'package:bookna_app/core/utils/setup_services_locator.dart';
import 'package:bookna_app/features/books/data/repo/books_repo_impl.dart';
import 'package:bookna_app/features/books/domain/entities/book.dart';
import 'package:bookna_app/features/books/domain/usecase/get_books_by_category_path_use_case.dart';
import 'package:bookna_app/features/books/presentation/controller/similar_cubit/similar_cubit.dart';
import 'package:bookna_app/features/books/presentation/controller/similar_cubit/similar_state.dart';

class BookDetailsView extends StatelessWidget {
  final Book book;

  const BookDetailsView({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BookDetailsWidget(book: book));
  }
}

class BookDetailsWidget extends StatelessWidget {
  final Book book;

  const BookDetailsWidget({super.key, required this.book});

  Future<void> _refreshData(BuildContext context) async {
    await Future.wait([
      context.read<SimilarCubit>().getBooksBycategory(
        book.categories?.first ?? 'fiction',
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => SimilarCubit(
            GetBooksByCategoryPathUseCase(getIt.get<BooksRepoImpl>()),
          )..getBooksBycategory(book.categories?.first ?? 'fiction'),
      child: BlocBuilder<SimilarCubit, SimilarState>(
        builder: (context, state) {
          if (state is SimilarBooksLoading) {
            return const LoadingWidget();
          }
          return RefreshIndicator(
            color: Colors.red,
            backgroundColor: Colors.white,
            strokeWidth: 3,
            onRefresh: () => _refreshData(context),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                BookDetailsSection(book: book),
                OverviewSectionWidget(overview: book.description),
                AuthorSectionWidget(book: book),
                SimilarBooksSection(state: state),
              ],
            ),
          );
        },
      ),
    );
  }
}
