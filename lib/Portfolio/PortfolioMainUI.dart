// ignore_for_file: file_names, avoid_print

import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:piadvisory/Common/PieChart.dart';
import 'package:piadvisory/Common/PieChartLiabilities.dart';
import 'package:piadvisory/HomePage/Homepage.dart';
import 'package:piadvisory/HomePage/Notifications/Notification.dart';
import 'package:piadvisory/HomePage/Stock/stock.dart';
import 'package:piadvisory/Profile/GoalsRepository/storeGoals.dart';
import 'package:piadvisory/Profile/ProfileMain.dart';
import 'package:piadvisory/Profile/goal.dart';
import 'package:piadvisory/SideMenu/Brokerage/broker.dart';
import 'package:piadvisory/SideMenu/Brokerage/broker_account_model.dart';
import 'package:piadvisory/SideMenu/NavDrawer.dart';
import 'package:piadvisory/SideMenu/Subscribe/Mysubscription.dart';
import 'package:piadvisory/Profile/KYC/SchduleAppointment.dart';
import 'package:piadvisory/SideMenu/myresources.dart';
import 'package:piadvisory/Utils/custom_icons_icons.dart';
import 'package:piadvisory/Utils/textStyles.dart';
import 'package:scgateway_flutter_plugin/scgateway_flutter_plugin.dart';
import 'package:async/async.dart';

import '../Common/holding_model.dart';
import '../Common/user_id.dart';
import '../smallcase_api_methods.dart';

class PortfolioMainUI extends StatefulWidget {
  const PortfolioMainUI({Key? key}) : super(key: key);

  @override
  State<PortfolioMainUI> createState() => _PortfolioMainUIState();
}

class _PortfolioMainUIState extends State<PortfolioMainUI> {
  void _selectedTab(int index) {
    setState(() {
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
            // openDashboardPage(context);
          }
          break;
        default:
          {
            throw Error();
          }
      }
    });
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        extendBody: false,
        backgroundColor: Color(0xFF878787),
        key: _key,
        drawer: NavDrawer(),
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
                  "assets/images/product sans logo wh.svg",
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: TextStyle(color: Color(0xFFF78104)),
          unselectedLabelStyle: TextStyle(color: Colors.grey),
          unselectedIconTheme: IconThemeData(color: Colors.grey),
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                CustomIcons.path_3177,
                //  color:
                //       Get.isDarkMode ? Color(0xFFF78104) : Color(0xFFF78104)
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(
                  CustomIcons.path_4346,
                  //  color:
                  //     Get.isDarkMode ? Color(0xFFF78104) : Color(0xFFF78104)
                ),
              ),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CustomIcons.group_2369,
                //  color:
                //       Get.isDarkMode ? Color(0xFFF78104) : Color(0xFFF78104)
              ),
              label: 'Subscribe',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CustomIcons.date_range,
                //  color:
                //         Get.isDarkMode ? Color(0xFFF78104) : Color(0xFFF78104)
              ),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CustomIcons.bottombarbagicon,
                size: 22.5,
                //  color:
                //       Get.isDarkMode ? Color(0xFFF78104) : Color(0xFFF78104)
              ),
              label: 'Dashboard',
            ),
          ],
          currentIndex: 4,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Color(0xFFF78104),
          backgroundColor: Colors.white,
          onTap: (index) {
            print(index);
            _selectedTab(index);
          },
          type: BottomNavigationBarType.fixed,
        ),
        appBar: AppBar(
          bottom: TabBar(
            indicatorColor: Color(0xFF008083),
            unselectedLabelStyle: TextStyle(color: Color(0xFF6B6B6B)),
            labelColor: Colors.black,
            labelStyle: TextStyle(
              color: Color(0xFF000000),
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
            tabs: [
              Tab(
                text: "Net Worth",
              ),
              Tab(
                text: "Goal Tracker",
              ),
              // Tab(
              //   text: "Taxation",
              // ),
            ],
          ),
          backgroundColor: Colors.white,
          elevation: 2,
          shadowColor: Colors.black,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          title: Text("Dashboard"),
          leading: Row(
            children: [
              IconButton(
                onPressed: () {
                  _key.currentState!.openDrawer();
                },
                icon: Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                iconSize: 25,
              ),
            ],
          ),
          actions: [
            // IconButton(
            //   onPressed: () {},
            //   icon: SvgPicture.asset(
            //     'assets/images/search-icon.svg',
            //   ),
            //   iconSize: 22,
            //   color: const Color(0xFF6B6B6B),
            // ),
            // IconButton(
            //   onPressed: () {
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: ((context) => const Notify())));
            //   },
            //   icon: SvgPicture.asset(
            //     'assets/images/notification-icon.svg',
            //   ),
            //   iconSize: 22,
            //   color: const Color(0xFF6B6B6B),
            // ),
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const ProfileMain())));
              },
              icon: SvgPicture.asset(
                'assets/images/Profile1.svg',
              ),
              iconSize: 22,
              color: const Color(0xFF303030),
            ),
          ],
        ),
        body: TabBarView(
          physics: BouncingScrollPhysics(),
          dragStartBehavior: DragStartBehavior.down,
          children: [
            //net worth
            PortfolioMain(),

            //goal tracker
            GoalsTracker(),

            //taxation
            //Taxation(),
          ],
        ),
      ),
    );
  }
}

class PortfolioMain extends StatefulWidget {
  const PortfolioMain({Key? key}) : super(key: key);

  @override
  State<PortfolioMain> createState() => _PortfolioMainState();
}

class _PortfolioMainState extends State<PortfolioMain> {
  bool showingAdditionalDetails = false;
  bool showingAdditionalDetails2 = false;

  double myNetWorth = 0;

  late Widget body;

  Map<String, dynamic>? userHoldings;

