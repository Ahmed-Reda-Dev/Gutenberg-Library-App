import 'package:json_annotation/json_annotation.dart';

import 'package:hive_ce_flutter/hive_flutter.dart';
part 'author_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class AuthorModel extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  @JsonKey(name: 'birth_year')
  final int? birthYear;

  @HiveField(2)
  @JsonKey(name: 'death_year')
  final int? deathYear;

  AuthorModel({required this.name, this.birthYear, this.deathYear});

  factory AuthorModel.fromJson(Map<String, dynamic> json) =>
      _$AuthorModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorModelToJson(this);
}
