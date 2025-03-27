import 'package:bookna_app/core/presentation/widget/author_section.dart';
import 'package:bookna_app/core/presentation/widget/details_card.dart';
import 'package:bookna_app/core/presentation/widget/over_view_section.dart';
import 'package:bookna_app/core/presentation/widget/similar_section.dart';
import 'package:bookna_app/features/books/domain/entities/book.dart';
import 'package:bookna_app/features/books/presentation/widget/books_card_details.dart';
import 'package:flutter/material.dart';

class BookDetailsView extends StatelessWidget {
  const BookDetailsView({super.key, required this.book});
  final Book book;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BookDetailsWidget(book: book));
  }
}

class BookDetailsWidget extends StatelessWidget {
  const BookDetailsWidget({super.key, required this.book});
  final Book book;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: DetailsCard(
            book: book,
            detailsWidget: BooksCardDetails(book: book),
          ),
        ),
        SliverToBoxAdapter(child: OverviewSection(overview: book.description)),
        SliverToBoxAdapter(child: AuthorSection(book: book)),

        SliverToBoxAdapter(child: SimilarSection(isBook: true)),
      ],
    );
  }
}
