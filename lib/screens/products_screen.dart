import 'package:flutter/material.dart';
import 'package:pharmly/resources/app_string.dart';
import 'package:pharmly/widgets/product.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.txtCategoryName),
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 3,
        padding: EdgeInsets.all(5),
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        children: [
          Product(),
          Product(),
          Product(),
          Product(),
          Product(),
          Product(),
          Product(),
          Product(),
          Product(),
          Product(),
          Product(),
        ],
      ),
    );
  }
}
