import 'package:bookna_app/features/books/presentation/widget/popular_books_section.dart';
import 'package:bookna_app/features/books/presentation/widget/slider_section.dart';
import 'package:bookna_app/features/books/presentation/widget/top_rated_books_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookna_app/core/presentation/widget/loading_widget.dart';
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
    return BlocBuilder<SliderBooksCubit, SliderBooksState>(
      builder: (context, sliderState) {
        return BlocBuilder<PopularBooksCubit, PopularBooksState>(
          builder: (context, popularState) {
            return BlocBuilder<TopRatedBooksCubit, TopRatedBooksState>(
              builder: (context, topRatedState) {
                // التحقق مما إذا كان أي قسم في حالة تحميل
                if (sliderState is SliderBooksLoading ||
                    popularState is PopularBooksLoading ||
                    topRatedState is TopRatedBooksLoading) {
                  return const LoadingWidget();
                }

                // إذا لم يتم تحميل أي بيانات، إرجاع شاشة فارغة
                if (sliderState is! SliderBooksLoaded &&
                    popularState is! PopularBooksLoaded &&
                    topRatedState is! TopRatedBooksLoaded) {
                  return const SizedBox.shrink();
                }

                // عرض الأقسام
                return CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    const SliderSection(),
                    const PopularBooksSection(),
                    const TopRatedBooksSection(),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
