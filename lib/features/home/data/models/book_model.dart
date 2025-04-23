import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

import 'author_model.dart';


part 'book_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class BookModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final List<AuthorModel> authors;

  @HiveField(3)
  final List<String>? summaries;

  @HiveField(4)
  final List<String> languages;

  @HiveField(5)
  final List<String> subjects;

  @HiveField(6)
  @JsonKey(name: 'download_count')
  final int downloadCount;

  @HiveField(7)
  final Map<String, dynamic> formats;

  BookModel({
    required this.id,
    required this.title,
    required this.authors,
    this.summaries,
    required this.languages,
    required this.subjects,
    required this.downloadCount,
    required this.formats,
  });

  String? get coverImageUrl => formats['image/jpeg'] as String?;
  String? get summary =>
      summaries?.isNotEmpty == true ? summaries?.first : null;
  List<String> get authorNames => authors.map((author) => author.name).toList();

  factory BookModel.fromJson(Map<String, dynamic> json) =>
      _$BookModelFromJson(json);
  Map<String, dynamic> toJson() => _$BookModelToJson(this);
}
