import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pharmly/networking/api_service.dart';
import 'package:pharmly/resources/app_color.dart';
import 'package:pharmly/resources/app_string.dart';

class DiseaseScreen extends StatefulWidget {
  const DiseaseScreen({Key? key}) : super(key: key);

  @override
  State<DiseaseScreen> createState() => _DiseaseScreenState();
}

class _DiseaseScreenState extends State<DiseaseScreen> {
  late double _deviceHeight;
  late double _deviceWidth;
  String? diseaseName;
  String? diseaseDescription;
  var allDiseaseData;
  var items;

  getData() async {
    allDiseaseData = await ApiService().getAllDisease();
    items = allDiseaseData.data;
  }

  // late final List<String> items;
  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

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
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    gradient: LinearGradient(
                      colors: [
                        AppColor.lightBlueColor2,
                        AppColor.lightBlueColor
                      ],
                    ),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        child: Image.asset("assets/images/virus.png"),
                      ),
                      Container(
                        height: _deviceHeight * 2,
                        margin: EdgeInsets.only(
                          right: _deviceWidth * 0.65,
                          top: _deviceHeight * 0.01,
                        ),
                        child: SvgPicture.asset(
                          "assets/icons/Dr.svg",
                          height: _deviceHeight * 2,
                          width: _deviceWidth * 2,
                        ),
                      ),
                      Positioned(
                        top: _deviceHeight * 0.07,
                        left: _deviceWidth * 0.44,
                        child: SizedBox(
                            width: _deviceWidth * 0.9,
                            child: Text(
                              "${AppString.allYouNeedis}\n${AppString.txtIsStayHome}",
                              style: TextStyle(
                                  fontSize: _deviceHeight * 0.03,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.whitecolor),
                            )),
                      )
                    ],
                  ),
                ),
                color: Colors.white,
              ),
              ListView.builder(
                itemCount: allDiseaseData.data.length(),
                itemBuilder: (context, index) {
                  return DeseaseCard(
                    title: items[index][diseaseName],
                    text: items[index][diseaseDescription],
                  );
                },
              ),
              DeseaseCard(
                title: "Fever",
                text:
                    "Working good ok then bye and do your work order that does  ok",
              ),
              DeseaseCard(
                title: "Fever",
                text: "Working good ok ",
              ),
              DeseaseCard(
                title: "Fever",
                text: "Working good ok ",
              ),
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
                  height: _deviceHeight * 0.15)),
          Container(
            margin: EdgeInsets.only(
                left: _deviceWidth * 0.32, top: _deviceHeight * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title!,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColor.lightBlueColor,
                        fontSize: 19,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: AppColor.blueColor,
                    ),
                  ],
                ),
                SizedBox(
                  height: _deviceHeight * 0.001,
                ),
                Container(
                  child: Text(
                    text!,
                    maxLines: 3,
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
