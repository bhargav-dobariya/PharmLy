import 'package:flutter/material.dart';
import 'package:pharmly/models/get_cart_model.dart';
import 'package:pharmly/networking/api_service.dart';
import 'package:pharmly/resources/app_color.dart';
import 'package:pharmly/resources/app_string.dart';
import 'package:pharmly/widgets/product_of_cart.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Future<GetCartModel?> getCartData;
  getCartDetails(){
    getCartData=ApiService().getCart();
  }

  @override
  void initState() {
    getCartDetails();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppString.txtCart,style: TextStyle(color: AppColor.colorWhite),),
          backgroundColor: AppColor.colorTheme,
          centerTitle: true,
        ),
        body: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: FutureBuilder<GetCartModel?>(
                future: getCartData,
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    return ListView.separated(
                        itemBuilder: (context,index){
                          return ProductInCart(snap: snapshot.data!.data!.productData![index],);
                        },
                        separatorBuilder: (context,index){
                          return Divider(
                            thickness: 2,
                            color: AppColor.colorGrey.withAlpha(50),
                          );
                        },
                        itemCount: 6
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                }
              ),
            ),
            Positioned(
              bottom: 0,
              child: GestureDetector(
                onTap: (){},
                child: Container(
                  height: MediaQuery.of(context).size.height/14.5,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: Text(AppString.txtProceedToCheckout,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: AppColor.colorWhite),),
                  decoration: BoxDecoration(
                    color: AppColor.colorRedAccent
                  ),
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}
