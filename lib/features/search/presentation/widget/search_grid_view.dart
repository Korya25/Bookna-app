import 'package:bookna_app/core/resources/app_values.dart';
import 'package:bookna_app/features/search/presentation/widget/grid_view_card.dart';
import 'package:flutter/material.dart';

class SearchGridView extends StatelessWidget {
  const SearchGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(vertical: AppPadding.p12),
        itemCount: 10,
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          childAspectRatio: 0.55,
        ),
        itemBuilder: (context, index) {
          return GridViewCard();
        },
      ),
    );
  }
}
