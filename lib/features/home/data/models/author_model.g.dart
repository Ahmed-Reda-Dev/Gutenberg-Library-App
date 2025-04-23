// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthorModelAdapter extends TypeAdapter<AuthorModel> {
  @override
  final int typeId = 1;

  @override
  AuthorModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AuthorModel(
      name: fields[0] as String,
      birthYear: (fields[1] as num?)?.toInt(),
      deathYear: (fields[2] as num?)?.toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, AuthorModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.birthYear)
      ..writeByte(2)
      ..write(obj.deathYear);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthorModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthorModel _$AuthorModelFromJson(Map<String, dynamic> json) => AuthorModel(
  name: json['name'] as String,
  birthYear: (json['birth_year'] as num?)?.toInt(),
  deathYear: (json['death_year'] as num?)?.toInt(),
);

Map<String, dynamic> _$AuthorModelToJson(AuthorModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'birth_year': instance.birthYear,
      'death_year': instance.deathYear,
    };
