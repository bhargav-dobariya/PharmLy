import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:pharmly/resources/app_color.dart';
import 'package:pharmly/resources/app_string.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({Key? key}) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  late double _deviceHeight;
  late double _deviceWidth;
  OtpFieldController otpController = OtpFieldController();
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;

    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            _logoUi(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: _deviceHeight * 0.2),
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
                    print("Completed: " + pin);
                  },
                ),
                Container(
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
              ],
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _logoUi() {
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