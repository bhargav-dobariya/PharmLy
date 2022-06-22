import 'package:flutter/material.dart';
import 'package:pharmly/screens/disease_screen.dart';
import 'package:pharmly/screens/login_screen.dart';
import 'package:pharmly/screens/otp_verification_screen.dart';

import 'package:pharmly/screens/home_screen.dart';
import 'package:pharmly/screens/profile_screen.dart';
import 'package:pharmly/widgets/bottom_nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const LoginScreen(),
        // '/signup_screen': (context) => const SignUpScreen(),
        '/login_screen': (context) => const LoginScreen(),
        '/forgot_password': (context) => const OtpVerificationScreen(),
        '/otp_verification': (context) => const OtpVerificationScreen(),
        '/disease_screen': (context) => const DiseaseScreen(),
        '/bottom_navbar': (context) => BottomNavBar(),
        '/home_screen': (context) => const HomeScreen(),
        '/profile_screen': (context) => const ProfileScreen(),
      },
    );
  }
}
