import 'package:bookna_app/core/presentation/views/main_view.dart';
import 'package:bookna_app/core/resources/app_routes.dart';
import 'package:bookna_app/features/books/domain/entities/book.dart';
import 'package:bookna_app/features/books/presentation/views/book_details_view.dart';
import 'package:bookna_app/features/books/presentation/views/books_main_view.dart';
import 'package:bookna_app/features/books/presentation/views/books_view.dart';
import 'package:bookna_app/features/books/presentation/views/popular_books_view.dart';
import 'package:bookna_app/features/books/presentation/views/top_rated_books_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const String booksPath = '/books';
const String booksDetailsPath = 'details/:bookId';
const String popularBooksPath = 'popular';
const String topRatedBooksPath = 'top-rated';
const String novelsPath = '/novels';
const String popularNovelsPath = '/popularNovels';
const String topRatedNovelsPath = '/top-ratedNovels';
const String novelsDetailsPath = 'details/:novelId';
const String favoritePath = '/favorite';
const String searchPath = '/search';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: booksPath,
    routes: [
      ShellRoute(
        builder: (context, state, child) => MainView(child: child),
        routes: [
          ShellRoute(
            builder: (context, state, child) => BooksMainView(child: child),
            routes: [
              GoRoute(
                path: booksPath,
                name: AppRoutes.booksRoute,
                pageBuilder:
                    (context, state) =>
                        const NoTransitionPage(child: BooksView()),
                routes: [
                  GoRoute(
                    path: booksDetailsPath,
                    name: AppRoutes.bookDetailsRoute,
                    pageBuilder: (context, state) {
                      final book = state.extra as Book;
                      return CupertinoPage(child: BookDetailsView(book: book));
                    },
                  ),
                  GoRoute(
                    path: popularBooksPath,
                    name: AppRoutes.popularBooksRoute,
                    pageBuilder:
                        (context, state) =>
                            const NoTransitionPage(child: PopularBooksView()),
                  ),
                  GoRoute(
                    path: topRatedBooksPath,
                    name: AppRoutes.topRatedBooksRoute,
                    pageBuilder:
                        (context, state) =>
                            const NoTransitionPage(child: TopRatedBooksView()),
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: favoritePath,
            name: AppRoutes.favoriteRoute,
            pageBuilder:
                (context, state) => const NoTransitionPage(
                  child: Scaffold(body: Center(child: Text('Favorite'))),
                ),
          ),
          GoRoute(
            path: searchPath,
            name: AppRoutes.searchRoute,
            pageBuilder:
                (context, state) => const NoTransitionPage(
                  child: Scaffold(body: Center(child: Text('Search'))),
                ),
          ),
        ],
      ),
    ],
    errorPageBuilder:
        (context, state) => const MaterialPage(
          child: Scaffold(body: Center(child: Text('Page not found'))),
        ),
  );
}
