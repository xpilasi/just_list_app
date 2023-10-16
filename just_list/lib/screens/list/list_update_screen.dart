import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/sizes.dart';
import '../../common/texts.dart';
import '../../controllers/dashboard_controller.dart';

import '../../widgets/buttons/custom_buttons.dart';
import '../dashboard/dashboard.dart';

class UpdateListScreen extends StatelessWidget {
  const UpdateListScreen(
      {Key? key, required this.nameOfTheList, required this.listKey})
      : super(key: key);
  final String nameOfTheList;
  final String listKey;

  @override
  Widget build(BuildContext context) {
    final DashBoardController dashBoardController =
        Get.put(DashBoardController());
    final newListName = TextEditingController(text: nameOfTheList);
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              tUpdateYourList,
              //style: const TextStyle(color: Colors.black),
            ),
            leading: CustomBackButton(onPressed: () => Get.back())),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(tDefaultMargin),
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
                            label: const Text(tLabelUpdateListName)),
                      ),
                      const SizedBox(
                        height: tDefaultMargin - 10,
                      ),
                      CustomElevatedButton(
                        onPressed: () {
                          //Update List:
                          dashBoardController.updateListName(
                              listKey: listKey, newListName: newListName.text);
                          //Return to the Lists:
                          Get.to(() => DashBoardScreen());
                        } //to get the text form the controller
                        ,
                        buttonText: tUpdateList,
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
