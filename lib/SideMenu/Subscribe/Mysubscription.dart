// ignore_for_file: file_names

import 'package:another_flushbar/flushbar.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:piadvisory/Common/SubscriptionLoadingPage.dart';
import 'package:piadvisory/HomePage/Stock/stock.dart';
import 'package:piadvisory/Portfolio/PortfolioMainUI.dart';
import 'package:piadvisory/Profile/ProfileRepository/ProfileMethods.dart';
import 'package:piadvisory/SideMenu/Subscribe/Repository/getSubscriptionWithDetails.dart';
import 'package:piadvisory/SideMenu/Subscribe/Repository/razorpay.dart';
import 'package:piadvisory/Utils/base_manager.dart';
import 'package:piadvisory/Utils/database.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../smallcase_api_methods.dart';
import '/Utils/Dialogs.dart';
import '/Common/CustomAppbarWithIcons.dart';
import '/Common/CustomNextButton.dart';
import '/Common/fab_bottom_app_bar.dart';
import '/HomePage/Notifications/Notification.dart';
//import '/HomePage/SettingsPage.dart';
//import '/Portfolio/PortfolioMainUI.dart';
import '/Profile/KYC/SchduleAppointment.dart';
import '/SideMenu/NavDrawer.dart';
import '/SideMenu/Subscribe/Example.dart';
import '/SideMenu/Subscribe/SubscriptionPlans.dart';
import '/Utils/custom_icons_icons.dart';
import '/PaymentSuccess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../HomePage/Homepage.dart';
//
import '../../Utils/textStyles.dart';

class Mysubscription extends StatefulWidget {
  const Mysubscription({Key? key}) : super(key: key);

  @override
  State<Mysubscription> createState() => _MysubscriptionState();
}

