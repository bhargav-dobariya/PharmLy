import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pharmly/methods/checkInternetConnectivity.dart';
import 'package:pharmly/models/get_user_model.dart';
import 'package:pharmly/networking/api_service.dart';
import 'package:pharmly/resources/app_color.dart';
import 'package:pharmly/resources/app_string.dart';
import 'package:pharmly/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool firstNameEnabled=false;
  bool lastNameEnabled=false;
  bool contactEnabled=false;
  bool emailEnabled=false;
  TextEditingController firstNameController=TextEditingController();
  TextEditingController lastNameController=TextEditingController();
  TextEditingController contactController=TextEditingController();
  String? emailText;
  late StreamSubscription subscription;
  late SharedPreferences userLogIn;
  var userData;
  var updateUserData;

  String userFirstName="";
  String userLastName="";
  String userContactNo="";

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    contactController.dispose();
    super.dispose();
  }

  getData() async{
    UserProfile? userData=await ApiService().getUserDetails();
    lastNameController.text=userData?.data?.lastName ?? "Majmudar";
    contactController.text=userData?.data?.contactNo ?? "9900990099";
    firstNameController.text=userData?.data?.firstName ?? "NEh";
    emailText=userData?.data?.email ?? "NEh";
    setState(() {});
  }

  updateData(String newFirstName,String newLastName,String newContactNo) async{
    await ApiService().updateUserDetails(firstName: newFirstName,lastName: newLastName,contactNo: newContactNo);
  }

  void userLoggedIn()async{
    userLogIn=await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    getData();
    super.initState();
    userLoggedIn();
    subscription=Connectivity().onConnectivityChanged.listen(showConnectivityToast);
    // userDetails=ApiService.getUserDetails();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(AppString.txtProfile,style: TextStyle(fontFamily: 'Mali')),
        centerTitle: true,
        backgroundColor: AppColor.colorTheme,
        elevation: 1,
        actions: [
          TextButton(
            onPressed: (){
              ApiService().logOutUser(email: emailText).then((res) async{
                if(res?.code==200){
                  userLogIn.setBool('isLoggedIn', false);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                }
                else{
                  print(res?.code);
                }
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width/4.9,
              height: MediaQuery.of(context).size.height/28.13,
              alignment: Alignment.center,
              child: Text(AppString.txtSignOut,style: TextStyle(color: AppColor.colorWhite,fontSize: 10),),
              decoration: BoxDecoration(
                color: AppColor.colorRedAccent,
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
            )
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width/1.568,
                      height: MediaQuery.of(context).size.height/11.25,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: TextFormField(
                        controller: firstNameController,
                        enabled: firstNameEnabled,
                        decoration: InputDecoration(
                          labelText: AppString.txtFirstName,
                          alignLabelWithHint: true
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          firstNameEnabled=!firstNameEnabled;
                          //update database method()
                        });
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        child: firstNameEnabled?Icon(Icons.check_rounded,color: AppColor.colorWhite,size: 20,):Icon(Icons.edit,color: AppColor.colorWhite,size: 20,),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: firstNameEnabled?AppColor.colorLightGreen:AppColor.colorBlue,
                          borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      width: MediaQuery.of(context).size.width/1.568,
                      height: MediaQuery.of(context).size.height/11.25,
                      child: TextFormField(
                        controller: lastNameController,
                        enabled: lastNameEnabled,
                        decoration: InputDecoration(
                          labelText: AppString.txtLastName,
                          alignLabelWithHint: true
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          lastNameEnabled=!lastNameEnabled;
                          //update database method()
                        });
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        child: lastNameEnabled?Icon(Icons.check_rounded,color: AppColor.colorWhite,size: 20,):Icon(Icons.edit,color: AppColor.colorWhite,size: 20,),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: lastNameEnabled?AppColor.colorLightGreen:AppColor.colorBlue,
                          borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                      ),
                    )
                  ],
                ),
                GestureDetector(
                  onTap: (){
                    Fluttertoast.showToast(msg: AppString.txtCannotChangeEmail);
                    print("toast?");
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(vertical: 5),
                    width: MediaQuery.of(context).size.width/1.568,
                    height: MediaQuery.of(context).size.height/11.25,
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
                      margin: EdgeInsets.symmetric(vertical: 5),
                      width: MediaQuery.of(context).size.width/1.568,
                      height: MediaQuery.of(context).size.height/11.25,
                      child: TextFormField(
                        controller: contactController,
                        enabled: contactEnabled,
                        decoration: InputDecoration(
                          fillColor: AppColor.colorRed,
                          labelText: AppString.txtContact,
                          alignLabelWithHint: true
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          contactEnabled=!contactEnabled;
                          //update database method()
                        });
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        child: contactEnabled?Icon(Icons.check_rounded,color: AppColor.colorWhite,size: 20,):Icon(Icons.edit,color: AppColor.colorWhite,size: 20,),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: contactEnabled?AppColor.colorLightGreen:AppColor.colorBlue,
                          borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                      ),
                    )
                  ],
                ),
                GestureDetector(
                  onTap: (){
                    if(ConnectivityResult.none != true){
                      setState(() {
                        firstNameEnabled=false;
                        lastNameEnabled=false;
                        contactEnabled=false;
                        updateData(firstNameController.text,lastNameController.text,contactController.text);
                      });
                      //update account in db
                    }
                    else{
                      Fluttertoast.showToast(msg: AppString.txtInternetIsRequired);
                    }
                  },

                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/28.13),
                    width: MediaQuery.of(context).size.width / 1.68,
                    height: MediaQuery.of(context).size.height / 18.75,
                    child: Text(AppString.txtUpdateDetails.toUpperCase(),style: TextStyle(fontSize: 14,color: AppColor.colorWhite,fontWeight: FontWeight.bold),),
                    decoration: BoxDecoration(
                        color: AppColor.colorTheme,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    if(ConnectivityResult.none != true){
                      //delete account from db
                    }
                    else{
                      Fluttertoast.showToast(msg: AppString.txtInternetIsRequired);
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/28.13),
                    width: MediaQuery.of(context).size.width / 1.68,
                    height: MediaQuery.of(context).size.height / 18.75,
                    child: Text(AppString.txtDeleteAccount.toUpperCase(),style: TextStyle(fontSize: 14,color: AppColor.colorWhite,fontWeight: FontWeight.bold),),
                    decoration: BoxDecoration(
                      color: AppColor.colorTheme,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
              ],
            ),
          )
        ),
      ),
    );
  }
}
