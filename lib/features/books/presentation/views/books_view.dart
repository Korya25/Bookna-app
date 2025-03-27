import 'package:bookna_app/core/presentation/widget/custom_slider.dart';
import 'package:bookna_app/core/presentation/widget/section_header.dart';
import 'package:bookna_app/core/presentation/widget/section_list_view.dart';
import 'package:bookna_app/core/presentation/widget/section_list_view_card.dart';
import 'package:bookna_app/core/presentation/widget/slider_card.dart';
import 'package:bookna_app/core/resources/app_routes.dart';
import 'package:bookna_app/core/resources/app_strings.dart';
import 'package:bookna_app/core/resources/app_values.dart';
import 'package:bookna_app/features/books/presentation/controller/books_cubit/books_cubit.dart';
import 'package:bookna_app/features/books/presentation/controller/books_cubit/books_state.dart';
import 'package:bookna_app/features/books/presentation/controller/popular_books_cubit/popular_books_cubit.dart';
import 'package:bookna_app/features/books/presentation/controller/popular_books_cubit/popular_books_state.dart';
import 'package:bookna_app/features/books/presentation/controller/top_rated_cubit/top_rated_cubit.dart';
import 'package:bookna_app/features/books/presentation/controller/top_rated_cubit/top_rated_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BooksView extends StatelessWidget {
  const BooksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<SliderBooksCubit, SliderBooksState>(
            listener: (context, state) {
              if (state is SliderBooksError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
          ),
          BlocListener<PopularBooksCubit, PopularBooksState>(
            listener: (context, state) {
              if (state is PopularBooksError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
          ),
          BlocListener<TopRatedBooksCubit, TopRatedBooksState>(
            listener: (context, state) {
              if (state is TopRatedBooksError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
          ),
        ],
        child: const BooksWidget(),
      ),
    );
  }
}

class BooksWidget extends StatelessWidget {
  const BooksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // Slider Section
        BlocBuilder<SliderBooksCubit, SliderBooksState>(
          builder: (context, state) {
            if (state is SliderBooksLoading) {
              return const SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (state is SliderBooksLoaded) {
              return SliverToBoxAdapter(
                child: CustomSlider(
                  itemBuilder: (BuildContext context, int itemIndex, _) {
                    return SliderCard(
                      itemIndex: itemIndex,
                      isBook: true,
                      book: state.books[itemIndex],
                    );
                  },
                ),
              );
            } else {
              return const SliverToBoxAdapter(child: SizedBox.shrink());
            }
          },
        ),

        // Popular Books Section
        SliverToBoxAdapter(
          child: SectionHeader(
            title: AppStrings.popularBooks,
            onSeeAllTap: () {
              context.goNamed(AppRoutes.popularBooksRoute);
            },
          ),
        ),
        BlocBuilder<PopularBooksCubit, PopularBooksState>(
          builder: (context, state) {
            if (state is PopularBooksLoading) {
              return const SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (state is PopularBooksLoaded) {
              return SliverToBoxAdapter(
                child: SectionListView(
                  height: AppSize.s240,
                  itemCount: state.books.length,
                  itemBuilder: (context, index) {
                    return SectionListViewCard(
                      isBook: true,
                      book: state.books[index],
                    );
                  },
                ),
              );
            } else {
              return const SliverToBoxAdapter(child: SizedBox.shrink());
            }
          },
        ),

        // Top Rated Books Section
        SliverToBoxAdapter(
          child: SectionHeader(
            title: AppStrings.topRatedBooks,
            onSeeAllTap: () {
              context.goNamed(AppRoutes.topRatedBooksRoute);
            },
          ),
        ),
        BlocBuilder<TopRatedBooksCubit, TopRatedBooksState>(
          builder: (context, state) {
            if (state is TopRatedBooksLoading) {
              return const SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (state is TopRatedBooksLoaded) {
              return SliverToBoxAdapter(
                child: SectionListView(
                  height: AppSize.s240,
                  itemCount: state.books.length,
                  itemBuilder: (context, index) {
                    return SectionListViewCard(
                      isBook: true,
                      book: state.books[index],
                    );
                  },
                ),
              );
            } else {
              return const SliverToBoxAdapter(child: SizedBox.shrink());
            }
          },
        ),
      ],
    );
  }
}
