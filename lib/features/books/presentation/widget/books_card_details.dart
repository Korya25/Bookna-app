import 'package:bookna_app/core/presentation/widget/circle_dot.dart';
import 'package:bookna_app/core/utils/functions/format_date.dart';
import 'package:bookna_app/features/books/domain/entities/book.dart';
import 'package:flutter/material.dart';

class BooksCardDetails extends StatelessWidget {
  const BooksCardDetails({super.key, required this.book});
  final Book book;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    if (book.publishedDate != null &&
        book.categories != null &&
        book.pageCount != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (book.publishedDate != null) ...[
                Text(
                  formatDate(book.publishedDate),
                  style: textTheme.bodyLarge,
                ),
                const CircleDot(),
              ],
              if (book.categories != null) ...[
                Text(
                  book.categories?.first.toString() ?? '',
                  style: textTheme.bodyLarge,
                ),
              ],
            ],
          ),
          if (book.pageCount != null)
            Text("${book.pageCount} Page", style: textTheme.bodyLarge),
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}
