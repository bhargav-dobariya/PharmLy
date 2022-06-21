import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pharmly/networking/api_service.dart';
import 'package:pharmly/resources/app_color.dart';
import 'package:pharmly/resources/app_string.dart';
import 'package:pharmly/shared/validator.dart';
import 'package:pharmly/utils/network_connection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  late SharedPreferences _prefs;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passworController = TextEditingController();

  late double _deviceHeight;
  late double _deviceWidth;
  @override
  void initState() {
    // TODO: implement initState
    SharedPreferences.getInstance().then((sharedPref) {
      _prefs = sharedPref;
    });
    super.initState();
  }

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
              Positioned(
                top: _deviceHeight * 0.02,
                child: Image.asset(
                  "assets/images/Logo3.png",
                  height: _deviceHeight * 0.2,
                ),
              ),
              _getLoginForm(),
            ],
          ),
        ),
      ),
    );
  }

  Form _getLoginForm() {
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
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _passworController,
              decoration: InputDecoration(labelText: AppString.txtPassword),
              obscureText: true,
              validator: (value) {
                if (value != null && value.length < 8) {
                  return "Enter min. 8 characters";
                } else {
                  return null;
                }
              },
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
                ApiService()
                    .userLogin(
                        email: _emailController.text,
                        password: _passworController.text)
                    .then(
                  (res) async {
                    if (res.code == 200) {
                      await _prefs.setString(AppString.userToken, res.data!);
                      Navigator.pushNamed(context, '/bo');
                    } else {
                      _emailController.clear();
                      _passworController.clear();
                      Fluttertoast.showToast(
                          msg: AppString.txtPleaseEnterCorrectEmailAndPassword);
                    }
                  },
                );
              }
            },
            child: Container(
              margin: EdgeInsets.only(left: _deviceWidth * 0.39),
              width: _deviceWidth * 0.46,
              height: _deviceHeight * 0.062,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColor.lightBlueColor2,
                      AppColor.lightBlueColor,
                    ],
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(50))),
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
              Navigator.pushReplacementNamed(context, '/signup_screen');
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
    );
  }
}
