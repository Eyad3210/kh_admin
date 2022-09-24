import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khalifa_admin/model/productmodel.dart';

class CartController extends GetxController {
  var productsMap = {}.obs;

  void addProductToCart(ProductModel product) {
    if (productsMap.containsKey(product)) {
      productsMap[product] += 1;
    } else {
      productsMap[product] = 1;
    }
  }

  void removeProductsFarmCart(ProductModel product) {
    if (productsMap.containsKey(product) && productsMap[product] == 1) {
      productsMap.removeWhere((key, value) => key == product);
    } else {
      productsMap[product] -= 1;
    }
  }

  void removeOneProduct(ProductModel product) {
    productsMap.removeWhere((key, value) => key == product);
  }
/* 
  void clearAllProducts() {
    Get.defaultDialog(
      title: "Clean Products",
      titleStyle: const TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      middleText: 'Are you sure you need clear products',
      middleTextStyle: const TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: Colors.grey[300],
      radius: 10,
      textCancel: " No ",
      cancelTextColor: Colors.white,
      textConfirm: " YES ",
      confirmTextColor: Colors.white,
      onCancel: () {
        Get.toNamed(Routes.cartScreen);
      },
      onConfirm: () {
        productsMap.clear();
        productsList.clear();
        print(productsList);

        badgeCount.value = 0;
        Get.back();
      },
      buttonColor: Get.isDarkMode ? Colors.red : mainColor,
    );
  } */

  get productSubTotal =>
      productsMap.entries.map((e) => e.key.price * e.value).toList();

  get total => productsMap.entries
      .map((e) => e.key.price * e.value)
      .toList()
      .reduce((value, element) => value + element);
  ///////////////////////vip/////////////////////////////
  get productSubTotalVip =>
      productsMap.entries.map((e) => e.key.vipPrice * e.value).toList();

  get totalVip => productsMap.entries
      .map((e) => e.key.vipPrice * e.value)
      .toList()
      .reduce((value, element) => value + element);
  int quantity() {
    if (productsMap.isEmpty) {
      return 0;
    } else {
      return productsMap.entries
          .map((e) => e.value)
          .toList()
          .reduce((value, element) => value + element);
    }
  }
}
