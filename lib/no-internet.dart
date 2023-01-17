// ignore_for_file: prefer_const_constructors, duplicate_ignore, file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'Common/app_bar.dart';

class No_internet extends StatefulWidget {
  const No_internet({Key? key}) : super(key: key);

  @override
  State<No_internet> createState() => _No_internetState();
}

class _No_internetState extends State<No_internet> {
var isDeviceConnected = false;
bool isAlertSet = false;
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return 
    WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
          appBar: CustomAppBar(titleTxt: "", bottomtext: false),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 50),
              child: Column(
                children: [
                  Center(
                    child: SvgPicture.asset(
                      "assets/images/Group 5522.svg",
                      width: 150,
                      height: 150,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    child: Text(
                      "No Internet Connection!",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    child: Text(
                      "Please check your internet connectivity.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF6B6B6B),
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: GestureDetector(
                        onTap: () async {
                          Navigator.pop(context, "Cancel");
                          setState(() => isAlertSet = false);
                          isDeviceConnected =
                              await InternetConnectionChecker().hasConnection;
                          if (!isDeviceConnected) {
                            Get.to(() => No_internet());
                            setState(() => isAlertSet = true);
                          }
                        },
                        child: Text(
                          "Try Again",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF008083),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ))
                ],
              ),
            ),
          )),
    );
  }
}
