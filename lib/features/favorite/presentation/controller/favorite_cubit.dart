import 'package:bookna_app/core/resources/app_strings.dart';
import 'package:bookna_app/features/books/domain/entities/book.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoriteCubit extends Cubit<List<Book>> {
  final Box<Book> _favoritesBox;

  FavoriteCubit()
    : _favoritesBox = Hive.box<Book>(AppStrings.favoritesBox),
      super([]) {
    _loadFavorites();
  }

  void _loadFavorites() {
    final favorites = _favoritesBox.values.toList();
    emit(favorites);
  }

  void addToFavorites(Book book) {
    if (!state.contains(book)) {
      _favoritesBox.add(book);
      emit([...state, book]);
    }
  }

  void removeFromFavorites(Book book) {
    final key = _getKeyForBook(book);
    if (key != null) {
      _favoritesBox.delete(key);
      emit(state.where((b) => b != book).toList());
    }
  }

  void clearAllFavorites() {
    _favoritesBox.clear();
    emit([]);
  }

  bool isFavorite(Book book) {
    return state.contains(book);
  }

  int? _getKeyForBook(Book book) {
    final bookMap = _favoritesBox.toMap();
    for (final entry in bookMap.entries) {
      if (entry.value == book) {
        return entry.key as int;
      }
    }
    return null;
  }
}
