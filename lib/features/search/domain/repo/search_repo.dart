import 'package:bookna_app/core/data/error/failure.dart';
import 'package:bookna_app/features/search/domain/entities/search_result_item.dart';
import 'package:dartz/dartz.dart';

abstract class SearchRepo {
  Future<Either<Failure, List<SearchResultItem>>> searchBooks(String title);
}
