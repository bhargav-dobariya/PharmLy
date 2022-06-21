import 'package:flutter/material.dart';
import 'package:pharmly/resources/app_color.dart';
import 'package:pharmly/resources/app_string.dart';

class Product extends StatefulWidget {
  final String productName;
  final String productCompany;
  final double productPrice;
  final String productImageUrl;
  final bool addToCart;
  final int index;
  const Product({Key? key,required this.productName,required this.productCompany,required this.productImageUrl,required this.productPrice,required this.addToCart,required this.index}) : super(key: key);

  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: AppColor.colorGrey.withAlpha(70)),top: BorderSide(color: AppColor.colorGrey.withAlpha(70)))
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height/2,
                width: MediaQuery.of(context).size.width/2,
                padding: EdgeInsets.all(10),
                // margin: EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                    // border: Border(left: BorderSide(color: AppColor.colorGrey)),
                    borderRadius: BorderRadius.all(Radius.circular(5))
                ),
                child: Image.asset(widget.productImageUrl,fit: BoxFit.cover,),
              ),
            ),
            Text(widget.productName,style: TextStyle(fontSize: 15,color: AppColor.colorBlack,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
            Text(widget.productCompany,style: TextStyle(fontSize: 10,color: AppColor.colorGrey),textAlign: TextAlign.center,),
            Text("Rs. ${widget.productPrice}/-",style: TextStyle(fontSize: 10,color: AppColor.colorBlack,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
            GestureDetector(
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width/2.3,
                height: 20,
                margin: EdgeInsets.only(bottom: 5),
                child: Text(AppString.txtAddToCart.toUpperCase(),style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: AppColor.colorBlue.withAlpha(110)
                ),
              ),
              onTap: (){

              },
            )
          ],
        ),
      ),
    );
  }
}
