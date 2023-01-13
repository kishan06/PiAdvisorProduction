// ignore_for_file: file_names


import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:piadvisory/SideMenu/DateRangeWidget.dart';
import 'package:piadvisory/Utils/textStyles.dart';

import '../Common/app_bar.dart';

class ReportsAndStatement extends StatefulWidget {
  const ReportsAndStatement({Key? key}) : super(key: key);

  @override
  State<ReportsAndStatement> createState() => _ReportsAndStatementState();
}

class _ReportsAndStatementState extends State<ReportsAndStatement> {
  String? finalDate;

  Future _showDateRangePicker() async {
    FocusScope.of(context).unfocus();
    final data = await showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: DateRangeWidget(),
          );
        });
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
    setState(() {
      finalDate = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titleTxt: "Reports & Statements",bottomtext: false),
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
      //  SingleChildScrollView(
      //     child: Padding(
      //   padding: const EdgeInsets.only(
      //     left: 20,
      //     right: 20,
      //   ),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       const SizedBox(
      //         height: 30,
      //       ),
      //       Container(
      //         width: double.infinity,
      //         height: 60,
      //         decoration: BoxDecoration(
      //           color: const Color(0xFF008083),
      //           borderRadius: BorderRadius.circular(10),
      //         ),
      //         child: GestureDetector(
      //           onTap: () {
      //             _showDateRangePicker();
      //           },
      //           child: IntrinsicWidth(
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: [
      //                 Text(
      //                   finalDate ?? '2022-04-12      ---      2022-05-12 ',
      //                   style:
      //                       blackStyle(context).copyWith(color: Colors.white),
      //                 ),
      //                 // Text(
      //                 //   "22-04-12",
      //                 //   style:
      //                 //       blackStyle(context).copyWith(color: Colors.white),
      //                 // ),
      //                 // const SizedBox(
      //                 //   width: 20,
      //                 // ),
      //                 // Container(
      //                 //   height: 1,
      //                 //   width: 20,
      //                 //   color: Colors.white,
      //                 // ),
      //                 // const SizedBox(
      //                 //   width: 20,
      //                 // ),
      //                 // Text(
      //                 //   "22-05-12",
      //                 //   style:
      //                 //       blackStyle(context).copyWith(color: Colors.white),
      //                 // ),
      //               ],
      //             ),
      //           ),
      //         ),
      //       ),
      //       const SizedBox(
      //         height: 25,
      //       ),
      //       Card(
      //         shape: OutlineInputBorder(
      //             borderRadius: BorderRadius.circular(10),
      //             borderSide: const BorderSide(color: Color(0xFFDCDCDC))),
      //         child: Padding(
      //           padding: const EdgeInsets.all(16),
      //           child: Column(
      //             children: [
      //               const SizedBox(
      //                 height: 12,
      //               ),
      //               Row(
      //                 //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //                   const Expanded(child: Text("Page 1/1")),
      //                   SvgPicture.asset(
      //                     'assets/images/xlsx.svg',
      //                   ),
      //                   const SizedBox(
      //                     width: 5,
      //                   ),
      //                   SvgPicture.asset(
      //                     'assets/images/download.svg',
      //                     color: Get.isDarkMode? Colors.white: Colors.black
      //                   ),
      //                 ],
      //               ),
      //               const SizedBox(
      //                 height: 12,
      //               ),
      //                Divider(
      //                 thickness: 1,
      //                  color: Get.isDarkMode? Colors.grey: Colors.grey
      //               ),
      //               Column(
      //                 children: [
      //                   SizedBox(
      //                     height: 400,
      //                     child: ListView.builder(
      //                         itemCount: 15,
      //                         itemBuilder: (BuildContext context, int index) {
      //                           return Column(
      //                             children: [
      //                               Padding(
      //                                 padding: const EdgeInsets.symmetric(
      //                                     vertical: 8.0, horizontal: 5),
      //                                 child: Row(
      //                                   crossAxisAlignment:
      //                                       CrossAxisAlignment.start,
      //                                   mainAxisAlignment:
      //                                       MainAxisAlignment.spaceBetween,
      //                                   children: [
      //                                     Expanded(
      //                                       child: Column(
      //                                         crossAxisAlignment:
      //                                             CrossAxisAlignment.start,
      //                                         children: [
      //                                           Text(
      //                                             "2022-04-22",
      //                                             style: blackStyle(context)
      //                                                 .copyWith(
      //                                                     color:Get.isDarkMode? Colors.white: Colors.black,
      //                                                     fontWeight:
      //                                                         FontWeight.bold),
      //                                           ),
      //                                           const SizedBox(
      //                                             height: 4,
      //                                           ),
      //                                           Text(
      //                                             "NSE-EQ",
      //                                             style: blackStyle(context)
      //                                                 .copyWith(
      //                                                     fontSize: 10,
      //                                                     color:Get.isDarkMode? Colors.white: const Color(
      //                                                         0xFF878787)),
      //                                           ),
      //                                           const SizedBox(
      //                                             height: 4,
      //                                           ),
      //                                           const Text(
      //                                               "Net settlement for Equity with settlement number : 2022075"),
      //                                         ],
      //                                       ),
      //                                     ),
      //                                     Expanded(
      //                                       flex: 0,
      //                                       child: Column(
      //                                         mainAxisAlignment:
      //                                             MainAxisAlignment.start,
      //                                         crossAxisAlignment:
      //                                             CrossAxisAlignment.start,
      //                                         children: [
      //                                           Text(
      //                                             "3,1277.72 Dr.",
      //                                             style: blackStyle(context)
      //                                                 .copyWith(
      //                                                     fontSize: 14,
      //                                                     fontWeight:
      //                                                         FontWeight.bold,
      //                                                         color: Get.isDarkMode? Colors.white: Colors.black),
      //                                           ),
      //                                           const SizedBox(
      //                                             height: 25,
      //                                           ),
      //                                           Text(
      //                                             "Balance: 76.73",
      //                                             style: blackStyle(context)
      //                                                 .copyWith(
      //                                                     fontSize: 13,
      //                                                     fontWeight:
      //                                                         FontWeight.bold,
      //                                                     color:Get.isDarkMode? Colors.white: const Color(
      //                                                         0xFF034698)),
      //                                           ),
      //                                         ],
      //                                       ),
      //                                     ),
      //                                   ],
      //                                 ),
      //                               ),
      //                                Divider(
      //                                 color: Get.isDarkMode? Colors.grey: Colors.grey,
      //                               )
      //                             ],
      //                           );
      //                         }),
      //                   ),
      //                 ],
      //               ),
      //             ],
      //           ),
      //         ),
      //       )
      //     ],
      //   ),
      // )
      // ),
      
    );
  }
}