  Widget netWorthPage(Map<String, dynamic> fetchedHoldings) {
    List data = fetchedHoldings['securities'];
    var mapped =
        data.map<HoldingModel>((json) => HoldingModel.fromJson(json)).toList();
    mapped.forEach((holding) {
      myNetWorth +=
          double.parse(holding.averagePrice!) * double.parse(holding.quantity!);
    });
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 60,
            child: Card(
              elevation: 1,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 2, color: Color(0xFFF78104)),
                  ),
                  color: Get.isDarkMode
                      ? Color(0xFF303030).withOpacity(0.4)
                      : Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "My Net Worth",
                      style: blackStyle(context).copyWith(
                          color: Get.isDarkMode ? Colors.white : Colors.black),
                    ),
                    Text(
                      "₹ ${myNetWorth.toStringAsFixed(2)}",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Get.isDarkMode ? Colors.white : Colors.black),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Color(0xFFEBEBEB), width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Assets",
                            style: blackStyle(context).copyWith(
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : const Color(0xFF6B6B6B)),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          "₹ 1,00,000",
                          style: blackStyle(context).copyWith(
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  PieChartSample1(holdings: fetchedHoldings),
                  const SizedBox(
                    height: 30,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Expanded(
                  //       flex: 10,
                  //       child: GestureDetector(
                  //         onTap: () {
                  //           setState(() {
                  //             showingAdditionalDetails =
                  //                 !showingAdditionalDetails;
                  //           });
                  //         },
                  //         child: Text(
                  //           "View Details",
                  //           style: blackStyle(context).copyWith(
                  //               fontSize: 14,
                  //               fontWeight: FontWeight.bold,
                  //               color: Get.isDarkMode
                  //                   ? Colors.white
                  //                   : Colors.black),
                  //         ),
                  //       ),
                  //     ),
                  //     Expanded(
                  //       flex: 2,
                  //       child: Icon(
                  //         !showingAdditionalDetails
                  //             ? Icons.keyboard_arrow_down_rounded
                  //             : Icons.keyboard_arrow_up_rounded,
                  //         color: Get.isDarkMode ? Colors.white : Colors.black,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  //if (showingAdditionalDetails)
                  // Column(
                  //   children: [
                  //     Divider(
                  //       thickness: 1.5,
                  //     ),
                  //     Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //       children: [
                  //         const Text("       "),
                  //         Text(
                  //           "Invited Amount",
                  //           style: blackStyle(context).copyWith(
                  //               fontSize: 12,
                  //               color: Get.isDarkMode
                  //                   ? Colors.white
                  //                   : const Color(0xFF6B6B6B)),
                  //         ),
                  //         Text(
                  //           "Count Value",
                  //           style: blackStyle(context).copyWith(
                  //               fontSize: 12,
                  //               color: Get.isDarkMode
                  //                   ? Colors.white
                  //                   : const Color(0xFF6B6B6B)),
                  //         ),
                  //         Text(
                  //           "Profit",
                  //           style: blackStyle(context).copyWith(
                  //               fontSize: 12,
                  //               color: Get.isDarkMode
                  //                   ? Colors.white
                  //                   : const Color(0xFF6B6B6B)),
                  //         ),
                  //       ],
                  //     ),
                  //     const SizedBox(
                  //       height: 10,
                  //     ),
                  //     Row(
                  //       children: [
                  //         Expanded(
                  //             flex: 2,
                  //             child: Text(
                  //               "Equity",
                  //               style: blackStyle(context).copyWith(
                  //                   fontSize: 14,
                  //                   color: Get.isDarkMode
                  //                       ? Colors.white
                  //                       : Colors.black,
                  //                   fontWeight: FontWeight.w600),
                  //             )),
                  //         Expanded(
                  //             flex: 2,
                  //             child: Text(
                  //               "15K",
                  //               style: blackStyle(context).copyWith(
                  //                 fontSize: 14,
                  //                 color: Get.isDarkMode
                  //                     ? Colors.white
                  //                     : Colors.black,
                  //               ),
                  //             )),
                  //         Expanded(
                  //             flex: 1,
                  //             child: Text(
                  //               "20K",
                  //               style: blackStyle(context).copyWith(
                  //                   fontSize: 14,
                  //                   color: Get.isDarkMode
                  //                       ? Colors.white
                  //                       : Colors.black),
                  //             )),
                  //         Expanded(
                  //             flex: 0,
                  //             child: Row(
                  //               children: [
                  //                 Text(
                  //                   "5K",
                  //                   style: blackStyle(context).copyWith(
                  //                       fontSize: 14,
                  //                       color: Get.isDarkMode
                  //                           ? Colors.white
                  //                           : Colors.black),
                  //                 ),
                  //                 Text(
                  //                   "(+33%)",
                  //                   style: blackStyle(context).copyWith(
                  //                       fontSize: 12, color: Colors.green),
                  //                 ),
                  //               ],
                  //             )),
                  //       ],
                  //     ),
                  //     const SizedBox(
                  //       height: 5,
                  //     ),
                  //     const Divider(
                  //       thickness: 1,
                  //     ),
                  //     Row(
                  //       children: [
                  //         Expanded(
                  //             flex: 2,
                  //             child: Text(
                  //               "MF",
                  //               style: blackStyle(context).copyWith(
                  //                   fontSize: 14,
                  //                   color: Get.isDarkMode
                  //                       ? Colors.white
                  //                       : Colors.black,
                  //                   fontWeight: FontWeight.w600),
                  //             )),
                  //         Expanded(
                  //             flex: 2,
                  //             child: Text(
                  //               "15K",
                  //               style: blackStyle(context).copyWith(
                  //                   fontSize: 14,
                  //                   color: Get.isDarkMode
                  //                       ? Colors.white
                  //                       : Colors.black),
                  //             )),
                  //         Expanded(
                  //             flex: 1,
                  //             child: Text(
                  //               "20K",
                  //               style: blackStyle(context).copyWith(
                  //                   fontSize: 14,
                  //                   color: Get.isDarkMode
                  //                       ? Colors.white
                  //                       : Colors.black),
                  //             )),
                  //         Expanded(
                  //             flex: 0,
                  //             child: Row(
                  //               children: [
                  //                 Text(
                  //                   "5K",
                  //                   style: blackStyle(context).copyWith(
                  //                       fontSize: 14,
                  //                       color: Get.isDarkMode
                  //                           ? Colors.white
                  //                           : Colors.black),
                  //                 ),
                  //                 Text(
                  //                   "(+33%)",
                  //                   style: blackStyle(context).copyWith(
                  //                       fontSize: 12, color: Colors.green),
                  //                 ),
                  //               ],
                  //             )),
                  //       ],
                  //     ),
                  //     const SizedBox(
                  //       height: 5,
                  //     ),
                  //     const Divider(
                  //       thickness: 1,
                  //     ),
                  //     Row(
                  //       children: [
                  //         Expanded(
                  //             flex: 2,
                  //             child: Text(
                  //               "FD",
                  //               style: blackStyle(context).copyWith(
                  //                   fontSize: 14,
                  //                   color: Get.isDarkMode
                  //                       ? Colors.white
                  //                       : Colors.black,
                  //                   fontWeight: FontWeight.w600),
                  //             )),
                  //         Expanded(
                  //             flex: 2,
                  //             child: Text(
                  //               "15K",
                  //               style: blackStyle(context).copyWith(
                  //                   fontSize: 14,
                  //                   color: Get.isDarkMode
                  //                       ? Colors.white
                  //                       : Colors.black),
                  //             )),
                  //         Expanded(
                  //             flex: 1,
                  //             child: Text(
                  //               "20K",
                  //               style: blackStyle(context).copyWith(
                  //                   fontSize: 14,
                  //                   color: Get.isDarkMode
                  //                       ? Colors.white
                  //                       : Colors.black),
                  //             )),
                  //         Expanded(
                  //             flex: 0,
                  //             child: Row(
                  //               children: [
                  //                 Text(
                  //                   "5K",
                  //                   style: blackStyle(context).copyWith(
                  //                       fontSize: 14,
                  //                       color: Get.isDarkMode
                  //                           ? Colors.white
                  //                           : Colors.black),
                  //                 ),
                  //                 Text(
                  //                   "(+33%)",
                  //                   style: blackStyle(context).copyWith(
                  //                       fontSize: 12, color: Colors.green),
                  //                 ),
                  //               ],
                  //             )),
                  //       ],
                  //     ),
                  //     const SizedBox(
                  //       height: 5,
                  //     ),
                  //     const Divider(
                  //       thickness: 1,
                  //     ),
                  //     Row(
                  //       children: [
                  //         Expanded(
                  //             flex: 1,
                  //             child: Text(
                  //               "Real Estate",
                  //               style: blackStyle(context).copyWith(
                  //                   fontSize: 14,
                  //                   color: Get.isDarkMode
                  //                       ? Colors.white
                  //                       : Colors.black,
                  //                   fontWeight: FontWeight.w600),
                  //             )),
                  //         const Expanded(flex: 1, child: Text("--")),
                  //         const Expanded(flex: 1, child: Text("--")),
                  //         const Expanded(flex: 0, child: Text("--")),
                  //       ],
                  //     ),
                  //   ],
                  // )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          // Card(
          //   elevation: 1,
          //   shape: RoundedRectangleBorder(
          //     side: const BorderSide(color: Color(0xFFEBEBEB), width: 1),
          //     borderRadius: BorderRadius.circular(10),
          //   ),
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Column(
          //       children: [
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceAround,
          //           children: [
          //             Expanded(
          //               child: Padding(
          //                 padding: const EdgeInsets.only(left: 8.0),
          //                 child: Text(
          //                   "Liability",
          //                   style: blackStyle(context).copyWith(
          //                       color: Get.isDarkMode
          //                           ? Colors.white
          //                           : const Color(0xFF6B6B6B)),
          //                 ),
          //               ),
          //             ),
          //             Expanded(
          //               flex: 1,
          //               child: Text(
          //                 "₹ 40,000",
          //                 style: blackStyle(context).copyWith(
          //                     color:
          //                         Get.isDarkMode ? Colors.white : Colors.black,
          //                     fontWeight: FontWeight.bold),
          //               ),
          //             ),
          //           ],
          //         ),
          //         const Divider(
          //           thickness: 2,
          //         ),
          //         const PieChartLiabilites(),
          //         const SizedBox(
          //           height: 30,
          //         ),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           children: [
          //             Expanded(
          //               flex: 10,
          //               child: GestureDetector(
          //                 onTap: () {
          //                   setState(() {
          //                     showingAdditionalDetails2 =
          //                         !showingAdditionalDetails2;
          //                   });
          //                 },
          //                 child: Text(
          //                   "View Details",
          //                   style: blackStyle(context).copyWith(
          //                       fontSize: 14,
          //                       fontWeight: FontWeight.bold,
          //                       color: Get.isDarkMode
          //                           ? Colors.white
          //                           : Colors.black),
          //                 ),
          //               ),
          //             ),
          //             Expanded(
          //               flex: 2,
          //               child: Icon(
          //                 !showingAdditionalDetails2
          //                     ? Icons.keyboard_arrow_down_rounded
          //                     : Icons.keyboard_arrow_up_rounded,
          //                 color: Get.isDarkMode ? Colors.white : Colors.black,
          //               ),
          //             ),
          //           ],
          //         ),
          //         //  const SizedBox(height: 10),
          //         if (showingAdditionalDetails2)
          //           Column(
          //             children: [
          //               Divider(
          //                 thickness: 1.5,
          //               ),
          //               Row(
          //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //                 children: [
          //                   const Expanded(flex: 1, child: Text("")),
          //                   Expanded(
          //                     flex: 1,
          //                     child: Column(
          //                       crossAxisAlignment: CrossAxisAlignment.end,
          //                       children: [
          //                         Text(
          //                           "Borrowed",
          //                           style: blackStyle(context).copyWith(
          //                               fontSize: 12.sp,
          //                               color: Get.isDarkMode
          //                                   ? Colors.white
          //                                   : const Color(0xFF6B6B6B)),
          //                         ),
          //                         Text(
          //                           " Amount",
          //                           style: blackStyle(context).copyWith(
          //                               fontSize: 12.sp,
          //                               color: Get.isDarkMode
          //                                   ? Colors.white
          //                                   : const Color(0xFF6B6B6B)),
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                   SizedBox(
          //                     width: 6,
          //                   ),
          //                   Expanded(
          //                     flex: 1,
          //                     child: Column(
          //                       children: [
          //                         Text(
          //                           "Current ",
          //                           style: blackStyle(context).copyWith(
          //                               fontSize: 12.sp,
          //                               color: Get.isDarkMode
          //                                   ? Colors.white
          //                                   : const Color(0xFF6B6B6B)),
          //                         ),
          //                         Text(
          //                           " Outstanding",
          //                           style: blackStyle(context).copyWith(
          //                               fontSize: 12.sp,
          //                               color: Get.isDarkMode
          //                                   ? Colors.white
          //                                   : const Color(0xFF6B6B6B)),
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                   SizedBox(
          //                     width: 6,
          //                   ),
          //                   Expanded(
          //                     flex: 1,
          //                     child: Column(
          //                       crossAxisAlignment: CrossAxisAlignment.start,
          //                       children: [
          //                         Text(
          //                           "Rate(%)",
          //                           style: blackStyle(context).copyWith(
          //                               fontSize: 12.sp,
          //                               color: Get.isDarkMode
          //                                   ? Colors.white
          //                                   : const Color(0xFF6B6B6B)),
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                   // SizedBox(
          //                   //   width: 6,
          //                   // ),
          //                 ],
          //               ),
          //               const SizedBox(
          //                 height: 10,
          //               ),
          //               Row(
          //                 children: [
          //                   Expanded(
          //                       flex: 2,
          //                       child: Text(
          //                         "Home Loan",
          //                         style: blackStyle(context).copyWith(
          //                             fontSize: 14,
          //                             fontWeight: FontWeight.w600,
          //                             color: Get.isDarkMode
          //                                 ? Colors.white
          //                                 : Colors.black),
          //                       )),
          //                   Expanded(flex: 1, child: Text("25K")),
          //                   Expanded(flex: 1, child: Text("10K")),
          //                   Expanded(flex: 1, child: Text("7%")),
          //                 ],
          //               ),
          //               const SizedBox(
          //                 height: 5,
          //               ),
          //               const Divider(
          //                 thickness: 1,
          //               ),
          //               Row(
          //                 children: [
          //                   Expanded(
          //                       flex: 2,
          //                       child: Text(
          //                         "Personal Loan",
          //                         style: blackStyle(context).copyWith(
          //                             fontSize: 14,
          //                             fontWeight: FontWeight.w600,
          //                             color: Get.isDarkMode
          //                                 ? Colors.white
          //                                 : Colors.black),
          //                       )),
          //                   Expanded(flex: 1, child: Text("15K")),
          //                   Expanded(flex: 1, child: Text("20K")),
          //                   Expanded(flex: 1, child: Text("10%")),
          //                 ],
          //               ),
          //               const SizedBox(
          //                 height: 5,
          //               ),
          //               const Divider(
          //                 thickness: 1,
          //               ),
          //               Row(
          //                 children: [
          //                   Expanded(
          //                       flex: 2,
          //                       child: Text(
          //                         "Car Loan",
          //                         style: blackStyle(context).copyWith(
          //                             fontSize: 14,
          //                             fontWeight: FontWeight.w600,
          //                             color: Get.isDarkMode
          //                                 ? Colors.white
          //                                 : Colors.black),
          //                       )),
          //                   Expanded(flex: 1, child: Text("15K")),
          //                   Expanded(flex: 1, child: Text("10K")),
          //                   Expanded(flex: 1, child: Text("20%")),
          //                 ],
          //               ),
          //               SizedBox(
          //                 height: 30,
          //               )
          //             ],
          //           )
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    ));
  }

  FutureGroup fetchUserIdAndBrokerAccounts = FutureGroup();
  List<BrokerAccountModel> myBrokerAccounts = [];
  @override
  void initState() {
    super.initState();
    fetchUserIdAndBrokerAccounts.add(getUserId());
    fetchUserIdAndBrokerAccounts.add(fetchBrokerAccounts());
    fetchUserIdAndBrokerAccounts.close();
    body = Center(child: CircularProgressIndicator());
    fetchUserIdAndBrokerAccounts.future.then((value) {
      int userId = value[0];
      List<BrokerAccountModel> brokerAccounts = value[1];
      try {
        myBrokerAccounts.addAll(brokerAccounts
            .where((element) => element.userId == userId.toString()));
      } catch (e) {}
      debugPrint("myBrokerAccounts.length ${myBrokerAccounts.length}");
      debugPrint("BrokerAccounts.length ${brokerAccounts.length}");
      if (myBrokerAccounts.isEmpty) {
        setState(() {
          body = Center(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("You need to add broker account"),
              Text("to fetch holdings"),
              SizedBox(height: 6),
              OutlinedButton(
                onPressed: () {
                  Get.off(Broker());
                },
                child: Text("Brokerage Account"),
              )
            ],
          ));
        });
      } else {
        setBodyToBrokers();
      }
    });
  }

  void setBodyToBrokers() {
    setState(() {
      body = Padding(
        padding: const EdgeInsets.only(top: 28, left: 28, right: 28),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text("Please select your broker account"),
          SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: myBrokerAccounts.length,
              itemBuilder: (context, index) {
                return OutlinedButton(
                  onPressed: () {
                    setState(() {
                      body = Center(child: CircularProgressIndicator());
                    });
                    fetchHoldingsImportTxnId(
                            myBrokerAccounts.elementAt(index).authToken!)
                        .then((txnIdResponse) {
                      if (txnIdResponse.statusCode == 200) {
                        debugPrint('SESSION STARTED');
                        debugPrint(
                            'AUTH TOKEN: ${myBrokerAccounts.elementAt(index).authToken!}');
                        fetchHoldingsImportTxnId(
                                myBrokerAccounts.elementAt(index).authToken!)
                            .then((txnRes) {
                          String txnId =
                              jsonDecode(txnRes.body)['data']['transactionId'];
                          debugPrint('TXN ID $txnId');
                          ScgatewayFlutterPlugin.triggerGatewayTransaction(
                                  txnId)
                              .then(
                            (txnRes) {
                              debugPrint('TXN RES $txnRes');
                              if (txnRes != null) {
                                fetchHoldings(
                                        //holdingsAuthToken
                                        myBrokerAccounts
                                            .elementAt(index)
                                            .authToken!)
                                    .then(
                                  (holdings) {
                                    setState(() {
                                      body = netWorthPage(holdings);
                                    });
                                  },
                                );
                              }
                            },
                          );
                        });
                      } else {
                        debugPrint('SESSION EXPIRED');
                        onTxnTimeout();
                      }
                    });
                  },
                  child: Text(myBrokerAccounts.elementAt(index).brokerName!),
                );
              },
            ),
          )
        ]),
      );
    });
  }

  void onTxnTimeout() {
    bool showDialogContent = true;
    bool replaceDialogContentWithLoader = false;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(content: StatefulBuilder(
              builder: (context, setDialogState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Visibility(
                      visible: showDialogContent,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Transaction Timeout",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              )),
                          SizedBox(height: 18),
                          Text("You need to login again to continue"),
                          SizedBox(height: 18),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              OutlinedButton(
                                onPressed: () {
                                  setBodyToBrokers();
                                  Get.back();
                                },
                                child: Text("Cancel"),
                              ),
                              SizedBox(width: 12),
                              ElevatedButton(
                                onPressed: () {
                                  setDialogState(() {
                                    showDialogContent = false;
                                    replaceDialogContentWithLoader = true;
                                  });
                                  //login again
                                  fetchAuthToken().then((fetchedAuthToken) {
                                    debugPrint(
                                        "fetchedAuthToken $fetchedAuthToken");
                                    fetchBrokerConnectTxnId(
                                            authToken: fetchedAuthToken)
                                        .then(
                                      (txnId) =>
                                          ScgatewayFlutterPlugin.initGateway(
                                                  fetchedAuthToken)
                                              .then(
                                        (value) => ScgatewayFlutterPlugin
                                            .triggerGatewayTransaction(
                                          txnId,
                                        ).then(
                                          (loginRes) {
                                            if (loginRes != null) {
                                              var data =
                                                  jsonDecode(loginRes)['data'];
                                              if (data != null) {
                                                String authToken = jsonDecode(
                                                    data)['smallcaseAuthToken'];
                                                String brokerName =
                                                    jsonDecode(data)['broker'];
                                                String txnId = jsonDecode(
                                                    data)['transactionId'];
                                                getUserId().then((userId) {
                                                  postBrokerAccount(
                                                          userId: userId!
                                                              .toString(),
                                                          brokerName:
                                                              brokerName,
                                                          authToken: authToken,
                                                          txnId: txnId)
                                                      .then((isPosted) {
                                                    if (isPosted) {
                                                      // Get.back();
                                                      // setBodyToBrokers();
                                                      Get.off(
                                                          PortfolioMainUI());
                                                    }
                                                  });
                                                });
                                              }
                                            }
                                          },
                                        ),
                                      ),
                                    );
                                  });
                                },
                                child: Text("Login Again"),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Visibility(
                      visible: replaceDialogContentWithLoader,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 28.0),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    )
                  ],
                );
              },
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: body);
  }
}

