import 'package:flutter/material.dart';
import 'package:pharmly/res/colors/app_colors.dart';
import 'package:pharmly/res/strings/app_strings.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(AppStrings.txtProfile),
        centerTitle: true,
        backgroundColor: AppColors.colorGrey,
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 200,
                    height: 100,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Neh",
                        labelText: AppStrings.txtFirstName,
                        // alignLabelWithHint: true
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      width: 20,
                      height: 20,
                      child: Icon(Icons.edit,color: AppColors.colorWhite,size: 15,),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.colorRed,
                        borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                    ),
                  )
                ],
              ),
            ],
          )
        ),
      ),
    );
  }
}
