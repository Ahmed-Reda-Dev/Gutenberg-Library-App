import '../../../../core/networking/api_result.dart';
import '../repositories/book_repository.dart';
import '../../data/models/books_response.dart';
import '../../data/models/book_model.dart';

class GetBooksUseCase {
  final BookRepository _repository;

  GetBooksUseCase(this._repository);

  Future<ApiResult<BooksResponse>> call({int? page}) async {
    return await _repository.getBooks(page: page);
  }

  Future<List<BookModel>> getCachedBooks() async {
    return await _repository.getCachedBooks();
  }

  Future<void> cacheBooks(List<BookModel> books) async {
    await _repository.cacheBooks(books);
  }
}
