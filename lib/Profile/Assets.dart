import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piadvisory/Common/app_bar.dart';
import 'package:piadvisory/SideMenu/Subscribe/AppWidget.dart';

class Assets extends StatefulWidget {
  const Assets({super.key});

  @override
  State<Assets> createState() => _AssetsState();
}

class _AssetsState extends State<Assets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleTxt: "Assets",
        bottomtext: false,
      ),
      body: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color(0xFFEBEBEB), width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 12.h,
            ),
            Text(
              "My Total Invstments ₹0.00",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 12.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                   IconButton(
                    icon: Icon(Icons.assessment_outlined),
                    onPressed: () {},
                  ),
                  // SizedBox(
                  //   height: 2.h,
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text("Mutual Fund",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black
                    ),
                    ),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text("₹99.k",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black
                    ),
                    ),
                  )
                  ],
                ),
                 Column(
                  children: <Widget>[
                   IconButton(
                    icon: Icon(Icons.snapchat_rounded),
                    onPressed: () {},
                  ),
                  // SizedBox(
                  //   height: 2.h,
                  // ),
                  Text("Fix Deposit",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black
                  ),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Text("₹99.k",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black
                  ),
                  )
                  ],
                ),
                 Column(
                  children: <Widget>[
                   IconButton(
                    icon:  Icon(Icons.star),
                    onPressed: () {},
                  ),
                  // SizedBox(
                  //   height: 2.h,
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Text("Real Estate",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black
                    ),
                    ),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Text("₹99.k",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black
                    ),
                    ),
                  )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
          ],
        )),
      ),
    );
  }
}
