import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'author_model.dart';

part 'book_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class BookModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final List<AuthorModel> authors;

  @HiveField(3)
  final List<String>? summaries;

  @HiveField(4)
  final Map<String, String> formats;

  @HiveField(5)
  final List<String> subjects;

  @HiveField(6)
  final List<String> languages;

  @HiveField(7)
  final bool copyright;

  @HiveField(8)
  @JsonKey(name: 'media_type')
  final String mediaType;

  @HiveField(9)
  @JsonKey(name: 'download_count')
  final int downloadCount;

  BookModel({
    required this.id,
    required this.title,
    required this.authors,
    this.summaries,
    required this.formats,
    required this.subjects,
    required this.languages,
    required this.copyright,
    required this.mediaType,
    required this.downloadCount,
  });

  String? get coverImageUrl => formats['image/jpeg'];
  String? get firstSummary =>
      summaries?.isNotEmpty == true ? summaries!.first : null;
  String get authorNames => authors.map((a) => a.name).join(', ');

  factory BookModel.fromJson(Map<String, dynamic> json) =>
      _$BookModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookModelToJson(this);
}
