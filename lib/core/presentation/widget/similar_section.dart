import 'package:bookna_app/core/presentation/widget/section_list_view.dart';
import 'package:bookna_app/core/presentation/widget/section_list_view_card.dart';
import 'package:bookna_app/core/presentation/widget/section_title.dart';
import 'package:bookna_app/core/resources/app_strings.dart';
import 'package:bookna_app/core/resources/app_values.dart';
import 'package:bookna_app/features/books/domain/entities/book.dart';
import 'package:flutter/material.dart';

class SimilarSection extends StatefulWidget {
  const SimilarSection({super.key, required this.isBook});
  final bool isBook;

  @override
  State<SimilarSection> createState() => _SimilarSectionState();
}

class _SimilarSectionState extends State<SimilarSection> {
  final Book books = Book(
    bookId: '62',
    title: 'Korya',
    authors: [],
    publishedDate: '115',
    description: 'vfg',
    pageCount: 25,
    price: 0,
    averageRating: 52,
    ratingsCount: 2,
    thumbnail: '',
    categories: [],
    previewLink: '',
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: AppStrings.similar),
        SectionListView(
          height: AppSize.s240,
          itemCount: 30,
          itemBuilder:
              (context, index) =>
                  SectionListViewCard(isBook: widget.isBook, book: books),
        ),
      ],
    );
  }
}
