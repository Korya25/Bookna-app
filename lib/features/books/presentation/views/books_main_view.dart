import 'package:bookna_app/core/utils/setup_services_locator.dart';
import 'package:bookna_app/features/books/data/repo/books_repo_impl.dart';
import 'package:bookna_app/features/books/domain/usecase/get_all_popular_books_use_case.dart';
import 'package:bookna_app/features/books/domain/usecase/get_all_top_rated_books_use_case.dart';
import 'package:bookna_app/features/books/domain/usecase/get_books_use_case.dart';
import 'package:bookna_app/features/books/presentation/controller/books_cubit/books_cubit.dart';
import 'package:bookna_app/features/books/presentation/controller/popular_books_cubit/popular_books_cubit.dart';
import 'package:bookna_app/features/books/presentation/controller/top_rated_cubit/top_rated_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BooksMainView extends StatelessWidget {
  final Widget child;

  const BooksMainView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  SliderBooksCubit(GetBooksUseCase(getIt.get<BooksRepoImpl>()))
                    ..getSliderBooks(),
        ),
        BlocProvider(
          create:
              (context) => PopularBooksCubit(
                GetAllPopularBooksUseCase(getIt.get<BooksRepoImpl>()),
              )..getPopularBooksLimited(),
        ),
        BlocProvider(
          create:
              (context) => TopRatedBooksCubit(
                GetAllTopRatedBooksUseCase(getIt.get<BooksRepoImpl>()),
              )..getTopRatedBooksLimited(),
        ),
      ],
      child: child,
    );
  }
}
