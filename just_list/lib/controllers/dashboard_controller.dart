import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_list/common/sizes.dart';
import 'package:just_list/common/texts.dart';
import 'package:just_list/models/saved_purchased_row.dart';

import 'package:just_list/widgets/buttons/custom_buttons.dart';
import 'package:just_list/widgets/snack_bars/snack_bar_widget.dart';

import '../common/colors.dart';
import '../models/list_model.dart';
import '../models/product_model.dart';
import '../screens/purchases/purchases_screen.dart';

class DashBoardController extends GetxController {
  final Box<ListModel> listModelsBox = Hive.box<ListModel>('list_models_8');

  final Box<SavedPurchasedRow> listHistoricPurchasesBox =
      Hive.box<SavedPurchasedRow>('historic_purchases_box_7');

//Creating an observable list with the values of the Model's box Map: OK
  List<ListModel> get dataModels => listModelsBox.values.toList();

//Creating an observable list with the values of the Historic Purch box Map: OK
  List<SavedPurchasedRow> get dataHistoricPurchases =>
      listHistoricPurchasesBox.values.toList();

//To add a new list within the Hive Box: OK
  addList(ListModel listName) {
    //Opening the box:

    listModelsBox.add(listName);

    //Show snackbar ok:
    CustomSnackBarOk.showSnackbarOk(
        title: tSnackBarListCreatedTitle,
        subtitle: tSnackBarListCreatedSubTitle);

    update();
  }

//To Update the list name: OK
  updateListName({required String listKey, required String newListName}) {
    int indexKey = 0;
    for (var list in dataModels) {
      if (listKey != list.listKey) {
        indexKey += 1;
      } else {
        list.listName = newListName;
        //Finding the key to make the replacement of the box:
        int modelKey = listModelsBox.keyAt(indexKey);

        //Creating replacement ListModel for the Box:
        ListModel replacementModel = list;

        //Replace data within the Box:
        listModelsBox.put(modelKey, replacementModel);

        update();
        break;
      }
    }
  }

//To add a new Product List: OK
  newProductInList({required String? keyList, required Product product}) {
    int indexKey = 0;
    for (var productList in dataModels) {
      if (productList.listKey != keyList) {
        indexKey += 1;
      } else {
        //modificar dataModel:
        productList.listProducts!.add(product);
        //Finding the key for replacing the value:
        indexKey = listModelsBox.keyAt(indexKey);

        //Creating variable for replacing the value:
        ListModel newListModel = productList;

        //Replacing the value within the Hive Box:
        listModelsBox.put(indexKey, newListModel);

        update();

        break;
      }
    }
  }

//To get model list: OK
  ListModel getListModel({required String? listKey}) {
    var modelList;
    for (var model in dataModels) {
      if (model.listKey == listKey) {
        modelList = model;
      }
    }
    return modelList;
  }

//To edit the product in the list: OK
  updateProductInList({
    required String? keyList,
    required Product product,
    required Product newProduct,
  }) {
    int indexKey = 0;
    //Find the list key within the lists:
    for (var list in dataModels) {
      //Find the product key within the prod list:

      if (list.listKey != keyList) {
        indexKey += 1;
      } else {
        //Iterate within the Product (name + price + qty):

        for (var prod in list.listProducts!) {
          //Find the correct product:

          if (product.key != prod.key) {
          } else {
            //Create replacement product:
            try {
              prod.productName = newProduct.productName;
              prod.productPrice = newProduct.productPrice;
              prod.productQuantity = newProduct.productQuantity;

              //Finding the key to make the replacement of the box:
              int modelKey = listModelsBox.keyAt(indexKey);

              //Creating replacement ListModel for the Box:
              ListModel replacementModel = list;

              //Replace data within the Box:
              listModelsBox.put(modelKey, replacementModel);
            } catch (e) {
              //print("ERROR: $e");
            }

            CustomSnackBarOk.showSnackbarOk(
                title: tSnackBarUpdatedTitle,
                subtitle: tSnackBarUpdatedSubtitle);
            update();
            break;
          }
        }
      }
    }
  }

//To store a model and achieve undo:
  Map storeProductInListUndo(
      {required String keyList, required Product product}) {
    //Iterate within the Lists and find the list key:
    int indexKey = 0;
    int modelKey = 0;
    Product savedProduct = product;
    var oldMap = {};

    for (var oldList in dataModels) {
      if (oldList.listKey != keyList) {
        indexKey += 1;
      } else {
        //**CHEQUEO */
        ListModel oldModel = oldList;
        //print("CHECK1 : ${oldModel.listProducts.length}");
        //--

        //Iterate within the product list:
        for (var oldProd in oldList.listProducts) {
          //Find the product with the key:
          if (oldProd.key == product.key) {
            modelKey = listModelsBox.keyAt(indexKey);

            //NUEVO
            oldMap = {modelKey: oldModel};
            break;
          }
        }
      }
    }
    return oldMap;
  }

//To remove the product from the list: OK
  removeProductInList({required String keyList, required Product product}) {
    int indexKeyRemove = 0;
    int modelKeyRemove = 0;
    int indexListRemove = 0;
    Product deletedProduct = product;
    final Map oldMap =
        storeProductInListUndo(keyList: keyList, product: product);

    for (var list in dataModels) {
      //Find the list key
      if (list.listKey != keyList) {
        indexKeyRemove += 1;
      } else {
        //Iterate within the product list:
        for (var prod in list.listProducts) {
          //Find the product with the key:
          if (prod.key == product.key) {
            modelKeyRemove = listModelsBox.keyAt(indexKeyRemove); //OK

            //New Model:
            ListModel replacementModel = list;
            final listOfProducts = replacementModel.listProducts;

            //Removing from the new Model:
            listOfProducts.removeAt(indexListRemove);

            //Replace data within the Box:
            listModelsBox.put(modelKeyRemove, replacementModel);
            update();

            CustomSnackBarUndo.showSnackbarConfUndo(
              undoFunction: () {
                listOfProducts.insert(indexListRemove, deletedProduct);
                ListModel replacementModel = list;
                listModelsBox.put(modelKeyRemove, replacementModel);
                update();
              },
              title: "Dismissed",
              subtitle: "Product dismissed from your list",
            );

            break;
          } else {
            indexListRemove += 1;
          }
        }
      }
    }
  }

//To get the Product List:OK
  List<Product> getProductList({required String? listKey}) {
    //Iterating within the box to check the key(a string):
    List<Product> listOfProducts = [];
    for (var productList in dataModels) {
      if (productList.listKey == listKey) {
        listOfProducts = productList.listProducts!;
      }
    }
    return listOfProducts;
  }

//To change switch state: OK
  bool changeSwitch(
      {required String listName,
      required String? listKey,
      required bool value,
      required String productKey}) {
    //List<Product> productList = getProductList(listKey: listKey);
    int indexKey = 0;
    bool finalState = true;

    for (var list in dataModels) {
      //final String nameList = listName;

      if (list.listKey != listKey) {
        indexKey += 1;
      } else {
        //Iterate within the products list:
        for (var l in list.listProducts!) {
          if (l.key == productKey) {
            int modelKey = listModelsBox.keyAt(indexKey);
            // print("Changed Key: $productKey}");
            l.activaded = value;
            finalState = l.activaded;

            ListModel replacementModel = list;

            listModelsBox.put(modelKey, replacementModel);
            update();
            break;
          }
        }
      }
    }

    return finalState;
  }

//To get the total amount of the Cart: OK
  String getTotalCart({required String? keyOfTheList}) {
    List<Product> productList = getProductList(listKey: keyOfTheList).obs;

    var totalCart = 0.0;

    for (var element in productList) {
      if (element.activaded) {
        totalCart += element.productPrice * element.productQuantity;
      }
    }

    return totalCart.toStringAsFixed(2); //2 decimals
  }

//To remove the Product List: OK
  removeProductList({required String? listKey}) {
    int modelIndex = 0;

    for (var list in listModelsBox.values) {
      if (list.listKey != listKey) {
        modelIndex += 1;
      } else {
        listModelsBox.deleteAt(modelIndex);
      }
    }

    Get.back();

    update();
  }

//To show an alert dialog before removing the ProductList: OK
  showAlertDialog({required String? keyOftheList}) {
    return CupertinoAlertDialog(
      title: const Text(tDismissedAlert),
      content: const Text(tDismissedListConf),
      actions: [
        CustomDialogButton(
            buttonText: "Cancel",
            textColor: tPrimaryColor,
            onPressed: () => Get.back()),
        CustomDialogButton(
            textColor: tLightRed,
            buttonText: "Dismiss",
            onPressed: () {
              removeProductList(listKey: keyOftheList);
            }),
      ],
    );
  }

//To delete purchase row: OK
  Future<void> removePurchaseRow({
    required String keyRow,
  }) async {
    int indexKey = 0;

    //Encontrar la lista inicial:
    for (var list in dataHistoricPurchases) {
      if (list.rowKey != keyRow) {
        indexKey += 1;
      } else {
        dataHistoricPurchases.remove(list);
        //Replace data within the Box:
        listHistoricPurchasesBox.deleteAt(indexKey);
        Get.back();
        update();
      }
    }
  }

//Dialog for confirming when removing the row: OK
  showAlertDialogRow({
    required String rowKey,
  }) {
    return CupertinoAlertDialog(
        title: const Text(tDismissedAlert),
        content: const Text(tDismissedPurchRowConf),
        actions: [
          CustomDialogButton(
              buttonText: "Cancel",
              textColor: tPrimaryColor,
              onPressed: () => Get.back()),
          CustomDialogButton(
              textColor: tLightRed,
              buttonText: "Dismiss",
              onPressed: () {
                removePurchaseRow(keyRow: rowKey);

                //Este tiene q estar para salir del alertDialog
              }),
        ]);
  }

//To add only activaded Products to the list within the purchase row: OK
  List<Product> createListActivatedProducts(
      {required List<Product> productList}) {
    List<Product> finalList = [];
    for (var product in productList) {
      if (product.activaded) {
        finalList.add(product);
      }
    }
    //From A to Z
    finalList.sort((a, b) => a.productName.compareTo(b.productName));
    return finalList;
  }

//To add a new purchase historic row: OK
  newPurchaseRow(
      {required String? keyOfTheList,
      required String keyOfTheRow,
      required ListModel listModel,
      required String listName,
      required String cartTotal,
      required List<Product> productList,
      required String listKey}) {
    final newRow = SavedPurchasedRow(
        keyOfTheList: listKey,
        nameList: listName,
        cart: createListActivatedProducts(productList: productList),
        totalCart: cartTotal,
        rowKey: UniqueKey().toString(),
        purchaseDate: DateTime.now());

    listHistoricPurchasesBox.add(newRow);
    Get.back();

    //Show snackbar ok:
    CustomSnackBarOkTop.showSnackbarOk(
        title: tSnackBarSavedRow, subtitle: tSnackBarSavedRowMsg);

    //con esta función getx refresca la pantalla
  }

//To show the alertDialog before saving the Row: OK
  showAlertDialogSaveRow({
    required String keyOftheList,
    required String totalCart,
    required ListModel modelList,
    required String listName,
    required List<Product> productList,
  }) {
    return CupertinoAlertDialog(
      title: const Text(tSavePurchRowAlert),
      content: const Text(tSavePurchRowConf),
      actions: [
        CustomDialogButton(
            buttonText: "Cancel",
            textColor: tLightRed,
            onPressed: () => Get.back()),
        CustomDialogButton(
            textColor: tPrimaryColor,
            buttonText: "Save",
            onPressed: () {
              newPurchaseRow(
                  listKey: keyOftheList,
                  keyOfTheRow: UniqueKey().toString(),
                  cartTotal: totalCart,
                  keyOfTheList: keyOftheList,
                  listModel: modelList,
                  listName: listName,
                  productList: productList);
            }),
      ],
    );
  }

