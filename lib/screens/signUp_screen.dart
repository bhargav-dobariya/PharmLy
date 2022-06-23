import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pharmly/methods/shared_prefs_methods.dart';
import 'package:pharmly/networking/api_service.dart';
import 'package:pharmly/resources/app_color.dart';
import 'package:pharmly/resources/app_string.dart';
import 'package:pharmly/utils/validator.dart';
import 'package:pharmly/utils/network_connection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late SharedPreferences _prefs;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  late double _deviceHeight;
  late double _deviceWidth;
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: _signUpFormUi(),
        ),
      ),
    );
  }

  Widget _signUpFormUi() {
    return Stack(
      children: [
        Center(
          child: Visibility(
            visible: _isLoading,
            child: Container(
                margin: EdgeInsets.only(top: _deviceHeight / 2),
                child: const CircularProgressIndicator()),
          ),
        ),
        Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    "assets/images/Logo3.png",
                    height: _deviceHeight * 0.18,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: _deviceHeight * 0.02,
                      bottom: _deviceHeight * 0.01,
                      right: _deviceWidth * 0.55),
                  alignment: Alignment.center,
                  child: Text(
                    AppString.txtSignUp,
                    style: TextStyle(
                        fontSize: _deviceHeight * 0.04,
                        fontWeight: FontWeight.bold,
                        color: AppColor.lightBlueColor),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                      left: _deviceWidth * 0.1,
                      right: _deviceWidth * 0.1,
                      bottom: _deviceHeight * 0.01),
                  child: TextFormField(
                    // autovalidateMode: AutovalidateMode.always,
                    controller: _firstNameController,
                    decoration:
                        InputDecoration(labelText: AppString.txtfirstname),
                    validator: Validator.firstName,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                      left: _deviceWidth * 0.1,
                      right: _deviceWidth * 0.1,
                      bottom: _deviceHeight * 0.01),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _lastNameController,
                    decoration:
                        InputDecoration(labelText: AppString.txtlastname),
                    validator: Validator.lastName,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                      left: _deviceWidth * 0.1,
                      right: _deviceWidth * 0.1,
                      bottom: _deviceHeight * 0.01),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _phoneController,
                    decoration:
                        InputDecoration(labelText: AppString.txtPhoneNumber),
                    validator: Validator.phoneNumber,
                  ),
                ),

                //Email TextField
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                      left: _deviceWidth * 0.1,
                      right: _deviceWidth * 0.1,
                      bottom: _deviceHeight * 0.01),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _emailController,
                    decoration:
                        InputDecoration(labelText: AppString.txtEmailAddress),
                    validator: Validator.email,
                  ),
                ),

                //Password TextField
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                      left: _deviceWidth * 0.1,
                      right: _deviceWidth * 0.1,
                      bottom: _deviceHeight * 0.04),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _passwordController,
                    decoration:
                        InputDecoration(labelText: AppString.txtPassword),
                    obscureText: true,
                    validator: Validator.password,
                  ),
                ),

                // Signup Button
                GestureDetector(
                  onTap: () async {
                    final result = await Connectivity().checkConnectivity();
                    showConnectivityToast(result);
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _isLoading = true;
                      });
                      ApiService()
                          .userRegistration(
                              firstName: _firstNameController.text,
                              lastName: _lastNameController.text,
                              contactNo: _phoneController.text,
                              email: _emailController.text,
                              password: _passwordController.text)
                          .then(
                        (res) {
                          if (res.code == 200) {
                            PreferenceHelper.setEmail(_emailController.text);
                            setState(() {
                              _isLoading = false;
                            });
                            Navigator.pushNamed(context, '/otp_verification');
                          } else if (res.code == 409) {
                            setState(() {
                              _isLoading = false;
                            });
                            Fluttertoast.showToast(
                                msg:
                                    "Your mail Id is already used for this account please try login from this mail id");
                          } else {
                            _isLoading = false;
                            Fluttertoast.showToast(
                                msg:
                                    "something went wrong please try after sometime");
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
                        gradient: LinearGradient(colors: [
                          AppColor.lightBlueColor2,
                          AppColor.lightBlueColor
                        ]),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50))),
                    alignment: Alignment.center,
                    child: Text(
                      AppString.txtSignUp.toUpperCase(),
                      style: TextStyle(
                        fontSize: 19,
                        color: AppColor.whitecolor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, "/login_screen");
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        left: _deviceWidth * 0.39, top: _deviceHeight * 0.020),
                    child: Text(AppString.txtAlreadyhaveAnAccount,
                        style: TextStyle(
                            fontSize: _deviceHeight * 0.018,
                            fontWeight: FontWeight.w700,
                            color: AppColor.purpleButton)),
                  ),
                )
              ],
            )),
      ],
    );
  }
}
