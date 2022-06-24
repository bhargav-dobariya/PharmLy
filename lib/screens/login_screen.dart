import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pharmly/networking/api_service.dart';
import 'package:pharmly/resources/app_color.dart';
import 'package:pharmly/resources/app_string.dart';
import 'package:pharmly/utils/validator.dart';
import 'package:pharmly/utils/network_connection.dart';

import '../methods/shared_prefs_methods.dart';
import '../utils/validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  bool _isVisible = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passworController = TextEditingController();

  late double _deviceHeight;
  late double _deviceWidth;

  @override
  void initState() {
    PreferenceHelper.initPreference();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      height: _deviceHeight,
      width: _deviceWidth,
      decoration: const BoxDecoration(
        // background color
        image: DecorationImage(
            image: AssetImage(
              "assets/images/bg_image.png",
            ),
            fit: BoxFit.cover), // background image above color
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: _getLoginForm(),
          ),
        ),
      ),
    );
  }

  Widget _getLoginForm() {
    return Form(
      key: _formKey,
      child: Stack(
        children: [
          //progressindicator
          Center(
            child: Visibility(
              visible: _isLoading,
              child: Container(
                  margin: EdgeInsets.only(top: _deviceHeight / 2),
                  child: const CircularProgressIndicator()),
            ),
          ),

          //verify button if user not verified
          Visibility(
            visible: _isVisible,
            child: Container(
              margin: EdgeInsets.only(
                  left: _deviceWidth * 0.5, top: _deviceHeight * 0.23),
              width: _deviceWidth * 0.4,
              height: _deviceHeight * 0.06,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColor.lightBlueColor3,
                      AppColor.lightBlueColor2,
                    ],
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(50))),
              alignment: Alignment.center,
              child: Text(
                AppString.txtVerify,
                style: TextStyle(
                  fontSize: 19,
                  color: AppColor.whitecolor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),

          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/Logo3.png",
                height: _deviceHeight / 5,
              ),
              Container(
                margin: EdgeInsets.only(
                    top: _deviceHeight * 0.04,
                    bottom: _deviceHeight * 0.05,
                    right: _deviceWidth * 0.62),
                alignment: Alignment.center,
                child: Text(
                  AppString.txtlogin,
                  style: TextStyle(
                    fontSize: _deviceHeight * 0.04,
                    fontWeight: FontWeight.bold,
                    color: AppColor.lightBlueColor,
                  ),
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
                  controller: _emailController,
                  decoration: InputDecoration(labelText: AppString.txtUsername),
                  validator: Validator.email,
                ),
              ),

              //Password TextField
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                    left: _deviceWidth * 0.1,
                    right: _deviceWidth * 0.1,
                    bottom: _deviceHeight * 0.01),
                child: TextFormField(
                  controller: _passworController,
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
                  child: Text(
                    AppString.txtForgotPassword,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColor.lightBlueColor,
                    ),
                  ),
                ),
              ),

              // Signin Button
              GestureDetector(
                onTap: () async {
                  final result = await Connectivity().checkConnectivity();
                  showConnectivityToast(result);
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _isLoading = true;
                    });
                    ApiService()
                        .userLogin(
                            email: _emailController.text,
                            password: _passworController.text)
                        .then(
                      (res) {
                        if (res?.code == 401) {
                          Fluttertoast.showToast(
                              msg:
                                  "first verify your self by tapping verify button");
                          setState(() {
                            _isVisible = true;
                            _isLoading = false;
                          });
                          Fluttertoast.showToast(
                              msg:
                                  "Your Password is Wrong please try again or Click on forgot password");
                        } else if (res?.code == 200) {
                          setState(() {
                            _isLoading = false;
                          });
                          PreferenceHelper.setAccessToken(res?.data!.token);
                          PreferenceHelper.setUserId(res?.data!.userId);

                          PreferenceHelper.prefs
                              .setBool(AppString.txtIsLoggedIn, true);

                          Navigator.pushReplacementNamed(
                              context, '/bottom_navbar');
                        } else if (res?.code == 406) {
                          setState(() {
                            _isLoading = false;
                          });
                          Fluttertoast.showToast(
                              msg:
                                  "Your Password is Wrong please try again or Click on forgot password");
                        } else if (res?.code != 200) {
                          _emailController.clear();
                          _passworController.clear();
                          setState(() {
                            _isLoading = false;
                          });
                          Fluttertoast.showToast(
                              msg: AppString
                                  .txtPleaseEnterCorrectEmailAndPassword);
                        } else {
                          print("else called");
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      },
                    );
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(left: _deviceWidth * 0.46),
                  width: _deviceWidth * 0.46,
                  height: _deviceHeight * 0.062,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColor.lightBlueColor2,
                          AppColor.lightBlueColor,
                        ],
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(50))),
                  alignment: Alignment.center,
                  child: Text(
                    AppString.txtSignIn,
                    style: TextStyle(
                      fontSize: 19,
                      color: AppColor.whitecolor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.pushNamed(context, '/signup_screen');
                },
                child: Container(
                  margin: EdgeInsets.only(
                      left: _deviceWidth * 0.45, top: _deviceHeight * 0.025),
                  child: Text(
                    AppString.txtDontHaveAnAccountSignup,
                    style: TextStyle(
                      fontSize: _deviceHeight * 0.018,
                      fontWeight: FontWeight.w500,
                      color: AppColor.purpleButton,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
