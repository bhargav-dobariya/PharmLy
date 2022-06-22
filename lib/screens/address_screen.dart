import 'package:flutter/material.dart';
import 'package:pharmly/resources/app_color.dart';
import 'package:pharmly/resources/app_string.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.colorBlack12.withAlpha(20),
        appBar: AppBar(
          title: Text(AppString.txtMyAddresses,style: TextStyle(color: AppColor.colorWhite,fontSize: 17),),
          centerTitle: true,
          backgroundColor: AppColor.colorTheme,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: (){},
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/26.13),
                  margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/6.5),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/11,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.add,color: AppColor.colorTheme,size: 20,),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(AppString.txtAddANewAddress,style: TextStyle(fontSize: 15,color: AppColor.colorTheme),),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.colorWhite,
                    boxShadow: [
                      BoxShadow(color: AppColor.colorBlack12,blurRadius: 2,spreadRadius: 2)
                    ]
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/6,
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/26.13),
                child: Text("Address",style: TextStyle(fontSize: 15,color: AppColor.colorBlack),),
                decoration: BoxDecoration(
                  color: AppColor.colorWhite,
                    boxShadow: [
                      BoxShadow(color: AppColor.colorBlack12,blurRadius: 2,spreadRadius: 2)
                    ]
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
