import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khalifa_admin/app/home/home_page.dart';

import 'package:khalifa_admin/components/crud.dart';
import 'package:khalifa_admin/components/customtextform.dart';
import 'package:khalifa_admin/components/valid.dart';
import 'package:khalifa_admin/constant/color.dart';
import 'package:khalifa_admin/constant/linkapi.dart';
import 'package:khalifa_admin/model/productmodel.dart';

class AddProduct extends StatefulWidget {
  final List? menuId;

  AddProduct({
    Key? key,
    this.menuId,
  }) : super(key: key);
  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> with Crud {
  ProductModel productModel = ProductModel();
  File? myfile;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController category = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController nameAr = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController discount = TextEditingController();

  bool isLoading = false;
  var myVal;

  addProduct() async {
    if (myfile == null || myVal==null) {
      return AwesomeDialog(
          context: context,
          title: "هام",
          body: const Text("قم بالتأكد من وجود صورة واختيار نوع"))
        ..show();
    }
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});

      var response = await postRequestWithFile(
          "$linkServerName/myApp/products/add.php",
          {
            "category_id": myVal.toString(),
            "name": name.text,
            "name_ar": nameAr.text,
            "price": price.text,
            "discount_id": discount.text,
            "description": description.text,
          },
          myfile!);
      isLoading = false;
      setState(() {});
      if (response["status"] == "success") {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => HomePage(),
          ),
          (route) => false,
        );
      } else {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("اضافة منتج"),
        centerTitle: true,
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(
              color: Colors.red,
            ))
          : Container(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: formstate,
                child: ListView(
                  children: [
                    Center(
                      child: DropdownButton(
                        
                        underline: Container(),
                        value: myVal,
                        hint: const Text('اختر النوع'),
                        items: List.generate(
                            widget.menuId!.length,
                            (index) => DropdownMenuItem(
                                  child: Text(
                                      widget.menuId![index]['category_name']),
                                  value: widget.menuId![index]['id'],
                                )),
                        onChanged: (newValue) {
                          setState(() {
                            myVal = newValue;
                          });
                        },
                      ),
                    ),
                    CustTextFormSign(
                        hint: "الاسم",
                        mycontroller: name,
                        valid: (val) {
                          return validInput(val!, 1, 40);
                        }),
                    CustTextFormSign(
                        hint: "الاسم بالعربي",
                        mycontroller: nameAr,
                        valid: (val) {
                          return validInput(val!, 1, 40);
                        }),
                    CustTextFormSign(
                        hint: "السعر",
                        mycontroller: price,
                        valid: (val) {
                          if (price.text.isEmpty) {
                            return "السعر فارغ";
                          }
                        }),
                    CustTextFormSign(
                        hint: "الوصف",
                        mycontroller: description,
                        valid: (val) {
                          return validInput(val!, 10, 255);
                        }),
                    CustTextFormSign(
                        hint: "نسبة الخصم",
                        mycontroller: discount,
                        valid: (val) {
                          if (int.parse(discount.text) > 100) {
                            return "لايمكن ان يكون الخصم اكبر من 100";
                          }
                        }),
                    Container(height: 20),
                    MaterialButton(
                      onPressed: () async {
                        XFile? xfile = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        myfile = File(xfile!.path);
                        setState(() {});
                      },
                      child: const Text("اختيار صورة"),
                      textColor: Colors.white,
                      color: myfile == null ? blue : Colors.green,
                    ),
                    Container(height: 20),
                    MaterialButton(
                      onPressed: () async {
                        if(myVal!=null){

                        }
                        await addProduct();
                      },
                      child: const Text("اضافة"),
                      textColor: Colors.white,
                      color: blue,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
