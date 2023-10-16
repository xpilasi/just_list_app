// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ListModelAdapter extends TypeAdapter<ListModel> {
  @override
  final int typeId = 0;

  @override
  ListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ListModel(
      listName: fields[0] as String,
      listProducts: (fields[1] as List).cast<Product>(),
      listKey: fields[2] as String,
      listColor: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ListModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.listName)
      ..writeByte(1)
      ..write(obj.listProducts)
      ..writeByte(2)
      ..write(obj.listKey)
      ..writeByte(3)
      ..write(obj.listColor);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
