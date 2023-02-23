


import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:piadvisory/Common/CreateBottomBar.dart';
import 'package:piadvisory/Common/CustomAppbarWithIcons.dart';
import 'package:piadvisory/Common/Customfloatingbutton.dart';
import 'package:piadvisory/Common/GlobalFuntionsVariables.dart';
import 'package:piadvisory/HomePage/Stock/stock.dart';
import 'package:piadvisory/Portfolio/PortfolioMainUI.dart';
import 'package:piadvisory/Profile/KYC/SchduleAppointment.dart';
import 'package:piadvisory/SideMenu/NavDrawer.dart';
import 'package:piadvisory/SideMenu/Subscribe/Mysubscription.dart';
import 'package:piadvisory/Utils/textStyles.dart';



import '../../Utils/custom_icons_icons.dart';

import '../../smallcase_api_methods.dart';
import '../Homepage.dart';


class Notify extends StatefulWidget {
  const Notify({Key? key}) : super(key: key);

  @override
  State<Notify> createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
  final GlobalKey<ScaffoldState> _Notifykey = GlobalKey();
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
      key: _Notifykey,
      drawer: NavDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 22,
            right: MediaQuery.of(context).size.width * 0.43,
            child: CustomFloatingButton(),
            // FloatingActionButton(
            //   backgroundColor :Color(0xFFF78104),
            //   heroTag: "tag1",
            //   onPressed: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: ((context) => const Mysubscription())));
            //   },
            //   tooltip: 'Portfolio',
            //   elevation: 2.0,
            //   child: SvgPicture.asset(
            //       "assets/images/product sans logo wh new.svg",
            //       color: Colors.white,
            //       fit: BoxFit.contain,
            //       width: 28,
            //       height: 24,
            //     ),
            //   // SvgPicture.asset(
            //   //   "assets/images/product sans logo wh.svg",
            //   //  // "assets/images/group-6177.svg",
            //   // ),
            // ),
          ),
        ],
      ),
      bottomNavigationBar:CreateBottomBar(stateBottomNav, "Bottombar", context),
      appBar: CustomAppBarWithIcons( isnotification: true,
        titleTxt: "Notification",
        globalkey: _Notifykey,
      ),
      body: DefaultTabController(
        length: 5,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              ButtonsTabBar(
                contentPadding: EdgeInsets.only(left: 25, right: 25),
                radius: 4,
                backgroundColor: Color(0xFF008083),
                unselectedBorderColor: Color(0xFF008083),
                borderWidth: 2,
                borderColor: Color(0xFF008083),
                unselectedBackgroundColor: Get.isDarkMode?Color(0xFF303030).withOpacity(0.8): Colors.white,
                unselectedLabelStyle: TextStyle(color:Get.isDarkMode? Colors.white: Color(0xFF6B6B6B)),
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sm,
                ),
                tabs: [
                  Tab(
                    text: "All",
                  ),
                  Tab(
                    text: "Mutual Fund",
                  ),
                  Tab(
                    text: "Stocks",
                  ),
                  Tab(
                    text: "Insights",
                  ),
                  Tab(
                    text: "Tax Investment",
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    AllNotifications(),
                    AllNotifications(),
                    AllNotifications(),
                    AllNotifications(),
                    AllNotifications(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AllNotifications extends StatefulWidget {
  AllNotifications({Key? key}) : super(key: key);

  @override
  State<AllNotifications> createState() => _AllNotificationsState();
}

class _AllNotificationsState extends State<AllNotifications> {
  void selectedNotification(int index) {
    setState(() {
      switch (index) {
        case 0:
          {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: ((context) => ProfileMain())));
          }
          break;

        case 1:
          {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: ((context) => DetailedNotification())));
          }
          break;

        case 2:
          {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: ((context) => DetailedNotification2())));
          }
          break;
        case 3:
          {}
          break;
        case 4:
          {}
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
    List<Map<String, String>> data = [
      {
        "title": "Your KYC is Pending.",
        "subtitle": "May 02, 12:55",
      },
      {
        "title": "Best Stock and Mutual Fund to Invest Today.",
        "subtitle": "May 02, 12:55",
      },
      {
        "title": "Your Profile is Incomplete!",
        "subtitle": "May 02, 12:55",
      },
      {
        "title":
            "Top 10 trading ideas for next 3-4 weeks as market expected to be volatile",
        "subtitle": "May 02, 12:55",
      },
      {
        "title":
            "Top 10 trading ideas for next 3-4 weeks as market expected to be volatile",
        "subtitle": "May 02, 12:55",
      },
      {
        "title":
            "Top 10 trading ideas for next 3-4 weeks as market expected to be volatile",
        "subtitle": "May 02, 12:55",
      },
    ];

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: ((context, index) {
          return InkWell(
            onTap: () {
              selectedNotification(index);
            },
            child: CustomListTile(
              title: data[index]['title']!,
              subtitle: data[index]['subtitle']!,
            ),
          );
        }),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border.all(
                  color: Color(0xFF6B6B6B).withOpacity(0.8), width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: 12,
                    height: 12,
                    child: SvgPicture.asset(
                      'assets/images/notify-icon.svg',
                      color: Color(0xFF034698),
                    )),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.76,
                      child: Text(title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: blackStyle(context).copyWith(
                              fontSize: 14.sm, fontWeight: FontWeight.w600,color: Get.isDarkMode? Colors.white: Colors.black)),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color:Get.isDarkMode? Colors.white: Color(0xFF444444),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
