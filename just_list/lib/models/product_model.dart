import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';

part 'product_model.g.dart';

@HiveType(typeId: 1)
class Product extends HiveObject {
  @HiveField(0)
  late String productName;
  @HiveField(1)
  late int productQuantity;
  @HiveField(2)
  late double productPrice;
  @override
  @HiveField(3)
  late String key;
  @HiveField(4)
  final int productColor;
  @HiveField(5)
  bool activaded = true;
  @HiveField(6)
  bool checked = false;
  @HiveField(7)
  final DateTime? creationTime;

  Product({
    required this.productName,
    required this.productQuantity,
    required this.productPrice,
    required this.activaded,
    required this.key,
    required this.productColor,
    required this.checked,
    this.creationTime,
  });
}