class _MysubscriptionState extends State<Mysubscription> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  String _lastSelected = 'TAB: 0';
  int currentIndex = 0;
  bool? colorchanged0;
  bool colorchanged1 = false;
  bool agree = false;

  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    ProfileMethods().getUpdateStatus();
    super.initState();
  }

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
          {}
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
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: ((context) => const PortfolioMainUI())));
          }
          break;
        default:
          {
            throw Error();
          }
      }
    });
  }

  buildAdvisoryAgreementAlertDialog() {
    return showDialog(
      context: context,
      builder: (context) => FutureBuilder(
        future: RazorpayMethods().createOrder(),
        builder: (ctx, snapshot) {
          if (snapshot.data == null) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: CircularProgressIndicator()),
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
          return _buildBody();
        },
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 40,
          child: FittedBox(
            child: FloatingActionButton(
                elevation: 0,
                backgroundColor: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.close,
                  size: 30,
                )),
          ),
        ),
        AlertDialog(
          insetPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
          contentPadding: EdgeInsets.fromLTRB(24, 8, 24, 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side:
                BorderSide(color: Get.isDarkMode ? Colors.grey : Colors.white),
          ),
          // contentPadding:
          //     EdgeInsets.all(
          //         10),

          content: AdvisoryAgreement(),
        ),
      ],
    );
  }

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
            child: FloatingActionButton(
              backgroundColor: Color(0xFFF78104),
              heroTag: "tag1",
              onPressed: null,
              //  () {
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: ((context) => const Mysubscription())));
              // },
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
              //         Get.isDarkMode ? Color(0xFFF78104) : Color(0xFFF78104)
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(right: 8),
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
              // color: Get.isDarkMode ? Color(0xFFF78104) : Color(0xFFF78104)
            ),
            label: 'Subscribe',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CustomIcons.date_range,
              //  color:
              //           Get.isDarkMode ? Color(0xFFF78104) : Color(0xFFF78104)
            ),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CustomIcons.bottombarbagicon,
              size: 22.5,
              //  color:
              //         Get.isDarkMode ? Color(0xFFF78104) : Color(0xFFF78104)
            ),
            label: 'Dashboard',
          ),
        ],
        currentIndex: 2,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Color(0xFFF78104),
        backgroundColor: Colors.white,
        onTap: (index) {
          print(index);
          _selectedTab(index);
        },
        type: BottomNavigationBarType.fixed,
      ),
      appBar: CustomAppBarWithIcons(
        titleTxt: "Subscription",
        globalkey: _key,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: SizedBox(
                        width: 194,
                        child: Text.rich(
                            TextSpan(children: [
                              TextSpan(
                                  text: "Talk to your",
                                  style: TextStyle(
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.black)),
                              TextSpan(
                                  text: " PI ",
                                  style: TextStyle(color: Color(0xFF008083))),
                              TextSpan(
                                  text: "now and start investing like a",
                                  style: TextStyle(
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.black)),
                              TextSpan(
                                  text: " PRO!",
                                  style: TextStyle(color: Color(0xFF008083))),
                            ]),
                            textAlign: TextAlign.center,
                            style:
                                blackStyle(context).copyWith(fontSize: 16.sm)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          //  width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/images/Group 6430.svg'),
                              SizedBox(
                                width: 24,
                              ),
                              Flexible(
                                child: Text(
                                  "Dedicated PI – a highly qualified and experienced Personal Investment Advisor",
                                  style: blackStyle(context).copyWith(
                                      fontSize: 12,
                                      color: const Color(0xFF008083)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/images/Group 6429.svg'),
                              SizedBox(
                                width: 24,
                              ),
                              Flexible(
                                child: Text(
                                  "Quality, research-backed advice that Institutional Investors receive",
                                  style: blackStyle(context).copyWith(
                                      fontSize: 12,
                                      color: const Color(0xFF008083)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/images/Group 6428.svg'),
                              SizedBox(
                                width: 24,
                              ),
                              Text(
                                "Simple and transparent fee structure",
                                style: blackStyle(context).copyWith(
                                    fontSize: 12,
                                    color: const Color(0xFF008083)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 0,
                    ),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: SizedBox(height: 472.h, child: SubscriptionPlans()),
            ),
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Row(
            //           children: const [
            //             ScrollableCards3(
            //               title: "Investment Advisory",
            //               subtitle: "1% of the Sum\nInvested",
            //             ),
            //             ScrollableCards1(),
            //             SizedBox(
            //               width: 10,
            //             ),
            //             ScrollableCards(
            //               title: "Financial Advisory\n(Tax Planning)",
            //               subtitle: "₹1,999",
            //             ),
            //             SizedBox(
            //               width: 10,
            //             ),
            //             ScrollableCards2(
            //               title: "One Time Advisory",
            //               subtitle: "₹199",
            //             ),
            //             SizedBox(
            //               width: 10,
            //             ),
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 25,
            ),
            // !userHasSubscription
            //     ? Padding(
            //         padding: const EdgeInsets.only(
            //           left: 20,
            //           right: 20,
            //         ),
            //         child: Text.rich(
            //           TextSpan(children: [
            //             TextSpan(
            //                 text:
            //                     "Get Started by booking 1st Consultation with your PI @ ",
            //                 style: TextStyle(
            //                     //   //fontSize: 12,
            //                     fontWeight: FontWeight.w600,
            //                     color: Get.isDarkMode
            //                         ? Colors.white
            //                         : Colors.black)),
            //             TextSpan(
            //                 text: "₹199/-",
            //                 style: TextStyle(
            //                     color: Get.isDarkMode
            //                         ? Colors.white
            //                         : Colors.black,
            //                     decorationColor: Colors.red,
            //                     decoration: TextDecoration.lineThrough,
            //                     fontWeight: FontWeight.w600)),
            //             TextSpan(
            //                 text: " FREE",
            //                 style: TextStyle(
            //                     color: Colors.red,
            //                     // fontSize: 12,
            //                     fontWeight: FontWeight.w600)),
            //           ]),
            //           style: Theme.of(context).textTheme.headline5,
            //         ),
            //       )
            //     : const SizedBox(
            //         height: 25,
            //       ),
            !userHasSubscription
                ? SizedBox(
                    height: 30,
                  )
                : SizedBox(
                    height: 0,
                  ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: CustomNextButton(
                  text: 'Book Now',
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => SchduleAppointment())));
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: ((context) => const PaymentSuccess())));

                    // print("user subs? $userHasSubscription");
                    // userHasSubscription
                    //     ? Get.to(() => LoadingScreenPayment())
                    //     : buildAdvisoryAgreementAlertDialog();
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}

class ScrollableCards extends StatelessWidget {
  const ScrollableCards({
    Key? key,
    this.title,
    this.subtitle,
    this.plvalues,
    this.colorvalue,
  }) : super(key: key);

  final String? title;
  final String? subtitle;
  final String? plvalues;
  final int? colorvalue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: 250,
      height: 250,
      child: Card(
        elevation: 2,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF6B6B6B))),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: IntrinsicWidth(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Text(
                  textAlign: TextAlign.center,
                  title!,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF444444),
                  ),
                ),
                const Divider(
                  indent: 80,
                  endIndent: 80,
                  thickness: 2,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      subtitle!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 40,
                        color: const Color(0xFF444444),
                      ),
                    ),
                    const Text(
                      "Only/-",
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF6B6B6B),
                      ),
                    ),
                  ],
                ),
                Column(children: const [
                  SizedBox(
                    height: 20,
                  ),
                  Listsubscribe(
                    title: 'Preparation and filing of Income Tax Returns ',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Listsubscribe(
                    title:
                        'Review of all income, expenses, investments to suggest most efficient tax planning ',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Listsubscribe(
                    title: 'Investments in tax saving instruments ',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Listsubscribe(
                    title:
                        'Advance tax planning to avoid last minute investment rush/hassles ',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Listsubscribe(
                    title: 'b.Insurance',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Listsubscribe(
                    title: 'c.Loans',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ScrollableCards1 extends StatelessWidget {
  const ScrollableCards1({
    Key? key,
    this.title,
    this.subtitle,
    this.plvalues,
    this.colorvalue,
  }) : super(key: key);

  final String? title;
  final String? subtitle;
  final String? plvalues;
  final int? colorvalue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 650,
      child: Card(
        elevation: 2,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF6B6B6B))),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: IntrinsicWidth(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Comprehensive Financial Planning",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF303030),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Divider(
                  indent: 100,
                  endIndent: 100,
                  thickness: 2,
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "Full-Time \nAdvisory",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30,
                    color: const Color(0xFF444444),
                  ),
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(
                        height: 15,
                      ),
                      Listsubscribe1(
                        title: 'All feature of Plan 1 and Plan 2',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Listsubscribe1(
                        title:
                            'Comprehensive financial planning including investment planning (stocks, mutual funds, fixed deposits, real estate), liquidity management, insurance, loan. Retirement planning, goal planning ',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Listsubscribe1(
                        title:
                            'Highly qualified and experienced personal financial planner ',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Listsubscribe1(
                        title:
                            'Holistic review of overall financial health twice a year ',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Listsubscribe1(
                        title:
                            'Unlimited access to your personal financial planner through chat',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Listsubscribe1(
                        title:
                            'Go to person for all your financial requirements across all stages of your life',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Listsubscribe1(
                        title:
                            'Complementary tax planning and ITR filing (worth Rs 1999/-)',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ScrollableCards2 extends StatelessWidget {
  const ScrollableCards2({
    Key? key,
    this.title,
    this.subtitle,
    this.plvalues,
    this.colorvalue,
  }) : super(key: key);

  final String? title;
  final String? subtitle;
  final String? plvalues;
  final int? colorvalue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: 250,
      height: 650,
      child: Card(
        elevation: 2,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF6B6B6B))),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: IntrinsicWidth(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 25,
                ),
                Text(
                  textAlign: TextAlign.center,
                  title!,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF444444),
                  ),
                ),
                const Divider(
                  indent: 80,
                  endIndent: 80,
                  thickness: 2,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      subtitle!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 40,
                        color: const Color(0xFF444444),
                      ),
                    ),
                    const Text(
                      "Only/-",
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF6B6B6B),
                      ),
                    ),
                  ],
                ),
                Column(children: const [
                  SizedBox(
                    height: 20,
                  ),
                  Listsubscribe(
                    title: 'Get Started at a Booking Amount of ₹199/- only',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Listsubscribe(
                  //   title: 'Lorem ipsum',
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Listsubscribe(
                  //   title: 'Lorem ipsum',
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Listsubscribe(
                  //   title: 'Lorem ipsum',
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ScrollableCards3 extends StatelessWidget {
  ScrollableCards3({
    Key? key,
    this.title,
    this.subtitle,
    this.colorChange = false,
    required this.list1,
  }) : super(key: key);

  final String? title;
  final String? subtitle;

  final bool colorChange;
  List<Listsubscribe1> list1 = [];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 650,
      child: Card(
        color: colorChange ? const Color(0xFF008083) : Colors.white,
        elevation: 2,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF6B6B6B))),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: IntrinsicWidth(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 25,
                ),
                Text(
                  textAlign: TextAlign.center,
                  title!,
                  style: const TextStyle(
                    fontSize: 14,
                    color: const Color(0xFF444444),
                  ),
                ),
                const Divider(
                  indent: 100,
                  endIndent: 100,
                  thickness: 2,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        subtitle!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 30,
                          color: Color(0xFF444444),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(children: [
                  const SizedBox(
                    height: 20,
                  ),
                  ListView.builder(
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return list1[index];
                      }),
                  const Listsubscribe1(title: 'Dedicated Investment Advisor '),
                  const SizedBox(
                    height: 10,
                  ),
                  const Listsubscribe1(
                    title:
                        'Personal interaction with highly qualified and experienced investment advisor',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Listsubscribe1(
                    title: 'Curated investment portfolio advice',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Listsubscribe1(
                    title:
                        'Diversification across stocks, mutual funds, fixed deposits, real estate ',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Listsubscribe1(
                    title: 'Investments in tax saving instruments ',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Listsubscribe1(
                    title: 'Professional risk management',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Listsubscribe1(
                    title: 'Periodic rebalancing of portfolio ',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Listsubscribe1(
                    title: 'Detailed risk profiling ',
                  )
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Listsubscribe extends StatelessWidget {
  const Listsubscribe({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.check,
          size: 21,
          color: const Color(0xFF008083),
        ),
        const SizedBox(
          width: 5,
        ),
        SizedBox(
          width: 250.w,
          child: Text(
            title,
            style: const TextStyle(
              color: Color(0xFF6B6B6B),
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}

class Listsubscribe1 extends StatelessWidget {
  const Listsubscribe1({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.check,
          size: 21,
          color: const Color(0xFF008083),
        ),
        const SizedBox(
          width: 5,
        ),
        SizedBox(
          width: 250.w,
          child: Text(
            title,
            style: const TextStyle(
              color: Color(0xFF6B6B6B),
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}

class AdvisoryAgreement extends StatefulWidget {
  const AdvisoryAgreement({Key? key}) : super(key: key);

  @override
  State<AdvisoryAgreement> createState() => _AdvisoryAgreementState();
}

class _AdvisoryAgreementState extends State<AdvisoryAgreement> {
  bool agree = false;
  Razorpay _razorpay = Razorpay();
  Map<String, dynamic> planDetails = {};
  Map<String, dynamic> userdetails = {};
  Map<String, dynamic> options = {};
  // @override
  // void initState() {
  //   _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
  //   _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  //   _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

  //   setState(() {
  //     planDetails = Get.find<Database>().restorePriceAndPlanName();
  //     print("planDetails is $planDetails");
  //     planDetails = planDetails;
  //     userdetails = Get.find<Database>().restoreUserDetails();
  //     print("user details $userdetails");
  //   });
  //   super.initState();
  // }

  // setOptions() {
  //   options = {
  //     'key': 'rzp_test_ryPoiSUUJmfLXB',
  //     'amount': planDetails['amount'], //in the smallest currency sub-unit.
  //     'name': planDetails['planName'],
  //     'order_id': orderID, // Generate order_id using Orders API
  //     'description': 'Fine T-Shirt',
  //     'timeout': 60, // in seconds
  //     'prefill': {
  //       'contact': userdetails['number'],
  //       'email': userdetails['email']
  //     }
  //   };
  // }

  // // void UploadData(orderId, paymentID, signature) async {
  // //   Map<String, dynamic> updata = {
  // //     'orderID': orderId,
  // //     'paymentID': paymentID,
  // //     'signature': signature
  // //   };

  // //   final data = await RazorpayMethods().postpaymentverification(updata);
  // //   if (data.status == ResponseStatus.SUCCESS) {
  // //     Get.toNamed('/paymentsuccessfull', arguments: [
  // //       {"orderID": orderId},
  // //       {"paymentID": paymentID},
  // //       {"signature": signature}
  // //     ]);
  // //   } else {
  // //     return utils.showToast(data.message);
  // //   }
  // // }

  // void _handlePaymentSuccess(PaymentSuccessResponse response) {
  //   print("success payment ");
  //   print(response.orderId);
  //   print(response.paymentId);
  //   print(response.signature);

  //   RazorpayMethods().getPaymentDetails(response.orderId!);

  //   Get.toNamed('/paymentsuccessfull', arguments: [
  //     {"orderID": response.orderId},
  //     {"paymentID": response.paymentId},
  //     {"signature": response.signature}
  //   ]);

  //   //  UploadData(response.orderId, response.paymentId, response.signature);
  // }

  // void _handlePaymentError(PaymentFailureResponse response) {
  //   print("failed called");
  //   print(response.message);
  //   print(response.code);

  //   RazorpayMethods().getPaymentDetails(orderID);
  // }

  // void _handleExternalWallet(ExternalWalletResponse response) {
  //   // Do something when an external wallet is selected
  //   print(response.walletName);
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text("Advisory Agreement",
            style: blackStyle(context).copyWith(
              color: Get.isDarkMode ? Colors.white : Colors.black,
            )),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
          child: Container(
            padding: const EdgeInsets.all(10),
            color: const Color(0xFF008083),
            height: 250,
            child: Scrollbar(
              thumbVisibility: true,
              child: SingleChildScrollView(
                child: Text(
                  '''THIS INVESTMENT ADVISORY AGREEMENT is made AMONGST: 1. SuperMoney Advisors Private Limited, a private limited company incorporated under the Companies Act 2013, having its registered office at Tirupati Nagar Banswara (M), Udaipur Road, Banswara, Rajasthan 327001 (“SuperMoney” or the "Investment Advisor"); and 2. The Client, whose name, address and details are set out in the account application; WHEREAS: (A) SuperMoney Advisors Private Limited (“SuperMoney” or the "Investment Advisor”) is registered with the Securities and Exchange Board of India (the “SEBI”) under the provisions of Securities and Exchange Board of India (Investment Advisers) Regulations, 2013 (“Investment Advisors Regulations”) with Registration No. [**************] to act as an ‘Investment Advisor’. SuperMoney operates mobile applications and websites ************ under brand names “PI Advisors" (“Platform”) and offers and provides advisory services, as specified under “Schedule 2” to clients. (B) The Client wishes to appoint the Investment Advisor to provide advisory services in accordance with the Client's investment objectives and the Investment Advisor is willing to accept such appointment on the terms and conditions hereinafter contained. Except as otherwise provided in this Agreement, the services provided pursuant to this Agreement does not include or otherwise apply to services provided by the Investment Advisor’s non registered affiliates or technology partners or to services provided with respect to assets not held in the Portfolio. AND IT IS HEREBY AGREED AND DECLARED as follows: 1. Consent of the Client: i. I have read and understood the terms and conditions of Investment Advisory services provided by the Investment Advisor along with the fee structure and mechanism for charging and payment of fee. ii. Based on our written request to the Investment Advisor, an opportunity was provided by the Investment Advisor to ask questions and interact with person(s) associated with the investment advice. 2. Declaration from Investment Advisor: i. Investment Advisor shall neither render any investment advice nor charge any fee until the Client has signed this agreement. ii. Investment Advisor shall not manage funds and securities on behalf of the Client and that it shall only receive such sums of monies from the Client as are necessary to discharge the Client's liability towards fees owed to the Investment Advisor. iii. Investment Advisor shall not, in the course of performing its services to the Client, hold out any investment advice implying any assured returns or minimum returns or target return or percentage accuracy or service provision till achievement of target returns or any other nomenclature that gives the impression to the Client that the investment advice is risk-free and/or not susceptible to market risks and or that it can generate returns with any level of assurance. 3. Fees specified by Investment Advisor Regulations and circular issued by SEBI: As per Regulation 15A of Securities Exchange Board of India (Investment Advisor) Regulations, 2013 read with circulars issued from time to time, Investment Advisor will be entitled to charge fees from a Client in either of the following 2 modes: 3.1 Asset Under Advice (AUA) mode: The maximum fees that may be charged under this mode shall not exceed two point five percent (2.5%) of AUA per annum per Client across all services offered by Investment Advisor. 3.2 Fixed fee mode: The maximum fees that may be charged under this mode shall not exceed Rupees One Lakh twenty-five thousand (INR 1,25,000) per annum per Client across all services offered by Investment Advisor. 4. Fees payable by the Client : 4.1 Client shall pay all fees specified in the Client Services Agreement which is covered as part of Schedule 2 (the “Investment Advisory Services & Fees”). 4.2 Except as otherwise specified herein, all fees are payable in Indian Rupees. The subscription fees are based on the investment advisory services provided by SuperMoney and SuperMoney reserves the right to amend such fees. All fees are exclusive of taxes and Client shall be liable to pay all applicable government taxes on the investment made by the Client. Client is advised to consult a tax professional to determine their taxation obligations. SuperMoney shall not be liable nor advise the Client on their taxation obligations. 4.3 The Investment Advisor may, in writing, reduce, defer or waive all or part of the fees or other amounts payable to the Investment Advisor under this Agreement or direct that a portion of such fees or other amounts to be paid by the Client to third parties, employees of the Investment Advisor, providers of services to the Client or such other parties as the Investment Advisor in its discretion may see fit from time to time. 5. Appointment of Investment Advisor 5.1 Appointment In accordance with the applicable laws, Client hereby appoints, entirely at his / her / its risk, the Investment Advisor to provide the required services in accordance with the terms and conditions of the Agreement as mandated under Regulation19(1)(d) of the Securities and Exchange Board of India (Investment Advisors) Regulations, 2013. The Client hereby appoints the Investment Advisor to provide the services as set out in Schedule 2 (the “Investment Advisory Services & Fees”) and to undertake investment advisory duties as may, from time to time, be reasonably requested by the Client, for the period and on the terms set out herein, and the Investment Advisor accepts such appointment and agrees to assume the obligations set forth below for the compensation herein provided. 5.2 Independent contractor The Investment Advisor is an independent contractor and not under or by virtue of the provisions of this Agreement, a partner, joint venturer or employee of the Client. The Investment Advisor is not an agent of the Client unless and to the extent expressly provided for under the terms of this Agreement. 6. Scope of Services 6.1 Advisory The Investment Advisor shall advise the Client in relation to the investment in the securities, as well as on such ancillary matters as shall reasonably be requested by the Client and having regard to the investment objectives and restrictions of the Client as set out in the related documents specified in Schedule 1. Without limiting the generality of the foregoing, the Investment Advisor will have the power and the duty to carry out the actions listed in Schedule 2 which also list down the scope coverage of services along with possible risk factors associated with investing in securities. The Investment Advisor is a technology enabled platform and will use technological tools for communicating advices with respect to investment in securities. While these reduce costs and improve efficiency, the Client is exposed to risks associated with electronic dissemination of advice. The Client acknowledges and accepts all the involved risks while opening the account. 6.2 Compliance i. In performing its obligations under this Agreement, the Investment Advisor will not provide advisory services that would result in a breach by the Client of any applicable laws and regulations. This is subject to the Client providing full and complete disclosure about its scope under this Agreement. ii. In carrying out its duties hereunder, the Investment Advisor shall observe and comply with all applicable laws, rules and regulations as amended from time to time, including those under the regulations and the applicable circulars and guidelines issued by the SEBI and RBI. iii. For the avoidance of doubt, the Investment Advisor shall not hold any assets or fund belonging to the Client. iv. The Investment Advisor confirms that it has a clean disciplinary history. 6.3 Execution i. The Client is under no obligation to choose the stock broker, depository participant or distributor to execute the transactions. The Client has the right to choose the same through whom the execution services are to be carried out. 7. Investment Advisor’s Powers i. In performing its duties and responsibilities under this Agreement, the Investment Advisor may delegate such of its powers, authorities, duties and responsibilities to such party or parties (including fund administrators, KYC and other members of the Group) as the Investment Advisor may consider necessary or desirable except that investment advisory duties shall not be delegated. The Investment Advisor will exercise its power of delegation only on terms which are consistent with the terms of this Agreement, including as to any indemnity provided for such delegation. ii. Notwithstanding any such delegation, the Investment Advisor will remain liable for all the obligations expressed to be assumed by it under this Agreement. 8. Functions of Investment Advisor (including principal officer and all persons associated with the investment advice): Investment Advisor shall comply with : i. the Securities and Exchange Board of India (Investment Advisors) Regulations, 2013 and its amendments, rules, circulars and notifications at all the time. ii. eligibility criteria as specified under the Investment Advisor Regulations at all times. iii. risk assessment procedure of Client including their risk capacity and risk aversion iv. providing reports to the Clients on potential and current investments v. maintenance of records i.e. Client-wise KYC, risk assessment, analysis reports of investment advice and suitability, terms and conditions document, related books of accounts and a register containing list of Clients along with dated investment advice and its rationale in compliance with the Securities and Exchange Board of India (Investment Advisors) Regulations, 2013 vi. provisions regarding audit as per the Securities and Exchange Board of India (Investment Advisors) Regulations, 2013 vii. Investment Advisor undertakes to abide by the Code of Conduct as specified in the Third Schedule of the Securities and Exchange Board of India (Investment Advisors) Regulations, 2013 9. Conflicts of Interests 9.1 Other interests It is understood that: i. directors, officers, agents and shareholders of the Client are or may be interested in the Investment Advisor as directors, officers, shareholders or otherwise and vice versa; ii. the Investment Advisor is or may be interested in the Client as a shareholder or otherwise and vice versa; and iii. the Client and the Investment Advisor and its respective directors, officers, agents and shareholders may, from time to time, have other appointments, offices and interests to which they may devote such time, effort and resources as they consider appropriate provided that such appointments, offices and interests do not deter from the performance of the Investment Advisor’s obligations under this Agreement, and it is hereby acknowledged that no person so interested will be liable to account for any benefit to any other party by reason solely of such interest. 9.2 The Investment Advisor will disclose to the client all conflicts of interest as and when they arise during the course of business.​10. Representations and Warranties 10.1 Each party represents and warrants to the other party that: i. it is duly incorporated and in good standing under the laws of where they are domiciled and has and will at all times have the necessary power to enter into and perform its obligations under this Agreement and has duly authorised the execution of this Agreement; ii. this Agreement constitutes legal and binding obligations enforceable against it; iii. its execution, delivery, observance and performance of this Agreement will not result in any violation of any law, statute, ordinance, rule or regulation applicable to it; iv. it has obtained all the necessary licenses, permissions, authorisations, consents and exemptions to enable it to enter into this Agreement and to perform its obligations under this Agreement and the necessary licenses, permissions, authorisation, consents and exemptions will remain in full force and effect at all times during the term of this Agreement; v. there is no litigation, governmental investigation or other governmental proceeding pending against it or any of its related parties which, if adversely determined, would materially adversely affect its business; and vi. any information which it has provided to the other party is complete and correct and agrees to notify the other party forthwith if there is any material change in any such information provided. 10.2 The Client warrants and represents that: i. any information which the Client has provided to the Investment Advisor, including in relation to the Client's status for taxation purposes, is complete and correct and the Client agrees to provide any further information required by any competent authority. The Client will promptly notify the Investment Advisor forthwith and in writing if there is any material change in any information provided including any information which affects the client’s risk profiling and his risk appetite. The Client understands and accepts that failure to do so may adversely affect the quality of the advice or recommendations. ii. Client further agrees to provide any data and information which the Investment Advisor may reasonably request from time to time, in order to enable the Investment Advisor to perform the Advisory Services or comply with any laws, regulations and policies in relation to KYC. The client agrees that advisory agreement shall be considered to be effective only on completion of KYC (CVL KRA and CKYC) by the client. iii. Client understand that the factors that may be important for us to render the Advisory Services effectively are as follows: (a) circumstances that may lead to a change in Client’s risk appetite or risk tolerance; (b) client’s investment objectives including time for which the Client wishes to stay invested; (c) the purposes of the investments; (d) any restrictions or preferences that the Client may wish to specify in respect of the nature or manner of investments or on any particular security/sector; (e) client’s income details; (f) client’s liabilities details; and (g) client’s existing investments and assets including those not advised by the Investment Advisor. iv. Client agrees that the Client shall not disclose any advice provided by the Investment Advisor pursuant to the availing of the Advisory Services pertaining to the purchase and sale of securities to any third party and, in this respect, the Investment Advisor shall not be responsible for any claims or losses that may be suffered by such party as a result of the disclosure of such advice by the Client. v. Client hereby agrees and acknowledges that any advice provided to the Client pursuant to this Agreement, is exclusively for Client’s knowledge and use, subject to the extent otherwise permitted herein. vi. that no assurance, representation or guarantee has been given by the Investment Advisor or any other person that the Investment Advisor's services provided herein will generate profits or avoid losses for the Client or in any way will meet the investment objectives of the Client. 10.3 Investment Advisor represents that : i. The investment advisor will take all consents and permissions from the Client prior to undertaking any actions in relation to the securities or investment product advised by the Investment Advisor. ii. The Investment Advisor shall maintain arm’s length relationship between its activities as ‘investment advisor’ under the provisions of SEBI Investment Advisors Regulations and other activities and the activities of distribution or execution services offered by its group company, if any. The Investment Advisor provides execution services through separately identifiable department having its own team of professionals distinct from its professionals involved in advisory services. iii. The Investment Advisor will not seek any power of attorney or authorizations from its Clients for implementation of investment advice. iv. The Client also understands that the Investment Advisor may give advice or take action in performing its duties to other client(s), or for their own accounts, that differ from advice given to or acts taken for the Client. The Investment Advisor is not obligated to buy, sell or recommend for Client any security or other investment, that the Investment Advisor may buy, sell or recommend for any other Client or for its own accounts. This Agreement does not limit or restrict in any way the Investment Advisor from buying, selling or trading in any security or other investments for their own accounts, subject to compliance with the Regulations. v. The Client understands that the Investment Advisor, pursuant to the terms of SEBI Investment Advisors Regulations, shall maintain certain records which include, KYC details of the Client, risk assessment and Risk Profiling details, provide reports on potential and current investments, analysis reports of investment advice/Advisory Services rendered and suitability, other related documents and books of account pertaining to the Investment Advice and any conversation relating to Advisory Services with the Client, which includes, any physical records written &amp; signed by Client, telephone recording, email from registered email id, record of SMS messages, and/or any other legally verifiable record; and in this respect the Client gives its consent in respect of maintenance of such records and documents. SuperMoney represents and warrants that it shall, at all times, comply with the SEBI Investment Advisors Regulations and applicable laws of India in relation to maintenance of such records and data. vi. The Investment Advisor represents that it shall not (i) provide any distribution services, for securities and investment products, either directly or through their group to an Advisory client; and (ii) provide investment Advisory Services, for securities and investment products, either directly or through their group to the distribution client. vii. The Investment Advisor represents that it shall provide direct implementation of Advisory services i.e. through direct schemes/direct codes (wherever applicable) to the client. However, Investment Advisor shall ensure that no consideration including any commission or referral fees, whether embedded or indirect or otherwise, by whatever name called is received; directly or indirectly, at investment advisor’s group level for the said service, as the case maybe. 11. LIABILITY 11.1 The Client acknowledges and agrees that the Investment Advisor does not guarantee that its advice will result in profits or avoid losses or meet the investment objectives of the Client or that such advice will not at any time be affected by adverse tax consequences, technical failures, timely regulatory compliance to a new law. The Investment Advisor will not be liable to the Client for any error of judgement or loss suffered by the Client in connection with the Advisory Services provided to the Client by the Investment Advisor. 11.2 All decisions in relation to investments are based on the Client’s own evaluation of the Client’s financial circumstances and investment objectives. Any decision, action or omission to buy, sell or hold Investments shall be based solely on the Client’s own verification and a proper evaluation of all the relevant facts, financials and other circumstances and neither the Investment Advisor nor any of the Investment Advisor’s employees, officers, directors, personnel, agents or representatives shall be responsible or held liable for the same for any reason whatsoever. 11.3 The Client understands that at the request of the Client, the Investment Advisor provides Advisory Services to the Client, and the Investment Advisor provides such advices as per the standards within the ambit of the applicable laws of India, which may require the Investment Advisor to have a reasonable basis to believe that such advice (a) meets the Client’s investment objectives as may be recorded with the Investment Advisor and confirmed by the Client, including but not limited to, risk assessment and Risk Profiling; (b) that the Client is able to bear investment risk consistent with the Client’s  investment objectives and risk tolerance; and (c) that the Client has the necessary experience and knowledge to understand the risks involved in the investment(s). 11.4 It is expressly clarified that unless specifically requested by the Client and explicitly agreed by the Investment Advisor, the Investment Advisor shall have no ongoing obligation to advise the Client on, or to monitor, any individual investment or portfolio of investments. 11.5 11.5 The Client confirms that the Client is aware that securities are subject to a very wide variety of risks which include amongst others an unpredictable loss in value which may extend to a total loss of value of the securities due to, inter alia: (a) overall economic slowdown, unanticipated corporate performance, environmental or political problems, changes to monetary or fiscal policies, changes in government policies and regulations with regard to industry and exports; (b) acts of force majeure including nationalisation, expropriation, currency restriction, measures taken by any government or agency of any country, state or territory in the world, industrial action or labour disturbances of any nature, boycotts, power failures or breakdowns in communication links or equipment (including but not limited to loss of electronic data) international conflicts, violent or armed actions, acts of terrorism, insurrection, revolution, nuclear fusion, fission or radiation, or acts of God, default of courier or delivery service or failure or disruption of any relevant stock exchange, depository, clearing house, clearing or settlement systems or market, or the delivery of fake or stolen securities; (c) volatility of the stock markets, stock market scams, circular trading of securities and price rigging; (d) default or non-performance of a third party, company’s refusal to register a Security due to legal stay or otherwise and disputes raised by third parties; and (e) low possibilities of recovery of loss due to expensive and time-consuming legal process and any changes in the Securities and Exchange Board of India (SEBI) rules and regulations and other applicable laws governing the Terms, and in this relation the Client understands that the Investment Advisor shall not be liable and responsible for any loss occurred to Client arising of or in connection with, such aforesaid risk factors and elements.  11.6 Indemnity Client hereby undertakes to hold harmless and fully indemnify the Investment Advisor and its directors, principal officers, employees and duly appointed agents and representatives (the "Indemnified Parties“)against all liabilities, obligations, losses, damages, penalties, actions, proceedings, judgments, suits, claims, costs, demands, expenses and/or disbursements of any kind or nature whatsoever which may be brought against suffered or incurred by the Indemnified Parties by reason of their performance of its duties under the terms of this agreement or otherwise by reason of their activities on behalf of the Client including all legal fees (on a full indemnity basis) and any other expenses properly incurred and including any such liabilities, actions, proceedings, claims, costs, demands and expenses as shall arise as a result of loss, delay, interruptions of service or error in transmission of any cable, telex, telefax, telegraphic or other communication. Client acknowledges that there may be delays for interruptions in the use of Client’s system, including, for example, those caused intentionally by Investment Advisor for purposes of servicing its system. Under no circumstances shall the Investment Advisor be liable for any punitive, indirect, incidental, special or consequential loss or damages, including loss of business or goodwill. Further, the Client agrees to indemnify and hold harmless the Indemnified Parties from and against any and all liabilities, obligations, losses, damages, penalties, actions, judgments, suits, costs, expenses or disbursements of any kind or nature whatsoever arising out or in relation or in connection with, breach of any terms of this Agreement by the Client (including breach of representations and obligations as specified herein), non-compliance of any applicable law of India; furnishing/providing any untrue and false data and information, records or document to Investment Advisor as may be required for the purposes of Advisory Services or this Agreement; and/or any act or omission of gross negligence, fraud and wilful default by the Client. Without prejudice to the generality of the preceding provisions of this Clause, Investment Advisor will not be responsible for any loss suffered by the Client as a result of any default by any person with whom Investment Advisor arranges or enters into any transaction on behalf of the Client pursuant to this Agreement. 11.7 Disclaimer The Investment Advisor to the best of its knowledge is compliant with all the regulatory framework for carrying out its business services, however ultimate responsibility for regulatory compliance lies with the Client and the Client shall seek his/her/its own independent opinion through a professional to take an informed decision. 11.8 Officers, employees etc. For the avoidance of doubt, the references to the Investment Advisor in this clause will be deemed to include the principals, officers, directors, shareholders, agents, employees or servants of the Investment Advisor. 12. Termination 12.1 Term This Agreement shall continue until terminated by either party giving to the other not less than 30 clear calendar days’ prior written notice of termination or such other period as may be agreed between the parties in writing or terminated pursuant to the remaining provisions of this clause 12. 12.2 Termination events Notwithstanding the provisions of clause 12.1, this Agreement and the appointment of the Investment Advisor hereunder may be terminated: i. automatically, if either party files a petition for bankruptcy, reorganisation or arrangement, or makes an assignment for the benefit of the creditors or takes advantage of an insolvency or similar law, or if a receiver or trustee is appointed for the assets or business of either party and is not discharged within 90 days after such appointment; ii. In case of death / permanent disability of the Client; iii. If the Investment Advisor’s certificate of registration cancelled or suspend by the Securities Exchange Board of India and iv. by either party if the other party shall commit any breach of its obligations under this Agreement and shall fail to make good such breach within 30 days of receipt of notice served by the party requiring it so to do. v. The Investment Advisor reserves the right to suspend or terminate this Agreement forthwith, if the Client commit a breach of any of the terms and conditions hereunder or if SuperMoney’s arrangement with the third party employer of the Client is terminated. For avoidance of doubt, it is clarified that if the employer of the Client fails to pay the advisory Fee on behalf of the Client, SuperMoney will have the right to suspend performance of the Advisory Services until the Client pays the Advisory Fee on our platform to continuing availing the advisory Services of SuperMoney. The Client may terminate the Agreement in case of suspension or termination of the registration of the Investment Advisor as an Investment Advisor by SEBI or any other competent authority. vi. The Investment Advisor may immediately stop advising the client If he / she doesn't pay advisory fees by the due date. The Investment Advisor may terminate the agreement if the client doesn’t pay the advisory fees on or before 3 moths from the due date of the payment. 12.3 Payments on termination On termination of this Agreement pursuant to this clause 12, the Investment Advisor will be entitled to receive the following payments (unless otherwise agreed by the parties) from the Client: i. all accrued but unpaid fees or other amounts otherwise payable under this Agreement, to the date of the termination; and ii. the reimbursement of all costs incurred and expenses provided for in this Agreement but not yet paid by the Client, including all costs and expenses reasonably incurred by the Investment Advisor in relation to such termination, unless this Agreement is terminated due to the Investment Advisor breaching its obligations under this Agreement. 13. Confidentiality 13.1 The Client acknowledges that, in the course of his relationship with SuperMoney and in using the Services, he may obtain information relating to the Services and/or SuperMoney (“Proprietary Information”). Such Proprietary Information shall belong solely to SuperMoney and includes, but is not limited to, the features and mode of operation of the Services, trade secrets, know-how, inventions (whether or not patentable), techniques, processes, programs, ideas, algorithms, schematics, testing procedures, software design and architecture, computer code, internal documentation, design and function specifications, product requirements, problem reports, analysis and performance information, benchmarks, software documents, and other technical, business, product, plans and data. In regard to this Proprietary Information. 13.2 The Receiving Party will hold the Confidential Information of the Disclosing Party in trust and confidence for the Disclosing Party and, except as set forth in this Agreement or as otherwise may be authorized by the Disclosing Party in writing, will not disclose such information to any third party. The Parties agree that the Receiving Party may disclose the Confidential Information of the Disclosing Party to its affiliates and employees on a need to know basis and to the extent necessary for the conduct of its business or for performing its obligations under this Agreement. SuperMoney will not publish, disclose or use any Confidential Information of the Client unless required by any applicable law, regulations, rules and guidelines laid down by SEBI, order of a court of competent jurisdiction or by a regulatory authority or with specific permission of the Client. 13.3 Any information shall not be considered “Confidential Information” to the extent, but only to the extent, that such information: (a) was already known to the Receiving Party free of any restriction at the time it is obtained from the Disclosing Party; (b) is subsequently learned from an independent third party free of any restrictions and without breach of this Agreement or any other agreements; (c) is or becomes publicly available through no wrongful act of the Receiving Party; or (d) is independently developed by the Receiving Party without reference to any Confidential Information. 13.4 The Receiving Party may disclose Confidential Information of the Disclosing Party if required to do so under any applicable law, rule or order, provided that the Receiving Party, where reasonably practicable and to the extent legally permissible, provides the Disclosing Party with prior written notice of the required disclosure so that the Disclosing Party may seek a protective order or other appropriate remedy , and provided further that the Receiving Party discloses no more Confidential Information of the disclosing Party than is reasonably necessary in order to respond to the required disclosure. Each Party may retain copies of the Confidential Information, as applicable, to the extent required to comply with applicable legal and regulatory requirements. Such Confidential Information, as applicable, will remain subject to the terms and conditions herein. 13.5 For the purpose of this clause, the term “Disclosing Party” means the party and its affiliates providing Confidential Information. The term “Receiving Party” means the party and its affiliates receiving Confidential Information. 14. Notice 14.1 Any notice or other communication required or authorized by this Agreement shall be given in writing and shall be served by hand at or by being sent by registered post or by electronic delivery or by facsimile transmission or comparable means of communication to the address or the facsimile transmission number of the relevant party as set out below or provided to Investment Advisor on its system: 14.2 Any notices or information given by post in the manner prescribed in Clause 16.1 which is not returned to the sender as undelivered shall be deemed to have been given on the seventh day after the envelope containing it was so posted and proof that the envelope containing any such notice or information was properly addressed, prepaid, registered and posted and that it has not been so returned to the sender shall be sufficient evidence that the notice or information has been duly given. 14.3 Any notice or information sent by facsimile transmission, electronic mail or comparable means of communication shall be deemed to have been duly sent on the date of transmission upon receipt of the transmission report showing due transmission. 15. Miscellaneous 15.1 Nothing contained in this Agreement is intended to or shall be deemed to establish any partnership between the Client and Investment Advisor or any of its Affiliates or other clients. 15.2 Client acknowledges that Investment Advisor may revise this Agreement by sending notice of the revised agreement by e-mail or upon Client’s log-in on the Investment Advisor’s system. Client’s use of Investment Advisor’s system after such notice constitutes acceptance of the revised agreement. Each time the Client utilizes the Investment Advisor system, software or technologies, the Client affirms its acceptance of, and agreement to, the terms outlined in this Agreement. 15.3 No failure or delay by a party to exercise any right or remedy under this Agreement or by law will operate as a waiver of that or any other right or remedy, nor shall it prevent or restrict the further exercise of that or any other right or remedy. No single or partial exercise of such right or remedy shall prevent or restrict the further exercise of that or any other right or remedy. For the avoidance of doubt, the rights and remedies provided in this Agreement are cumulative and not exclusive of any rights or remedies provided by law. 15.4 This Agreement may be executed in more than one counterpart and shall come into force/take effect as delivery once each party has executed such a counterpart in identical form and exchanged the same in PDF, JPEG or other agreed format or a facsimile copy of the same with the other party 15.5 This Agreement shall be binding upon, and inure solely to the benefit of, the Client, Investment Advisor and, to the extent the Client is an entity, the Client representative, the officers and directors of the Client and each person who controls the Client and their respective heirs, executors, administrators, successors and assigns, and no other person shall acquire or have any right under or by virtue of this Agreement. 15.6 Time shall be of the essence of this Agreement. As used herein, the term “business day” shall mean any day when the Investment Advisor’s office is open for business. 15.7 This Agreement supersedes and extinguishes all prior agreements and understandings (whether written or oral) between the Client and Investment Advisor, with respect to the subject matter hereof. 15.8 The Client consents to recording of all telephone conversations. The Client acknowledges Investment Advisors Privacy Policy and consents to the collection and use of the Client Personal Information as described therein. 15.9 The agreement may be amended by mutual consent of the parties. 16. Electronic Consent 16.1 Client hereby agrees and consents to have Investment Advisor deliver or make available electronically all current and future account statements, notices (including privacy notices), letters to Client regulatory communications and other information, documents, data and records related to the Account (collectively, “Account Communications”). Client acknowledges and agrees that electronic communication from Investment Advisor will include, among other things, email delivery, and/or the electronic communication of Account Communications pertaining to Client via Investment Advisor’s website and Client acknowledges and agrees that such email delivery and electronic provision shall be deemed delivery. Client acknowledges and agrees that it is Client’s affirmative obligation to notify Investment Advisor in writing of any changes to Client’s email address. With respect to e-mail delivery of account communication, Client understands that e-mail messages may sometimes fail to transmit properly, including being delivered to SPAM folders Client further understand that Client is responsible for ensuring that any emails from the Investment Advisor are not marked as SPAM and that Investment Advisor is responsible only to the extent that it sends e-mail messages to Client’s e-mail address as on record. Regardless of whether or not Client receives an e-mail notification, Client agrees to check Investment Advisor’s website on a regular basis for current information and to avoid missing any information that is time-sensitive. 16.2 Investment Advisor shall not be liable for any interception by any third party of Account Communications. Client acknowledges and agrees that, although Investment Advisor will not charge additional amounts for electronic delivery, Client may incur charges from its internet service provider or other third parties in connection with the delivery and receipt of account communications delivered electronically. In addition, Client understands that there are risks associated with electronic delivery of account communications, including the risk of system outages or interruptions, which risks may, among other things, inhibit or delay Client’s receipt of account communications. 16.3 Investment Advisor’s shall maintain the Client’s documents as per its internal confidentiality policy for a period of seven (7) years. 16.4 Subject to the terms of this Agreement, Client may revoke or restrict consent to electronic delivery of Account Communication at any time by notifying Investment Advisor in writing of Client’s intention to do so. Client understands that it has the right to request paper delivery of any Account Communication that the law requires Investment Advisor to provide to Client in paper form. Client understands that if it revokes or restricts consent to electronic delivery of Account Communications or requests paper delivery of the same, Investment Advisor, in its sole discretion, may: (i) charge Client a reasonable service fee for the delivery of any Account Communications that would otherwise be delivered to Client electronically, and/or (ii) restrict or close the Account. Client understands that neither the revocation or restriction of consent, request for paper delivery, nor Investment Advisor’s delivery of paper copies of Account Communications will affect the legal effectiveness or validity of any electronic communication provided while Client’s consent is in effect. 16.5 Client’s consent to receive electronic delivery of Account Communications will be effective immediately and will remain in effect unless and until either Client or Investment Advisor revokes consent per Section 19.4 above. Client understands that it may take up to three (3) business days to process a revocation of consent to electronic delivery. Client acknowledges that it may receive electronic notifications until such consent is processed. 16.6 Client understands and confirms that in order to access, view, and retain Account Communications from Investment Advisor Client must have: (i) access to an up-to-date internet browser to access the Account, or if accessing through a mobile application, one of the following mobile operating systems: Apple iOS 6.0 or later or Android OS 2.3 or later; (ii) local, electronic storage capacity to retain Account Communications and/or a printer to print them; (iii) a valid e-mail account and software to access it; (iv) an up-to-date device or devices including but not limited to a computer, tablet, or smartphone suitable for connecting to the internet and downloading or accessing websites; and (v) software that enables Client to view files in the Portable Document Format (“PDF”). 17. Electronic Signature Client consents and agrees that his or her use of a key pad, mouse, or other device to select an item, button, icon, or similar act/action while accessing or making any transactions regarding any agreement, acknowledgment, consent, terms, disclosures, or conditions constitutes Client’s electronic signature, acceptance, and agreement and that such electronic signature will meet the requirements of an original signature as if actually signed by Client in writing. Further, Client agrees that no certification authority or other third-party verification is necessary for the enforceability of his or her signature or any resulting contract between Client and Investment Advisor. At the request of Investment Advisor, any electronically signed document must be promptly re-executed in original form by Client who executed the electronically signed document. No party hereto may raise the use of an electronic signature as a defense to the enforcement of this Agreement or any amendment or other document executed in compliance with this section. 18. Grievance Redressal Timelines: Investor Advisor shall resolve the grievances of the Client within the timeline specified under SEBI guidelines and / or circulars issued from time to time as per grievance redressal mechanism updated on the website. 19. Governing Law 19.1 This Agreement shall be governed by and construed in accordance with Indian law. 19.2 In all judicial actions, arbitrations or dispute resolution methods, the parties waive any right to punitive or consequential damages. 20. Arbitration 20.1 All parties to this Agreement agree to giving up the right to settle the dispute in court, insofar as such waiver can validly be made. 20.2 Client agrees that any dispute, controversy or claim or grievance between Investment Advisor, any Investment Advisor affiliate or any of their shareholders, officers, directors, associates or agents, on one hand, and the Client or, if applicable, the Client’s shareholders, officers, directors, associates, or agents on the other hand, arising out of, or relating to, this Agreement or any account(s) established hereunder in which investment advice may be made; any transactions therein; any transaction between Investment Advisor and the Client; any provision of this Agreement or any other agreement between Investment Advisor and the Client; or any breach, termination or invalidity of such transactions or agreements shall be settled by the Arbitration and Conciliation Act 1996 (the “Act”). The award of the arbitrator shall be final and judgment upon the awards rendered may be entered in the High Court of Mumbai, Maharashtra. 20.3 The number of arbitrator shall be one 20.4 The juridical seat of arbitration shall be Mumbai, India. 20.5 The language to be used in the arbitral proceedings shall be English. By signing this Agreement, the Client acknowledges that he has received, read and understood the terms herein. 21. Severability : If any provision of this Agreement shall be held or made invalid by a court decision, statute, rule or otherwise, the remainder of this Agreement shall not be affected thereby. 22. Force Majeure: The Investment Advisor shall not be liable for any failure to perform any of its obligations under this Agreement for any loss, damage or additional expense arising out of and in relation or as a result of any event which could not have been reasonably foreseen, or the consequences of which could not have been reasonably avoided by, even with the exercise of all due care, including an act of God, fire, casualty, flood, failure of public utilities, injunction or any act, exercise, labour or civic unrest, assertion or requirement of any governmental authority, epidemic, pandemic, any government order or change in regulation/ law which renders a Party incapable of performing the obligations under this Agreement, strikes, commotion, unrest, war or threat of war, terrorist activity, industrial disputes, natural or man-made disaster, adverse weather conditions and all similar events outside the Investment Advisor’s control (“Force Majeure Events”). In the event of equipment breakdowns, on account of Force Majeure event, the Investment Advisor shall, however, take reasonable steps to minimize service interruptions but shall have no liability with respect thereto. 23. Waiver: No failure on the part of any party to exercise, and no delay on its part in exercising any right or remedy under this Agreement will operate as a waiver thereof, nor will any single or partial exercise of any right. 24. Entire Agreement: This Agreement together with all the schedules, annexures, and addendum constitutes the entire agreement between the Parties and supersedes all previous agreements, promises, proposals, representations, understandings and negotiations, whether written or oral between the Parties pertaining to the  subject matter hereof. SCHEDULE 1 RELATED DOCUMENTS The Client acknowledges that he has created a log in and password at the Investment Advisor's Website and / mobile application and accepts the Terms of Use and Privacy Policy at the Website and / mobile application. The Client also acknowledges that he has read, reviewed and electronically signed the following documents (as applicable) relating to the Agreement: 1. The Terms and Conditions (Accepted at login) 2. Privacy Policy (Accepted at login) 3. Disclaimer 4. Disclosures 5. Grievance Redressal Mechanism A copy of the each of the above is available at all times through the Website. SCHEDULE 2 INVESTMENT ADVISORY SERVICES, FEES & RISK FACTORS The Investment Advisor shall provide some or all the following services solely online: 1. evaluate, recommend and advise on suitable investment and divestment opportunities and proposals to and for the Client and to supervise the implementation of the Client’s investment program; 2. analyse the performance of investments and advise the Client in relation to investment trends, market improvements, political and economic conditions and all other matters likely or which might reasonably be considered to affect the investment objectives of the Client and consult with such other investment advisors and advisors as may be appointed by the Client from time to time; 3. prepare reports in relation to the investment objectives of the Client; 4. provide such investment research and advice as the Client may reasonably require from time to time; 5. keep the Client informed on matters relating to the advise, including issuing reports outlining the performance of the Investments and other matters as may be agreed; 6. do all other things and to provide such other services as may be reasonably requested by the Client in relation to the business of the Client; 7. keep such accounts and such books and records as may be required by law or otherwise for the proper conduct of the affairs of Investment Advisor under this Agreement. Risk Factor: Risk Factors 1. The Client’s investments can experience volatility or lack of liquidity or credit risk. The fluctuations are dependent upon various factors such as: macro-economics, geopolitical, sentiments, fundamentals, micro-economics, the performance of underlying companies and assets. These are not the only factors and there could be many other factors that can lead to such volatility, reduction, loss or increase in capital. 2. All investments are subject to market risks. As an investor, the Client has satisfied himself/herself by reading the investment brochures. 3. Any change in law and regulatory affairs may impact the Client’s investments. The Client understands the legal obligations and tax affairs including making any applicable filings and payments and complying with any applicable laws and regulations. 4. Past performance is not indicative of future returns. Please consider your specific investment requirements, risk tolerance, goal, time frame, risk and reward balance and the cost associated with the investment before choosing a fund, or designing a portfolio that suits your needs. Performance and returns of any investment portfolio can neither be predicted nor guaranteed. Fees and mode of payments: 1. The Client hereby agrees and undertakes that the advisory Fees shall be paid to SuperMoney in accordance with the terms herein for the purposes of availing of the advisory services by availing any of the Program(s) offered by SuperMoney, as detailed and specified on our platform. 2. The Client agrees that the advisory fees may be required to paid in advance for at least one [month/quarter/half-year]. In this respect, the Client agrees such that advisory fees shall be paid to SuperMoney to in advance in the manner as provided herein above. 3. In case of termination of this agreement by the Client for convenience, the Investment Advisor shall refund the advisory fees for the unexpired period of the term if the Client directly paid the advisory fees to SuperMoney. In the event of pre-mature termination on account of termination of SuperMoney's arrangement with the third party employer of the Client, the refund shall be governed in accordance with applicable laws and the terms and conditions of the agreement between SuperMoney and such third party employer and SuperMoney will not be entitled to refund any amount directly to the Client in such a scenario and the Client hereby expressly releases and waives any right to claim any amount (whether as refund, cost, expense or damage) from SuperMoney in this regard. In case of termination of this Agreement by the Investment Advisor for cause, the Investment Advisor shall have a right to retain and forfeit the advisory fees for the remaining period of the term provided such forfeited advisory fees shall not exceed the fees to be charged for one quarter. 4. All payments shall be made by account payee crossed cheques / demand draft or by way of direct credit into the Investment Advisor’s bank account through NEFT/ RTGS/UPI/ or any other mode specified/allowed by the authority from time to time. 5. It is clarified that SuperMoney does not accept cash deposits. All payments should be through legitimate sources and should be in compliance with the policies and guidelines laid down by RBI, NPCI, SEBI, or any other regulatory body. Further, advisory fees shall be made through Bank account of the Client and in case of a joint Bank Account the Client shall be one of the holders of such Bank Account. APPENDIX In this Agreement, unless the context or meaning thereof otherwise requires: The headings used in this Agreement are for convenience only and shall not affect the construction and interpretation of any clause of this Agreement; Few key definitions: i. “Assets Under Advice” shall mean the aggregate net asset value of securities and investment products for which the investment advisor has rendered investment advice irrespective of whether the implementation services are provided by investment advisor or concluded by the Client directly or through other service providers ii. ‘Securities’ for the purpose of this Agreement shall mean ‘Securities’ as defined in Section 2(h) of Securities Contracts (Regulation) Act, 1956. iii. ‘Investment’ shall include disinvestment. iv. “Financial planning” shall include analysis of Clients current financial situation, identification of their financial goals and developing and recommending financial strategies to realise such goals. v. “investment advice” means advice relating to investing in, purchasing, selling or otherwise dealing in securities or investment products, and advice on investment portfolio containing securities or investment products, whether written, oral or through any other means of communication for the benefit of the Client and shall include financial planning. vi. “Investment advisor” means any person, who for consideration, is engaged in the business of providing investment advice to Clients or other persons or group of persons and includes any person who holds out himself as an investment advisor, by whatever name called.''',
                  style: blackStyle(context)
                      .copyWith(fontSize: 14.sm, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        Row(
          children: [
            Transform.scale(
              scale: 0.9,
              child: Theme(
                data: ThemeData(
                  unselectedWidgetColor: const Color(0xFFF78104),
                ),
                child: Checkbox(
                    focusColor: const Color(0xFFF78104),
                    activeColor: const Color(0xFFF78104),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    value: agree,
                    onChanged: (bool? agree) {
                      setState(() {
                        this.agree = agree!;
                      });
                    }),
              ),
            ),
            Flexible(
              child: Text(
                maxLines: 2,
                softWrap: true,
                'I Agree To The Above Advisory Agreement',
                style: blackStyle(context).copyWith(
                    fontSize: 12,
                    color: Get.isDarkMode ? Colors.white : Colors.black),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 40,
        ),
        Center(
            child: SizedBox(
          width: double.infinity,
          height: 60,
          child: CustomNextButton(
            text: "Continue",
            ontap: () {
              // try {
              //   setOptions();
              //   _razorpay.open(options);
              // } catch (e) {
              //   print("razor error " + e.toString());
              // }
              agree
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const SubscriptionLoadingPage()))
                  : Flushbar(
                      message: "Please Accept Advisory Agreement",
                      duration: const Duration(seconds: 3),
                    ).show(context);
            },
          ),
        )),
        const SizedBox(height: 16),
      ],
    );
  }
}

class TableCard extends StatelessWidget {
  const TableCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 650,
      child: Card(
        elevation: 2,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF6B6B6B))),
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              child: Table(
                children: [
                  TableRow(children: [
                    Column(children: const [
                      Text('Features', style: TextStyle(fontSize: 16))
                    ]),
                    Column(children: const [
                      Text('Comprehensive Financial Planning',
                          style: TextStyle(fontSize: 16.0))
                    ]),
                    Column(children: const [
                      Text('Investment Advisory',
                          style: TextStyle(fontSize: 16.0))
                    ]),
                    Column(children: const [
                      Text('Tax Planning ', style: TextStyle(fontSize: 16.0))
                    ]),
                  ]),
                  TableRow(children: [
                    Column(children: const [Text('Javatpoint')]),
                    Column(children: const [Text('Flutter')]),
                    Column(children: const [Text('5*')]),
                    Column(children: const [Text('5*')]),
                  ]),
                ],
                border: TableBorder.all(width: 2),
              ),
            )),
      ),
    );
  }
}

class LoadingScreenPayment extends StatefulWidget {
  const LoadingScreenPayment({super.key});

  @override
  State<LoadingScreenPayment> createState() => _LoadingScreenPaymentState();
}

class _LoadingScreenPaymentState extends State<LoadingScreenPayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: RazorpayMethods().createOrder(),
        builder: (ctx, snapshot) {
          if (snapshot.data == null) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: CircularProgressIndicator()),
              ],
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Future.microtask(
                () => Get.offAllNamed('/subscription_loading_page'));
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occured',
                  style: TextStyle(fontSize: 18),
                ),
              );
            }
          }
          return Container();
        },
      ),
    );
  }
}
