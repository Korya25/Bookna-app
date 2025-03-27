import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookna_app/core/presentation/widget/author_section.dart';
import 'package:bookna_app/core/presentation/widget/details_card.dart';
import 'package:bookna_app/core/presentation/widget/over_view_section.dart';
import 'package:bookna_app/core/presentation/widget/similar_section.dart';
import 'package:bookna_app/core/utils/setup_services_locator.dart';
import 'package:bookna_app/features/books/data/repo/books_repo_impl.dart';
import 'package:bookna_app/features/books/domain/entities/book.dart';
import 'package:bookna_app/features/books/domain/usecase/get_books_by_category_path_use_case.dart';
import 'package:bookna_app/features/books/presentation/controller/similar_cubit/similar_cubit.dart';
import 'package:bookna_app/features/books/presentation/controller/similar_cubit/similar_state.dart';
import 'package:bookna_app/features/books/presentation/widget/books_card_details.dart';
import 'package:bookna_app/core/presentation/widget/loading_widget.dart'; // استيراد الودجت الجديدة

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
            return const LoadingWidget(); // استخدام الودجت المخصصة
          }

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: DetailsCard(
                  book: book,
                  detailsWidget: BooksCardDetails(book: book),
                ),
              ),
              SliverToBoxAdapter(
                child: OverviewSection(overview: book.description),
              ),
              SliverToBoxAdapter(child: AuthorSection(book: book)),
              if (state is SimilarBooksLoaded)
                SliverToBoxAdapter(
                  child: SimilarSection(isBook: true, books: state.books),
                )
              else
                const SliverToBoxAdapter(child: SizedBox.shrink()),
            ],
          );
        },
      ),
    );
  }
}
