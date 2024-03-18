// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goals_main_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GoalsMainModelAdapter extends TypeAdapter<GoalsMainModel> {
  @override
  final int typeId = 1;

  @override
  GoalsMainModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GoalsMainModel(
      key: fields[2] as String?,
      goalList: (fields[1] as List).cast<GoalsModel>(),
      goalTitle: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, GoalsMainModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.goalTitle)
      ..writeByte(1)
      ..write(obj.goalList)
      ..writeByte(2)
      ..write(obj.key);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoalsMainModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
