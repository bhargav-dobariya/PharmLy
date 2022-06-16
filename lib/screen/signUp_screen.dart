import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:pharmly/resources/app_color.dart';
import 'package:pharmly/resources/app_string.dart';

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
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          //Background Design
          Positioned(
              bottom: _deviceHeight * 0.76,
              child: Image.asset(
                "assets/images/top1.png",
              )),
          Positioned(
              bottom: _deviceHeight * 0.7,
              child: Image.asset(
                "assets/images/top2.png",
              )),
          Positioned(
              top: _deviceHeight * 0.66,
              right: _deviceWidth * 0.19,
              child: Image.asset(
                "assets/images/bottom1.png",
              )),
          Positioned(
              top: _deviceHeight * 0.86,
              child: Image.asset(
                "assets/images/bottom2.png",
              )),
          Positioned(
              // top: _deviceHeight * 0.002,
              left: _deviceWidth * 0.04,
              child: Image.asset(
                "assets/images/Logo3.png",
                height: _deviceHeight * 0.18,
              )),
          _buildUi()
        ],
      ),
    ));
  }

  Form _buildUi() {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(
                top: _deviceHeight * 0.19,
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
              controller: _firstNameValidator,
              decoration: InputDecoration(labelText: AppString.txtfirstname),
              obscureText: true,
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
                left: _deviceWidth * 0.1,
                right: _deviceWidth * 0.1,
                bottom: _deviceHeight * 0.01),
            child: TextFormField(
              controller: _lastNameValidator,
              decoration: InputDecoration(labelText: AppString.txtlastname),
              obscureText: true,
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
                left: _deviceWidth * 0.1,
                right: _deviceWidth * 0.1,
                bottom: _deviceHeight * 0.01),
            child: TextFormField(
              controller: _phoneNumber,
              decoration: InputDecoration(labelText: AppString.txtPhoneNumber),
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty || !RegExp(r"^[0-9]{10}$").hasMatch(value)) {
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
                  controller: _emailValidator,
                  decoration:
                      InputDecoration(labelText: AppString.txtEmailAddress),
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
                bottom: _deviceHeight * 0.04),
            child: TextFormField(
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

          // Signin Button
          GestureDetector(
            onTap: () {},
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
                  AppString.txtSignUp.toUpperCase(),
                  style: TextStyle(
                    fontSize: 19,
                    color: AppColor.whitecolor,
                    fontWeight: FontWeight.w700,
                  ),
                )),
          ),
          GestureDetector(
            onTap: () {},
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
      ),
    );
  }
}
