import 'package:flutter/material.dart';
import 'package:pharmly/models/product_model.dart';
import 'package:pharmly/models/view_category.dart' as ViewCategory;
import 'package:pharmly/networking/api_service.dart';
import 'package:pharmly/resources/app_color.dart';
import 'package:pharmly/resources/app_string.dart';
import 'package:pharmly/widgets/product.dart';

class ProductsScreen extends StatefulWidget {
  final ViewCategory.Datum categorySnap;
  const ProductsScreen({Key? key,required this.categorySnap}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late Future<ProductModel?> productDetails;
  getProduct(){
    productDetails=ApiService().getProductDetails(categoryId: widget.categorySnap.id);
  }

  @override
  void initState() {
    getProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categorySnap.categoryName!,style: TextStyle(color: AppColor.colorWhite),),
        centerTitle: true,
        backgroundColor: AppColor.colorTheme,
      ),
      body: FutureBuilder<ProductModel?>(
        future: productDetails,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.6
                ),
                itemCount: snapshot.data?.data?.length,
                itemBuilder: (ctx,index){
                  return Product(index: index,addToCart: true,snap: snapshot.data!.data![index],);
                }
            );
          }
          return Center(child: const CircularProgressIndicator());
        }
      ),
      // body: GridView.count(
      //   crossAxisCount: 2,
      //   padding: EdgeInsets.symmetric(vertical: 5),
      //   childAspectRatio: 0.6,
      //   children: [
      //     Product(),
      //     Product(),
      //     Product(),
      //     Product(),
      //     Product(),
      //     Product(),
      //     Product(),
      //     Product(),
      //     Product(),
      //     Product(),
      //     Product(),
      //   ],
      // ),
    );
  }
}
