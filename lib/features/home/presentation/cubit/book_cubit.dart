import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/networking/api_result.dart' as api_result;
import '../../data/models/book_model.dart';
import '../../domain/usecases/get_books_usecase.dart';
import '../../domain/usecases/search_books_usecase.dart';
import 'book_state.dart';

class BookCubit extends Cubit<BookState> {
  final GetBooksUseCase _getBooksUseCase;
  final SearchBooksUseCase _searchBooksUseCase;

  BookCubit(this._getBooksUseCase, this._searchBooksUseCase)
    : super(const BookState.initial());
  Future<void> getBooks({bool refresh = false}) async {
    if (refresh) {
      emit(const BookState.loading());
    } else if (state is Success) {
      final currentState = state as Success;

      if (currentState.hasReachedMax) return;
    }

    final int nextPage =
        (state is Success) ? (state as Success).currentPage + 1 : 1;

    if (nextPage == 1) {
      try {
        final cachedBooks = await _getBooksUseCase.getCachedBooks();
        if (cachedBooks.isNotEmpty) {
          emit(
            BookState.success(
              books: cachedBooks,
              hasReachedMax: false,
              currentPage: 0,
              searchQuery: null,
            ),
          );
        }
      } catch (_) {}
    }

    if (nextPage == 1 || refresh) {
      emit(const BookState.loading());
    }

    final result = await _getBooksUseCase(page: nextPage);

    _handleApiResult(result, nextPage);
  }

  Future<void> searchBooks(String query, {bool refresh = false}) async {
    if (query.isEmpty) {
      getBooks(refresh: true);
      return;
    }

    if (refresh) {
      emit(const BookState.loading());
    } else if (state is Success) {
      final currentState = state as Success;

      if (currentState.searchQuery != query) {
        emit(const BookState.loading());
      } else if (currentState.hasReachedMax) {
        return;
      }
    }

    final int nextPage =
        (state is Success && (state as Success).searchQuery == query)
            ? (state as Success).currentPage + 1
            : 1;

    if (nextPage == 1) {
      emit(const BookState.loading());
    }

    final result = await _searchBooksUseCase(query: query, page: nextPage);

    _handleApiResult(result, nextPage, searchQuery: query);
  }

  void _handleApiResult(
    api_result.ApiResult<dynamic> result,
    int page, {
    String? searchQuery,
  }) {
    if (result is api_result.Success) {
      final data = (result).data;
      final newBooks = data.results;
      final List<BookModel> allBooks = [];

      if (state is Success && page > 1) {
        allBooks.addAll((state as Success).books);
      }

      allBooks.addAll(newBooks);

      if (page == 1 && searchQuery == null) {
        _getBooksUseCase.cacheBooks(newBooks);
      }

      emit(
        BookState.success(
          books: allBooks,
          hasReachedMax: data.next == null,
          currentPage: page,
          searchQuery: searchQuery,
        ),
      );
    } else if (result is api_result.Failure) {
      final errorMsg = (result).error;

      if (state is Success && page > 1) {
      } else {
        if (page == 1 && searchQuery == null) {
          _loadFromCacheOnError();
        } else {
          emit(BookState.error(errorMsg));
        }
      }
    }
  }

  void resetSearch() {
    if (state is Success && (state as Success).searchQuery != null) {
      getBooks(refresh: true);
    }
  }

  Future<void> _loadFromCacheOnError() async {
    try {
      final cachedBooks = await _getBooksUseCase.getCachedBooks();
      if (cachedBooks.isNotEmpty) {
        emit(
          BookState.success(
            books: cachedBooks,
            hasReachedMax: true,
            currentPage: 0,
            searchQuery: null,
          ),
        );
      } else {
        emit(
          const BookState.error(
            "No internet connection and no cached data available",
          ),
        );
      }
    } catch (e) {
      emit(BookState.error("Failed to load cached data: ${e.toString()}"));
    }
  }
}
