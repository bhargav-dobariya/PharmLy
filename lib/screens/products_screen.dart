import 'package:flutter/material.dart';
import 'package:pharmly/models/product_model.dart';
import 'package:pharmly/networking/api_service.dart';
import 'package:pharmly/resources/app_color.dart';
import 'package:pharmly/resources/app_string.dart';
import 'package:pharmly/widgets/product.dart';

class ProductsScreen extends StatefulWidget {
  final String categoryName;
  const ProductsScreen({Key? key,required this.categoryName}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late Future<ProductModel?> productDetails;
  getProduct()async{
    productDetails=ApiService().getProductDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName,style: TextStyle(color: AppColor.colorWhite),),
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
                  return Product(index: index,productCompany: snapshot.data!.data![index]!.companyName,addToCart: true,productImageUrl: 'assets/images/carousel3.jpg',productName: "Dettol Sanitizer 250 ml",productPrice: 3000,);
                }
            );
          }
          return const CircularProgressIndicator();
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
