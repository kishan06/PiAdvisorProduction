import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyWatchListTab extends StatefulWidget {
  MyWatchListTab({Key? key}) : super(key: key);

  @override
  State<MyWatchListTab> createState() => _MyWatchListTabState();
}

class _MyWatchListTabState extends State<MyWatchListTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Get.isDarkMode ? Colors.black : Colors.white,
        width: double.infinity,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultTabController(
              length: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TabBar(
                    labelColor: Get.isDarkMode ? Colors.white : Colors.black,
                    indicatorPadding:
                        EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                    // labelPadding: EdgeInsets.symmetric(horizontal: 50),
                    indicatorColor: Color(0xFF008083),
                    isScrollable: false,
                    unselectedLabelStyle: TextStyle(color: Color(0xFF6B6B6B)),
                    labelStyle: TextStyle(
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    padding: EdgeInsets.only(
                      left: 30,
                      right: 30,
                      top: 10,
                      bottom: 10,
                    ),
                    tabs: [
                      Tab(
                        text: "Stocks",
                      ),
                      Tab(
                        text: "Mutual Funds",
                      ),
                    ],
                    indicatorWeight: 1.5,
                  ),
                  SizedBox(
                      // width: double.infinity,
                      height: 500.h,
                      child: TabBarView(children: []))
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
