import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_list/common/colors.dart';
import 'package:just_list/common/sizes.dart';
import 'package:flutter/cupertino.dart';

import 'package:just_list/screens/list/list_board_screen.dart';
import 'package:just_list/screens/purchases/purchase_list_screen.dart';

import '../../common/texts.dart';
import '../../controllers/dashboard_controller.dart';
import '../../models/saved_purchased_row.dart';
import '../../widgets/icons/icons.dart';

class PurchasesScreen extends StatelessWidget {
  const PurchasesScreen(
      {Key? key,
      required this.historicPurchaseRows,
      required this.listname,
      required this.listKey})
      : super(key: key);
  final String listname;
  final String listKey;
  final List<SavedPurchasedRow> historicPurchaseRows;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //automaticallyImplyLeading: false,
          toolbarHeight: 100,

          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(
              CupertinoIcons.back,
              size: tIconSize,
            ),
            onPressed: () => Get.to(ListBoardScreen(
              listKey: listKey,
              nameOfTheList: listname,
            )),
          ),
          elevation: 0,
          title: Text(
            "Purchases - $listname",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: tDefaultMargin - 15),
          child: Container(
            //color: tPink,
            child: GetBuilder<DashBoardController>(
                init: DashBoardController(),
                builder: (dashBoardController) {
                  if (dashBoardController
                      .getListOfPurchasesByList(listKey: listKey)
                      .isNotEmpty) {
                    return ListView.builder(
                      itemCount: dashBoardController
                          .getListOfPurchasesByList(listKey: listKey)
                          .length,
                      itemBuilder: (context, index) {
                        var roundedRectangleBorder = RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10));

                        List<SavedPurchasedRow> listPurchasedRows =
                            dashBoardController.getListOfPurchasesByList(
                                listKey: listKey);
                        String fullDate =
                            listPurchasedRows[index].purchaseDate.toString();

                        String shortDate =
                            "${fullDate.substring(8, 10)}/${fullDate.substring(5, 7)}/${fullDate.substring(0, 4)}";
                        var cart2 = dashBoardController.getTotalItems(
                            productListLength:
                                listPurchasedRows[index].cart.length);
                        return
                            //Wrap the ListTile with a Card:
                            Column(
                          children: [
                            Container(
                              child: Card(
                                color: Colors.transparent,
                                elevation: 0,
                                shape: roundedRectangleBorder,
                                child: ListTile(
                                  tileColor: Colors.transparent,
                                  onTap: () {
                                    Get.to(PurchaseListScreen(
                                      listName: listname,
                                      date: shortDate,
                                      purchaseList:
                                          listPurchasedRows[index].cart,
                                    ));
                                  },
                                  onLongPress: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return dashBoardController
                                              .showAlertDialogRow(
                                                  rowKey:
                                                      listPurchasedRows[index]
                                                          .rowKey);
                                        });
                                  },
                                  trailing: IconButton(
                                      icon: const CircleButtonForward(),
                                      onPressed: () {
                                        Get.to(PurchaseListScreen(
                                          listName: listname,
                                          date: shortDate,
                                          purchaseList:
                                              listPurchasedRows[index].cart,
                                        ));
                                      }),
                                  leading: const Icon(
                                    CupertinoIcons.cart_fill,
                                    color: tSecondaryColor,
                                    size: tIconSize,
                                  ),
                                  title: Text(
                                      "\$ ${listPurchasedRows[index].totalCart}"),
                                  subtitle: Text(
                                    "$cart2 | $shortDate",
                                    style: const TextStyle(color: tDarkit),
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
                          Text(tEmptyListHistMsg)
                        ],
                      ),
                    );
                  }
                }),
          ),
        ));
  }
}
