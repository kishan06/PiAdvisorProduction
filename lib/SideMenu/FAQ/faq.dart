// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:piadvisory/Common/CreateBottomBar.dart';
import 'package:piadvisory/Common/Customfloatingbutton.dart';
import 'package:piadvisory/Common/GlobalFuntionsVariables.dart';
import 'package:piadvisory/HomePage/Stock/stock.dart';
import 'package:piadvisory/Portfolio/PortfolioMainUI.dart';
import 'package:piadvisory/SideMenu/FAQ/Model/FaqModel.dart';
import 'package:piadvisory/SideMenu/FAQ/faqrepository/feesrepo.dart';
import 'package:piadvisory/SideMenu/FAQ/feesChargesFaq.dart';
import 'package:piadvisory/SideMenu/FAQ/generalQueriesfaq.dart';
import 'package:piadvisory/SideMenu/FAQ/investmentAdvisoryFaq.dart';

import '../../smallcase_api_methods.dart';
import '/Common/CustomAppbarWithIcons.dart';
import '/Common/fab_bottom_app_bar.dart';
import '/HomePage/Homepage.dart';
//import '/SideMenu/FAQ/aboutsupermoney.dart';
import '/SideMenu/FAQ/broking.dart';
import '/SideMenu/FAQ/global.dart';
//import '/SideMenu/FAQ/mutulfaq.dart';
//import '/SideMenu/FAQ/stockfaq.dart';
import '/SideMenu/FAQ/SubscriptionAndBillingFAQ.dart';
import '/SideMenu/FAQ/taxplanning.dart';
import '/SideMenu/NavDrawer.dart';
import '/SideMenu/Subscribe/Mysubscription.dart';
import '/Utils/custom_icons_icons.dart';
import '/Utils/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../Common/app_bar.dart';
// import '../../HomePage/Stock/stock.dart';
// import '../../Portfolio/PortfolioMainUI.dart';
import '../../Profile/KYC/SchduleAppointment.dart';

class Faq extends StatefulWidget {
  const Faq({Key? key}) : super(key: key);

  @override
  State<Faq> createState() => _FaqState();
}

class _FaqState extends State<Faq> {
  late final Future myFuture;
  @override
  void initState() {
    myFuture = getFAQ().getFAQs();
    super.initState();
  }

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

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: NavDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 22,
            right: MediaQuery.of(context).size.width * 0.43,
            child: CustomFloatingButton(),
            // FloatingActionButton(
            //   backgroundColor: Color(0xFFF78104),
            //   heroTag: "tag1",
            //   onPressed: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: ((context) => const Mysubscription())));
            //   },
            //   tooltip: 'Subscribe',
            //   elevation: 2.0,
            //   child:SvgPicture.asset(
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
      appBar: CustomAppBarWithIcons(
        globalkey: _key,
        titleTxt: "FAQs",
      ),
      body: FutureBuilder(
        future: myFuture,
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
          return _buildBody(
            context,
          );
        },
      ),
    );
  }

  Widget _buildBody(context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 28),
            child: Text("How Can we help you today?",
                style: blackStyle(context).copyWith(
                  fontWeight: FontWeight.bold,
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 114,
                  width: MediaQuery.of(context).size.width * 0.42,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  generalQueriesFaq(faq: myfaq.cat1!)));
                    },
                    child: Card(
                      elevation: 2,
                      color: Color(0xFFF2F5FA),
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xFF008083))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            "General Queries",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 114,
                  width: MediaQuery.of(context).size.width * 0.42,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => investmentAdvisoryFaq(
                                    faq: myfaq.cat2!,
                                  )));
                    },
                    child: Card(
                      elevation: 2,
                      color: Color(0xFFF2F5FA),
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xFF008083))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            "Investment Advisory",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 114,
                  width: MediaQuery.of(context).size.width * 0.42,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => planningFaq(
                                    faq: myfaq.cat3!,
                                  )));
                    },
                    child: Card(
                      elevation: 2,
                      color: Color(0xFFF2F5FA),
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xFF008083))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            "Tax Planning",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 114,
                  width: MediaQuery.of(context).size.width * 0.42,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  feesChargesFaq(faq: myfaq.cat4!)));
                    },
                    child: Card(
                      elevation: 2,
                      color: Color(0xFFF2F5FA),
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xFF008083))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            "Fees and \n Other Charges",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
