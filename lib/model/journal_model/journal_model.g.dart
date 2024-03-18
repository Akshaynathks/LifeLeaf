// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JournalModelAdapter extends TypeAdapter<JournalModel> {
  @override
  final int typeId = 3;

  @override
  JournalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return JournalModel(
      journalkey: fields[2] as String?,
      journalTitle: fields[0] as String?,
      journalNotes: fields[1] as String,
      journalDate: fields[3] as String?,
      images: (fields[4] as List).cast<String?>(),
    );
  }

  @override
  void write(BinaryWriter writer, JournalModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.journalTitle)
      ..writeByte(1)
      ..write(obj.journalNotes)
      ..writeByte(2)
      ..write(obj.journalkey)
      ..writeByte(3)
      ..write(obj.journalDate)
      ..writeByte(4)
      ..write(obj.images);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JournalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
