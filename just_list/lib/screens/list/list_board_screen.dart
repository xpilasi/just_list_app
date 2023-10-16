import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_list/common/colors.dart';
import 'package:just_list/common/sizes.dart';
import 'package:just_list/controllers/dashboard_controller.dart';
import 'package:just_list/screens/dashboard/dashboard.dart';
import 'package:just_list/screens/list/list_update_screen.dart';
import 'package:just_list/screens/product/product_create_screen.dart';
import 'package:just_list/screens/product/product_update.screen.dart';

import '../../common/texts.dart';
import '../../widgets/buttons/custom_buttons.dart';

class ListBoardScreen extends StatelessWidget {
  final String nameOfTheList;
  final String listKey;
  ListBoardScreen(
      {Key? key, required this.nameOfTheList, required this.listKey})
      : super(key: key);

  final DashBoardController dashBoardController =
      Get.put(DashBoardController());

  Widget build(BuildContext context) {
    //info from de mobile:
    var mediaQuery = MediaQuery.of(context);
    //Getting the size of the mobile device screen:
    var screenSize = mediaQuery.size.height;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
        floatingActionButton: FloatingActionButton(
            backgroundColor: tSecondaryColor,
            onPressed: () {
              Get.to(() => CreateProductScreen(
                    nameOfTheList: nameOfTheList,
                    keyOftheList: listKey,
                  ));
              //dashBoardController.goToTheLastItem();
            },
            child: const Icon(
              Icons.add,
              color: tWhite,
            )),
        appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 100,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text(
              nameOfTheList,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            leading: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: CustomButton(
                icon: Icons.home,
                size: tIconSize,
                onPressed: () => Get.to(DashBoardScreen()),
              ),
            ),
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    EditButton(listKey: listKey, nameOfTheList: nameOfTheList),
                  ],
                ),
              )
            ]),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: tDefaultMargin - 15),
          child: Container(
              //color: tWhite,
              child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    //Header --> List title + total cart:
                    GetBuilder<DashBoardController>(
                        builder: (dashboardController) => Flexible(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: tDefaultMargin - 25),
                                child: Container(
                                  //color: tGreenS,
                                  height: 58,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.zero,
                                            child: IconButton(
                                                icon: const Icon(
                                                    CupertinoIcons
                                                        .ellipsis_vertical,
                                                    size: tIconSize),
                                                onPressed: () {
                                                  dashBoardController.showMenu(
                                                      context: context,
                                                      listProducts:
                                                          dashboardController
                                                              .getProductList(
                                                                  listKey:
                                                                      listKey),
                                                      keyList: listKey,
                                                      nameList: nameOfTheList,
                                                      dashBoardC:
                                                          dashboardController);
                                                }),
                                          ),
                                          IconButton(
                                              icon: const Icon(
                                                CupertinoIcons
                                                    .arrow_up_arrow_down,
                                                size: tIconSize,
                                              ),
                                              onPressed: () {
                                                dashBoardController.showMenuSort(
                                                    context: context,
                                                    listProducts:
                                                        dashboardController
                                                            .getProductList(
                                                                listKey:
                                                                    listKey),
                                                    keyList: listKey,
                                                    nameList: nameOfTheList,
                                                    dashBoardC:
                                                        dashboardController);
                                              }),
                                          Text(
                                            "TOTAL: \$ ${dashBoardController.getTotalCart(
                                              keyOfTheList: listKey,
                                            )}",
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )),

                    SizedBox(
                      height: screenSize / 1.4,
                      child: Container(
                        //color: tPrimaryColor,
                        child: GetBuilder<DashBoardController>(
                            builder: (dashBoardController) {
                          var productList = dashBoardController.getProductList(
                              listKey: listKey);

                          var roundedRectangleBorder = RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20));
                          if (productList.isNotEmpty) {
                            return ListView.builder(
                              controller: dashBoardController.scrollController,
                              itemCount: productList.length,
                              itemBuilder: (context, index) {
                                return Dismissible(
                                  //revisar esto:
                                  key: UniqueKey(),
                                  onDismissed: (direction) =>
                                      (dashBoardController.removeProductInList(
                                          keyList: listKey,
                                          product: productList[index])),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      //Wrap the ListTile with a Card:
                                      Card(
                                        elevation: 0.5,
                                        shape: roundedRectangleBorder,
                                        child: ListTile(
                                          textColor: tWhite,
                                          shape: roundedRectangleBorder,
                                          tileColor: tDarker,
                                          leading: GestureDetector(
                                            onTap: () {
                                              dashBoardController.toggleIcon(
                                                  listKey: listKey,
                                                  productKey:
                                                      productList[index].key);
                                            },
                                            child:
                                                dashBoardController.iconAvatar(
                                                    color: productList[index]
                                                        .productColor,
                                                    productName:
                                                        productList[index]
                                                            .productName,
                                                    listKey: listKey,
                                                    isIconChanged:
                                                        productList[index]
                                                            .checked),
                                          ),
                                          trailing: Container(
                                            // color: tDarkPurpleS,
                                            width: 140,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  dashBoardController
                                                      .getPercentageOfTheProduct(
                                                          product: productList[
                                                              index],
                                                          listKey: listKey),
                                                  style: const TextStyle(
                                                      color: tTurkS,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                CupertinoSwitch(
                                                  activeColor: tLightRed,
                                                  value: productList[index]
                                                      .activaded,
                                                  onChanged: (bool newValue) {
                                                    dashBoardController
                                                        .changeSwitch(
                                                            listKey: listKey,
                                                            listName:
                                                                nameOfTheList,
                                                            productKey:
                                                                productList[
                                                                        index]
                                                                    .key,
                                                            value: newValue);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          subtitle: Text(
                                            "${productList[index].productQuantity} x \$ ${productList[index].productPrice}",
                                            style:
                                                const TextStyle(fontSize: 13),
                                          ),
                                          title: Text(
                                              productList[index].productName,
                                              style: const TextStyle(
                                                  fontSize: 15)),
                                          onTap: () {
                                            Get.to(UpdateProductScreen(
                                              keyOfTheList: listKey,
                                              nameOfTheList: nameOfTheList,
                                              fullProduct: productList[index],
                                            ));
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
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
                                  Text(tEmptyListProdMsg)
                                ],
                              ),
                            );
                          }
                        }),
                      ),
                    ),
                    //)
                  ],
                ),
              )
            ],
          )),
        ));
  }
}

class EditButton extends StatelessWidget {
  const EditButton({
    super.key,
    required this.listKey,
    required this.nameOfTheList,
  });

  final String listKey;
  final String nameOfTheList;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(
          Icons.edit,
          size: tIconSize,
        ),
        onPressed: () {
          Get.to(
              UpdateListScreen(listKey: listKey, nameOfTheList: nameOfTheList));
        });
  }
}

class MenuButton extends StatelessWidget {
  const MenuButton({
    super.key,
    required this.listKey,
    required this.nameOfTheList,
  });

  final String listKey;
  final String nameOfTheList;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(CupertinoIcons.ellipsis_vertical),
        iconSize: tIconSize,
        onPressed: () {
          Get.to(
              UpdateListScreen(listKey: listKey, nameOfTheList: nameOfTheList));
        });
  }
}
