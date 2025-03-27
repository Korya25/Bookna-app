import 'package:bookna_app/features/books/data/datasource/books_remote_data_source.dart';
import 'package:bookna_app/features/books/data/repo/books_repo_impl.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServicesLocator() {
  getIt.registerSingleton<BooksRepoImpl>(
    BooksRepoImpl(booksRemoteDataSource: BooksRemoteDataSourceImpl()),
  );
}
