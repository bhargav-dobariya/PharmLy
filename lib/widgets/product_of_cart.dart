import 'package:flutter/material.dart';
import 'package:pharmly/models/get_cart_model.dart' as GetCartModel;
import 'package:pharmly/resources/app_color.dart';

class ProductInCart extends StatefulWidget {
  final GetCartModel.ProductDatum snap;
  const ProductInCart({Key? key,required this.snap}) : super(key: key);

  @override
  _ProductInCartState createState() => _ProductInCartState();
}

class _ProductInCartState extends State<ProductInCart> {
  @override
  Widget build(BuildContext context) {
    var deviceHeight=MediaQuery.of(context).size.height;
    var deviceWidth=MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
      height: deviceHeight/4,
      width: deviceWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(widget.snap.product!.productImage!,fit: BoxFit.cover,),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              height: double.infinity,
              width: 120,
              margin: EdgeInsets.only(left: 10),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: widget.snap.product!.title!,style: TextStyle(fontSize: 20,color: AppColor.colorBlack)),
                    TextSpan(text: "\n ${widget.snap.product!.companyName!}",style: TextStyle(fontSize: 15,color: AppColor.colorGrey)),
                    TextSpan(text: "\nRs. ${widget.snap.product!.price!}/-",style: TextStyle(fontSize: 20,color: AppColor.colorBlack)),
                  ]
                )
              ),
            ),
          ),
          IconButton(icon: Icon(Icons.delete_sharp),color: AppColor.colorGrey, onPressed: () {  },)
        ],
      ),
    );
  }
}
