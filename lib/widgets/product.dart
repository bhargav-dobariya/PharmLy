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
              height: MediaQuery.of(context).size.height/2,
              width: MediaQuery.of(context).size.width/2,
              padding: EdgeInsets.all(10),
              // margin: EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                  // border: Border.all(color: AppColor.colorGrey.withAlpha(50)),
                  borderRadius: BorderRadius.all(Radius.circular(5))
              ),
              child: Image.asset('assets/images/carousel3.jpg',fit: BoxFit.cover,),
            ),
          ),
          Text("Dettol disinfectant spray bottle, 225ml",style: TextStyle(fontSize: 10,color: AppColor.colorBlack,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
          Text("Reckitt",style: TextStyle(fontSize: 10,color: AppColor.colorGrey),textAlign: TextAlign.center,),
          Text("3000/-",style: TextStyle(fontSize: 10,color: AppColor.colorBlack),textAlign: TextAlign.center,)
        ],
      ),
    );
  }
}
