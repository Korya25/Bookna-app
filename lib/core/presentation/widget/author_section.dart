import 'package:bookna_app/core/data/network/api_constants.dart';
import 'package:bookna_app/core/presentation/widget/author_card.dart';
import 'package:bookna_app/core/presentation/widget/section_list_view.dart';
import 'package:bookna_app/core/presentation/widget/section_title.dart';
import 'package:bookna_app/core/resources/app_strings.dart';
import 'package:bookna_app/core/resources/app_values.dart';
import 'package:bookna_app/features/books/domain/entities/book.dart';
import 'package:flutter/material.dart';

class AuthorSection extends StatelessWidget {
  const AuthorSection({super.key, required this.book});
  final Book book;
  @override
  Widget build(BuildContext context) {
    return book.authors != null
        ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(title: AppStrings.author),
            SectionListView(
              height: AppSize.s175,
              itemCount: book.authors!.length,
              itemBuilder:
                  (context, index) => AuthorCard(
                    imageUrl: ApiConstants.authorPlaceholder,
                    name: book.authors![index],
                  ),
            ),
          ],
        )
        : const SizedBox.shrink();
  }
}
