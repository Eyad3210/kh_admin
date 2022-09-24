import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khalifa_admin/cart/cart.dart';
import 'package:khalifa_admin/constant/linkapi.dart';
import 'package:khalifa_admin/main.dart';
import 'package:khalifa_admin/model/productmodel.dart';

class CardDiscount extends StatelessWidget {
  final void Function() onadd;
  final void Function() ondelete;
  final int quantity;
  final ProductModel productModel;
  CardDiscount({
    Key? key,
    required this.quantity,
    required this.onadd,
    required this.ondelete,
    required this.productModel,
  }) : super(key: key);
  var controller = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              flex: 1,
              child: Image.network(
                "$linkServerName/myApp/upload/${productModel.image}",
                width: 150,
                height: 120,
                fit: BoxFit.fill,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              )),
          Expanded(
              flex: 2,
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: IconButton(
                      onPressed: () {
                        controller.addProductToCart(productModel);
                      },
                      icon: const Icon(Icons.add_circle),
                    )),
                    Expanded(child: Text("$quantity")),
                    Expanded(
                        child: IconButton(
                            onPressed: () {
                              controller.removeProductsFarmCart(productModel);
                            },
                            icon: const Icon(
                              Icons.remove_circle,
                            ))),
                  ],
                ),
                subtitle: Text(
                  "${productModel.name}",
                ),
              ))
        ],
      ),
    );
  }
}
