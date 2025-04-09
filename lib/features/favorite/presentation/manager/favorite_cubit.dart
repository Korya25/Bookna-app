import 'package:bookna_app/core/resources/app_strings.dart';
import 'package:bookna_app/features/books/domain/entities/book.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoriteCubit extends Cubit<List<Book>> {
  final Box<Book> _favoritesBox;

  FavoriteCubit() :
      _favoritesBox = Hive.box<Book>(AppStrings.kfavoritesBox),
      super([]) {
    _loadFavorites();
  }

  // تحميل البيانات من Hive
  void _loadFavorites() {
    final favorites = _favoritesBox.values.toList();
    emit(favorites);
  }

  // إضافة كتاب إلى المفضلة
  void addToFavorites(Book book) {
    if (!state.contains(book)) {
      _favoritesBox.add(book); // إضافة الكتاب إلى Hive
      final updatedFavorites = [...state, book];
      emit(updatedFavorites);
    }
  }

  // إزالة كتاب من المفضلة
  void removeFromFavorites(Book book) {
    final key = _getKeyForBook(book);
    if (key != null) {
      _favoritesBox.delete(key); // حذف الكتاب من Hive
      final updatedFavorites = state.where((b) => b != book).toList();
      emit(updatedFavorites);
    }
  }

  // الحصول على المفتاح الخاص بالكتاب في Hive
  int? _getKeyForBook(Book book) {
    for (var i = 0; i < _favoritesBox.length; i++) {
      if (_favoritesBox.getAt(i) == book) {
        return i;
      }
    }
    return null;
  }

  // التحقق مما إذا كان الكتاب موجودًا في المفضلة
  bool isFavorite(Book book) {
    return state.contains(book);
  }
}