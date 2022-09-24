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

class AddCategory extends StatefulWidget {
  const AddCategory({
    Key? key,
  }) : super(key: key);
  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> with Crud {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController nameAr = TextEditingController();
  File? myfile;
  bool isLoading = false;
  addCategory() async {
    if (myfile == null) {
      return AwesomeDialog(
          context: context,
          title: "هام",
          body: const Text("الرجاء اضافة الصورة الخاصة بالملاحظة"))
        ..show();
    }
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});

      var response = await postRequestWithFile(
          "$linkServerName/myApp/categories/add.php",
          {
            "name": name.text,
            "name_ar": nameAr.text,
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
        title: const Text("اضافة قسم"),
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
                    CustTextFormSign(
                        hint: "الاسم",
                        mycontroller: name,
                        valid: (val) {
                          return validInput(val!, 1, 40);
                        }),
                    CustTextFormSign(
                        hint: "الاسم العربي",
                        mycontroller: nameAr,
                        valid: (val) {
                          return validInput(val!, 1, 40);
                        }),
                    MaterialButton(
                      onPressed: () async {
                        XFile? xfile = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        myfile = File(xfile!.path);
                       
                        setState(() {});
                      },
                      child: const Text("اختر صورة"),
                      textColor: Colors.white,
                      color: myfile == null ? blue : Colors.green,
                    ),
                    Container(height: 20),
                    MaterialButton(
                      onPressed: () async {
                        await addCategory();
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
