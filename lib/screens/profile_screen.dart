import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pharmly/res/colors/app_colors.dart';
import 'package:pharmly/res/strings/app_strings.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool firstNameEnabled=false;
  bool lastNameEnabled=false;
  bool contactEnabled=false;
  TextEditingController firstNameController=TextEditingController();
  TextEditingController lastNameController=TextEditingController();
  TextEditingController contactController=TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    contactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(AppStrings.txtProfile),
        centerTitle: true,
        backgroundColor: AppColors.colorBlue.withAlpha(60),
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
                          hintText: "Neh",
                          labelText: AppStrings.txtFirstName,
                          // alignLabelWithHint: true
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
                        child: firstNameEnabled?Icon(Icons.check_rounded,color: AppColors.colorWhite,size: 20,):Icon(Icons.edit,color: AppColors.colorWhite,size: 20,),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: firstNameEnabled?AppColors.colorLightGreen:AppColors.colorBlue,
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
                          hintText: "Majmudar",
                          labelText: AppStrings.txtLastName,
                          // alignLabelWithHint: true
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
                        child: lastNameEnabled?Icon(Icons.check_rounded,color: AppColors.colorWhite,size: 20,):Icon(Icons.edit,color: AppColors.colorWhite,size: 20,),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: lastNameEnabled?AppColors.colorLightGreen:AppColors.colorBlue,
                          borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                      ),
                    )
                  ],
                ),
                GestureDetector(
                  onTap: (){
                    Fluttertoast.showToast(
                      gravity: ToastGravity.CENTER,
                      msg: AppStrings.txtCannotChangeEmail,
                    );
                    print("toast?");
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(vertical: 5),
                    width: MediaQuery.of(context).size.width/1.568,
                    height: MediaQuery.of(context).size.height/11.25,
                    child: TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                        hintText: "neh@neh.com",
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
                          hintText: "9900990099",
                          labelText: AppStrings.txtContact,
                          // alignLabelWithHint: true
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
                        child: contactEnabled?Icon(Icons.check_rounded,color: AppColors.colorWhite,size: 20,):Icon(Icons.edit,color: AppColors.colorWhite,size: 20,),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: contactEnabled?AppColors.colorLightGreen:AppColors.colorBlue,
                          borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                      ),
                    )
                  ],
                ),
                GestureDetector(
                  onTap: (){
                    //update account in db
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/28.13),
                    width: MediaQuery.of(context).size.width / 1.68,
                    height: MediaQuery.of(context).size.height / 18.75,
                    child: Text(AppStrings.txtUpdateDetails.toUpperCase(),style: TextStyle(fontSize: 14,color: AppColors.colorWhite),),
                    decoration: BoxDecoration(
                        color: AppColors.colorLightGreen,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    //delete account from db
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/28.13),
                    width: MediaQuery.of(context).size.width / 1.68,
                    height: MediaQuery.of(context).size.height / 18.75,
                    child: Text(AppStrings.txtDeleteAccount.toUpperCase(),style: TextStyle(fontSize: 14,color: AppColors.colorWhite),),
                    decoration: BoxDecoration(
                      color: AppColors.colorRed,
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
