// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookModelAdapter extends TypeAdapter<BookModel> {
  @override
  final int typeId = 0;

  @override
  BookModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookModel(
      id: (fields[0] as num).toInt(),
      title: fields[1] as String,
      authors: (fields[2] as List).cast<AuthorModel>(),
      summaries: (fields[3] as List?)?.cast<String>(),
      languages: (fields[4] as List).cast<String>(),
      subjects: (fields[5] as List).cast<String>(),
      downloadCount: (fields[6] as num).toInt(),
      formats: (fields[7] as Map).cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, BookModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.authors)
      ..writeByte(3)
      ..write(obj.summaries)
      ..writeByte(4)
      ..write(obj.languages)
      ..writeByte(5)
      ..write(obj.subjects)
      ..writeByte(6)
      ..write(obj.downloadCount)
      ..writeByte(7)
      ..write(obj.formats);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookModel _$BookModelFromJson(Map<String, dynamic> json) => BookModel(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  authors:
      (json['authors'] as List<dynamic>)
          .map((e) => AuthorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  summaries:
      (json['summaries'] as List<dynamic>?)?.map((e) => e as String).toList(),
  languages:
      (json['languages'] as List<dynamic>).map((e) => e as String).toList(),
  subjects:
      (json['subjects'] as List<dynamic>).map((e) => e as String).toList(),
  downloadCount: (json['download_count'] as num).toInt(),
  formats: json['formats'] as Map<String, dynamic>,
);

Map<String, dynamic> _$BookModelToJson(BookModel instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'authors': instance.authors,
  'summaries': instance.summaries,
  'languages': instance.languages,
  'subjects': instance.subjects,
  'download_count': instance.downloadCount,
  'formats': instance.formats,
};
