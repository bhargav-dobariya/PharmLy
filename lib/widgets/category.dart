import 'package:flutter/material.dart';
import 'package:pharmly/resources/app_color.dart';

class Category extends StatefulWidget {
  final String imageUrl;
  final String categoryTitle;
  const Category({Key? key,required this.imageUrl,required this.categoryTitle}) : super(key: key);

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
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.colorGrey.withAlpha(50)),
                borderRadius: BorderRadius.all(Radius.circular(5))
              ),
              child: Image.asset(widget.imageUrl,fit: BoxFit.cover,),
            ),
          ),
          Text(widget.categoryTitle,style: TextStyle(fontSize: 10,color: AppColor.colorBlack),textAlign: TextAlign.center,)
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
