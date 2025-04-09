
import 'package:bookna_app/core/presentation/widget/custom_app_bar.dart';

import 'package:bookna_app/core/resources/app_strings.dart';
import 'package:bookna_app/features/favorite/presentation/views/wigets/body_favorite_view.dart';
import 'package:flutter/material.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
  //    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar:  const CustomAppBar(title: AppStrings.favorite),
      body: BodyFavoriteView(),
    );
  }
}
