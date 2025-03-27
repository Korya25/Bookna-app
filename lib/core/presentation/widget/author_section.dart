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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: AppStrings.author),
        SectionListView(
          height: AppSize.s175,
          itemCount: book.authors.length,
          itemBuilder:
              (context, index) => AuthorCard(
                imageUrl:
                    'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQ1bPYruAQo94dq6zxMcfN2q3maqaQYT0qMoE9Umc_k5AFT1VnY2h26OAP6WB5AXphc2dJ-OSFR4C9LcetqWSEGEw',
                name: book.authors[index],
              ),
        ),
      ],
    );
  }
}
