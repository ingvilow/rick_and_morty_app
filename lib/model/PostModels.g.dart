// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PostModels.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PostModelsAdapter extends TypeAdapter<PostModels> {
  @override
  final int typeId = 1;

  @override
  PostModels read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PostModels(
      name: fields[1] as String?,
      descriptions: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PostModels obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.descriptions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostModelsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
