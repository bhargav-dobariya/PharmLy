import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pharmly/methods/shared_prefs_methods.dart';
import 'package:pharmly/resources/app_color.dart';
import 'package:pharmly/resources/app_string.dart';
import 'package:pharmly/utils/validator.dart';

import '../methods/check_internet_connectivity.dart.dart';
import '../networking/api_service.dart';

class newPasswordScreen extends StatefulWidget {
  const newPasswordScreen({Key? key}) : super(key: key);

  @override
  State<newPasswordScreen> createState() => newPasswordScreenState();
}

class newPasswordScreenState extends State<newPasswordScreen> {
  late double _deviceHeight;
  late double _deviceWidth;
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
            _bgUi(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: _deviceHeight * 0.1),
                  child: Image.asset(
                    "assets/images/Logo3.png",
                    height: _deviceHeight * 0.2,
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(
                        top: _deviceHeight * 0.05,
                        bottom: _deviceHeight * 0.07),
                    child: Text(
                      AppString.txtEnterYourNewPasswordHere,
                      style: TextStyle(
                          color: AppColor.lightBlueColor,
                          fontSize: _deviceHeight * 0.028,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                      left: _deviceWidth * 0.1,
                      right: _deviceWidth * 0.1,
                      bottom: _deviceHeight * 0.01),
                  child: TextFormField(
                    controller: _passwordController,
                    decoration:
                        InputDecoration(labelText: AppString.txtPassword),
                    obscureText: true,
                    validator: Validator.password,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final result = await Connectivity().checkConnectivity();
                    showConnectivityToast(result);
                    setState(() {
                      _isLoading = true;
                    });
                    ApiService()
                        .addPassword(PreferenceHelper.getEmail(),
                            _passwordController.text)
                        .then((value) async {
                      if (value.code == 200) {
                        setState(() {
                          _isLoading = false;
                        });
                        Navigator.pushReplacementNamed(
                            context, "/login_screen");
                      } else {
                        Fluttertoast.showToast(
                            msg: "Something went wrong please try again");
                      }
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        left: _deviceWidth * 0.39, top: _deviceHeight * 0.08),
                    width: _deviceWidth * 0.4,
                    height: _deviceHeight * 0.06,
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
                      AppString.txtVerify,
                      style: TextStyle(
                        fontSize: 19,
                        color: AppColor.whitecolor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _bgUi() {
    return SizedBox(
      height: _deviceHeight,
      width: _deviceWidth,
      child: Image.asset(
        "assets/images/bg_image.png",
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
