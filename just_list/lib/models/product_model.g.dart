// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 1;

  @override
  Product read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Product(
      productName: fields[0] as String,
      productQuantity: fields[1] as int,
      productPrice: fields[2] as double,
      activaded: fields[5] as bool,
      key: fields[3] as String,
      productColor: fields[4] as int,
      checked: fields[6] as bool,
      creationTime: fields[7] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.productName)
      ..writeByte(1)
      ..write(obj.productQuantity)
      ..writeByte(2)
      ..write(obj.productPrice)
      ..writeByte(3)
      ..write(obj.key)
      ..writeByte(4)
      ..write(obj.productColor)
      ..writeByte(5)
      ..write(obj.activaded)
      ..writeByte(6)
      ..write(obj.checked)
      ..writeByte(7)
      ..write(obj.creationTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
