// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_purchased_row.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavedPurchasedRowAdapter extends TypeAdapter<SavedPurchasedRow> {
  @override
  final int typeId = 2;

  @override
  SavedPurchasedRow read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavedPurchasedRow(
      totalCart: fields[0] as String,
      rowKey: fields[1] as String,
      purchaseDate: fields[2] as DateTime,
      nameList: fields[3] as String,
      cart: (fields[4] as List).cast<Product>(),
      keyOfTheList: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SavedPurchasedRow obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.totalCart)
      ..writeByte(1)
      ..write(obj.rowKey)
      ..writeByte(2)
      ..write(obj.purchaseDate)
      ..writeByte(3)
      ..write(obj.nameList)
      ..writeByte(4)
      ..write(obj.cart)
      ..writeByte(5)
      ..write(obj.keyOfTheList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedPurchasedRowAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
