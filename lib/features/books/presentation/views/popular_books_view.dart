import 'package:bookna_app/core/presentation/widget/custom_app_bar.dart';
import 'package:bookna_app/core/presentation/widget/loading_widget.dart';
import 'package:bookna_app/core/presentation/widget/nice_loading_widget.dart';
import 'package:bookna_app/core/presentation/widget/vertical_list_view.dart';
import 'package:bookna_app/core/presentation/widget/vertical_list_view_card.dart';
import 'package:bookna_app/core/resources/app_strings.dart';
import 'package:bookna_app/features/books/presentation/controller/popular_books_cubit/popular_books_cubit.dart';
import 'package:bookna_app/features/books/presentation/controller/popular_books_cubit/popular_books_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularBooksView extends StatelessWidget {
  const PopularBooksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: AppStrings.popularBooks),
      body: const _PopularBooksContent(),
    );
  }
}

class _PopularBooksContent extends StatefulWidget {
  const _PopularBooksContent();

  @override
  State<_PopularBooksContent> createState() => _PopularBooksContentState();
}

class _PopularBooksContentState extends State<_PopularBooksContent> {
  void _fetchMoreBooks() {
    if (context.read<PopularBooksCubit>().hasMoreData) {
      context.read<PopularBooksCubit>().getPopularBooks();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularBooksCubit, PopularBooksState>(
      builder: (context, state) {
        if (state is PopularBooksLoading) {
          return const LoadingWidget();
        }

        if (state is PopularBooksError) {
          return Center(
            child: Text(
              state.message,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        }

        final books =
            state is PopularBooksLoaded
                ? state.books
                : (state as PopularBooksLoadingMore).books;

        return Stack(
          children: [
            VerticalListView(
              itemCount: books.length,
              itemBuilder:
                  (context, index) =>
                      VerticalListViewCard(isBook: true, book: books[index]),
              addEvent: _fetchMoreBooks,
            ),
            if (state is PopularBooksLoadingMore)
              const Positioned(
                bottom: 16.0,
                left: 0,
                right: 0,
                child: NiceLoadingWidget(),
              ),
          ],
        );
      },
    );
  }
}
