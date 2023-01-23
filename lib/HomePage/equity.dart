// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:piadvisory/Common/PieChartLiabilities.dart';
import '../Common/app_bar.dart';

import '../Common/holding_model.dart';
import '../Portfolio/PortfolioMainUI.dart';
import '../Profile/KYC/SchduleAppointment.dart';
import '../SideMenu/Subscribe/Mysubscription.dart';
import '../Utils/custom_icons_icons.dart';
import 'package:piadvisory/HomePage/Stock/stock.dart';
import '../smallcase_api_methods.dart';
import 'Homepage.dart';

class Equityinner extends StatefulWidget {
  const Equityinner({required this.holdings, Key? key}) : super(key: key);

  final Map<String, dynamic>? holdings;

  @override
  State<Equityinner> createState() => _EquityinnerState();
}

class _EquityinnerState extends State<Equityinner> {
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

  double investment = 0;

  @override
  Widget build(BuildContext context) {
    List data = widget.holdings!['securities'];
    var mapped =
        data.map<HoldingModel>((json) => HoldingModel.fromJson(json)).toList();
    mapped.forEach((holding) {
      investment +=
          double.parse(holding.averagePrice!) * double.parse(holding.quantity!);
    });
    List<Widget> pageList = [];
    pageList.addAll([
      SizedBox(height: 12),
      //pie chart
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF707070)),
            borderRadius: BorderRadius.circular(4)),
        child: const Padding(
          padding: EdgeInsets.all(20),
          child: PieChartLiabilites(),
        ),
      ),
      const SizedBox(height: 12)
    ]);
    pageList.addAll(mapped.map(
      (holding) => Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Color(0xFF707070),
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Qty",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Color(0xFF878787)),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                holding.quantity ?? " ",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Color(0xFF444444)),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.circle,
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                                size: 5,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Avg",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Color(0xFF878787)),
                              ),
                              SizedBox(width: 5),
                              Text(
                                holding.averagePrice ?? " ",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Color(0xFF444444)),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Text("- - - - -",
                        style:
                            TextStyle(fontSize: 14, color: Color(0xFF2CAB41))),
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
                        holding.bseTicker ?? " ",
                        style: TextStyle(
                            fontSize: 14,
                            color: Get.isDarkMode
                                ? Colors.white
                                : Color(0xFF000000)),
                      ),
                    ),
                    Text("- - - - -",
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF2CAB41))),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Invested",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Color(0xFF878787)),
                              ),
                              SizedBox(width: 5),
                              Text(
                                (double.parse(holding.quantity!) *
                                        double.parse(holding.averagePrice!))
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Color(0xFF444444)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              // Text(
                              //   "LTP",
                              //   style: TextStyle(
                              //       fontSize: 12,
                              //       color: Get.isDarkMode
                              //           ? Colors.white
                              //           : Color(0xFF878787)),
                              // ),
                              SizedBox(
                                width: 6,
                              ),
                              Text(
                                "-  -  -  -  -",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Color(0xFF444444)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    ));
    pageList.add(SizedBox(height: 3));
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
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: TextStyle(color: Color(0xFFF78104)),
        unselectedLabelStyle: TextStyle(color: Colors.grey),
        unselectedIconTheme: IconThemeData(color: Colors.grey),
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
            ),
            label: 'Subscribe',
          ),
          BottomNavigationBarItem(
            icon: Icon(CustomIcons.date_range),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CustomIcons.bottombarbagicon,
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
      appBar: const CustomAppBar(
        titleTxt: "Equity",
        bottomtext: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //box 1
            Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF707070)),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      //Investment, current
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Investment",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "Current",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "₹ $investment",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                              child: Text("- - - - - - - -",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.black))),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Divider(
                        color:
                            Get.isDarkMode ? Colors.white : Color(0xFF707070),
                        thickness: 1,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "P&L",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("- - - - - - - -",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Color(0xFF2CAB41))),
                                Text("-  -  -  -",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF2CAB41))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
            const SizedBox(height: 12),
            Divider(
              color: Get.isDarkMode ? Colors.white : Color(0xFF707070),
              thickness: 1,
              height: 1,
            ),
            Expanded(
              child: ListView(
                children: pageList,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
