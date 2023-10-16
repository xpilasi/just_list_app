import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_list/common/colors.dart';

import '../../common/sizes.dart';
import '../../controllers/dashboard_controller.dart';
import '../../models/product_model.dart';

class PurchaseListScreen extends StatelessWidget {
  final List<Product> purchaseList;
  final String listName;
  final String date;

  const PurchaseListScreen(
      {Key? key,
      required this.purchaseList,
      required this.listName,
      required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Product> purchaseListActivated = DashBoardController()
        .createListActivatedProducts(productList: purchaseList);
    return Scaffold(
        appBar: AppBar(
          //automaticallyImplyLeading: false,
          toolbarHeight: 100,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(CupertinoIcons.back),
            onPressed: () => Get.back(),
          ),
          centerTitle: true,

          elevation: 0,
          title: Text(
            "$date - $listName",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: tDefaultMargin - 15),
          child: Container(
            child: Center(child:
                GetBuilder<DashBoardController>(builder: (dashBoardController) {
              return ListView.builder(
                  itemCount: purchaseListActivated.length,
                  itemBuilder: (context, index) {
                    var roundedRectangleBorder = RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20));

                    String price =
                        purchaseListActivated[index].productPrice.toString();
                    String product = purchaseListActivated[index].productName;
                    String qty =
                        purchaseListActivated[index].productQuantity.toString();
                    double total = purchaseList[index].productQuantity *
                        purchaseListActivated[index].productPrice;

                    return
                        //Wrap the ListTile with a Card:

                        Column(children: [
                      Card(
                        color: Colors.transparent,
                        elevation: 0,
                        shape: roundedRectangleBorder,
                        child: ListTile(
                          leading: CircleAvatar(
                              backgroundColor: Color(
                                  purchaseListActivated[index].productColor),
                              child: Text(
                                product[0],
                                style: TextStyle(color: tWhite),
                              )),
                          title: Text(product),
                          subtitle: Text("Un. price  : \$ $price"),
                          trailing:
                              Text("Total : \$ ${total.toStringAsFixed(2)}"),
                        ),
                      ),
                    ]);
                  });
            })),
          ),
        ));
  }
}
