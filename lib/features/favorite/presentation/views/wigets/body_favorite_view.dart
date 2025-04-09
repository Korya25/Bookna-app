import 'package:bookna_app/core/presentation/widget/vertical_list_view.dart';
import 'package:bookna_app/core/presentation/widget/vertical_list_view_card.dart';
import 'package:bookna_app/features/books/domain/entities/book.dart';

import 'package:bookna_app/features/favorite/presentation/manager/favorite_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BodyFavoriteView extends StatefulWidget {
  const BodyFavoriteView({super.key});

  @override
  State<BodyFavoriteView> createState() => _BodyFavoriteViewState();
}

class _BodyFavoriteViewState extends State<BodyFavoriteView> {
  void _fetchMoreBooks() {
    if (context.read<FavoriteCubit>().state.isNotEmpty) {
      context.read<FavoriteCubit>();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, List<Book>>(
      builder: (context, favoriteBooks) {
        if (favoriteBooks.isEmpty) {
          return Center(
            child: Text(
              'No favorite books yet!',
              style: TextStyle(fontSize: 18),
            ),
          );
        }

        return VerticalListView(
          itemCount: favoriteBooks.length,
          itemBuilder:
              (context, index) => VerticalListViewCard(
                isBook: true,
                book: favoriteBooks[index],
              ),
          onScrollEnd: () => _fetchMoreBooks(),
        );
      },
    );
  }
}
