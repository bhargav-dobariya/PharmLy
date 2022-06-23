import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pharmly/methods/shared_prefs_methods.dart';
import 'package:pharmly/resources/app_color.dart';
import 'package:pharmly/resources/app_string.dart';
import 'package:pharmly/utils/validator.dart';
import 'package:pharmly/utils/network_connection.dart';

import '../networking/api_service.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();

  late StreamSubscription subscription;
  TextEditingController emailController = TextEditingController();
  bool _isLoading = false;
  late double _deviceHeight;
  late double _deviceWidth;

  @override
  initState() {
    super.initState();
    subscription =
        Connectivity().onConnectivityChanged.listen(showConnectivityToast);
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
          child: Stack(
        children: [
          Center(
            child: Visibility(
              visible: _isLoading,
              child: Container(
                  margin: EdgeInsets.only(top: _deviceHeight / 2),
                  child: const CircularProgressIndicator()),
            ),
          ),
          Column(
            children: [
              Material(
                elevation: 2,
                shadowColor: AppColor.greyColor,
                child: Container(
                  alignment: Alignment.topCenter,
                  height: _deviceHeight * 0.251,
                  margin: EdgeInsets.only(
                    top: _deviceHeight * 0.10,
                  ),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            'assets/images/forgot_password_img.png',
                          ),
                          fit: BoxFit.cover)),
                ),
              ),
              Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                      bottom: _deviceHeight * 0.04,
                      left: _deviceWidth * 0.1,
                      right: _deviceWidth * 0.1,
                      top: _deviceHeight * 0.08),
                  child: TextFormField(
                      controller: _emailController,
                      decoration:
                          InputDecoration(labelText: AppString.txtEmailAddress),
                      validator: Validator.email)),
              GestureDetector(
                child: Container(
                  margin: EdgeInsets.only(top: _deviceHeight * 0.1),
                  alignment: Alignment.center,
                  width: _deviceWidth * 0.5,
                  height: _deviceHeight * 0.06,
                  decoration: BoxDecoration(
                    color: AppColor.lightBlueColor,
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    gradient: LinearGradient(
                      colors: [
                        AppColor.lightBlueColor3,
                        AppColor.lightBlueColor
                      ],
                    ),
                  ),
                  child: Text(
                    AppString.txtVerify.toUpperCase(),
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColor.colorWhite,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                onTap: () async {
                  final result = await Connectivity().checkConnectivity();
                  showConnectivityToast(result);
                  setState(() {
                    _isLoading = true;
                  });
                  ApiService().otpResend(_emailController.text).then(
                    (value) {
                      if (value.code == 200) {
                        print('______1!!!!!!!!!');

                        PreferenceHelper.setEmail(_emailController.text);
                        print('______2!!!!!!!!!');

                        setState(() {
                          _isLoading = false;
                        });
                        Navigator.pushReplacementNamed(
                            context, "/forgot_password_verification");
                      } else {
                        Fluttertoast.showToast(
                            msg:
                                "Something Went Wrong Please try afterSometime");
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ],
      )),
    );
  }
}
