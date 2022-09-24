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

class Edit extends StatefulWidget {
  final product;
  Edit({Key? key, this.product}) : super(key: key);

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> with Crud {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  TextEditingController price = TextEditingController();
  TextEditingController discount = TextEditingController();

  bool isLoading = false;

  edit() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response;

      {
        response =
            await postRequest("$linkServerName/myApp/products/edit_price.php", {
          "price": price.text,
          "discount": discount.text,
          "product_id": widget.product['id'].toString(),
        });
      }

      isLoading = false;
      setState(() {});
      if (response['status'] == "success") {
        Navigator.of(context).pushReplacementNamed("homepage");
      } else {
        return AwesomeDialog(
            context: context,
            title: "هام",
            body: const Text("لم يتم التعديل على الخانات"))
          ..show();
      }
    }
  }

  @override
  void initState() {
    price.text = widget.product['price'].toString();
    discount.text = widget.product['discount'].toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تعديل"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                isLoading = true;
                setState(() {});
                var response = await postRequest(
                    "$linkServerName/myApp/products/delete.php", {
                  "product_id": widget.product['id'].toString(),
                  "imagename": widget.product['image'].toString()
                });
                if (response['status'] == "success") {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => HomePage(),
                    ),
                    (route) => false,
                  );
                }
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(
              color: Colors.red,
            ))
          : Container(
              padding: const EdgeInsets.all(30),
              child: Form(
                key: formstate,
                child: ListView(
                  children: [
                    CustTextFormSign(
                        hint: "السعر",
                        mycontroller: price,
                        valid: (val) {
                          return validInput(val!, 1, 40);
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
                        await edit();
                      },
                      child: const Text("حفظ"),
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
