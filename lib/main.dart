import 'package:flutter/material.dart';
import 'package:pharmly/screen/desease_screen.dart';
import 'package:pharmly/screen/forgot_password.dart';
import 'package:pharmly/screen/login_screen.dart';
import 'package:pharmly/screen/otp_verification_screen.dart';
import 'package:pharmly/screen/signup_screen.dart';

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
        '/': (context) => const DeseaseScreen(),
        '/signup_screen': (context) => const SignUpScreen(),
        '/login_screen': (context) => const LoginScreen(),
        '/forgot_password': (context) => const ForgotPassword(),
        '/otp_verification': (context) => const OtpVerificationScreen(),
      },
    );
  }
}
