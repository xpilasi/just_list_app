import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_list/common/colors.dart';
import 'package:just_list/common/sizes.dart';
import 'package:just_list/controllers/dashboard_controller.dart';
import 'package:just_list/screens/list/list_create_screen.dart';

import '../../common/texts.dart';
import '../../widgets/content/content_widget.dart';
import '../list/list_board_screen.dart';

class DashBoardScreen extends StatelessWidget {
  DashBoardScreen({Key? key}) : super(key: key);

  final DashBoardController dashBoardController =
      Get.put(DashBoardController());
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            toolbarHeight: 100,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leadingWidth: 59,
            // leading: Container(
            //     width: 80,
            //     child: Image.asset('assets/icons/jl_192.png', width: 50)),
            title: const Text(
              tMyLists,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: tDefaultMargin - 20),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.to(() => const CreateListScreen());
                      },
                      icon: const Icon(
                        Icons.add,
                        size: tIconSize,
                      ),
                    ),
                  ],
                ),
              )
            ]),
        body: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: tDefaultMargin - 15, vertical: 5),
          child: Container(
              child: Column(
            children: [
              Expanded(
                flex: 2,
                child: GetBuilder<DashBoardController>(
                    builder: (dashBoardController) {
                  if (dashBoardController.dataModels.isNotEmpty) {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, mainAxisExtent: 107),
                      itemCount: dashBoardController.dataModels.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              height: 100,
                              width: 175,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                elevation: 0,
                                child: ListTile(
                                  textColor: tWhite,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  tileColor: Color(dashBoardController
                                      .dataModels[index].listColor),
                                  title: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15.0, horizontal: 0),
                                    child: ListDashBoardContent(
                                      listName: dashBoardController
                                          .dataModels[index].listName,
                                      totalCartList:
                                          dashBoardController.getTotalCart(
                                              keyOfTheList: dashBoardController
                                                  .dataModels[index].listKey),
                                    ),
                                  ),
                                  onTap: () => Get.to(ListBoardScreen(
                                    listKey: dashBoardController
                                        .dataModels[index].listKey,
                                    nameOfTheList: dashBoardController
                                        .dataModels[index].listName,
                                  )),
                                  onLongPress: () => showDialog(
                                    context: context,
                                    builder: (context) {
                                      return dashBoardController
                                          .showAlertDialog(
                                              keyOftheList: dashBoardController
                                                  .dataModels[index].listKey);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Icon(
                            Icons.notifications,
                            size: 70,
                            color: tDark,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(tEmptyListMsg)
                        ],
                      ),
                    );
                  }
                }),
              )
            ],
          )),
        ));
  }
}

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: tTextColor,
      radius: 15,
      child: Text(
        tAcronym,
        style: TextStyle(fontSize: 13, color: tWhite),
      ),
    );
  }
}
