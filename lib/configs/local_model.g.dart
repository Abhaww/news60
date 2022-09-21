// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalNewsModelAdapter extends TypeAdapter<LocalNewsModel> {
  @override
  final int typeId = 0;

  @override
  LocalNewsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalNewsModel()..newsId = (fields[0] as List).cast<String>();
  }

  @override
  void write(BinaryWriter writer, LocalNewsModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.newsId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalNewsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
