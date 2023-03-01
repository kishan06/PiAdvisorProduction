// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new, duplicate_ignore, file_names, avoid_print


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:piadvisory/Common/CreateBottomBar.dart';
import 'package:piadvisory/Common/CustomAppbarWithIcons.dart';
import 'package:piadvisory/Common/Customfloatingbutton.dart';
import 'package:piadvisory/Common/GlobalFuntionsVariables.dart';
import 'package:piadvisory/HomePage/CaseStudyInner.dart';
import 'package:piadvisory/SideMenu/NavDrawer.dart';
import '../Common/app_bar.dart';
import '../Common/fab_bottom_app_bar.dart';
import '../Portfolio/PortfolioMainUI.dart';
import '../Profile/KYC/SchduleAppointment.dart';
import '../SideMenu/Subscribe/Mysubscription.dart';
import '../Utils/custom_icons_icons.dart';
import '../Utils/textStyles.dart';
import '../smallcase_api_methods.dart';
import 'Homepage.dart';
import 'Stock/stock.dart';

class CaseStudy extends StatefulWidget {
  const CaseStudy({Key? key}) : super(key: key);

  @override
  State<CaseStudy> createState() => _CaseStudyState();
}

class _CaseStudyState extends State<CaseStudy> {
  String _lastSelected = 'TAB: 0';
  final GlobalKey<ScaffoldState> _key = GlobalKey();
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
      drawer: NavDrawer(),
      key: _key,
      appBar: CustomAppBarWithIcons(titleTxt: "Case Studies", globalkey: _key),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 22,
            right: MediaQuery.of(context).size.width * 0.43,
            child: CustomFloatingButton(),
            //  FloatingActionButton(
            //   heroTag: "tag1",
            //    backgroundColor: Color(0xFFF78104),
            //   onPressed: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: ((context) => const Mysubscription())));
            //   },
            //   tooltip: 'Subscribe',
            //   elevation: 2.0,
            //   child: SvgPicture.asset(
            //       "assets/images/product sans logo wh new.svg",
            //       color: Colors.white,
            //       fit: BoxFit.contain,
            //       width: 28,
            //       height: 24,
            //     ),
            // ),
          ),
        ],
      ),
      bottomNavigationBar:CreateBottomBar(stateBottomNav, "Bottombar", context),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 50,
        ),
        child: Column(
          children: [
            CmdCasestudies(),
            CmdCasestudies(),
            CmdCasestudies(),
            CmdCasestudies(),
            CmdCasestudies(),
          ],
        ),
      )),
    );
  }
}

class CmdCasestudies extends StatelessWidget {
  const CmdCasestudies({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CaseStudyInner()));
      },
      child: SizedBox(
        child: Card(
          elevation: 0.0,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color.fromARGB(73, 105, 105, 104),
                ),
                // bottom: BorderSide(color: Colors.black),
              ),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 15, bottom: 15, left: 10, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/images/case.svg"),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "10,000 to 10,00,000 Advice that \nmadeour X consumer earn more \nthrough equity stocks investment",
                      style: TextStyle(
                        fontSize: 14.sm,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF000000),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "May 03, 2022 11:33 AM IST",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 10.sm,
                        color: Color(0xFF6B6B6B),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
