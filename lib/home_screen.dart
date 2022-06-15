import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late double _deviceHeight;
  late double _deviceWidth;
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              bottom: _deviceHeight * 0,
              right: 30,
              child: Image.asset(
                "assets/images/bottom1.png",
              )),
          Positioned(
              bottom: _deviceHeight * 0.5,
              right: 20,
              child: Image.asset(
                "assets/images/bottom2.png",
              )),
        ],
      ),
    );
  }
}
