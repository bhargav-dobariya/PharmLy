import 'package:flutter/material.dart';
import 'package:pharmly/resources/app_color.dart';
import 'package:pharmly/screens/disease_screen.dart';
import 'package:pharmly/screens/products_screen.dart';

import '../models/view_category.dart' as ViewCategory;

class Category extends StatefulWidget {
  // final String imageUrl;
  // final String categoryTitle;
  final ViewCategory.Datum snap;
  const Category({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.snap.categoryName == "Diseases") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DiseaseScreen()));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductsScreen(
                        id: widget.snap.id!,
                        name: widget.snap.categoryName!,
                      )));
        }
      },
      child: Center(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColor.colorGrey.withAlpha(50)),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                child: Image.network(
                  widget.snap.categoryImage!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              widget.snap.categoryName!,
              style: TextStyle(fontSize: 10, color: AppColor.colorBlack),
              textAlign: TextAlign.center,
            )
          ],
        ),
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
