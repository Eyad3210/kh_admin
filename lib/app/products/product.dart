import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:get/get.dart';
import 'package:khalifa_admin/app/home/home_page.dart';
import 'package:khalifa_admin/app/products/edit.dart';
import 'package:khalifa_admin/cart/cart.dart';

import 'package:khalifa_admin/components/cardproduct.dart';
import 'package:khalifa_admin/components/crud.dart';
import 'package:khalifa_admin/constant/linkapi.dart';

import 'package:khalifa_admin/model/productmodel.dart';

class Product extends StatefulWidget {
  Product({Key? key, this.cat}) : super(key: key);
  final cat;
  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> with Crud {
  var controller = Get.put(CartController());
  bool isLoading = false;
  getProduct() async {
    var response = await postRequest("$linkServerName/myApp/products/view.php",
        {"category_id": widget.cat['id'].toString()});

    return response;
  }

  deleteCategory() async {
    print(widget.cat);
    isLoading = true;
    setState(() {});
    var response =
        await postRequest("$linkServerName/myApp/categories/delete.php", {
      "category_id": widget.cat['id'].toString(),
      "imagename": widget.cat['image'].toString(),
    });

    if (response['status'] == "success") {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => HomePage(),
        ),
        (route) => false,
      );
    } else {
      print("object");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cat['category_name_ar'].toString()),
        centerTitle: true,
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: const Text("حذف القسم بالكامل"),
                      value: 1,
                      onTap: () async {
                        await deleteCategory();
                      },
                    ),
                  ])
        ],
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(
              color: Colors.red,
            ))
          : Container(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: [
                  FutureBuilder(
                      future: getProduct(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data['status'] == 'fail') {
                            return const Center(
                                child: Text(
                              "لا يوجد منتجات",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ));
                          }
                          return ListView.builder(
                              itemCount: snapshot.data['data'].length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, i) {
                                return CardProduct(
                                    onadd: () {
                                      controller.addProductToCart(
                                          ProductModel.fromJson(
                                              snapshot.data['data'][i]));
                                    },
                                    /* onDelete: () async {
                                      isLoading = true;
                                      setState(() {});
                                      var response = await postRequest(
                                          "$linkServerName/myApp/products/delete.php",
                                          {
                                            "product_id": snapshot.data['data']
                                                    [i]['id']
                                                .toString(),
                                            "imagename": snapshot.data['data']
                                                    [i]['image']
                                                .toString()
                                          });
                                      if (response['status'] == "success") {
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                HomePage(),
                                          ),
                                          (route) => false,
                                        );
                                      }
                                    }, */
                                    ontap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => Edit(
                                                  product: snapshot.data['data']
                                                      [i])));
                                    },
                                    productModel: ProductModel.fromJson(
                                        snapshot.data['data'][i]));
                              });
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator(
                            color: Colors.red,
                          ));
                        }
                        return const Center(child: CircularProgressIndicator());
                      })
                ],
              ),
            ),
    );
  }
}
