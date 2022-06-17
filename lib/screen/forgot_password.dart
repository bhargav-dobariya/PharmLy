import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:pharmly/resources/app_color.dart';
import 'package:pharmly/resources/app_string.dart';
import 'package:pharmly/utils/network_connection.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailValidator = TextEditingController();

  late StreamSubscription subscription;
  TextEditingController emailController = TextEditingController();

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
        child: Container(
          margin: EdgeInsets.only(
            // bottom: _deviceHeight * ,
            left: _deviceWidth * 0.1,
            right: _deviceWidth * 0.1,
          ),
          child: Column(
            children: [
              Container(
                alignment: Alignment.topCenter,
                width: _deviceWidth * 1.2,
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
              Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                      bottom: _deviceHeight * 0.04, top: _deviceHeight * 0.08),
                  child: TextFormField(
                      controller: _emailValidator,
                      decoration:
                          InputDecoration(labelText: AppString.txtEmailAddress),
                      validator: (email) =>
                          email != null && !EmailValidator.validate(email)
                              ? 'Enter A Valid Email'
                              : null)),
              GestureDetector(
                  child: Container(
                    margin: EdgeInsets.only(top: _deviceHeight * 0.1),
                    alignment: Alignment.center,
                    width: _deviceWidth * 0.5,
                    height: _deviceHeight * 0.06,
                    decoration: BoxDecoration(
                        color: AppColor.lightBlueColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                        gradient: LinearGradient(colors: [
                          AppColor.lightBlueColor3,
                          AppColor.lightBlueColor
                        ])),
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
                    Navigator.pushNamed(context, '/otp_verification');
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
