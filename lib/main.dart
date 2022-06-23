import 'package:flutter/material.dart';
import 'package:pharmly/screens/add_address.dart';
import 'package:pharmly/screens/address_selection_screen.dart';

import 'package:pharmly/screens/disease_screen.dart';
import 'package:pharmly/screens/forgot_password.dart';
import 'package:pharmly/screens/forgot_password_verification.dart';
import 'package:pharmly/screens/login_screen.dart';
import 'package:pharmly/screens/new_password_screen.dart';
import 'package:pharmly/screens/otp_verification_screen.dart';

import 'package:pharmly/screens/home_screen.dart';
import 'package:pharmly/screens/profile_screen.dart';
import 'package:pharmly/screens/signup_screen.dart';
import 'package:pharmly/screens/splash_screen.dart';
import 'package:pharmly/widgets/bottom_nav_bar.dart';

import 'methods/shared_prefs_methods.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  PreferenceHelper.initPreference().then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const SplashScreen(),
        '/signup_screen': (context) => const SignUpScreen(),
        '/login_screen': (context) => const LoginScreen(),
        '/forgot_password': (context) => const ForgotPassword(),
        '/otp_verification': (context) => const OtpVerificationScreen(),
        '/disease_screen': (context) => const DiseaseScreen(),
        '/bottom_navbar': (context) => BottomNavBar(),
        '/home_screen': (context) => const HomeScreen(),
        '/profile_screen': (context) => const ProfileScreen(),
        '/new_password_screen': (context) => const newPasswordScreen(),
        '/forgot_password_verification': (context) =>
            const ForgotPasswordVeficationScreen(),
        '/add_new_address': (context) => const AddAddressScreen(),
        '/bottom_navbar': (context) => BottomNavBar(),
        '/home_screen': (context) => const HomeScreen(),
        '/profile_screen': (context) => const ProfileScreen(),
      },
    );
  }
}
