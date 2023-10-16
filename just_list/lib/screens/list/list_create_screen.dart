import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_list/models/product_model.dart';
import 'package:just_list/screens/list/list_board_screen.dart';

import '../../common/colors.dart';
import '../../common/sizes.dart';
import '../../common/texts.dart';
import '../../controllers/dashboard_controller.dart';
import '../../models/list_model.dart';
import '../../widgets/buttons/custom_buttons.dart';

class CreateListScreen extends StatelessWidget {
  const CreateListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DashBoardController dashBoardController =
        Get.put(DashBoardController());
    final newListName = TextEditingController();
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              tNameYourNewList,
            ),
            leading: CustomBackButton(onPressed: () => Get.back())),
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
                        controller: newListName,
                        decoration: dashBoardController.customInputDecoration(
                            inputField: newListName,
                            label: const Text(tLabelNewListName)),
                      ),
                      const SizedBox(
                        height: tDefaultMargin - 10,
                      ),
                      CustomElevatedButton(
                        onPressed: () {
                          //Empty Product list for the new list:
                          final List<Product> emptyProductList = [];

                          final newListModel = ListModel(
                            listKey: UniqueKey().toString(),
                            listColor: generateRandomColorInt(),
                            listName: newListName.text,
                            listProducts: emptyProductList,
                          );

                          final String keyOfTheList = newListModel.listKey;
                          final String nameOfTheList = newListModel.listName;

                          //Create List:
                          dashBoardController.addList(newListModel);

                          //Return to the Lists:
                          Get.to(() => ListBoardScreen(
                                nameOfTheList: nameOfTheList,
                                listKey: keyOfTheList,
                              ));
                        } //to get the text form the controller
                        ,
                        buttonText: tCreateList,
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
