// import 'package:flutter/material.dart';
// import 'package:pharmly/models/disease_product.dart' as DiseaseProduct;
// import 'package:pharmly/screens/disease_screen.dart';

// import 'package:pharmly/screens/disease_screen.dart' as DiseaseScreen;

// import '../resources/app_color.dart';
// import '../screens/disease_product_screen.dart';

// class DeseaseCard extends StatelessWidget {
//   late double _deviceHeight;
//   late double _deviceWidth;
//   final String? title;
//   final String? text;
//   final String? id;
//   DiseaseScreen.Datum? snap;

//   DeseaseCard({
//     Key? key,
//     this.snap,
//     this.id,
//     this.title,
//     this.text,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     _deviceHeight = MediaQuery.of(context).size.height;
//     _deviceWidth = MediaQuery.of(context).size.width;
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) =>
//                     DiseaseProductsScreen(id: snap!.id!, name: snap!.title!)));
//       },
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.02),
//         width: _deviceWidth,
//         height: _deviceHeight * 0.18,
//         child: Stack(
//           children: <Widget>[
//             Container(
//               height: _deviceHeight * 0.5,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                     offset: const Offset(0, 9),
//                     blurRadius: 40,
//                     color: AppColor.shadowColor,
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//                 alignment: Alignment.bottomLeft,
//                 child: Image.asset("assets/images/Logo3.png",
//                     height: _deviceHeight * 0.15)),
//             Container(
//               margin: EdgeInsets.only(
//                   left: _deviceWidth * 0.32, top: _deviceHeight * 0.02),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         title!,
//                         style: TextStyle(
//                           fontWeight: FontWeight.w500,
//                           color: AppColor.lightBlueColor,
//                           fontSize: 19,
//                         ),
//                       ),
//                       Icon(
//                         Icons.arrow_forward_ios_outlined,
//                         color: AppColor.blueColor,
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: _deviceHeight * 0.001,
//                   ),
//                   Container(
//                     child: Text(
//                       text!,
//                       maxLines: 3,
//                       style: TextStyle(
//                           fontWeight: FontWeight.w700,
//                           fontSize: _deviceHeight * 0.02,
//                           color: AppColor.greyColor),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
