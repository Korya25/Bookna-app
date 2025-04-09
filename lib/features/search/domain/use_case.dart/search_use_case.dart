import 'package:bookna_app/core/data/error/failure.dart';
import 'package:bookna_app/core/domain/usecase/base_use_case.dart';
import 'package:bookna_app/features/search/domain/entities/search_result_item.dart';
import 'package:bookna_app/features/search/domain/repo/search_repo.dart';
import 'package:dartz/dartz.dart';

class SearchUseCase extends BaseUseCase<List<SearchResultItem>, String> {
  final SearchRepo searchRepo;

  SearchUseCase(this.searchRepo);
  @override
  Future<Either<Failure, List<SearchResultItem>>> call(String p) async {
    return await searchRepo.searchBooks(p);
  }
}
