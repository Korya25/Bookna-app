import 'package:bookna_app/core/data/error/exceptions.dart';
import 'package:bookna_app/core/data/network/api_constants.dart';
import 'package:bookna_app/core/data/network/error_message_model.dart';
import 'package:bookna_app/features/books/data/model/author_model/author_model.dart';
import 'package:bookna_app/features/books/domain/entities/author.dart';
import 'package:dio/dio.dart';

abstract class AuthorRemoteDataSource {
  Future<List<Author>> getAuthorWithName(String name);
}

class AuthorRemoteDataSourceImpl implements AuthorRemoteDataSource {
  final Dio dio;

  AuthorRemoteDataSourceImpl(this.dio);

  @override
  Future<List<Author>> getAuthorWithName(String name) async {
    try {
      final response = await dio.get(ApiConstants.getAuthorWithNamePath(name));

      if (response.statusCode == 200) {
        final jsonData = response.data as Map<String, dynamic>;
        final List<dynamic> docs = jsonData['docs'] ?? [];
        return docs
            .map((doc) => AuthorModel.fromJson(doc as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } on DioException catch (e) {
      throw ServerException(
        errorMessageModel: ErrorMessageModel(
          message: e.response?.data['message'] ?? 'Unknown error',
        ),
      );
    }
  }
}
