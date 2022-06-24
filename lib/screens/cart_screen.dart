import 'package:flutter/material.dart';
import 'package:pharmly/models/get_cart_model.dart';
import 'package:pharmly/networking/api_service.dart';
import 'package:pharmly/resources/app_color.dart';
import 'package:pharmly/resources/app_string.dart';
import 'package:pharmly/screens/address_selection_screen.dart';
import 'package:pharmly/widgets/product_of_cart.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String? cartId;
  String? orderBill;
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
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: FutureBuilder<GetCartModel?>(
                future: getCartData,
                builder: (context, snapshot) {
                  orderBill=snapshot.data?.data?.totalPriceOfCart;
                  cartId=snapshot.data?.data?.cartId;
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
                        itemCount: snapshot.data!.data!.productData!.length
                    );
                  }
                  // else{
                  //   return Center(child: Text(AppString.txtNoDataInCart,style: TextStyle(fontSize: 15,color: AppColor.colorTheme),));
                  // }
                  return const Center(child: CircularProgressIndicator());
                }
              ),
            ),
            Positioned(
              bottom: 10,
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AddressSelectionScreen(cartId: cartId!,billTotal: orderBill!)));
                },
                child: Container(
                  height: MediaQuery.of(context).size.height/14.5,
                  width: MediaQuery.of(context).size.width/1.75,
                  alignment: Alignment.center,
                  child: Text(AppString.txtProceedToCheckout,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: AppColor.colorWhite),),
                  decoration: BoxDecoration(
                    color: AppColor.colorRedAccent,
                    borderRadius: BorderRadius.all(Radius.circular(20))
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
