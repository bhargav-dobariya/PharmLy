import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pharmly/networking/api_service.dart';
import 'package:pharmly/resources/app_color.dart';
import 'package:pharmly/resources/app_string.dart';
import 'package:pharmly/screens/disease_product_screen.dart';

import '../models/all_desease_model.dart' as DiseaseModel;

class DiseaseScreen extends StatefulWidget {
  const DiseaseScreen({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  State<DiseaseScreen> createState() => _DiseaseScreenState();
}

class _DiseaseScreenState extends State<DiseaseScreen> {
  late double _deviceHeight;
  late double _deviceWidth;
  String? diseaseName;
  String? diseaseDescription;
  late Future<DiseaseModel.DiseaseModel> allDiseaseData;

  getData() async {
    allDiseaseData = ApiService().getAllDisease();
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
              _headerCard(),
              _diseaseListUi(),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _diseaseListUi() {
    return SizedBox(
      height: 400,
      width: double.infinity,
      child: FutureBuilder<DiseaseModel.DiseaseModel?>(
        future: allDiseaseData,
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            return ListView.builder(
              itemCount: snapShot.data?.data?.length,
              itemBuilder: (context, index) {
                return DeseaseCard(
                  title: snapShot.data!.data![index]!.diseaseName,
                  text: snapShot.data!.data![index]!.diseaseDescription,
                  id: snapShot.data!.data![index]!.id,
                  snap: snapShot.data!.data![index],
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Card _headerCard() {
    return Card(
      shadowColor: AppColor.darkgreycolor,
      child: Container(
        height: _deviceHeight * 0.25,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),
          gradient: LinearGradient(
            colors: [AppColor.lightBlueColor2, AppColor.lightBlueColor],
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
                      letterSpacing: 2.0,
                      fontSize: _deviceHeight * 0.03,
                      fontWeight: FontWeight.w600,
                      color: AppColor.whitecolor),
                ),
              ),
            ),
            Positioned(
              top: _deviceHeight * 0.189,
              left: _deviceWidth * 0.40,
              child: SizedBox(
                width: _deviceWidth * 0.9,
                child: Text(
                  AppString.txtBeYourOwnDoctor,
                  style: TextStyle(
                      letterSpacing: 0.25,
                      fontSize: _deviceHeight * 0.025,
                      fontWeight: FontWeight.w600,
                      color: AppColor.lightgreyColor),
                ),
              ),
            ),
          ],
        ),
      ),
      color: Colors.white,
    );
  }
}

class DeseaseCard extends StatelessWidget {
  late double _deviceHeight;
  late double _deviceWidth;
  final String? title;
  final String? text;
  final String? id;
  DiseaseModel.Datum? snap;

  DeseaseCard({
    Key? key,
    this.snap,
    this.id,
    this.title,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DiseaseProductsScreen(
                      id: snap!.id!,
                      name: snap!.diseaseName!,
                    )));
      },
      child: Container(
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
            const Divider(thickness: 2),
          ],
        ),
      ),
    );
  }
}
