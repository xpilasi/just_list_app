//Modelo de lista

import 'package:hive_flutter/hive_flutter.dart';

import 'product_model.dart';

part 'list_model.g.dart';

@HiveType(typeId: 0)
class ListModel extends HiveObject {
  @HiveField(0)
  late String listName;
  @HiveField(1)
  late List<Product> listProducts = [];
  @HiveField(2)
  final String listKey;
  @HiveField(3)
  final int listColor;

  ListModel({
    required this.listName,
    required this.listProducts,
    required this.listKey,
    required this.listColor,
  });
}
