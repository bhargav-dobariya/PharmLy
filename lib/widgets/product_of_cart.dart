import 'package:flutter/material.dart';
import 'package:pharmly/resources/app_color.dart';

class ProductInCart extends StatefulWidget {
  const ProductInCart({Key? key}) : super(key: key);

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
          Image.asset('assets/images/carousel2.jpg',fit: BoxFit.cover,),
          Expanded(
            child: Container(
              height: double.infinity,
              width: 120,
              margin: EdgeInsets.only(left: 10),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "Dettol disinfectant spray bottle, 225ml",style: TextStyle(fontSize: 20,color: AppColor.colorBlack)),
                    TextSpan(text: "\nCompany",style: TextStyle(fontSize: 15,color: AppColor.colorGrey)),
                    TextSpan(text: "\nPrice",style: TextStyle(fontSize: 20,color: AppColor.colorBlack)),
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
