import 'dart:convert';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khalifa_admin/app/categories/addcategory.dart';
import 'package:khalifa_admin/app/discounts/discounts.dart';
import 'package:khalifa_admin/app/home/addcard.dart';
import 'package:khalifa_admin/app/home/categorycard.dart';
import 'package:khalifa_admin/app/products/add.dart';
import 'package:khalifa_admin/app/products/product.dart';
import 'package:khalifa_admin/app/videos/add.dart';

import 'package:khalifa_admin/components/crud.dart';
import 'package:khalifa_admin/constant/color.dart';
import 'package:khalifa_admin/constant/linkapi.dart';
import 'package:khalifa_admin/model/categoriesmodel.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with Crud {
  bool isLoading = false;
  File? myfile;
  var menuId = [];

  getCategory() async {

    isLoading=true;
    var response =
        await getRequest("$linkServerName/myApp/categories/view.php");
        isLoading=false;
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Khalifa Admin"),
        centerTitle: true,
      ),
      body: isLoading == true
          ? const CircularProgressIndicator()
          : Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        childAspectRatio: 1,
                      ),
                      children: [
                        AddCard(
                            press: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const AddCategory()));
                            },
                            text: 'اضافة قسم'),
                        AddCard(
                            press: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AddProduct(
                                        menuId: menuId,
                                      )));
                            },
                            text: 'اضافة منتج'),
                        AddCard(
                            press: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AddVideo()));
                            },
                            text: 'اضافة فيديو'),
                             AddCard(
                            press: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Discount(
                                      )));
                            },
                            text: 'سلة الحسم'),
                      ],
                    ),
                  ),
                  FutureBuilder(
                      future: getCategory(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data['status'] == 'fail') {
                            return const Center(
                                child: Text(
                              "لا يوجد اقسام",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ));
                          }
                          menuId = snapshot.data['data'];
                          return Expanded(
                            flex: 2,
                            child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 20,
                                  childAspectRatio: 1,
                                ),
                                itemCount: snapshot.data['data'].length,
                                shrinkWrap: true,
                                itemBuilder: (context, i) {
                                  return CategoryCard(
                                    categoriesModel: CategoriesModel.fromJson(
                                        snapshot.data['data'][i]),
                                    press: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => Product(
                                                  cat: snapshot.data['data']
                                                      [i])));
                                    },
                                  );
                                }),
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.red,
                            ),
                          );
                        }
                        if (snapshot.connectionState == ConnectionState.done) {}
                        return const Center(
                            child: Text(
                          "خطأ في الاتصال",
                          style: TextStyle(
                              color: red, fontWeight: FontWeight.bold),
                        ));
                      })
                ],
              ),
            ),
    );
  }
}
