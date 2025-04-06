import 'package:bookna_app/core/presentation/widget/custom_app_bar.dart';
import 'package:bookna_app/core/presentation/widget/loading_widget.dart';
import 'package:bookna_app/core/presentation/widget/nice_loading_widget.dart';
import 'package:bookna_app/core/presentation/widget/vertical_list_view.dart';
import 'package:bookna_app/core/presentation/widget/vertical_list_view_card.dart';
import 'package:bookna_app/core/resources/app_strings.dart';
import 'package:bookna_app/features/books/presentation/controller/top_rated_cubit/top_rated_cubit.dart';
import 'package:bookna_app/features/books/presentation/controller/top_rated_cubit/top_rated_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedBooksView extends StatelessWidget {
  const TopRatedBooksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: AppStrings.topRatedBooks),
      body: const _TopRatedBooksContent(),
    );
  }
}

class _TopRatedBooksContent extends StatefulWidget {
  const _TopRatedBooksContent();

  @override
  State<_TopRatedBooksContent> createState() => _TopRatedBooksContentState();
}

class _TopRatedBooksContentState extends State<_TopRatedBooksContent> {
  void _fetchMoreBooks() {
    if (context.read<TopRatedBooksCubit>().hasMoreData) {
      context.read<TopRatedBooksCubit>().getTopRatedBooks();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopRatedBooksCubit, TopRatedBooksState>(
      builder: (context, state) {
        if (state is TopRatedBooksLoading) {
          return const LoadingWidget();
        }

        if (state is TopRatedBooksError) {
          return Center(
            child: Text(
              state.message,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        }

        final books =
            state is TopRatedBooksLoaded
                ? state.books
                : (state as TopRatedBooksLoadingMore).books;

        return Stack(
          children: [
            VerticalListView(
              itemCount: books.length,
              itemBuilder:
                  (context, index) =>
                      VerticalListViewCard(isBook: true, book: books[index]),
              addEvent: _fetchMoreBooks,
            ),
            if (state is TopRatedBooksLoadingMore)
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
