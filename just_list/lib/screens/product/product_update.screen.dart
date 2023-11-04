import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_list/common/colors.dart';
import 'package:just_list/models/product_model.dart';
import 'package:just_list/screens/list/list_board_screen.dart';
import 'package:just_list/screens/product/product_methods.dart';

import '../../common/sizes.dart';
import '../../common/texts.dart';
import '../../controllers/dashboard_controller.dart';
import '../../widgets/buttons/custom_buttons.dart';
import '../../widgets/snack_bars/snack_bar_widget.dart';

class UpdateProductScreen extends StatelessWidget {
  final String nameOfTheList;
  final Product fullProduct;
  final String keyOfTheList;

  const UpdateProductScreen({
    Key? key,
    required this.nameOfTheList,
    required this.fullProduct,
    required this.keyOfTheList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DashBoardController dashBoardController =
        Get.put(DashBoardController());

    final updatedProductName =
        TextEditingController(text: fullProduct.productName);
    final updatedProductPrice =
        TextEditingController(text: fullProduct.productPrice.toString());
    final updatedProductQty =
        TextEditingController(text: fullProduct.productQuantity.toString());

    return Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            tUpdateTheProduct,
            //style: const TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              //color: tWhite,
            ),
            //color: Colors.black,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(tDefaultMargin),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        maxLength: 15,
                        textCapitalization: TextCapitalization.words,
                        //initialValue: fullProduct.productName,
                        controller: updatedProductName,
                        decoration: InputDecoration(
                            label: const Text(tProduct),
                            prefixIcon: const Icon(Icons.dns),
                            suffix: GestureDetector(
                              onTap: (() {
                                updatedProductName.clear();
                              }),
                              child: const Icon(Icons.clear),
                            )),
                      ),
                      const SizedBox(
                        height: tDefaultMargin - 30,
                      ),
                      TextFormField(
                          //initialValue: fullProduct.productPrice.toString(),
                          keyboardType: TextInputType.number,
                          controller: updatedProductPrice,
                          decoration: InputDecoration(
                            label: const Text(tNewPriceProduct),
                            prefixIcon: const Icon(Icons.attach_money_rounded),
                            suffix: GestureDetector(
                              onTap: (() {
                                updatedProductPrice.clear();
                              }),
                              child: const Icon(Icons.clear),
                            ),
                          )),
                      const SizedBox(
                        height: tDefaultMargin - 5,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: updatedProductQty,
                        decoration: InputDecoration(
                          label: const Text(tNewQtyProduct),
                          prefixIcon: const Icon(
                            Icons.auto_awesome_motion_rounded,
                          ),
                          suffix: GestureDetector(
                            onTap: (() {
                              updatedProductQty.clear();
                            }),
                            child: const Icon(Icons.clear),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: tDefaultMargin - 10,
                      ),
                      CustomElevatedButton(
                        onPressed: () {
                          //Unit value validation:

                          bool qtyValidation = ProductMethod.isInteger(
                              value: updatedProductQty.text);

                          bool priceValidation = ProductMethod.isBoolean(
                              value: updatedProductPrice.text);

                          if (qtyValidation && priceValidation) {
                            //Create the product with the given inputs:
                            final product = Product(
                              productColor: generateRandomColorInt(),
                              productName: updatedProductName.text,
                              productQuantity:
                                  int.parse(updatedProductQty.text),
                              productPrice:
                                  double.parse(updatedProductPrice.text),
                              activaded: true,
                              checked: false,
                              key: fullProduct.key,
                            );

                            //Insert the product within the corresponding list
                            List<Product> productList = dashBoardController
                                .getProductList(listKey: keyOfTheList);

                            //Update product:

                            dashBoardController.updateProductInList(
                              keyList: keyOfTheList,
                              product: fullProduct,
                              newProduct: product,
                            );

                            //Return to the list:
                            Get.to(() => ListBoardScreen(
                                  nameOfTheList: nameOfTheList,
                                  listKey: keyOfTheList,
                                ));

                            //end numbers validation
                          } else {
                            CustomSnackBarNotOk.showSnackbarNotOk(
                                title: tSnackBarNotCreated,
                                subtitle: tSnackBarNotint);
                          }
                        },
                        buttonText: tUpdateProduct,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
