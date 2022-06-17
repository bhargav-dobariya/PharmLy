import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pharmly/res/colors/app_colors.dart';
import 'package:pharmly/res/strings/app_strings.dart';
import 'package:pharmly/screens/home_screen.dart';
import 'package:pharmly/widgets/bottom_nav_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    checkUserStatus();
  }

  void checkUserStatus()async{
    Timer(Duration(seconds: 10), ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavBar())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.asset('assets/images/pharmly_logo.png',fit: BoxFit.cover,)
                ),
                Container(
                  child: Text(AppStrings.txtPharmly,style: TextStyle(fontSize: 36,fontFamily: 'Mali',color: AppColors.colorWhite),),
                )
              ],
            ),
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.colorBlue.withAlpha(100),AppColors.colorGreen.withAlpha(100)]
            )
          ),
        ),
      ),
    );
  }
}
