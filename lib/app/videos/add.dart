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

class AddVideo extends StatefulWidget {
  final product;
  AddVideo({Key? key, this.product}) : super(key: key);

  @override
  State<AddVideo> createState() => _AddVideoState();
}

class _AddVideoState extends State<AddVideo> with Crud {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  TextEditingController description =TextEditingController();

  bool isLoading = false;
  File ? myfile;

 

  
addVideo() async {
    if (myfile == null) {
      return AwesomeDialog(
          context: context,
          title: "هام",
          body: const Text("الرجاء اضافة الصورة الخاصة بالملاحظة"))
        ..show();
    }
    //if (formstate.currentState!.validate()) {
    isLoading = true;
    setState(() {});

    var response = await postRequestWithFile(
        "$linkServerName/myApp/vids/add.php",
        {
          "description": "description.text",
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
    // }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("اضافة فيديو"),
        centerTitle: true,
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
                        hint: "وصف الفيديو",
                        mycontroller: description,
                        valid: (val) {
                          return validInput(val!, 1, 255);
                        }),
                         MaterialButton(
                      
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => Container(
                                height: 120,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("اختر فيديو",
                                          style: TextStyle(fontSize: 22)),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        XFile? xfile = await ImagePicker()
                                            .pickVideo(
                                                source: ImageSource.gallery);
                                        Navigator.of(context).pop();
                                        myfile = File(xfile!.path);
                                        setState(() {});

                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(10),
                                        child: const Text(
                                          "From Gallery",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ),
                                    
                                  ],
                                )));
                      },
                      child: const Text("اختيار فيديو"),
                      textColor: Colors.white,
                      color: myfile == null ? blue : Colors.green,
                    ),
                   
                    Container(height: 20),
                    MaterialButton(
                      onPressed: () async {
                        await addVideo();
                      },
                      child: const Text("اضافة"),
                      textColor: Colors.white,
                      color: blue
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
