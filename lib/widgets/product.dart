import 'package:flutter/material.dart';
import 'package:pharmly/resources/app_color.dart';

class Product extends StatefulWidget {
  const Product({Key? key}) : super(key: key);

  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5))
              ),
              child: Image.asset('assets/images/carousel3.jpg',fit: BoxFit.cover,),
            ),
          ),
          Text("Beauty",style: TextStyle(fontSize: 10,color: AppColor.colorBlack),textAlign: TextAlign.center,),
          Text("Beauty",style: TextStyle(fontSize: 10,color: AppColor.colorBlack),textAlign: TextAlign.center,),
          Text("Beauty",style: TextStyle(fontSize: 10,color: AppColor.colorBlack),textAlign: TextAlign.center,)
        ],
      ),
    );
  }
}
