import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustTextFormSign extends StatelessWidget {
  final String hint ; 
  final String? Function(String?) valid ; 
  final TextEditingController mycontroller ; 
  const CustTextFormSign({Key? key, required this.hint, required this.mycontroller, required this.valid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const  EdgeInsets.only(bottom: 10),
      child: TextFormField(
        validator: valid,
        controller: mycontroller,
      
        decoration: InputDecoration(
          focusedBorder: const  OutlineInputBorder(  
            borderRadius:   BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Colors.red, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Colors.grey[400]!)),
            contentPadding:const  EdgeInsets.symmetric(vertical: 8, horizontal: 10),
           // hintText: hint,
           labelText: hint,
           labelStyle: const TextStyle(color: Colors.black54, fontSize: 15)
            ),
      ),
    );
  }
}
