import 'package:dio/dio.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';
import '../models/book_model.dart';
import '../models/books_response.dart';
import '../../domain/repositories/book_repository.dart';

class BookRepositoryImpl implements BookRepository {
  final ApiService _apiService;
  final Box<BookModel> _booksBox;

  BookRepositoryImpl(this._apiService, this._booksBox);

  @override
  Future<ApiResult<BooksResponse>> getBooks({int? page}) async {
    try {
      final response = await _apiService.getBooks(page: page);
      return ApiResult.success(response);
    } catch (error) {
      if (error is DioException) {
        return ApiResult.failure(
          ApiErrorHandler.handle(error).message ?? 'Unknown error occurred',
        );
      }
      return ApiResult.failure(error.toString());
    }
  }

  @override
  Future<ApiResult<BooksResponse>> searchBooks({
    required String query,
    int? page,
  }) async {
    try {
      final response = await _apiService.getBooks(query: query, page: page);
      return ApiResult.success(response);
    } catch (error) {
      if (error is DioException) {
        return ApiResult.failure(
          ApiErrorHandler.handle(error).message ?? 'Unknown error occurred',
        );
      }
      return ApiResult.failure(error.toString());
    }
  }

  @override
  Future<List<BookModel>> getCachedBooks() async {
    return _booksBox.values.toList();
  }

  @override
  Future<void> cacheBooks(List<BookModel> books) async {
    for (var book in books) {
      await _booksBox.put(book.id.toString(), book);
    }
  }
}
