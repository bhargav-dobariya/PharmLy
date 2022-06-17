import 'package:flutter/material.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({Key? key}) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 4.5,
                  width: MediaQuery.of(context).size.width / 2.5,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage(
                        'assets/TriggerTrackerIcons/splash_logo@3x.png'),
                  )),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    child: const Text("Enter OTP:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.orange))),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    otpBoxBuilder(),
                    const SizedBox(
                      width: 5,
                    ),
                    otpBoxBuilder(),
                    const SizedBox(
                      width: 5,
                    ),
                    otpBoxBuilder(),
                    const SizedBox(
                      width: 5,
                    ),
                    otpBoxBuilder(),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                InkWell(
                  child: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height / 15,
                    color: Colors.orangeAccent,
                    child: const Text("Submit",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white)),
                  ),
                  onTap: () {
                    //  Navigator.of(context).push(MaterialPageRoute(builder:(context)=>HomePage()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget otpBoxBuilder() {
    return Container(
      alignment: Alignment.center,
      height: 70,
      width: 70,
      child: const TextField(
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 23, color: Colors.blue),
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(border: InputBorder.none, counterText: ''),
        textAlign: TextAlign.center,
      ),
      decoration:
          BoxDecoration(border: Border.all(color: Colors.blue, width: 3)),
    );
  }
}
