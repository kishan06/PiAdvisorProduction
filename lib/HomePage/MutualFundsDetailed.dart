
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:piadvisory/Profile/KYC/SchduleAppointment.dart';
import '../Common/PieChartMutualFunds.dart';
import '../Common/app_bar.dart';

import '../Portfolio/PortfolioMainUI.dart';
import '../SideMenu/Subscribe/Mysubscription.dart';
import '../Utils/custom_icons_icons.dart';

import '../smallcase_api_methods.dart';
import 'Homepage.dart';
import 'Stock/stock.dart';

class mutulinner extends StatefulWidget {
  const mutulinner({Key? key}) : super(key: key);

  @override
  State<mutulinner> createState() => _mutulinnerState();
}

class _mutulinnerState extends State<mutulinner> {
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
              child:SvgPicture.asset(
                  "assets/images/product sans logo wh new.svg",
                  color: Colors.white,
                  fit: BoxFit.contain,
                  width: 30,
                  height: 28,
                ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              CustomIcons.path_3177,
              //  color:
              //         Get.isDarkMode ? Color(0xFFF78104) : Color(0xFFF78104)
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(
                CustomIcons.path_4346,
                //  color:
                //       Get.isDarkMode ? Color(0xFFF78104) : Color(0xFFF78104)
              ),
            ),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CustomIcons.group_2369,
              //  color:
              //         Get.isDarkMode ? Color(0xFFF78104) : Color(0xFFF78104)
            ),
            label: 'Subscribe',
          ),
          BottomNavigationBarItem(
            icon: Icon(CustomIcons.date_range,
            //  color:
            //           Get.isDarkMode ? Color(0xFFF78104) : Color(0xFFF78104)
            ),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CustomIcons.bottombarbagicon,
              //  color:
              //         Get.isDarkMode ? Color(0xFFF78104) : Color(0xFFF78104),
              size: 22.5,
            ),
            label: 'Dashboard',
          ),
        ],
        currentIndex: 0,
        unselectedItemColor: Colors.grey,
         selectedItemColor: Color(0xFFF78104),
        backgroundColor: Colors.white,
        onTap: (index) {
          print(index);
          _selectedTab(index);
        },
        type: BottomNavigationBarType.fixed,
      ),
      appBar: const CustomAppBar(titleTxt: "Mutual Funds", bottomtext: false,),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFF707070).withOpacity(0.5),
                      ),
                      borderRadius: BorderRadius.circular(4)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Investment",
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color:Get.isDarkMode? Colors.white: Color(0xFF6B6B6B)),
                                ),
                                SizedBox(
                                  height: 9,
                                ),
                                Text(
                                  "₹50,000",
                                  style: TextStyle(
                                      fontSize: 20.sp, color:Get.isDarkMode? Colors.white: Colors.black),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Current",
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color:Get.isDarkMode? Colors.white: Color(0xFF6B6B6B)),
                                ),
                                SizedBox(
                                  height: 9,
                                ),
                                Text(
                                  "₹50,000",
                                  style: TextStyle(
                                      fontSize: 20.sp, color:Get.isDarkMode? Colors.white: Colors.black),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Divider(
                          color: Color(0xFF707070).withOpacity(0.5),
                          thickness: 1,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Returns",
                              style:
                                  TextStyle(fontSize: 18, color:Get.isDarkMode? Colors.white: Colors.black),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("₹10,000",
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        color: Color(0xFF2CAB41))),
                                Text(" +5.3%",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Color(0xFF2CAB41))),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFF707070).withOpacity(0.5),
                      ),
                      borderRadius: BorderRadius.circular(4)),
                  child: PieChartMutualFunds()),
              const SizedBox(
                height: 20,
              ),
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Color(0xFF707070).withOpacity(0.5),
                      ),
                      // bottom: BorderSide(
                      //   color: Color(0xFF707070),
                      // ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Motilal Oswal S&P 500 Index ",
                              style: TextStyle(
                                  fontSize: 14.sp, color:Get.isDarkMode? Colors.white: Color(0xFF000000)),
                            ),
                            Text("₹41,573 ",
                                style: TextStyle(
                                    fontSize: 16.sp, color: Color(0xFF2CAB41))),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              child: Text(
                                "Fund Direct PI Advisor",
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color:Get.isDarkMode? Colors.white: Color.fromARGB(255, 126, 108, 108)),
                              ),
                            ),
                            Text(" (₹35,498) ",
                                style: TextStyle(
                                    fontSize: 16.sp, color:Get.isDarkMode? Colors.white: Color(0xFF444444))),
                          ],
                        ),
                      ],
                    ),
                  )),
              const SizedBox(
                height: 5,
              ),
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Color(0xFF707070).withOpacity(0.5),
                      ),
                      // bottom: BorderSide(
                      //   color: Color(0xFF707070),
                      // ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Smart Save - ICICI Prudential ",
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 14.sp, color:Get.isDarkMode? Colors.white: Color(0xFF000000)),
                            ),
                            Text("₹50,688  ",
                                style: TextStyle(
                                    fontSize: 16.sp, color: Color(0xFF2CAB41))),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              child: Text(
                                "Liquid Fund Direct Plan SM",
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 14.sp, color:Get.isDarkMode? Colors.white: Color(0xFF000000)),
                              ),
                            ),
                            Text(" (₹49,038) ",
                                style: TextStyle(
                                    fontSize: 16.sp, color:Get.isDarkMode? Colors.white: Color(0xFF444444))),
                          ],
                        ),
                      ],
                    ),
                  )),
              const SizedBox(
                height: 5,
              ),
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Color(0xFF707070).withOpacity(0.5),
                      ),
                      // bottom: BorderSide(
                      //   color: Color(0xFF707070),
                      // ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Axis Short Term Direct Fund",
                              style: TextStyle(
                                  fontSize: 14.sp, color:Get.isDarkMode? Colors.white: Color(0xFF000000)),
                            ),
                            Text("₹45,838  ",
                                style: TextStyle(
                                    fontSize: 16.sp, color: Color(0xFF2CAB41))),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              child: Text(
                                "PI Advisor",
                                style: TextStyle(
                                    fontSize: 14.sp, color:Get.isDarkMode? Colors.white: Color(0xFF000000)),
                              ),
                            ),
                            Text(" (₹49,049)",
                                style: TextStyle(
                                    fontSize: 16.sp, color:Get.isDarkMode? Colors.white: Color(0xFF444444))),
                          ],
                        ),
                      ],
                    ),
                  )),
              const SizedBox(
                height: 5,
              ),
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Color(0xFF707070).withOpacity(0.5),
                      ),
                      // bottom: BorderSide(
                      //   color: Color(0xFF707070),
                      // ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Axis Short Term Direct Fund",
                              style: TextStyle(
                                  fontSize: 14.sp, color:Get.isDarkMode? Colors.white: Color(0xFF000000)),
                            ),
                            Text("₹45,838  ",
                                style: TextStyle(
                                    fontSize: 16.sp, color: Color(0xFF2CAB41))),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              child: Text(
                                "PI Advisor",
                                style: TextStyle(
                                    fontSize: 14.sp, color:Get.isDarkMode? Colors.white: Color(0xFF000000)),
                              ),
                            ),
                            Text("(₹49,049)",
                                style: TextStyle(
                                    fontSize: 16.sp, color:Get.isDarkMode? Colors.white: Color(0xFF444444))),
                          ],
                        ),
                      ],
                    ),
                  )),
              const SizedBox(
                height: 5,
              ),
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Color(0xFF707070).withOpacity(0.5),
                      ),
                      // bottom: BorderSide(
                      //   color: Color(0xFF707070),
                      // ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Axis Short Term Direct Fund ",
                              style: TextStyle(
                                  fontSize: 14.sp, color:Get.isDarkMode? Colors.white: Color(0xFF000000)),
                            ),
                            Text("₹45,838  ",
                                style: TextStyle(
                                    fontSize: 16.sp, color: Color(0xFF2CAB41))),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:  [
                            SizedBox(
                              child: Text(
                                "PI Advisor",
                                style: TextStyle(
                                    fontSize: 14, color:Get.isDarkMode? Colors.white: Color(0xFF000000)),
                              ),
                            ),
                            Text(" (₹49,049)",
                                style: TextStyle(
                                    fontSize: 16, color:Get.isDarkMode? Colors.white: Color(0xFF444444))),
                          ],
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
