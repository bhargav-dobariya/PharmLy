import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pharmly/methods/check_internet_connectivity.dart.dart';
import 'package:pharmly/models/delete_user_model.dart';
import 'package:pharmly/models/get_user_model.dart';
import 'package:pharmly/networking/api_service.dart';

import 'package:pharmly/resources/app_color.dart';
import 'package:pharmly/resources/app_string.dart';
import 'package:pharmly/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../methods/shared_prefs_methods.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool firstNameEnabled = false;
  bool lastNameEnabled = false;
  bool contactEnabled = false;
  bool emailEnabled = false;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  String? emailText;
  late StreamSubscription subscription;
  var userData;
  var updateUserData;
  late DeleteUserModel? removeUser;

  String userFirstName = "";
  String userLastName = "";
  String userContactNo = "";

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    contactController.dispose();
    super.dispose();
  }

  getData() async {
    UserProfile? userData = await ApiService().getUserDetails();
    lastNameController.text = userData?.data?.lastName ?? "Majmudar";
    contactController.text = userData?.data?.contactNo ?? "9900990099";
    firstNameController.text = userData?.data?.firstName ?? "NEh";
    emailText = userData?.data?.email ?? "NEh";
    setState(() {});
  }

  updateData(
      String newFirstName, String newLastName, String newContactNo) async {
    await ApiService().updateUserDetails(
        firstName: newFirstName,
        lastName: newLastName,
        contactNo: newContactNo);
  }

  Future deleteAccount()async{
    removeUser=await ApiService().deleteUser();
  }

  void userLoggedIn() async {
    PreferenceHelper.prefs.setBool(AppString.txtIsLoggedIn, false);
  }


  @override
  void initState() {
    getData();
    super.initState();
    subscription =
        Connectivity().onConnectivityChanged.listen(showConnectivityToast);
    // userDetails=ApiService.getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(AppString.txtProfile),
        centerTitle: true,
        backgroundColor: AppColor.colorTheme,
        elevation: 1,
        actions: [
          TextButton(
              onPressed: () {
                ApiService().logOutUser(email: emailText).then((res) async {
                  if (res?.code == 200) {
                    userLoggedIn();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  } else {
                    print(res?.code);
                  }
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 4.9,
                height: MediaQuery.of(context).size.height / 28.13,
                alignment: Alignment.center,
                child: Text(
                  AppString.txtSignOut,
                  style: TextStyle(color: AppColor.colorWhite, fontSize: 10),
                ),
                decoration: BoxDecoration(
                    color: AppColor.colorRedAccent,
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
            child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width / 1.568,
                    height: MediaQuery.of(context).size.height / 11.25,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: TextFormField(
                      controller: firstNameController,
                      enabled: firstNameEnabled,
                      decoration: InputDecoration(
                          labelText: AppString.txtFirstName,
                          alignLabelWithHint: true),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        firstNameEnabled = !firstNameEnabled;
                        //update database method()
                      });
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      child: firstNameEnabled
                          ? Icon(
                              Icons.check_rounded,
                              color: AppColor.colorWhite,
                              size: 20,
                            )
                          : Icon(
                              Icons.edit,
                              color: AppColor.colorWhite,
                              size: 20,
                            ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: firstNameEnabled
                              ? AppColor.colorLightGreen
                              : AppColor.colorBlue,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    width: MediaQuery.of(context).size.width / 1.568,
                    height: MediaQuery.of(context).size.height / 11.25,
                    child: TextFormField(
                      controller: lastNameController,
                      enabled: lastNameEnabled,
                      decoration: InputDecoration(
                          labelText: AppString.txtLastName,
                          alignLabelWithHint: true),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        lastNameEnabled = !lastNameEnabled;
                        //update database method()
                      });
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      child: lastNameEnabled
                          ? Icon(
                              Icons.check_rounded,
                              color: AppColor.colorWhite,
                              size: 20,
                            )
                          : Icon(
                              Icons.edit,
                              color: AppColor.colorWhite,
                              size: 20,
                            ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: lastNameEnabled
                              ? AppColor.colorLightGreen
                              : AppColor.colorBlue,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                    ),
                  )
                ],
              ),
              GestureDetector(
                onTap: () {
                  Fluttertoast.showToast(msg: AppString.txtCannotChangeEmail);
                  print("toast?");
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  width: MediaQuery.of(context).size.width / 1.568,
                  height: MediaQuery.of(context).size.height / 11.25,
                  child: TextFormField(
                    enabled: emailEnabled,
                    decoration: InputDecoration(
                      hintText: emailText,
                      // alignLabelWithHint: true
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    width: MediaQuery.of(context).size.width / 1.568,
                    height: MediaQuery.of(context).size.height / 11.25,
                    child: TextFormField(
                      controller: contactController,
                      enabled: contactEnabled,
                      decoration: InputDecoration(
                          fillColor: AppColor.colorRed,
                          labelText: AppString.txtContact,
                          alignLabelWithHint: true),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        contactEnabled = !contactEnabled;
                        //update database method()
                      });
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      child: contactEnabled
                          ? Icon(
                              Icons.check_rounded,
                              color: AppColor.colorWhite,
                              size: 20,
                            )
                          : Icon(
                              Icons.edit,
                              color: AppColor.colorWhite,
                              size: 20,
                            ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: contactEnabled
                              ? AppColor.colorLightGreen
                              : AppColor.colorBlue,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                    ),
                  )
                ],
              ),
              GestureDetector(
                onTap: () {
                  if (ConnectivityResult.none != true) {
                    setState(() {
                      firstNameEnabled = false;
                      lastNameEnabled = false;
                      contactEnabled = false;
                      updateData(firstNameController.text,
                          lastNameController.text, contactController.text);
                    });
                    //update account in db
                  } else {
                    Fluttertoast.showToast(
                        msg: AppString.txtInternetIsRequired);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 28.13),
                  width: MediaQuery.of(context).size.width / 1.68,
                  height: MediaQuery.of(context).size.height / 18.75,
                  child: Text(
                    AppString.txtUpdateDetails.toUpperCase(),
                    style: TextStyle(
                        fontSize: 14,
                        color: AppColor.colorWhite,
                        fontWeight: FontWeight.bold),
                  ),
                  decoration: BoxDecoration(
                      color: AppColor.colorTheme,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (ConnectivityResult.none != true) {
                    deleteAccount().then((value){
                      if(removeUser?.code!=200){
                        Fluttertoast.showToast(msg: AppString.txtSomeErrorOccurred);
                      }
                      else{
                        AlertDialog(
                          title: Text(AppString.txtDeleteUserConfirmation.toUpperCase(),style: TextStyle(color: AppColor.colorRed,fontSize: 20),),
                          content: Text(AppString.txtDeleteUserConfirmationBody),
                          actions: [
                            TextButton(
                                onPressed: (){
                                  Fluttertoast.showToast(msg: AppString.txtAccountDeleted);
                                  ApiService().logOutUser(email: emailText).then((res) async {
                                    if (res?.code == 200) {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => const LoginScreen()),(Route<dynamic> route) => false);
                                    } else {
                                      print(res?.code);
                                    }
                                  });
                                },
                                child: Text(AppString.txtYesDelete,style: TextStyle(color: AppColor.colorRed),)
                            )
                          ],
                        );
                      }
                    });
                  } else {
                    Fluttertoast.showToast(
                        msg: AppString.txtInternetIsRequired);
                  }

                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 28.13),
                  width: MediaQuery.of(context).size.width / 1.68,
                  height: MediaQuery.of(context).size.height / 18.75,
                  child: Text(
                    AppString.txtDeleteAccount.toUpperCase(),
                    style: TextStyle(
                        fontSize: 14,
                        color: AppColor.colorWhite,
                        fontWeight: FontWeight.bold),
                  ),
                  decoration: BoxDecoration(
                      color: AppColor.colorTheme,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