  //To show the alertDialog before saving the Row: OK
  showAlertDialogResetSwitch({
    required String keyOftheList,
    required List<Product> listOfProducts,
  }) {
    return CupertinoAlertDialog(
      title: const Text(tResetSwitchAlert),
      content: const Text(tResetSwitchConf),
      actions: [
        CustomDialogButton(
            buttonText: "Cancel",
            textColor: tLightRed,
            onPressed: () => Get.back()),
        CustomDialogButton(
            textColor: tPrimaryColor,
            buttonText: "Reset",
            onPressed: () {
              resetAllSwitchesToFalse(
                  productList: listOfProducts, listKey: keyOftheList);
            }),
      ],
    );
  }

//To get % of the cart by product OK
  String getPercentageOfTheProduct(
      {required Product product, required String? listKey}) {
    double totalCart = double.parse(getTotalCart(keyOfTheList: listKey));
    String percentageOfTheProduct = "";
    String percentage = "";
    for (var list in dataModels) {
      if (list.listKey == listKey) {
        for (var prod in list.listProducts!) {
          if (prod.key == product.key) {
            if (prod.activaded == true) {
              percentageOfTheProduct =
                  (((prod.productPrice * prod.productQuantity) / totalCart) *
                          100)
                      .toStringAsFixed(0);
              percentage = "$percentageOfTheProduct%";
            } else {
              percentage = "0%";
            }
          }
        }
      }
    }
    return percentage;
  }

