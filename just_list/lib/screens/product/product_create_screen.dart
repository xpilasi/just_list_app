import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_list/common/colors.dart';
import 'package:just_list/models/product_model.dart';
import 'package:just_list/screens/product/product_methods.dart';

import '../../common/sizes.dart';
import '../../common/texts.dart';
import '../../controllers/dashboard_controller.dart';
import '../../widgets/buttons/custom_buttons.dart';
import '../../widgets/snack_bars/snack_bar_widget.dart';

class CreateProductScreen extends StatelessWidget {
  final String nameOfTheList;
  final String keyOftheList;

  const CreateProductScreen({
    Key? key,
    required this.nameOfTheList,
    required this.keyOftheList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DashBoardController dashBoardController =
        Get.put(DashBoardController());

    final newProductName = TextEditingController();
    final newProductPrice = TextEditingController();
    final newProductQty = TextEditingController(text: "1");

    return Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            tNewProduct,
          ),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
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
                        controller: newProductName,
                        decoration: InputDecoration(
                          label: Text(tProduct),
                          prefixIcon: Icon(Icons.dns),
                          suffix: GestureDetector(
                            onTap: (() {
                              newProductName.clear();
                            }),
                            child: const Icon(Icons.clear),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: tDefaultMargin - 30,
                      ),
                      TextFormField(
                          keyboardType: TextInputType.number,
                          controller: newProductPrice,
                          decoration: InputDecoration(
                            label: Text(tNewPriceProduct),
                            prefixIcon: Icon(Icons.attach_money_rounded),
                            suffix: GestureDetector(
                              onTap: (() {
                                newProductPrice.clear();
                              }),
                              child: const Icon(Icons.clear),
                            ),
                          )),
                      const SizedBox(
                        height: tDefaultMargin - 5,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: newProductQty,
                        decoration: InputDecoration(
                          label: const Text(tNewQtyProduct),
                          prefixIcon: const Icon(
                            Icons.auto_awesome_motion_rounded,
                          ),
                          suffix: GestureDetector(
                            onTap: (() {
                              newProductQty.clear();
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
                              value: newProductQty.text);

                          bool priceValidation = ProductMethod.isBoolean(
                              value: newProductPrice.text);

                          if (qtyValidation && priceValidation) {
                            //Create the product with the given inputs:
                            final product = Product(
                                creationTime: DateTime.now(),
                                productName: newProductName.text,
                                productQuantity: int.parse(newProductQty.text),
                                productPrice:
                                    double.parse(newProductPrice.text),
                                activaded: true,
                                checked: false,
                                productColor: generateRandomColorInt(),
                                key: UniqueKey().toString());

                            //Create product:
                            dashBoardController.newProductInList(
                                keyList: keyOftheList, product: product);

                            //Return to the list:
                            Get.back();
                            // dashBoardController
                            //     .scrollController.position.maxScrollExtent;

                            // Get.to(() => ListBoardScreen(
                            //       nameOfTheList: nameOfTheList,
                            //       listKey: keyOftheList,
                            //     ));
                          } else {
                            CustomSnackBarNotOk.showSnackbarNotOk(
                                title: tSnackBarNotCreated,
                                subtitle: tSnackBarNotint);
                          }
                        },
                        buttonText: tAddProduct,
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
