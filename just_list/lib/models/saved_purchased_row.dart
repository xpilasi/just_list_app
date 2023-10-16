import 'package:just_list/models/product_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'saved_purchased_row.g.dart';

@HiveType(typeId: 2)
class SavedPurchasedRow extends HiveObject {
  @HiveField(0)
  final String totalCart;
  @HiveField(1)
  final String rowKey;
  @HiveField(2)
  final DateTime purchaseDate;
  @HiveField(3)
  final String nameList;
  @HiveField(4)
  final List<Product> cart;
  @HiveField(5)
  final String keyOfTheList;

  SavedPurchasedRow(
      {required this.totalCart,
      required this.rowKey,
      required this.purchaseDate,
      required this.nameList,
      required this.cart,
      required this.keyOfTheList});
}
