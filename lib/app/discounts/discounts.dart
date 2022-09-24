import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:get/get.dart';
import 'package:khalifa_admin/app/home/home_page.dart';
import 'package:khalifa_admin/app/products/edit.dart';
import 'package:khalifa_admin/cart/cart.dart';
import 'package:khalifa_admin/components/carddiscount.dart';

import 'package:khalifa_admin/components/cardproduct.dart';
import 'package:khalifa_admin/components/crud.dart';
import 'package:khalifa_admin/constant/linkapi.dart';

import 'package:khalifa_admin/model/productmodel.dart';

class Discount extends StatefulWidget {
  Discount({
    Key? key,
  }) : super(key: key);
  @override
  State<Discount> createState() => _DiscountState();
}

class _DiscountState extends State<Discount> with Crud {
  var controller = Get.put(CartController());
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:const  Text("السلة"),
          centerTitle: true,
        ),
        body: Obx(()=>ListView.builder(
            itemCount: controller.productsMap.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, i) {
              return CardDiscount(
                onadd: () {},
                ondelete: () {},
                productModel: controller.productsMap.keys.toList()[i],
                quantity: controller.productsMap.values.toList()[i],
              );
            })));
  }
}
