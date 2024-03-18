// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memories_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MemoriesModelAdapter extends TypeAdapter<MemoriesModel> {
  @override
  final int typeId = 4;

  @override
  MemoriesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MemoriesModel(
      mkey: fields[2] as String?,
      title: fields[0] as String,
      images: (fields[1] as List).cast<String?>(),
      mainImage: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MemoriesModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.images)
      ..writeByte(2)
      ..write(obj.mkey)
      ..writeByte(3)
      ..write(obj.mainImage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MemoriesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
