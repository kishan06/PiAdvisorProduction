// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:piadvisory/Common/CreateBottomBar.dart';
import 'package:piadvisory/Common/GlobalFuntionsVariables.dart';
import 'package:piadvisory/HomePage/Stock/stock.dart';

import '../smallcase_api_methods.dart';
import '/Common/fab_bottom_app_bar.dart';
import '/Portfolio/PortfolioMainUI.dart';
import '/SideMenu/Subscribe/Mysubscription.dart';
import '/Utils/custom_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../Common/app_bar.dart';
import '../HomePage/Homepage.dart';

import '../Profile/KYC/SchduleAppointment.dart';

class resoures extends StatefulWidget {
  const resoures({Key? key}) : super(key: key);

  @override
  State<resoures> createState() => _resouresState();
}

class _resouresState extends State<resoures> {
  String _lastSelected = 'TAB: 0';
  void _selectedTab(int index) {
    setState(() {
      _lastSelected = 'TAB: $index';
      print(_lastSelected);

      switch (index) {
        case 0:
          {
            Navigator.push(
                context, MaterialPageRoute(builder: ((context) => HomePage())));
          }
          break;

        case 1:
          {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => Stocks(
                          selectedPage: 0,
                        ))));
          }
          break;

        case 2:
          {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => Mysubscription())));
          }
          break;
        case 3:
          {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => SchduleAppointment())));
          }
          break;
        case 4:
          {
            openDashboardPage(context);
            // Navigator.push(context,
            //     MaterialPageRoute(builder: ((context) => PortfolioMainUI())));
          }
          break;
        default:
          {
            throw Error();
          }
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: CustomAppBar(titleTxt: "My Resources",bottomtext: false,),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 22,
            right: MediaQuery.of(context).size.width * 0.43,
            child: FloatingActionButton(
              backgroundColor: Color(0xFFF78104),
              heroTag: "tag1",
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const Mysubscription())));
              },
              tooltip: 'Subscribe',
              elevation: 2.0,
              child: SvgPicture.asset(
                  "assets/images/product sans logo wh new.svg",
                  color: Colors.white,
                  fit: BoxFit.contain,
                  width: 28,
                  height: 24,
                ),
            ),
          ),
        ],
      ),
      bottomNavigationBar:CreateBottomBar(stateBottomNav, "Bottombar", context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 170,
              padding: EdgeInsets.all(35),
              // decoration: BoxDecoration(
              //   color: themeColor,
              //  // shape: BoxShape.circle,
              // ),
              child: Center(
                child: Image.asset(
                  "assets/images/Nodata.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(
              height: 1
              // screenHeight * 0.1
              ),
            Center(
              child: Text(
                "No Data Available",
                style: TextStyle(
                  color: Colors.black,
                   //Color(0xFF008083),
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
      // No Data section for now

      // SingleChildScrollView(
      //     child: Padding(
      //   padding: EdgeInsets.only(
      //     left: 20,
      //     right: 20,
      //   ),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       SizedBox(
      //         height: 20,
      //       ),
      //       download(
      //           title: "Standard Portfolio Advice Sheet",
      //           subtitle: "May 04, 12:55"),
      //       download(
      //           title: "Market Research Documents", subtitle: "May 04, 12:55"),
      //       download(
      //           title: "Tax Planning Cheat Sheet", subtitle: "May 04, 12:55"),
      //       download(
      //           title: "Tax Planning Cheat Sheet", subtitle: "May 04, 12:55"),
      //       download(
      //           title: "Tax Planning Cheat Sheet", subtitle: "May 04, 12:55"),
      //     ],
      //   ),
      // )
      // ),
    );
  }
}

class download extends StatelessWidget {
  download({
    Key? key,
    required this.title,
    required this.subtitle,
    this.ontap,
    this.showview = false,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final GestureTapCallback? ontap;
  bool? showview;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFDFDFDF))),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              border: Border(

                  // bottom: BorderSide(color: Colors.black),
                  ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 14.sm,
                          color: Get.isDarkMode? Colors.white: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color:Get.isDarkMode? Colors.white: Color(0xFF6B6B6B),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                showview!
                    ? GestureDetector(
                        onTap: () {
                          ontap!();
                        },
                        child: SizedBox(
                          child: Text(
                            "View",
                            style: TextStyle(
                                fontSize: 10,
                                color: Color(0xFF008083),
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          //ontap!();
                        },
                        child: SizedBox(
                          child: Text(
                            "Download PDF",
                            style: TextStyle(
                                fontSize: 10,
                                color: Color(0xFF008083),
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
