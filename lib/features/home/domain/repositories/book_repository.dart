import '../../../../core/networking/api_result.dart';
import '../../data/models/book_model.dart';
import '../../data/models/books_response.dart';

abstract class BookRepository {
  Future<ApiResult<BooksResponse>> getBooks({int? page});
  Future<ApiResult<BooksResponse>> searchBooks({
    required String query,
    int? page,
  });
  Future<List<BookModel>> getCachedBooks();
  Future<void> cacheBooks(List<BookModel> books);
}