  List<SavedPurchasedRow> getListOfPurchasesByList({required String listKey}) {
    List<SavedPurchasedRow> listOfPurchasesByList = [];

    for (var savedRow in dataHistoricPurchases) {
      if (savedRow.keyOfTheList == listKey) {
        listOfPurchasesByList.add(savedRow);
      }
    }
    return listOfPurchasesByList;
  }

//To get the product list within the list: OK
  SavedPurchasedRow getPurchaseRow({required String keyRow}) {
    var purchaseRow;

    for (var list in dataHistoricPurchases) {
      if (list.rowKey == keyRow) {
        purchaseRow = list;
      }
    }
    return purchaseRow;
  }

//To get the purchase row from the model: OK
  List<Product> getPurchaseRowFromModel({required String keyList}) {
    List<Product> modelList = [];
    for (var purchase in dataModels) {
      if (purchase.listKey == keyList) {
        modelList = purchase.listProducts;
      }
    }
    return modelList;
  }

//To show the saved product list with/without "s": OK
  String getTotalItems({required int productListLength}) {
    String fullTotalString = "";

    if (productListLength == 1) {
      fullTotalString = "$productListLength item";
    } else {
      fullTotalString = "$productListLength items";
    }

    return fullTotalString;
  }

//To tap the icon and change the boolean: OK
  void toggleIcon({required productKey, required listKey}) {
    int indexModel = 0;
    for (var list in dataModels) {
      if (list.listKey != listKey) {
        indexModel += 1;
      } else {
        for (var l in list.listProducts) {
          if (l.key == productKey) {
            l.checked = !l.checked;

            ListModel replacementModel = list;

            listModelsBox.putAt(indexModel, replacementModel);

            update();
            break;
          }
        }
      }
    }
  }

