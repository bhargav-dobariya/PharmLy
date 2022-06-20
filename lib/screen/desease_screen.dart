import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pharmly/resources/app_color.dart';

class DeseaseScreen extends StatefulWidget {
  const DeseaseScreen({Key? key}) : super(key: key);

  @override
  State<DeseaseScreen> createState() => _DeseaseScreenState();
}

class _DeseaseScreenState extends State<DeseaseScreen> {
  late double _deviceHeight;
  late double _deviceWidth;
  // late final List<String> items;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                shadowColor: AppColor.darkgreycolor,
                child: Container(
                  height: _deviceHeight * 0.25,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    // gradient: LinearGradient(
                    //   colors: [
                    //     AppColor.lightBlueColor2,
                    //     AppColor.lightBlueColor
                    //   ],
                    // ),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Center(
                        child: SvgPicture.asset(
                          "assets/icons/Dr.svg",
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                ),
                color: Colors.white,
              ),
              // ListView.builder(
              //   itemCount: items.length,
              //   itemBuilder: (context, index) {
              //     return DeseaseCard(
              //       title: items[index],
              //       text: items[index],
              //     );
              //   },
              // ),
              DeseaseCard(
                title: "Headache",
                text:
                    "Working good ok then bye and do your work order that does  ok",
              ),
              SvgPicture.asset(
                "assets/icons/Dr.svg",
                height: 50.0,
                width: 40.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DeseaseCard extends StatelessWidget {
  late double _deviceHeight;
  late double _deviceWidth;
  final String? title;
  final String? text;
  DeseaseCard({
    Key? key,
    this.title,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.02),
      width: _deviceWidth,
      height: _deviceHeight * 0.18,
      child: Stack(
        children: <Widget>[
          Container(
            height: _deviceHeight * 0.5,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 9),
                  blurRadius: 40,
                  color: AppColor.shadowColor,
                ),
              ],
            ),
          ),
          Container(
              alignment: Alignment.bottomLeft,
              child: Image.asset("assets/images/Logo3.png",
                  height: _deviceHeight * 0.17)),
          Container(
            margin: EdgeInsets.only(
                left: _deviceWidth * 0.32, top: _deviceHeight * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Text(
                      title!,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColor.lightBlueColor,
                        fontSize: 19,
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(
                          left: _deviceWidth * 0.34,
                        ),
                        child: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: AppColor.blueColor,
                        )),
                  ],
                ),
                SizedBox(
                  height: _deviceHeight * 0.001,
                ),
                Container(
                  child: Text(
                    text!,
                    maxLines: 7,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: _deviceHeight * 0.02,
                        color: AppColor.greyColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
