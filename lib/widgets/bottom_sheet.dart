/* import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BottomSheetImage extends StatefulWidget {
  File? myfile;
  BottomSheetImage({
    Key? key,
    this.myfile,
  }) : super(key: key);

  @override
  State<BottomSheetImage> createState() => _BottomSheetImageState();
}

class _BottomSheetImageState extends State<BottomSheetImage> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
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
                      child: Text("اختر صورة", style: TextStyle(fontSize: 22)),
                    ),
                    InkWell(
                      onTap: () async {
                        XFile? xfile = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        Navigator.of(context).pop();
                        widget.myfile = File(xfile!.path);
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
      child: const Text("اختيار صورة"),
      textColor: Colors.white,
      color: widget.myfile == null ? Colors.red[400] : Colors.green,
    );
  }
}
 */