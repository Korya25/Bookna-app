import 'package:bookna_app/core/resources/app_routes.dart';
import 'package:bookna_app/features/books/domain/entities/book.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<Object?> navigateToDetailsView(
  BuildContext context,
  bool isBook,
  Book book,
) {
  if (isBook) {
    return context.pushNamed(
      AppRoutes.bookDetailsRoute,
      pathParameters: {
        'bookId': book.bookId,
      }, // Provide the required path parameter
      extra: book, // Pass the entire book object
    );
  } else {
    return context.pushNamed(
      AppRoutes.novelsDetailsRoute,
      pathParameters: {'novelId': book.bookId}, // For novels
      extra: book,
    );
  }
}
