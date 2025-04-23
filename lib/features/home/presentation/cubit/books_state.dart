import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/book_model.dart';

part 'books_state.freezed.dart';

@freezed
sealed class BooksState with _$BooksState {
  const factory BooksState.initial() = _Initial;
  const factory BooksState.loading() = _Loading;
  const factory BooksState.success({
    required List<BookModel> books,
    required bool hasReachedMax,
    String? nextPageUrl,
  }) = _Success;
  const factory BooksState.error(String message) = _Error;
}
