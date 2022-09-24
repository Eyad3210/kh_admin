import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khalifa_admin/constant/color.dart';
import 'package:auto_size_text/auto_size_text.dart';

class AddCard extends StatelessWidget {
  String text;
  final Function() press;
  AddCard({Key? key, required this.press, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: blue,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
            child: AutoSizeText(text,
                maxLines: 1,
                style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white))),
      ),
    );
  }
}
