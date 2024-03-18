// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goals_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GoalsModelAdapter extends TypeAdapter<GoalsModel> {
  @override
  final int typeId = 2;

  @override
  GoalsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GoalsModel(
      key: fields[2] as String?,
      description: fields[1] as String,
      targetDate: fields[3] as String?,
      title: fields[0] as String,
      step: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, GoalsModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.key)
      ..writeByte(3)
      ..write(obj.targetDate)
      ..writeByte(4)
      ..write(obj.step);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoalsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
