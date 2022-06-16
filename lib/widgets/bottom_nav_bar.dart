import 'package:flutter/material.dart';
import 'package:pharmly/res/colors/app_colors.dart';
import 'package:pharmly/screens/home_screen.dart';
import 'package:pharmly/screens/profile_screen.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> {
  int currentIndex=0;
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
        return HomeScreen();

    ///Home screen
      case 1:
        return HomeScreen();

    ///Notification screen
      case 2:
        return HomeScreen();

    ///Add post/story screen
      case 3:
        return ProfileScreen();


      default:
        return HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenOptions(currentIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(color: AppColors.colorGrey, blurRadius: 10)
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.colorWhite,
            showUnselectedLabels: false,
            selectedItemColor: AppColors.colorLightGreen,
            unselectedItemColor: AppColors.colorGrey,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart), label: "Cart"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.dynamic_feed), label: "___"),
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