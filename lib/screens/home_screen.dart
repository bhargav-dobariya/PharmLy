import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pharmly/methods/check_internet_connectivity.dart.dart';
import 'package:pharmly/models/view_category.dart';
import 'package:pharmly/networking/api_service.dart';
import 'package:pharmly/resources/app_color.dart';
import 'package:pharmly/resources/app_string.dart';

import 'package:pharmly/widgets/category.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController scrollController = ScrollController();

  late StreamSubscription subscription;
  late Future<ViewCategory?> viewCategory;

  ///Api call for viewing categories
  getCategory() {
    viewCategory = ApiService().viewCategories();
  }

  @override
  void initState() {
    getCategory();
    super.initState();
    subscription =
        Connectivity().onConnectivityChanged.listen(showConnectivityToast);
  }

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
        backgroundColor: AppColor.colorWhite,
        body: NestedScrollView(
          controller: scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsSelected) {
            return <Widget>[
              SliverAppBar(
                  backgroundColor: AppColor.colorWhite,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Column(children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width / 26.13),
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 84.4),
                        child: Row(
                          children: [
                            Container(
                              height:
                                  MediaQuery.of(context).size.height / 28.13,
                              width: MediaQuery.of(context).size.height / 28.13,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              child: Image.asset(
                                'assets/images/pharmly_logo.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Text(
                              AppString.txtPharmly,
                              style: TextStyle(
                                  fontSize: 22,
                                  color: AppColor.colorTheme,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Mali'),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width /
                                        2.20),
                                child: Icon(Icons.shopping_cart_sharp,
                                    size: 20,
                                    color: AppColor.colorBlack.withAlpha(90)))
                          ],
                        ),
                      ),
                    ]),
                  ))
            ];
          },
          body: Column(children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                height: MediaQuery.of(context).size.height / 21.1,
                width: (MediaQuery.of(context).size.width) - 30,
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 26.13,
                    vertical: 5),
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 26.13),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: AppColor.colorWhite,
                    border:
                        Border.all(color: AppColor.colorGrey.withAlpha(110)),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                child: Row(
                  children: [
                    Icon(
                      Icons.search_outlined,
                      size: 20,
                      color: AppColor.colorBlack.withAlpha(54),
                    ),
                    Text(
                      AppString.txtSearchText,
                      style: TextStyle(fontSize: 15, color: AppColor.colorGrey),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: 5, bottom: MediaQuery.of(context).size.height / 84.4),
              height: MediaQuery.of(context).size.height / 3.5,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3.5,
                    child: Image.asset(
                      'assets/images/carousel1.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3.5,
                    child: Image.asset('assets/images/carousel2.jpg',
                        fit: BoxFit.cover),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3.5,
                    child: Image.asset('assets/images/carousel3.jpg',
                        fit: BoxFit.cover),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height / 84.4),
              height: 8,
              color: AppColor.colorBlue.withAlpha(30),
            ),
            Expanded(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2,
                  child: FutureBuilder<ViewCategory?>(
                    future: viewCategory,
                    builder: (context, snapShot) {
                      if (snapShot.hasData) {
                        return GridView.builder(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.height * 0.02),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 0.7,
                              crossAxisSpacing:
                                  MediaQuery.of(context).size.height * 0.015,
                              mainAxisSpacing:
                                  MediaQuery.of(context).size.width / 19.6,
                            ),
                            itemCount: snapShot.data?.data?.length,
                            itemBuilder: (ctx, index) {
                              return Category(
                                  snap: snapShot.data!.data![index]);
                            });
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  )),
            )
          ]),
        ),
      ),
    );
  }
}
