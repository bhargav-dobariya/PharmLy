import 'package:flutter/material.dart';
import 'package:pharmly/screens/home_screen.dart';
import 'package:pharmly/screens/splash_screen.dart';
import 'package:pharmly/widgets/bottom_nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PharmLy',
      home: SplashScreen(),
    );
  }
}