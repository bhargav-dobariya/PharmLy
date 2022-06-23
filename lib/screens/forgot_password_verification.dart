import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:pharmly/networking/api_service.dart';
import 'package:pharmly/resources/app_color.dart';
import 'package:pharmly/resources/app_string.dart';

import '../methods/check_internet_connectivity.dart.dart';
import '../methods/shared_prefs_methods.dart';

class ForgotPasswordVeficationScreen extends StatefulWidget {
  const ForgotPasswordVeficationScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordVeficationScreen> createState() =>
      ForgotPasswordVeficationScreenState();
}

class ForgotPasswordVeficationScreenState
    extends State<ForgotPasswordVeficationScreen> {
  late String _pin;
  late double _deviceHeight;
  late double _deviceWidth;
  final OtpFieldController otpController = OtpFieldController();
  final bool _isLoading = false;

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
                Container(
                    margin: EdgeInsets.only(
                        top: _deviceHeight * 0.05,
                        bottom: _deviceHeight * 0.07),
                    child: Text(
                      AppString.txtEnterYourOtpHere,
                      style: TextStyle(
                          color: AppColor.lightBlueColor,
                          fontSize: _deviceHeight * 0.028,
                          fontWeight: FontWeight.w600),
                    )),
                OTPTextField(
                  controller: otpController,
                  length: 6,
                  width: MediaQuery.of(context).size.width,
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldWidth: 45,
                  fieldStyle: FieldStyle.box,
                  outlineBorderRadius: 15,
                  style: const TextStyle(fontSize: 17),
                  onChanged: (pin) {
                    print("Changed: " + pin);
                  },
                  onCompleted: (pin) {
                    setState(() {
                      _pin = pin.toString();
                    });
                  },
                ),
                GestureDetector(
                  onTap: () async {
                    final result = await Connectivity().checkConnectivity();
                    showConnectivityToast(result);
                    ApiService()
                        .verifyEmail(PreferenceHelper.getEmail(), _pin)
                        .then((value) async {
                      if (value.code == 200) {
                        Navigator.pushReplacementNamed(
                            context, "/new_password_screen");
                      } else {
                        Fluttertoast.showToast(
                            msg:
                                "You Entered wrong OTP, Please add the right OTP");
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
