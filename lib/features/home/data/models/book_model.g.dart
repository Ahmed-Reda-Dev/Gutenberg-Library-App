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
      formats: (fields[4] as Map).cast<String, String>(),
      subjects: (fields[5] as List).cast<String>(),
      languages: (fields[6] as List).cast<String>(),
      copyright: fields[7] as bool,
      mediaType: fields[8] as String,
      downloadCount: (fields[9] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, BookModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.authors)
      ..writeByte(3)
      ..write(obj.summaries)
      ..writeByte(4)
      ..write(obj.formats)
      ..writeByte(5)
      ..write(obj.subjects)
      ..writeByte(6)
      ..write(obj.languages)
      ..writeByte(7)
      ..write(obj.copyright)
      ..writeByte(8)
      ..write(obj.mediaType)
      ..writeByte(9)
      ..write(obj.downloadCount);
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
  formats: Map<String, String>.from(json['formats'] as Map),
  subjects:
      (json['subjects'] as List<dynamic>).map((e) => e as String).toList(),
  languages:
      (json['languages'] as List<dynamic>).map((e) => e as String).toList(),
  copyright: json['copyright'] as bool,
  mediaType: json['media_type'] as String,
  downloadCount: (json['download_count'] as num).toInt(),
);

Map<String, dynamic> _$BookModelToJson(BookModel instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'authors': instance.authors,
  'summaries': instance.summaries,
  'formats': instance.formats,
  'subjects': instance.subjects,
  'languages': instance.languages,
  'copyright': instance.copyright,
  'media_type': instance.mediaType,
  'download_count': instance.downloadCount,
};
