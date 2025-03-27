import 'package:bookna_app/core/presentation/widget/custom_app_bar.dart';
import 'package:bookna_app/core/presentation/widget/vertical_list_view.dart';
import 'package:bookna_app/core/presentation/widget/vertical_list_view_card.dart';
import 'package:bookna_app/core/resources/app_strings.dart';
import 'package:bookna_app/features/books/domain/entities/book.dart';
import 'package:flutter/material.dart';

class PopularBooksView extends StatelessWidget {
  const PopularBooksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: AppStrings.popularBooks),
      body: PopularBooksWidget(),
    );
  }
}

class PopularBooksWidget extends StatelessWidget {
  const PopularBooksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return VerticalListView(
      itemCount: 30,
      itemBuilder: (BuildContext context, int index) {
        return VerticalListViewCard(
          isBook: true,
          book: Book(
            bookId: '',
            title: '',
            authors: [],
            publishedDate: '',
            description: '',
            pageCount: 0,
            price: 0,
            averageRating: 0,
            ratingsCount: 0,
            thumbnail: '',
            categories: [],
            previewLink: '',
          ),
        );
      },
      addEvent: () {},
    );
  }
}
