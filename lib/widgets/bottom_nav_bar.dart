import 'package:flutter/material.dart';
import 'package:pharmly/resources/app_color.dart';
import 'package:pharmly/screens/address_screen.dart';
import 'package:pharmly/screens/cart_screen.dart';
import 'package:pharmly/screens/home_screen.dart';
import 'package:pharmly/screens/profile_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;
  // late int passedIndex = widget.selectedIndex;
  // var _pref;
  // var currentUser = '';
  // void initState() {
  //   SharedPreferences.getInstance().then((sharedPref) {
  //     _pref = sharedPref;
  //     var userId = _pref.getString(AppString.userIDKey);
  //     currentUser = userId!;
  //   });
  //
  //   super.initState();
  // }

  screenOptions(currentIndex) {
    switch (currentIndex) {
      case 0:
        return const HomeScreen();

      ///Home screen
      case 1:
        return const CartScreen();

      ///Cart screen
      case 2:
        return const AddressScreen();

      ///Address screen
      case 3:
        return const ProfileScreen();

      ///Profile screen

      default:
        return const HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenOptions(currentIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            boxShadow: [BoxShadow(color: AppColor.colorGrey, blurRadius: 10)]),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColor.colorWhite,
            showUnselectedLabels: false,
            selectedItemColor: AppColor.colorTheme,
            unselectedItemColor: AppColor.colorGrey,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart), label: "Cart"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.dynamic_feed), label: "Address"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle), label: "Profile"),
            ],
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
