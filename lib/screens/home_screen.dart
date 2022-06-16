import 'package:flutter/material.dart';
import 'package:pharmly/res/colors/app_colors.dart';
import 'package:pharmly/res/strings/app_strings.dart';
import 'package:pharmly/widgets/category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  ScrollController scrollController=ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.colorWhite,
        body: NestedScrollView(
          controller: scrollController,
          headerSliverBuilder: (BuildContext context,bool innerBoxIsSelected){
            return <Widget>[
              SliverAppBar(
                backgroundColor: AppColors.colorWhite,
                // expandedHeight: 20,
                flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/26.13),
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/84.4),
                          child: Row(
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(30))
                                ),
                                child: Image.asset('assets/images/pharmly_logo.png',fit: BoxFit.cover,),
                              ),
                              Text(AppStrings.txtPharmly,style: TextStyle(fontSize: 23,color: AppColors.colorLightGreen,fontWeight: FontWeight.bold),),
                              Padding(
                                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/2.17),
                                child: Icon(Icons.shopping_cart_sharp,size: 20,color: AppColors.colorBlack.withAlpha(90))
                              )
                            ],
                          ),
                        ),
                    ]
                  ),
                )
              )
            ];
          },
          body: Column(
            children: [
              GestureDetector(
                onTap: (){},
                child: Container(
                  height: MediaQuery.of(context).size.height/21.1,
                  width: (MediaQuery.of(context).size.width)-30,
                  margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/26.13,vertical: 5),
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/26.13),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.colorWhite,
                      border: Border.all(
                          color: AppColors.colorGrey.withAlpha(110)
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search_outlined,size: 20,color: AppColors.colorBlack.withAlpha(54),),
                      Text(AppStrings.txtSearchText,style: TextStyle(fontSize: 15,color: AppColors.colorGrey),)
                    ],
                  ),
                ),
              ),
            Container(
                  margin: EdgeInsets.only(top: 5,bottom: MediaQuery.of(context).size.height/84.4),
                  height: MediaQuery.of(context).size.height/3.5,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height/3.5,
                        child: Image.asset('assets/images/carousel1.jpg',fit: BoxFit.cover,),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height/3.5,
                        child: Image.asset('assets/images/carousel2.jpg',fit: BoxFit.cover),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height/3.5,
                        child: Image.asset('assets/images/carousel3.jpg',fit: BoxFit.cover),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/84.4),
                  height: 8,
                  color: AppColors.colorBlue.withAlpha(30),
                ),
                Expanded(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height/2,
                    child: GridView.count(
                      crossAxisCount: 3,
                      physics: NeverScrollableScrollPhysics(),
                      childAspectRatio: 0.7,
                      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height*0.02),
                      crossAxisSpacing: MediaQuery.of(context).size.height*0.015,
                      mainAxisSpacing: MediaQuery.of(context).size.width/19.6,
                      children: [
                        Category(),
                        Category(),
                        Category(),
                        Category(),
                        Category(),
                        Category(),
                        Category(),
                        Category(),
                        Category(),
                        Category(),
                        Category(),
                      ],
                    ),
                  ),
                )
            ],
          )
        ),
        // body: Column(
        //   children: [
        //     Container(
        //       padding: EdgeInsets.symmetric(horizontal: 15),
        //       margin: EdgeInsets.symmetric(vertical: 5),
        //       child: Row(
        //         children: [
        //           Container(
        //             height: 15,
        //             width: 15,
        //             decoration: BoxDecoration(
        //               color: AppColors.colorRed,
        //               borderRadius: BorderRadius.all(Radius.circular(15))
        //             ),
        //           ),
        //           Text(AppStrings.txtPharmly,style: TextStyle(fontSize: 15,color: AppColors.colorLightGreen,fontWeight: FontWeight.bold),),
        //           Padding(
        //             padding: EdgeInsets.only(left: 240),
        //             child: Icon(Icons.shopping_cart_sharp,size: 20,color: AppColors.colorBlack.withAlpha(90))
        //           )
        //         ],
        //       ),
        //     ),
        //     GestureDetector(
        //       onTap: (){},
        //       child: Container(
        //         height: 40,
        //         width: (MediaQuery.of(context).size.width)-30,
        //         margin: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
        //         padding: EdgeInsets.symmetric(horizontal: 15),
        //         alignment: Alignment.center,
        //         decoration: BoxDecoration(
        //           border: Border.all(
        //             color: AppColors.colorGrey.withAlpha(110)
        //           ),
        //           borderRadius: BorderRadius.all(Radius.circular(5))
        //         ),
        //         child: Row(
        //           children: [
        //             Icon(Icons.search_outlined,size: 20,color: AppColors.colorBlack.withAlpha(54),),
        //             Text(AppStrings.txtSearchText,style: TextStyle(fontSize: 15,color: AppColors.colorGrey),)
        //           ],
        //         ),
        //       ),
        //     ),
        //     Container(
        //       margin: EdgeInsets.only(top: 5,bottom: 10),
        //       height: MediaQuery.of(context).size.height/3.5,
        //       child: ListView(
        //         scrollDirection: Axis.horizontal,
        //         children: [
        //           Container(
        //             width: MediaQuery.of(context).size.width,
        //             height: MediaQuery.of(context).size.height/3.5,
        //             child: Image.asset('assets/images/carousel1.jpg',fit: BoxFit.cover,),
        //           ),
        //           Container(
        //             width: MediaQuery.of(context).size.width,
        //             height: MediaQuery.of(context).size.height/3.5,
        //             child: Image.asset('assets/images/carousel2.jpg',fit: BoxFit.cover),
        //           ),
        //           Container(
        //             width: MediaQuery.of(context).size.width,
        //             height: MediaQuery.of(context).size.height/3.5,
        //             child: Image.asset('assets/images/carousel3.jpg',fit: BoxFit.cover),
        //           ),
        //         ],
        //       ),
        //     ),
        //     Divider(
        //       thickness: 12,
        //       color: AppColors.colorBlue.withAlpha(30),
        //     ),
        //     SizedBox(
        //       width: MediaQuery.of(context).size.width,
        //       height: MediaQuery.of(context).size.height/2,
        //       child: GridView.count(
        //         crossAxisCount: 4,
        //         padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height*0.01),
        //         crossAxisSpacing: MediaQuery.of(context).size.height*0.003,
        //         mainAxisSpacing: 40,
        //         children: [
        //           Category(),
        //           Category(),
        //           Category(),
        //           Category(),
        //           Category(),
        //           Category(),
        //           Category(),
        //           Category(),
        //           Category(),
        //           Category(),
        //           Category(),
        //           Category(),
        //           Category(),
        //         ],
        //       ),
        //     )
        //   ],
        // )
      ),
    );
  }
}
