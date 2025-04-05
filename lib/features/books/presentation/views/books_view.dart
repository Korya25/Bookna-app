import 'package:bookna_app/core/presentation/views/error_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookna_app/core/presentation/widget/loading_widget.dart';
import 'package:bookna_app/features/books/presentation/widget/slider_section.dart';
import 'package:bookna_app/features/books/presentation/widget/popular_books_section.dart';
import 'package:bookna_app/features/books/presentation/widget/top_rated_books_section.dart';
import 'package:bookna_app/features/books/presentation/controller/books_cubit/books_cubit.dart';
import 'package:bookna_app/features/books/presentation/controller/books_cubit/books_state.dart';
import 'package:bookna_app/features/books/presentation/controller/popular_books_cubit/popular_books_cubit.dart';
import 'package:bookna_app/features/books/presentation/controller/popular_books_cubit/popular_books_state.dart';
import 'package:bookna_app/features/books/presentation/controller/top_rated_cubit/top_rated_cubit.dart';
import 'package:bookna_app/features/books/presentation/controller/top_rated_cubit/top_rated_state.dart';

class BooksView extends StatelessWidget {
  const BooksView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: BooksContent());
  }
}

class BooksContent extends StatelessWidget {
  const BooksContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SliderBooksCubit, SliderBooksState>(
      builder: (context, sliderState) {
        return BlocBuilder<PopularBooksCubit, PopularBooksState>(
          builder: (context, popularState) {
            return BlocBuilder<TopRatedBooksCubit, TopRatedBooksState>(
              builder: (context, topRatedState) {
                return _buildBody(
                  context,
                  sliderState,
                  popularState,
                  topRatedState,
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildBody(
    BuildContext context,
    SliderBooksState sliderState,
    PopularBooksState popularState,
    TopRatedBooksState topRatedState,
  ) {
    if (_isAnyLoading(sliderState, popularState, topRatedState)) {
      return const LoadingWidget();
    }

    if (_isAnyError(sliderState, popularState, topRatedState)) {
      final errorMessage = _getFirstErrorMessage(
        sliderState,
        popularState,
        topRatedState,
      );
      return ErrorPage(
        message: errorMessage,
        onRetry: () {
          context.read<SliderBooksCubit>().getSliderBooks();
          context.read<PopularBooksCubit>().getPopularBooksLimited();
          context.read<TopRatedBooksCubit>().getTopRatedBooksLimited();
        },
      );
    }

    if (sliderState is SliderBooksLoaded &&
        popularState is PopularBooksLoaded &&
        topRatedState is TopRatedBooksLoaded) {
      return CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: const [
          SliderSection(),
          PopularBooksSection(),
          TopRatedBooksSection(),
        ],
      );
    }

    return const SizedBox.shrink();
  }

  bool _isAnyLoading(
    SliderBooksState sliderState,
    PopularBooksState popularState,
    TopRatedBooksState topRatedState,
  ) {
    return sliderState is SliderBooksLoading ||
        popularState is PopularBooksLoading ||
        topRatedState is TopRatedBooksLoading;
  }

  bool _isAnyError(
    SliderBooksState sliderState,
    PopularBooksState popularState,
    TopRatedBooksState topRatedState,
  ) {
    return sliderState is SliderBooksError ||
        popularState is PopularBooksError ||
        topRatedState is TopRatedBooksError;
  }

  String _getFirstErrorMessage(
    SliderBooksState sliderState,
    PopularBooksState popularState,
    TopRatedBooksState topRatedState,
  ) {
    if (sliderState is SliderBooksError) return sliderState.message;
    if (popularState is PopularBooksError) return popularState.message;
    if (topRatedState is TopRatedBooksError) return topRatedState.message;
    return 'Unknown error';
  }
}
