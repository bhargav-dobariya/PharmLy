import 'package:flutter/material.dart';
import 'package:pharmly/networking/api_service.dart';
import 'package:pharmly/resources/app_color.dart';
import 'package:pharmly/widgets/disease_product.dart';

import '../models/disease_product.dart' as DiseaseProduct;

class DiseaseProductsScreen extends StatefulWidget {
  final String id;
  final String name;

  final DiseaseProduct.Datum? snap;
  // final ViewCategory.Datum categorySnap;
  const DiseaseProductsScreen(
      {Key? key, required this.id, this.snap, required this.name})
      : super(key: key);

  @override
  _DiseaseProductsScreenState createState() => _DiseaseProductsScreenState();
}

class _DiseaseProductsScreenState extends State<DiseaseProductsScreen> {
  late Future<DiseaseProduct.DiseaseProduct?> diseaseProductDetails;

  getDiseaseProduct() {
    diseaseProductDetails =
        ApiService().getDiseaseProduct(categoryId: widget.id);
  }

  @override
  void initState() {
    getDiseaseProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: TextStyle(color: AppColor.colorWhite),
        ),
        centerTitle: true,
        backgroundColor: AppColor.colorTheme,
      ),
      body: FutureBuilder<DiseaseProduct.DiseaseProduct?>(
          future: diseaseProductDetails,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.6),
                  itemCount: snapshot.data?.data?.length,
                  itemBuilder: (ctx, index) {
                    return DiseasesProduct(
                      index: index,
                      snap: snapshot.data!.data![index],
                    );
                  });
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