  //To change the circleAvatar when true or false:
  CircleAvatar iconAvatar(
      {required bool isIconChanged,
      required String listKey,
      required int color,
      required String productName}) {
    var circleAvatar = CircleAvatar(
        backgroundColor: Color(color),
        child: Text(
          productName[0],
          style: const TextStyle(color: tWhite),
        ));

    if (isIconChanged != false) {
      circleAvatar = const CircleAvatar(
          backgroundColor: tSnackBarNotOk,
          child: Icon(Icons.shopping_bag_rounded,
              color: tWhite, size: tIconSize - 5));
    } else {
      circleAvatar = CircleAvatar(
          backgroundColor: Color(color),
          child: Text(
            productName[0],
            style: const TextStyle(color: tWhite),
          ));
    }

    return circleAvatar;
  }

//To come back to the last scroll:
  ScrollController scrollController = ScrollController();

  goToTheLastItem() {
    scrollController.position.maxScrollExtent;
  }

  //To clear TextField: OK
  InputDecoration customInputDecoration(
      {required TextEditingController inputField, required Text label}) {
    return InputDecoration(
        suffix: GestureDetector(
          onTap: (() {
            inputField.clear();
          }),
          child: const Icon(Icons.clear),
        ),
        label: label);
  }

  //To deploy bottom sheets: OK

