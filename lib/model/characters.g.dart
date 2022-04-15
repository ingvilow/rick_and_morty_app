// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'characters.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CharacterAllAdapter extends TypeAdapter<CharacterAll> {
  @override
  final int typeId = 1;

  @override
  CharacterAll read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CharacterAll(
      id: fields[0] as int?,
      name: fields[1] as String?,
      status: fields[2] as String?,
      species: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CharacterAll obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.species);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharacterAllAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
