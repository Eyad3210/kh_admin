import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khalifa_admin/model/categoriesmodel.dart';

class CategoryCard extends StatelessWidget {
  final CategoriesModel categoriesModel;

  final Function() press;

  const CategoryCard(
      {Key? key,
      required this.press,
      required this.categoriesModel,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: const AssetImage('images/back.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.grey.withOpacity(0.99), BlendMode.modulate)),
          color: Colors.grey[350],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
            child: Text(categoriesModel.category_name_ar!,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white))),
      ),
    );
  }
}