// class Taxation extends StatefulWidget {
//   const Taxation({Key? key}) : super(key: key);

//   @override
//   State<Taxation> createState() => _TaxationState();
// }

// class _TaxationState extends State<Taxation> {
//   bool showingAdditionalDetails = false;
//   bool showingAdditionalDetails2 = false;
//   bool showTaxationDetails = false;
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       child: Scaffold(
//         body: SingleChildScrollView(
//             child: Padding(
//           padding: const EdgeInsets.only(
//             left: 20,
//             right: 20,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: 20,
//               ),
//               if (showTaxationDetails)
//                 Column(
//                   children: [
//                     Card(
//                       elevation: 1,
//                       margin: EdgeInsets.zero,
//                       shape: RoundedRectangleBorder(
//                         side: const BorderSide(
//                             color: Color(0xFFEBEBEB), width: 1),
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(10.0),
//                           topRight: Radius.circular(10.0),
//                         ),
//                       ),
//                       color: Color(0xFF008083),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           children: [
//                             SizedBox(
//                               height: 30,
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 children: [
//                                   Expanded(
//                                     child: Padding(
//                                       padding: const EdgeInsets.only(left: 8.0),
//                                       child: Text(
//                                         "Particulars",
//                                         style: blackStyle(context).copyWith(
//                                             color: Colors.white, fontSize: 14),
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     flex: 0,
//                                     child: Text(
//                                       "Projected Amount (INR)",
//                                       style: blackStyle(context).copyWith(
//                                           color: Colors.white, fontSize: 14),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 2, right: 2),
//                       child: Card(
//                         elevation: 1,
//                         margin: EdgeInsets.zero,
//                         shape: RoundedRectangleBorder(
//                           side: const BorderSide(
//                               color: Color(0xFFEBEBEB), width: 1),
//                           borderRadius: BorderRadius.only(
//                             bottomLeft: Radius.circular(10.0),
//                             bottomRight: Radius.circular(10.0),
//                           ),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               IntrinsicHeight(
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceAround,
//                                   children: [
//                                     Expanded(
//                                       child: Padding(
//                                         padding:
//                                             const EdgeInsets.only(left: 8.0),
//                                         child: Text(
//                                           "Income from Salary",
//                                           style: blackStyle(context).copyWith(
//                                               color: Get.isDarkMode
//                                                   ? Colors.white
//                                                   : Colors.black,
//                                               fontSize: 14),
//                                         ),
//                                       ),
//                                     ),
//                                     VerticalDivider(
//                                       thickness: 2,
//                                       color: Get.isDarkMode
//                                           ? Colors.white
//                                           : Colors.grey,
//                                     ),
//                                     SizedBox(
//                                       width: 20,
//                                     ),
//                                     Expanded(
//                                       flex: 0,
//                                       child: Padding(
//                                         padding:
//                                             const EdgeInsets.only(right: 8.0),
//                                         child: Text(
//                                           "₹1,50,000",
//                                           style: blackStyle(context).copyWith(
//                                               color: Get.isDarkMode
//                                                   ? Colors.white
//                                                   : Colors.black,
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Divider(
//                                 thickness: 2,
//                                 color:
//                                     Get.isDarkMode ? Colors.white : Colors.grey,
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               IntrinsicHeight(
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceAround,
//                                   children: [
//                                     Expanded(
//                                       child: Padding(
//                                         padding:
//                                             const EdgeInsets.only(left: 8.0),
//                                         child: Text(
//                                           "Income from House Property",
//                                           style: blackStyle(context).copyWith(
//                                               color: Get.isDarkMode
//                                                   ? Colors.white
//                                                   : Colors.black,
//                                               fontSize: 14),
//                                         ),
//                                       ),
//                                     ),
//                                     VerticalDivider(
//                                       thickness: 2,
//                                       color: Get.isDarkMode
//                                           ? Colors.white
//                                           : Colors.grey,
//                                     ),
//                                     SizedBox(
//                                       width: 30,
//                                     ),
//                                     Expanded(
//                                       flex: 0,
//                                       child: Padding(
//                                         padding:
//                                             const EdgeInsets.only(right: 8.0),
//                                         child: Text(
//                                           "₹50,000",
//                                           style: blackStyle(context).copyWith(
//                                               color: Get.isDarkMode
//                                                   ? Colors.white
//                                                   : Colors.black,
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Divider(
//                                 thickness: 2,
//                                 color:
//                                     Get.isDarkMode ? Colors.white : Colors.grey,
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               IntrinsicHeight(
//                                 child: Row(
//                                   children: [
//                                     Expanded(
//                                       child: Padding(
//                                         padding: const EdgeInsets.only(
//                                             left: 8.0, bottom: 15),
//                                         child: Text(
//                                           "Capital Gains",
//                                           style: blackStyle(context).copyWith(
//                                               color: Get.isDarkMode
//                                                   ? Colors.white
//                                                   : Colors.black,
//                                               fontSize: 14),
//                                         ),
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: Column(
//                                         children: [
//                                           Text("Short Term"),
//                                           SizedBox(
//                                             height: 5,
//                                           ),
//                                           Text(
//                                             "₹1,000,00",
//                                             style: blackStyle(context).copyWith(
//                                                 color: Get.isDarkMode
//                                                     ? Colors.white
//                                                     : Colors.black,
//                                                 fontSize: 14,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     VerticalDivider(
//                                       endIndent: 15,
//                                       thickness: 2,
//                                       color: Get.isDarkMode
//                                           ? Colors.white
//                                           : Colors.grey,
//                                     ),
//                                     SizedBox(
//                                       width: 15,
//                                     ),
//                                     Expanded(
//                                       flex: 0,
//                                       child: Padding(
//                                         padding:
//                                             const EdgeInsets.only(right: 8.0),
//                                         child: Column(
//                                           children: [
//                                             Text("Long Term"),
//                                             SizedBox(
//                                               height: 5,
//                                             ),
//                                             Text(
//                                               "₹2,000,00",
//                                               style: blackStyle(context)
//                                                   .copyWith(
//                                                       color: Get.isDarkMode
//                                                           ? Colors.white
//                                                           : Colors.black,
//                                                       fontSize: 14,
//                                                       fontWeight:
//                                                           FontWeight.bold),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Divider(
//                                 thickness: 2,
//                                 color:
//                                     Get.isDarkMode ? Colors.white : Colors.grey,
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               IntrinsicHeight(
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceAround,
//                                   children: [
//                                     Expanded(
//                                       child: Padding(
//                                         padding:
//                                             const EdgeInsets.only(left: 8.0),
//                                         child: Text(
//                                           "Income from other sources",
//                                           style: blackStyle(context).copyWith(
//                                               color: Get.isDarkMode
//                                                   ? Colors.white
//                                                   : Colors.black,
//                                               fontSize: 14),
//                                         ),
//                                       ),
//                                     ),
//                                     VerticalDivider(
//                                       thickness: 2,
//                                       color: Get.isDarkMode
//                                           ? Colors.white
//                                           : Colors.grey,
//                                     ),
//                                     SizedBox(
//                                       width: 30,
//                                     ),
//                                     Expanded(
//                                       flex: 0,
//                                       child: Padding(
//                                         padding:
//                                             const EdgeInsets.only(right: 8.0),
//                                         child: Text(
//                                           "₹10,000",
//                                           style: blackStyle(context).copyWith(
//                                               color: Get.isDarkMode
//                                                   ? Colors.white
//                                                   : Colors.black,
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Divider(
//                                 thickness: 2,
//                                 color: Color(0xFF008083),
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               IntrinsicHeight(
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceAround,
//                                   children: [
//                                     Expanded(
//                                       child: Padding(
//                                         padding:
//                                             const EdgeInsets.only(left: 8.0),
//                                         child: Text(
//                                           "Total Income",
//                                           style: blackStyle(context).copyWith(
//                                               color: Get.isDarkMode
//                                                   ? Colors.white
//                                                   : Colors.black,
//                                               fontSize: 14),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 30,
//                                     ),
//                                     Expanded(
//                                       flex: 0,
//                                       child: Padding(
//                                         padding:
//                                             const EdgeInsets.only(right: 8.0),
//                                         child: Text(
//                                           "₹4,10,000",
//                                           style: blackStyle(context).copyWith(
//                                               color: Get.isDarkMode
//                                                   ? Colors.white
//                                                   : Colors.black,
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     Card(
//                       elevation: 1,
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       SizedBox(
//                                         height: 10,
//                                       ),
//                                       Text(
//                                         "Deduction under Chapter VI",
//                                         style: blackStyle(context).copyWith(
//                                             fontSize: 16,
//                                             color: Get.isDarkMode
//                                                 ? Colors.white
//                                                 : Color(0xFF303030)),
//                                       ),
//                                       SizedBox(
//                                         height: 5,
//                                       ),
//                                       Text(
//                                         "You are eligible for Tax benefits of ₹50,000",
//                                         style: blackStyle(context).copyWith(
//                                             fontSize: 12,
//                                             color: Get.isDarkMode
//                                                 ? Colors.white
//                                                 : Color(0xFF6B6B6B)),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Column(
//                                   children: [
//                                     Text(
//                                       "Check Your Options",
//                                       style: blackStyle(context).copyWith(
//                                         fontSize: 10,
//                                         fontWeight: FontWeight.bold,
//                                         color: Color(0xFF008083),
//                                         decoration: TextDecoration.underline,
//                                       ),
//                                     )
//                                   ],
//                                 )
//                               ],
//                             ),
//                             SizedBox(
//                               height: 23.5,
//                             ),
//                             Divider(
//                                 thickness: 2,
//                                 color: Get.isDarkMode
//                                     ? Colors.white
//                                     : Colors.grey),
//                             SizedBox(
//                               height: 17.5,
//                             ),
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "Other deduction",
//                                         style: blackStyle(context).copyWith(
//                                             fontSize: 16,
//                                             color: Get.isDarkMode
//                                                 ? Colors.white
//                                                 : Color(0xFF303030)),
//                                       ),
//                                       SizedBox(
//                                         height: 5,
//                                       ),
//                                       Text(
//                                         "You are eligible for Tax benefits of ₹50,000",
//                                         style: blackStyle(context).copyWith(
//                                             fontSize: 12,
//                                             color: Get.isDarkMode
//                                                 ? Colors.white
//                                                 : Color(0xFF6B6B6B)),
//                                       ),
//                                       SizedBox(
//                                         height: 10,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Column(
//                                   children: [
//                                     Text(
//                                       "Check Your Options",
//                                       style: blackStyle(context).copyWith(
//                                         fontSize: 10,
//                                         fontWeight: FontWeight.bold,
//                                         color: Color(0xFF008083),
//                                         decoration: TextDecoration.underline,
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             Divider(
//                                 thickness: 2,
//                                 color: Get.isDarkMode
//                                     ? Colors.white
//                                     : Colors.grey),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             IntrinsicHeight(
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 children: [
//                                   Expanded(
//                                     child: Padding(
//                                       padding: const EdgeInsets.only(left: 8.0),
//                                       child: Text(
//                                         "Total taxable income",
//                                         style: blackStyle(context).copyWith(
//                                             color: Get.isDarkMode
//                                                 ? Colors.white
//                                                 : Colors.black,
//                                             fontSize: 14),
//                                       ),
//                                     ),
//                                   ),
//                                   VerticalDivider(
//                                       thickness: 2,
//                                       color: Get.isDarkMode
//                                           ? Colors.white
//                                           : Colors.grey),
//                                   SizedBox(
//                                     width: 20,
//                                   ),
//                                   Expanded(
//                                     flex: 0,
//                                     child: Padding(
//                                       padding:
//                                           const EdgeInsets.only(right: 8.0),
//                                       child: Text(
//                                         "₹5,000",
//                                         style: blackStyle(context).copyWith(
//                                             color: Get.isDarkMode
//                                                 ? Colors.white
//                                                 : Colors.black,
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Divider(
//                                 thickness: 2,
//                                 color: Get.isDarkMode
//                                     ? Colors.white
//                                     : Colors.grey),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             IntrinsicHeight(
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 children: [
//                                   Expanded(
//                                     child: Padding(
//                                       padding: const EdgeInsets.only(left: 8.0),
//                                       child: Text(
//                                         "Tax Payable",
//                                         style: blackStyle(context).copyWith(
//                                             color: Get.isDarkMode
//                                                 ? Colors.white
//                                                 : Colors.black,
//                                             fontSize: 14),
//                                       ),
//                                     ),
//                                   ),
//                                   VerticalDivider(
//                                       thickness: 2,
//                                       color: Get.isDarkMode
//                                           ? Colors.white
//                                           : Colors.grey),
//                                   SizedBox(
//                                     width: 20,
//                                   ),
//                                   Expanded(
//                                     flex: 0,
//                                     child: Padding(
//                                       padding:
//                                           const EdgeInsets.only(right: 8.0),
//                                       child: Text(
//                                         "₹4,000",
//                                         style: blackStyle(context).copyWith(
//                                             color: Get.isDarkMode
//                                                 ? Colors.white
//                                                 : Colors.black,
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               SizedBox(
//                 height: 10,
//               ),
//               if (!showTaxationDetails)
//                 download(
//                     ontap: () {
//                       setState(() {
//                         showTaxationDetails = !showTaxationDetails;
//                       });
//                     },
//                     title: "F.Y. 2022-2023 ITR ",
//                     subtitle: "May 04, 12:55",
//                     showview: true),
//               SizedBox(
//                 height: 10,
//               ),
//               download(
//                   title: "F.Y. 2021-2022 ITR File", subtitle: "May 04, 12:55"),
//               SizedBox(
//                 height: 10,
//               ),
//               download(
//                   title: "F.Y. 2020-2021 ITR File", subtitle: "May 04, 12:55"),
//               SizedBox(
//                 height: 10,
//               ),
//               download(
//                   title: "F.Y. 2019-2020 ITR File", subtitle: "May 04, 12:55"),
//               SizedBox(
//                 height: 10,
//               ),
//               download(
//                   title: "F.Y. 2018-2019 ITR File", subtitle: "May 04, 12:55"),
//               SizedBox(
//                 height: 10,
//               ),
//               download(title: "Form 16", subtitle: "May 04 2017, 1:00"),
//               SizedBox(
//                 height: 10,
//               ),
//               download(title: "Form 16", subtitle: "May 04 2017, 1:00"),
//               SizedBox(
//                 height: 10,
//               ),
//               download(title: "Form 16", subtitle: "May 04 2017, 1:00"),
//               SizedBox(
//                 height: 10,
//               ),
//               download(title: "Form 16", subtitle: "May 04 2017, 1:00"),
//               SizedBox(
//                 height: 30,
//               ),
//             ],
//           ),
//         )),
//       ),
//     );
//   }
// }

class GoalsTracker extends StatefulWidget {
  const GoalsTracker({Key? key}) : super(key: key);

  @override
  State<GoalsTracker> createState() => _GoalsTrackerState();
}

late final Future? myFuture;

class _GoalsTrackerState extends State<GoalsTracker> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Storegoalsdetails().getGoals(),
        builder: (ctx, snapshot) {
          if (snapshot.data == null) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Lottie.asset(
                    "assets/images/lf30_editor_jc6n8oqe.json",
                    repeat: true,
                    height: 150,
                    width: 150,
                  ),
                ),
              ],
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occured',
                  style: TextStyle(fontSize: 18),
                ),
              );
            }
          }
          return _buildFutureResponseBody();
        },
      ),
    );
  }

  Widget _buildFutureResponseBody() {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          userGoals.data!.isEmpty
              ? _buildNoDataCard(context)
              : _buildCardHasData(),
          const SizedBox(
            height: 20,
          ),

          // Card(
          //   shape: RoundedRectangleBorder(
          //     side: const BorderSide(color: Color(0xFFEBEBEB), width: 1),
          //     borderRadius: BorderRadius.circular(10),
          //   ),
          //   child: Row(
          //     children: [
          //       Expanded(
          //         flex: 2,
          //         child: Padding(
          //           padding: const EdgeInsets.symmetric(
          //               vertical: 12, horizontal: 20),
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text(
          //                 "Balance Amount to Advisory",
          //                 style: blackStyle(context).copyWith(fontSize: 14),
          //               ),
          //               const SizedBox(
          //                 height: 10,
          //               ),
          //               Text(
          //                 "₹ 5,000",
          //                 style: blackStyle(context).copyWith(fontSize: 14),
          //               ),
          //               Text(
          //                 "Due Date: 12 Mar, 2022",
          //                 style: blackStyle(context).copyWith(
          //                     fontSize: 12, color: const Color(0xFF878787)),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //       Expanded(
          //         flex: 0,
          //         child: Padding(
          //           padding: const EdgeInsets.only(right: 15),
          //           child: ElevatedButton(
          //             style: ElevatedButton.styleFrom(
          //               elevation: 0,
          //               primary: const Color.fromRGBO(247, 129, 4, 1),
          //               shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(12),
          //               ),
          //             ),
          //             child: const Text(
          //               "Pay Now!",
          //               style: TextStyle(
          //                 color: Color(0xFFFFFFFF),
          //                 fontSize: 14,
          //                 fontFamily: 'Helvetica',
          //               ),
          //             ),
          //             onPressed: () {},
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    ));
  }

  Widget _buildCard(context, i) {
    return Card(
      color: const Color(0xFFEBEBEB),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Color(0xFFEBEBEB), width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              children: [
                const Expanded(
                    flex: 0,
                    child: CircleAvatar(
                      backgroundColor: Color(0xFF008083),
                      child: Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                    )),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userGoals.data![i].type!,
                        style:
                            blackStyle(context).copyWith(color: Colors.black),
                      ),
                      Text(
                        userGoals.data![i].duration!,
                        style: blackStyle(context).copyWith(
                            color: const Color(0xFF6B6B6B), fontSize: 12.sm),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: const [
                      CircleAvatar(
                        backgroundColor: Color(0xFF008083),
                        radius: 40,
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              "₹  ${userGoals.data![i].amount!}",
              style: blackStyle(context).copyWith(color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildNoDataCard(context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
        ),
        Text("No Goals Added"),
      ],
    ));
  }

  Widget _buildCardHasData() {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Color(0xFFEBEBEB), width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              "Goals Tracker",
              style: blackStyle(context).copyWith(
                  fontWeight: FontWeight.w600,
                  color: Get.isDarkMode ? Colors.white : Colors.black),
            ),
            const SizedBox(
              height: 15,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: ListView.builder(
                //shrinkWrap: false,
                itemCount: userGoals.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return _buildCard(context, index);
                },
              ),
            ),
            //static
            // Card(
            //   color: const Color(0xFFEBEBEB),
            //   shape: RoundedRectangleBorder(
            //     side: const BorderSide(color: Color(0xFFEBEBEB), width: 1),
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            //   child: Column(
            //     mainAxisSize: MainAxisSize.min,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.only(left: 15, right: 15),
            //         child: Row(
            //           children: [
            //             Expanded(
            //                 flex: 0,
            //                 child: CircleAvatar(
            //                   backgroundColor: Color(0xFF008083),
            //                   child: SvgPicture.asset(
            //                       "assets/images/Path 5674.svg"),
            //                 )),
            //             const SizedBox(
            //               width: 10,
            //             ),
            //             Expanded(
            //               flex: 1,
            //               child: Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Text(
            //                     "New Car",
            //                     style: blackStyle(context)
            //                         .copyWith(color: Colors.black),
            //                   ),
            //                   Row(
            //                     children: [
            //                       Text(
            //                         "4 Months left / ",
            //                         style: blackStyle(context).copyWith(
            //                             color: const Color(0xFF6B6B6B),
            //                             fontSize: 12.sm),
            //                       ),
            //                       Text(
            //                         "2 Years",
            //                         style: blackStyle(context).copyWith(
            //                             color: const Color(0xFF6B6B6B),
            //                             fontSize: 12.sm),
            //                       ),
            //                     ],
            //                   ),
            //                 ],
            //               ),
            //             ),
            //             Column(
            //               mainAxisSize: MainAxisSize.max,
            //               mainAxisAlignment: MainAxisAlignment.end,
            //               children: [
            //                 SizedBox(
            //                   height: 10,
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.only(top: 15),
            //                   child: CircularPercentIndicator(
            //                     radius: 40,
            //                     lineWidth: 5.0,
            //                     percent: 0.8,
            //                     center: const Icon(
            //                       Icons.currency_rupee,
            //                       size: 30.0,
            //                       color: Colors.black,
            //                     ),
            //                     backgroundColor: const Color(0xFFB2D9D9),
            //                     progressColor: const Color(0xFF008083),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ],
            //         ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.only(
            //           left: 15,
            //         ),
            //         child: Text(
            //           "₹ 20,000 of ₹5,00,000",
            //           style: blackStyle(context).copyWith(
            //             color: Colors.black,
            //           ),
            //         ),
            //       ),
            //       const SizedBox(
            //         height: 20,
            //       ),
            //     ],
            //   ),
            // ),
            //static
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
