import 'package:flutter/material.dart';
import 'package:pharmly/res/colors/app_colors.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.colorGrey),
              borderRadius: BorderRadius.all(Radius.circular(5))
            ),
            child: Image.asset('assets/images/carousel1.jpg',fit: BoxFit.cover,),
          ),
          Text("Beauty products",style: TextStyle(fontSize: 10,color: AppColors.colorBlack),)
        ],
      ),
    );
    // return Column(
    //   children: [
    //     Container(
    //       padding: EdgeInsets.all(10),
    //       margin: EdgeInsets.only(bottom: 10),
    //       height: 80,
    //       width: 80,
    //       decoration: BoxDecoration(
    //         border: Border.all(color: Colors.grey)
    //       ),
    //       child: Image.asset('assets/images/carousel3.jpg',fit: BoxFit.cover),
    //     ),
    //     Text("Beauty products",style: TextStyle(fontSize: 7,color: Colors.black,),maxLines: 3,)
    //   ],
    // );
  }
}
