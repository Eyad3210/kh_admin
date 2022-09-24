import 'package:flutter/material.dart';
import 'package:khalifa_admin/app/auth/login.dart';
import 'package:khalifa_admin/app/categories/addcategory.dart';
import 'package:khalifa_admin/app/home/home_page.dart';
import 'package:khalifa_admin/app/products/add.dart';
import 'package:khalifa_admin/app/products/edit.dart';
import 'package:khalifa_admin/app/products/product.dart';
import 'package:khalifa_admin/constant/color.dart';
import 'package:shared_preferences/shared_preferences.dart';
 late SharedPreferences sharedPref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      initialRoute: "homepage",
    theme: ThemeData(appBarTheme: const AppBarTheme(backgroundColor: red) ),
      routes: {
        "homepage": (context) => HomePage(),
        "login": (context) => Login(),
        "product": (context) => Product(),
        "addproduct": (context) => AddProduct(),
        "edit": (context) => Edit(),
        "addcategory": (context) => const AddCategory(),

      },
    );
  }
}
//ngrok config add-authtoken 2E4UZ3fkPhIJyga8tbEX3gj0VkA_6rtkmXjtCda2gicWQfbpx