  void showMenu(
      {required BuildContext context,
      required List<Product> listProducts,
      required String keyList,
      required String nameList,
      required DashBoardController dashBoardC}) {
    showModalBottomSheet(
      showDragHandle: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Wrap(
                children: <Widget>[
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: tDefaultMargin - 10),
                    child: Text(
                      tActionsTitle,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
                  ListTile(
                    leading: const Icon(CupertinoIcons.arrow_down),
                    title: const Text(tActionsSavePurchase),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return showAlertDialogSaveRow(
                                keyOftheList: keyList,
                                totalCart: getTotalCart(
                                  keyOfTheList: keyList,
                                ),
                                listName: nameList,
                                modelList: getListModel(listKey: keyList),
                                productList:
                                    getPurchaseRowFromModel(keyList: keyList));
                          });
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.history, size: 20),
                    title: const Text(tActionsViewPurchases),
                    onTap: () {
                      Get.to(PurchasesScreen(
                          listKey: keyList,
                          listname: nameList,
                          historicPurchaseRows:
                              getListOfPurchasesByList(listKey: keyList)));
                    },
                  ),
                  ListTile(
                    leading: const Icon(CupertinoIcons.refresh_bold, size: 20),
                    title: const Text(tActionsResetSwitches),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return showAlertDialogResetSwitch(
                              listOfProducts: listProducts,
                              keyOftheList: keyList,
                            );
                          });
                    },
                  ),
                ],
              ),
            ),
            TextButton(
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(tDarkit)),
              child: const Text(
                "CANCEL",
                style: TextStyle(fontSize: 15),
              ),
              onPressed: () => Get.back(),
            ),
            const SizedBox(height: 30),
          ],
        );
      },
    );
  }

  void showMenuSort(
      {required BuildContext context,
      required String keyList,
      required List<Product> listProducts,
      required String nameList,
      required DashBoardController dashBoardC}) {
    showModalBottomSheet(
      showDragHandle: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Wrap(
                children: <Widget>[
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: tDefaultMargin - 10),
                    child: Text(
                      tSortTitle,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
                  ListTile(
                    leading: const Icon(Icons.sort_by_alpha_rounded, size: 20),
                    title: const Text(tSortAz),
                    onTap: () {
                      sortByAz(listKey: keyList, productList: listProducts);
                    },
                  ),
                  ListTile(
                    leading: const Icon(CupertinoIcons.bag, size: 20),
                    title: const Text(tSortSelectedItems),
                    onTap: () {
                      sortByShop(listKey: keyList, productList: listProducts);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.access_time, size: 20),
                    title: const Text(tSCreated),
                    onTap: () {
                      sortByCreationTime(
                          listKey: keyList, productList: listProducts);
                    },
                  ),
                ],
              ),
            ),
            TextButton(
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(tDarkit)),
              child: const Text(
                "CANCEL",
                style: TextStyle(fontSize: 15),
              ),
              onPressed: () => Get.back(),
            ),
            const SizedBox(height: 30),
          ],
        );
      },
    );
  }

  void showMenuSettings(
      {required BuildContext context,
      required String keyList,
      required List<Product> listProducts,
      required String nameList,
      required DashBoardController dashBoardC}) {
    showModalBottomSheet(
      showDragHandle: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Wrap(
                children: <Widget>[
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: tDefaultMargin - 10),
                    child: Text(
                      tSortTitle,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
                  ListTile(
                    leading: const Icon(Icons.sort_by_alpha_rounded, size: 20),
                    title: const Text(tSortAz),
                    onTap: () {
                      sortByAz(listKey: keyList, productList: listProducts);
                    },
                  ),
                  ListTile(
                    leading: const Icon(CupertinoIcons.bag, size: 20),
                    title: const Text(tSortSelectedItems),
                    onTap: () {
                      sortByShop(listKey: keyList, productList: listProducts);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.access_time, size: 20),
                    title: const Text(tSCreated),
                    onTap: () {
                      sortByCreationTime(
                          listKey: keyList, productList: listProducts);
                    },
                  ),
                ],
              ),
            ),
            TextButton(
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(tDarkit)),
              child: const Text(
                "CANCEL",
                style: TextStyle(fontSize: 15),
              ),
              onPressed: () => Get.back(),
            ),
            const SizedBox(height: 30),
          ],
        );
      },
    );
  }

//To reset all switches to false: OK
  resetAllSwitchesToFalse(
      {required List<Product> productList, required String listKey}) {
    int indexModel = 0;
    for (var list in dataModels) {
      if (list.listKey != listKey) {
        indexModel += 1;
      } else {
        for (var l in list.listProducts) {
          l.activaded = false;
        }

        ListModel replacementModel = list;

        listModelsBox.putAt(indexModel, replacementModel);
        Get.back();
        update();
        break;
      }
    }
  }

//To sort by A-Z:
  sortByAz({required List<Product> productList, required String listKey}) {
    int indexModel = 0;
    for (var list in dataModels) {
      if (list.listKey != listKey) {
        indexModel += 1;
      } else {
        //From A to Z
        productList.sort((a, b) => a.productName.compareTo(b.productName));
        ListModel replacementModel = list;

        listModelsBox.putAt(indexModel, replacementModel);
        Get.back();
        update();
        break;
      }
    }
  }

//To sort by only on Shop bag: OK
  sortByShop({required List<Product> productList, required String listKey}) {
    int indexModel = 0;
    List<Product> sortedProductList = [];
    for (var list in dataModels) {
      if (list.listKey != listKey) {
        indexModel += 1;
      } else {
        for (var l in list.listProducts) {
          if (l.checked == true) {
            sortedProductList.add(l);
          }
        }
        for (var l in list.listProducts) {
          if (l.checked != true) {
            sortedProductList.add(l);
          }
        }
        list.listProducts = sortedProductList;
        ListModel replacementModel = list;

        listModelsBox.putAt(indexModel, replacementModel);
        Get.back();
        update();
        break;
      }
    }
  }

  //To sort by cration time: OK
  sortByCreationTime(
      {required List<Product> productList, required String listKey}) {
    int indexModel = 0;

    for (var list in dataModels) {
      if (list.listKey != listKey) {
        indexModel += 1;
      } else {
        list.listProducts
            .sort((a, b) => a.creationTime!.compareTo(b.creationTime!));
        ListModel replacementModel = list;

        listModelsBox.putAt(indexModel, replacementModel);
        Get.back();
        update();
        break;
      }
    }
  }
}
