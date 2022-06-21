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
        crossAxisCount: 2,
        padding: EdgeInsets.symmetric(vertical: 5),
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
