import 'package:bookna_app/core/data/error/exceptions.dart';
import 'package:bookna_app/core/data/error/failure.dart';
import 'package:bookna_app/features/books/data/datasource/author_remote_data_source_impl.dart';
import 'package:bookna_app/features/books/domain/entities/author.dart';
import 'package:bookna_app/features/books/domain/repo/author_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AuthorRepositoryImpl implements AuthorRepo {
  final AuthorRemoteDataSource authorRemoteDataSource;

  AuthorRepositoryImpl({required this.authorRemoteDataSource});

  @override
  Future<Either<Failure, List<Author>>> getAuthorWithName(String name) async {
    try {
      final result = await authorRemoteDataSource.getAuthorWithName(name);
      return Right(result);
    } on ServerException catch (e) {
      // Map ServerException to ServerFailure with detailed message
      return Left(ServerFailure(e.errorMessageModel.message));
    } on DioException catch (e) {
      // Handle Dio-specific errors with more detail
      final message =
          e.response?.data != null
              ? 'API Error: ${e.response?.statusCode} - ${e.response?.data}'
              : e.message ?? 'Unknown network error';
      return Left(ServerFailure(message));
    } catch (e) {
      // Catch any other unexpected errors
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }
}
