import 'package:flutter/material.dart';
import 'package:pharmly/resources/app_color.dart';
import 'package:pharmly/resources/app_string.dart';
import 'package:pharmly/widgets/product_of_cart.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text(AppString.txtCart,style: TextStyle(color: AppColor.colorWhite),),
        //   backgroundColor: AppColor.colorTheme,
        // ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context,bool innerBoxIsSelected){
            return<Widget> [
              SliverAppBar(
                backgroundColor: AppColor.colorTheme,
                expandedHeight: 30,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Text(AppString.txtCart,style: TextStyle(color: AppColor.colorWhite,fontSize: 20),),
                ),
              )
            ];
          },
          body: Stack(
            children: [
              Positioned(
                
              ),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context,index){
                    return ProductInCart();
                  },
                  separatorBuilder: (context,index){
                    return Divider(
                      thickness: 2,
                      color: AppColor.colorGrey,
                    );
                  },
                  itemCount: 6
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}
