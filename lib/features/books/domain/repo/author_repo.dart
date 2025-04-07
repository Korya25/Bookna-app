import 'package:bookna_app/core/data/error/failure.dart';
import 'package:bookna_app/features/books/domain/entities/book.dart';
import 'package:dartz/dartz.dart';

abstract class AuthorRepo {
  Future<Either<Failure, List<Book>>> getAuthorWithName(String name);
}
