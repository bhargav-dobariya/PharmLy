import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pharmly/networking/api_service.dart';
import 'package:pharmly/resources/app_color.dart';
import 'package:pharmly/resources/app_string.dart';
import 'package:pharmly/utils/network_connection.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailValidator = TextEditingController();
  final TextEditingController _passwordValidator = TextEditingController();

  late double _deviceHeight;
  late double _deviceWidth;
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        reverse: true,
        child: Stack(
          children: [
            SizedBox(
              height: _deviceHeight,
              width: _deviceWidth,
              child: Image.asset(
                "assets/images/bg_image.png",
                fit: BoxFit.fitHeight,
              ),
            ),
            //Background Design
            // Positioned(
            //     bottom: _deviceHeight * 0.76,
            //     child: Image.asset(
            //       "assets/images/top1.png",
            //     )),
            // Positioned(
            //     bottom: _deviceHeight * 0.7,
            //     child: Image.asset(
            //       "assets/images/top2.png",
            //     )),
            // Positioned(
            //     top: _deviceHeight * 0.64,
            //     child: Image.asset(
            //       "assets/images/bottom1.png",
            //     )),
            // Positioned(
            //     bottom: _deviceHeight * 0.0,
            //     child: Image.asset(
            //       "assets/images/bottom2.png",

            //     )),
            Positioned(
                top: _deviceHeight * 0.02,
                child: Image.asset(
                  "assets/images/Logo3.png",
                  height: _deviceHeight * 0.2,
                )),

            _formFieldUi()
          ],
        ),
      ),
    ));
  }

  Form _formFieldUi() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                top: _deviceHeight * 0.25,
                bottom: _deviceHeight * 0.05,
                right: _deviceWidth * 0.62),
            alignment: Alignment.center,
            child: Text(
              AppString.txtlogin,
              style: TextStyle(
                  fontSize: _deviceHeight * 0.04,
                  fontWeight: FontWeight.bold,
                  color: AppColor.lightBlueColor),
            ),
          ),

          //Email TextField
          Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                  left: _deviceWidth * 0.1,
                  right: _deviceWidth * 0.1,
                  bottom: _deviceHeight * 0.04),
              child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _emailValidator,
                  decoration: InputDecoration(labelText: AppString.txtUsername),
                  validator: (email) =>
                      email != null && !EmailValidator.validate(email)
                          ? 'Enter A Valid Email'
                          : null)),

          //Password TextField
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
                left: _deviceWidth * 0.1,
                right: _deviceWidth * 0.1,
                bottom: _deviceHeight * 0.01),
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _passwordValidator,
              decoration: InputDecoration(labelText: AppString.txtPassword),
              obscureText: true,
            ),
          ),
          //Forgot password
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/forgot_password');
            },
            child: Container(
              margin: EdgeInsets.only(
                  right: _deviceWidth * 0.09, bottom: _deviceHeight * 0.05),
              alignment: Alignment.centerRight,
              child: Text(AppString.txtForgotPassword,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColor.lightBlueColor)),
            ),
          ),

          // Signin Button
          GestureDetector(
            onTap: () async {
              final result = await Connectivity().checkConnectivity();
              showConnectivityToast(result);
              if (_formKey.currentState!.validate()) {
                ApiService()
                    .userLogin(
                        email: _emailValidator.text,
                        password: _passwordValidator.text)
                    .then((res) async {
                  if (res.code == 200) {
                    Navigator.pushNamed(context, '/otp_verification');
                  } else {
                    _emailValidator.clear();
                    _passwordValidator.clear();
                    Fluttertoast.showToast(
                        msg: "Please enter correct email and password details");
                  }
                });
              }
            },
            child: Container(
                margin: EdgeInsets.only(left: _deviceWidth * 0.39),
                width: _deviceWidth * 0.46,
                height: _deviceHeight * 0.062,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      AppColor.lightBlueColor2,
                      AppColor.lightBlueColor
                    ]),
                    borderRadius: const BorderRadius.all(Radius.circular(50))),
                alignment: Alignment.center,
                child: Text(
                  AppString.txtSignIn,
                  style: TextStyle(
                    fontSize: 19,
                    color: AppColor.whitecolor,
                    fontWeight: FontWeight.w700,
                  ),
                )),
          ),
          GestureDetector(
            onTap: () async {
              Navigator.pushReplacementNamed(context, '/signup_screen');
            },
            child: Container(
              margin: EdgeInsets.only(
                  left: _deviceWidth * 0.45, top: _deviceHeight * 0.025),
              child: Text(AppString.txtDontHaveAnAccountSignup,
                  style: TextStyle(
                      fontSize: _deviceHeight * 0.018,
                      fontWeight: FontWeight.w500,
                      color: AppColor.purpleButton)),
            ),
          )
        ],
      ),
    );
  }
}
