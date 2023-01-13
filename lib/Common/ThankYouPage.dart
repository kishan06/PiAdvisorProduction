// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:piadvisory/Common/Repository/Updatestatus.dart';

class ThankYouPage extends StatefulWidget {
  const ThankYouPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ThankYouPage> createState() => _ThankYouPageState();
}

Color themeColor = const Color(0xFF43D19E);

class _ThankYouPageState extends State<ThankYouPage> {
  double screenWidth = 600;
  double screenHeight = 400;
  Color textColor = const Color(0xFF32567A);

  @override
  void initState() {
    Timer(
      Duration(seconds: 2),
      () async {
        Get.offAllNamed('/schduleAppointment');
      },
    );
    UpdateStatus().Updatestatus(); 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 170,
              padding: EdgeInsets.all(35),
              decoration: BoxDecoration(
                color: themeColor,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                "assets/images/card.png",
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: screenHeight * 0.1),
            Text(
              "Thank You!",
              style: TextStyle(
                color:  Color(0xFF008083),
                fontWeight: FontWeight.w600,
                fontSize: 36,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            // Text(
            //   "Payment done Successfully",
            //   style: TextStyle(
            //     color: Colors.black87,
            //     fontWeight: FontWeight.w400,
            //     fontSize: 17,
            //   ),
            // ),
            SizedBox(height: screenHeight * 0.05),
            Text(
              "You will be redirected to the Scheduling Session page shortly, please proceed with booking your advisory session",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            SizedBox(height: screenHeight * 0.06),
            // Flexible(
            //   child: HomeButton(
            //     title: 'Home',
            //     onTap: () {},
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
