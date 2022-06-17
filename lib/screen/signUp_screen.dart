import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:pharmly/networking/api_service.dart';
import 'package:pharmly/resources/app_color.dart';
import 'package:pharmly/resources/app_string.dart';
import 'package:pharmly/utils/network_connection.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameValidator = TextEditingController();
  final TextEditingController _lastNameValidator = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _emailValidator = TextEditingController();
  final TextEditingController _passwordValidator = TextEditingController();

  late double _deviceHeight;
  late double _deviceWidth;
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return SafeArea(child: Scaffold(body: _buildUi()));
  }

  Widget _buildUi() {
    return SingleChildScrollView(
      reverse: true,
      child: Form(
          // autovalidateMode: AutovalidateMode.onUserInteraction,e
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
                    autovalidateMode: AutovalidateMode.always,
                    controller: _firstNameValidator,
                    decoration:
                        InputDecoration(labelText: AppString.txtfirstname),
                    validator: (value) {
                      if (value == null) {
                        return "Enter a valid firstname";
                      } else {
                        return null;
                      }
                    }),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                    left: _deviceWidth * 0.1,
                    right: _deviceWidth * 0.1,
                    bottom: _deviceHeight * 0.01),
                child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _lastNameValidator,
                    decoration:
                        InputDecoration(labelText: AppString.txtlastname),
                    // obscureText: true,
                    validator: (value) {
                      if (value == null) {
                        return "Enter a valid firstname";
                      } else {
                        return null;
                      }
                    }),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                    left: _deviceWidth * 0.1,
                    right: _deviceWidth * 0.1,
                    bottom: _deviceHeight * 0.01),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _phoneNumber,
                  decoration:
                      InputDecoration(labelText: AppString.txtPhoneNumber),
                  // obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r"^[0-9]{10}$").hasMatch(value)) {
                      return "Enter valid mobile number";
                    } else {
                      return null;
                    }
                  },
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
                      controller: _emailValidator,
                      decoration:
                          InputDecoration(labelText: AppString.txtEmailAddress),
                      validator: (email) =>
                          email != null && !EmailValidator.validate(email)
                              ? AppString.txtEnterValidEmailId
                              : null)),

              //Password TextField
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                    left: _deviceWidth * 0.1,
                    right: _deviceWidth * 0.1,
                    bottom: _deviceHeight * 0.04),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _passwordValidator,
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

              // Signup Button
              GestureDetector(
                onTap: () async {
                  final result = await Connectivity().checkConnectivity();
                  showConnectivityToast(result);
                  if (_formKey.currentState!.validate()) {
                    ApiService()
                        .userRegistration(
                            firstName: _firstNameValidator.text,
                            lastName: _lastNameValidator.text,
                            contactNo: _phoneNumber.text,
                            email: _emailValidator.text,
                            password: _passwordValidator.text)
                        .then((res) {
                      print(res.code);
                    });
                    print("workin");
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
                    )),
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
    );
  }
}
