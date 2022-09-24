import 'package:flutter/material.dart';
import 'package:khalifa_admin/constant/linkapi.dart';
import 'package:khalifa_admin/model/productmodel.dart';

class CardProduct extends StatelessWidget {
  final void Function() ontap;
  final void Function() onadd;

  final ProductModel productModel;
  const CardProduct({
    Key? key,
    required this.onadd,
    required this.ontap,
    required this.productModel,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              flex: 1,
              child: Image.network(
                "$linkServerName/myApp/upload/${productModel.image}",
                width: 150,
                height: 120,
                fit: BoxFit.fill,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              )),
          /* Image.network(
                "$linkServerName/myApp/upload/${productModel.image}",
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return const Text('error');
                },

                 loadingBuilder: (context, child, loadingProgress) =>
                  const   Center(child:  CircularProgressIndicator(color: Colors.red,)), 
                width: 100,
                height: 100,
                fit: BoxFit.fill,
              )), */
          Expanded(
              flex: 2,
              child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(
                        "${productModel.name}",
                      )),
                      Text("${productModel.discountId}%"),
                    ],
                  ),
                  subtitle: Text(
                      "${productModel.price! - (productModel.price! * productModel.discountId! / 100)}"),
                  trailing: InkWell(
                    onTap: ontap,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: IconButton(
                                onPressed: onadd,
                                icon: const Icon(Icons.add))),
                        const Expanded(
                          child: Text(
                            "تعديل",
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                      ],
                    ),
                  )))
        ],
      ),
    );
  }
}
