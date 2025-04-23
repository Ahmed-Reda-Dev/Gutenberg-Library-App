import '../../../../core/networking/api_result.dart';
import '../repositories/book_repository.dart';
import '../../data/models/books_response.dart';

class SearchBooksUseCase {
  final BookRepository _repository;

  SearchBooksUseCase(this._repository);

  Future<ApiResult<BooksResponse>> call({
    required String query,
    int? page,
  }) async {
    return await _repository.searchBooks(query: query, page: page);
  }
}
