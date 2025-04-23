import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/book_model.dart';

part 'book_state.freezed.dart';

@freezed
class BookState with _$BookState {
  const factory BookState.initial() = Initial;

  const factory BookState.loading() = Loading;

  const factory BookState.success({
    required List<BookModel> books,
    required bool hasReachedMax,
    required int currentPage,
    String? searchQuery,
  }) = Success;

  const factory BookState.error(String message) = Error;
}
