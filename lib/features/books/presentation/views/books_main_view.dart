import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookna_app/core/utils/setup_services_locator.dart';
import 'package:bookna_app/features/books/data/repo/books_repo_impl.dart';
import 'package:bookna_app/features/books/domain/usecase/get_all_popular_books_use_case.dart';
import 'package:bookna_app/features/books/domain/usecase/get_all_top_rated_books_use_case.dart';
import 'package:bookna_app/features/books/domain/usecase/get_books_use_case.dart';
import 'package:bookna_app/features/books/presentation/controller/books_cubit/books_cubit.dart';
import 'package:bookna_app/features/books/presentation/controller/popular_books_cubit/popular_books_cubit.dart';
import 'package:bookna_app/features/books/presentation/controller/top_rated_cubit/top_rated_cubit.dart';

class BooksScope extends StatefulWidget {
  const BooksScope({super.key, required this.child});
  final Widget child;

  @override
  State<BooksScope> createState() => _BooksScopeState();
}

class _BooksScopeState extends State<BooksScope>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      debugPrint('BooksFeatureScope initialized');
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final cubit = SliderBooksCubit(
              GetBooksUseCase(getIt.get<BooksRepoImpl>()),
            );
            WidgetsBinding.instance.addPostFrameCallback((_) {
              cubit.getSliderBooks().catchError((e) {
                debugPrint('SliderBooks Error: $e');
              });
            });
            return cubit;
          },
        ),
        BlocProvider(
          create: (context) {
            final cubit = PopularBooksCubit(
              GetAllPopularBooksUseCase(getIt.get<BooksRepoImpl>()),
            );
            WidgetsBinding.instance.addPostFrameCallback((_) {
              cubit.getPopularBooksLimited().catchError((e) {
                debugPrint('PopularBooks Error: $e');
              });
            });
            return cubit;
          },
        ),
        BlocProvider(
          create: (context) {
            final cubit = TopRatedBooksCubit(
              GetAllTopRatedBooksUseCase(getIt.get<BooksRepoImpl>()),
            );
            WidgetsBinding.instance.addPostFrameCallback((_) {
              cubit.getTopRatedBooksLimited().catchError((e) {
                debugPrint('TopRatedBooks Error: $e');
              });
            });
            return cubit;
          },
        ),
      ],
      child: widget.child,
    );
  }
}
