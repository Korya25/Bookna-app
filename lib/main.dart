import 'package:bookna_app/core/resources/app_router.dart';
import 'package:bookna_app/core/resources/app_strings.dart';
import 'package:bookna_app/core/resources/app_theme.dart';
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

void main() {
  setupServicesLocator();

  runApp(const BooknaApp());
}

class BooknaApp extends StatelessWidget {
  const BooknaApp({super.key});

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
              )..getPopularBooks(1),
        ),
        BlocProvider(
          create:
              (context) => TopRatedBooksCubit(
                GetAllTopRatedBooksUseCase(getIt.get<BooksRepoImpl>()),
              )..getTopRatedBooks(1),
        ),
      ],
      child: MaterialApp.router(
        title: AppStrings.appTitle,
        debugShowCheckedModeBanner: false,
        theme: getApplicationTheme(),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
