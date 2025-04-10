import 'package:bookna_app/core/resources/app_colors.dart';
import 'package:bookna_app/core/resources/app_values.dart';
import 'package:bookna_app/features/books/domain/entities/book.dart';
import 'package:bookna_app/features/favorite/presentation/controller/favorite_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteIconBlocBuilder extends StatelessWidget {
  const FavoriteIconBlocBuilder({
    super.key,
    required this.book,
    this.iconSize = AppSize.s24,
  });

  final Book book;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, List<Book>>(
      builder: (context, favoriteBooks) {
        final isFavorite = context.read<FavoriteCubit>().isFavorite(book);

        return InkWell(
          onTap: () {
            if (isFavorite) {
              context.read<FavoriteCubit>().removeFromFavorites(book);
            } else {
              context.read<FavoriteCubit>().addToFavorites(book);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(AppPadding.p8),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.iconContainerColor,
            ),
            child: Icon(
              Icons.bookmark_rounded,
              color: isFavorite ? Colors.red : null,
              size: iconSize,
            ),
          ),
        );
      },
    );
  }
}
