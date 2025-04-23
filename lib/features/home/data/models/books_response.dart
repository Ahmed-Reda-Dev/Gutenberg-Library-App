import 'package:json_annotation/json_annotation.dart';

import 'book_model.dart';

part 'books_response.g.dart';

@JsonSerializable()
class BooksResponse {
  final int count;
  final String? next;
  final String? previous;
  final List<BookModel> results;

  BooksResponse({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory BooksResponse.fromJson(Map<String, dynamic> json) =>
      _$BooksResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BooksResponseToJson(this);
}
