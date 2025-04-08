import 'package:bookna_app/core/presentation/views/main_view.dart';
import 'package:bookna_app/core/resources/app_routes.dart';
import 'package:bookna_app/features/books/domain/entities/book.dart';
import 'package:bookna_app/features/books/presentation/views/author_info_view.dart';
import 'package:bookna_app/features/books/presentation/views/book_details_view.dart';
import 'package:bookna_app/features/books/presentation/views/books_main_view.dart';
import 'package:bookna_app/features/books/presentation/views/books_view.dart';
import 'package:bookna_app/features/books/presentation/views/popular_books_view.dart';
import 'package:bookna_app/features/books/presentation/views/top_rated_books_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();
  static final _booksNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppPaths.books,
    debugLogDiagnostics: true,
    routes: [
      // Main shell route with bottom navigation
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => MainView(child: child),
        routes: [
          // Books section with nested navigation
          ShellRoute(
            navigatorKey: _booksNavigatorKey,
            builder: (context, state, child) => BooksMainView(child: child),
            routes: [
              GoRoute(
                path: AppPaths.books,
                name: AppRoutes.books,
                pageBuilder:
                    (context, state) =>
                        const NoTransitionPage(child: BooksView()),
                routes: [
                  GoRoute(
                    path: AppPaths.bookDetails,
                    name: AppRoutes.bookDetails,
                    pageBuilder: (context, state) {
                      final book = state.extra as Book;
                      return _buildPageWithFadeTransition(
                        child: BookDetailsView(book: book),
                        key: ValueKey('book-${book.bookId}'),
                      );
                    },
                  ),
                  GoRoute(
                    path: AppPaths.popularBooks,
                    name: AppRoutes.popularBooks,
                    pageBuilder:
                        (context, state) =>
                            const NoTransitionPage(child: PopularBooksView()),
                  ),
                  GoRoute(
                    path: AppPaths.topRatedBooks,
                    name: AppRoutes.topRatedBooks,
                    pageBuilder:
                        (context, state) =>
                            const NoTransitionPage(child: TopRatedBooksView()),
                  ),
                  GoRoute(
                    path: AppPaths.authorInfo,
                    name: AppRoutes.authorInfo,
                    pageBuilder: (context, state) {
                      final author = state.extra as String;
                      return _buildPageWithFadeTransition(
                        child: AuthorInfoView(authorName: author),
                        key: ValueKey('author-$author'),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),

          // Favorite section
          GoRoute(
            path: AppPaths.favorite,
            name: AppRoutes.favorite,
            pageBuilder:
                (context, state) => const NoTransitionPage(
                  child: Scaffold(body: Center(child: Text('Favorite'))),
                ),
          ),

          // Search section
          GoRoute(
            path: AppPaths.search,
            name: AppRoutes.search,
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

  static Page _buildPageWithFadeTransition({
    required Widget child,
    required ValueKey key,
  }) {
    return CustomTransitionPage(
      key: key,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}
