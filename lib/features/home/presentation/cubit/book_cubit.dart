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
    // If we're refreshing, reset to initial state
    if (refresh) {
      emit(const BookState.loading());
    } else // Check if state is the success variant from BookState
    if (state is Success) {
      final currentState = state as Success;

      // Don't fetch more if we've reached the max
      if (currentState.hasReachedMax) return;
    }

    final int nextPage =
        (state is Success) ? (state as Success).currentPage + 1 : 1;

    // Try to load from cache first if it's the first page
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
          // Return early to avoid showing the loading state
          // The user will still see fresh data when the network request completes
        }
      } catch (_) {
        // Ignore cache errors and continue with network request
      }
    }

    // Show loading state for the first page or if we're refreshing
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

    // Always reset to loading state for a new search
    if (refresh) {
      emit(const BookState.loading());
    } else if (state is Success) {
      final currentState = state as Success;

      // If it's a new search query, reset to loading
      if (currentState.searchQuery != query) {
        emit(const BookState.loading());
      } else if (currentState.hasReachedMax) {
        // Don't fetch more if we've reached the max for this search
        return;
      }
    }

    final int nextPage =
        (state is Success && (state as Success).searchQuery == query)
            ? (state as Success).currentPage + 1
            : 1;

    // Show loading state for the first page of a search
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

      // If we're paginating, combine the existing books with the new ones
      if (state is Success && page > 1) {
        allBooks.addAll((state as Success).books);
      }

      allBooks.addAll(newBooks);

      // Cache books if this is a fresh load (first page) and not a search
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

      // If we have books in the state already (pagination failure),
      // keep the existing state but maybe show a snackbar
      if (state is Success && page > 1) {
        // Keep the current state but maybe show a message to the user
      } else {
        emit(BookState.error(errorMsg));
      }
    }
  }

  void resetSearch() {
    if (state is Success && (state as Success).searchQuery != null) {
      getBooks(refresh: true);
    }
  }
}
