import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:piadvisory/Profile/KYC/AddIncomeAndExpense.dart';
import 'package:piadvisory/Profile/KYC/FamilyDetails.dart';

import '../../Common/CustomNextButton.dart';

class KYCThankYouPage extends StatefulWidget {
  const KYCThankYouPage({
    Key? key,
  }) : super(key: key);

  @override
  State<KYCThankYouPage> createState() => _KYCThankYouPageState();
}

Color themeColor = const Color(0xFF43D19E);

class _KYCThankYouPageState extends State<KYCThankYouPage> {
  double screenWidth = 600;
  double screenHeight = 400;
  Color textColor = const Color(0xFF32567A);

  // @override
  // void initState() {
  //   Timer(
  //     Duration(seconds: 2),
  //     () async {
  //       Get.offAllNamed('/profile');
  //     },
  //   );
  //   super.initState();
  // }

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
                color: themeColor,
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
              "Your KYC was successfully completed.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
            SizedBox(height: screenHeight * 0.06),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomNextButton(
                    text: "Family Details",
                    ontap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FamilyDetails()));
                    }),
                CustomNextButton(
                    text: "Income and Expenses",
                    ontap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AddIncomeAndExpenseDetails()));
                    }),
              ],
            )
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
