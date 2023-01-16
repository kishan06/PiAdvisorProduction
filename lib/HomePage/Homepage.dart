import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lottie/lottie.dart';
import 'package:piadvisory/Common/CustomNextButton.dart';
import 'package:piadvisory/Common/VideoYoutube.dart';
import 'package:piadvisory/HomePage/Blog%20Repository/blogrepo.dart';
import 'package:piadvisory/HomePage/CaseStudy.dart';
import 'package:piadvisory/HomePage/HomepageRepository/Homepagerepository.dart';
import 'package:piadvisory/HomePage/Stock/stock.dart';
import 'package:piadvisory/HomePage/blog.dart';
import 'package:piadvisory/HomePage/tax-planning.dart';
import 'package:piadvisory/Portfolio/PortfolioMainUI.dart';
import 'package:piadvisory/Profile/GoalsRepository/storeGoals.dart';
import 'package:piadvisory/Profile/KYC/Repository/KYCDigilocker.dart';
import 'package:piadvisory/Profile/KYC/SchduleAppointment.dart';
import 'package:piadvisory/Profile/ProfileMain.dart';
import 'package:piadvisory/SideMenu/Subscribe/Repository/getSubscriptionWithDetails.dart';
import 'package:piadvisory/SideMenu/Subscribe/SubscriptionPlanModel.dart';
import 'package:piadvisory/SideMenu/about.dart';
import 'package:piadvisory/Utils/Constants.dart';
import 'package:piadvisory/smallcase_api_methods.dart';
import 'package:scgateway_flutter_plugin/scgateway_flutter_plugin.dart';
import 'package:async/src/future_group.dart';
// import 'package:piadvisory/HomePage/Blog.dart';

import 'package:piadvisory/HomePage/Stock/stock.dart';
// import 'package:piadvisory/HomePage/tax-planning.dart';
// import 'package:piadvisory/Portfolio/PortfolioMainUI.dart';
// import 'package:piadvisory/Profile/KYC/SchduleAppointment.dart';

import 'package:piadvisory/SideMenu/NavDrawer.dart';
import 'package:piadvisory/SideMenu/Subscribe/Mysubscription.dart';
// import 'package:piadvisory/HomePage/SettingsPage.dart';
// import 'package:piadvisory/SideMenu/about.dart';
// import 'package:piadvisory/HomePage/CaseStudy.dart';
// import 'package:piadvisory/SideMenu/FAQ/SubscriptionAndBillingFAQ.dart';
import 'package:piadvisory/Utils/textStyles.dart';
import 'package:piadvisory/Utils/custom_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:shared_preferences/shared_preferences.dart';

// import '../SideMenu/Subscribe/Mysubscription.dart';

// import 'MutualFundsDetailed.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
    this.showVideo = true,
  }) : super(key: key);

  final bool? showVideo;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  late final Future myFuture;
  DateTime timebackPressed = DateTime.now();

  FutureGroup futureGroup = FutureGroup();

  @override
  void initState() {
    super.initState();
    futureGroup.add(getBlogs().getBlogsandNews());
    futureGroup.add(GetHomepagePopup().getHomepagePopup());
    futureGroup.add(Storegoalsdetails().getGoals());
    futureGroup.add(getSubscriptionWithDetails().getsubsDetail());
    futureGroup.close();
    //getVideoStatus();
    //_fetchfutures();
    //myFuture = getBlogs().getBlogsandNews();
    super.initState();
  }

  // void _fetchfutures() async {
  //   await Future.wait([
  //     GetHomepagePopup().getHomepagePopup(),
  //     Storegoalsdetails().getGoals(),
  //     getSubscriptionWithDetails().getsubsDetail(),
  //   ]);
  //   setState(() {});
  // }

  bool showBanner = false;
  bool showBannerLoader = true;

  void replaceBannerWithLoader() {
    setState(() {
      showBanner = false;
      showBannerLoader = true;
    });
  }

  void replaceLoaderWithBanner() {
    setState(() {
      showBanner = true;
      showBannerLoader = false;
    });
  }

  // getVideoStatus() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool isonce = prefs.getBool('video') ?? false;
  //   return Timer(Duration(seconds: 1), () {
  //     isonce
  //         ? null
  //         : widget.showVideo ?? false
  //             ? Future.delayed(const Duration(milliseconds: 500), () {
  //                 buildVideoDialog();
  //                 _saveOptions();
  //               })
  //             : _saveOptions();
  //   });
  // }

  _saveOptions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('video', true);
    setState(() {});
  }

  // ignore: unused_element
  void _selectedTab(int index) {
    setState(() {
      // _lastSelected = 'TAB: $index';
      // print(_lastSelected);

      switch (index) {
        case 0:
          {
            // Navigator.push(
            //     context, MaterialPageRoute(builder: ((context) => HomePage())));
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

  // buildVideoDialog() {
  //   return showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       insetPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
  //       contentPadding: EdgeInsets.zero,
  //       titlePadding: EdgeInsets.zero,
  //       shape: const RoundedRectangleBorder(
  //           borderRadius: BorderRadius.all(Radius.circular(2))),
  //       title: Column(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: [
  //           Container(
  //             decoration: BoxDecoration(
  //               border: Border(
  //                   top: BorderSide(color: Color(0xFFF78104), width: 3.w)),
  //             ),
  //           ),
  //           // Divider(
  //           //   thickness: 1,
  //           //   color: Colors.amber,
  //           // ),
  //           Row(
  //             //  crossAxisAlignment: CrossAxisAlignment.start,
  //             //  mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               SizedBox(
  //                 width: 80.w,
  //               ),
  //               Text(
  //                 "How Our piadvisory Works?",
  //                 style: blackStyle(context).copyWith(
  //                   fontWeight: FontWeight.bold,
  //                   color: Get.isDarkMode ? Colors.white : Colors.black,
  //                 ),
  //               ),
  //               Spacer(
  //                 flex: 1,
  //               ),
  //               IconButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                   SystemChrome.setPreferredOrientations(
  //                       [DeviceOrientation.portraitUp]);
  //                 },
  //                 icon: Icon(Icons.close),
  //               )
  //             ],
  //           ),
  //         ],
  //       ),
  //       content: VideoYoutube(),
  //     ),
  //   );
  // }

  buildSubscriptionPlan() {
    return showDialog(
      context: context,
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 45.h,
            width: 45.w,
            child: FittedBox(
              child: FloatingActionButton(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    size: 30,
                  )),
            ),
          ),
          AlertDialog(
            backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
            insetPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
            contentPadding: EdgeInsets.fromLTRB(24, 30, 24, 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              side: BorderSide(
                  color: Get.isDarkMode ? Colors.grey : Colors.white),
            ),
            // contentPadding:
            //     EdgeInsets.all(
            //         10),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40.h),
                Center(
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(children: [
                          TextSpan(
                              text:
                                  "Get started by booking 1st Consultation with your\n PI @ ₹ 199/-"),
                          TextSpan(
                              text: "FREE",
                              style: TextStyle(color: Colors.red)),
                        ]),
                        style: TextStyle(
                            fontSize: 20.sm,
                            fontWeight: FontWeight.bold,
                            color:
                                Get.isDarkMode ? Colors.white : Colors.black),
                      ),
                      // Text(
                      //   textAlign: TextAlign.center,
                      //   "Start Investing Like A \nPro @ Just ₹999",
                      //   style: blackStyle(context).copyWith(
                      //       //fontWeight: FontWeight.bold,
                      //       fontSize: 20),
                      // ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                SizedBox(
                  width: double.infinity,
                  child: CustomNextButton(
                    text: "Continue",
                    ontap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Mysubscription()));
                    },
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  child: Text(
                    "Will do it later",
                    style: blackStyle(context).copyWith(
                      fontSize: 15.sm,
                      //fontWeight: FontWeight.bold,
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                      decoration: TextDecoration.underline,
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

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  buildsmallcase() {
    ScgatewayFlutterPlugin.setConfigEnvironment(GatewayEnvironment.PRODUCTION,
        "moneycontrol", true, ["moneycontrol"]).then((value) {
      String authToken =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJndWVzdCI6dHJ1ZSwiaWF0IjoxNjU0MzIxMDAwfQ.qiZ_w1yFYXhkdLMlqI28XJOXitfZwr64e2oL-lMEHZU";
      ScgatewayFlutterPlugin.initGateway(authToken).then((value) {
        print("Init gateway complete: $value");
      });
    });

    // ScgatewayFlutterPlugin.setConfigEnvironment(
    //   GatewayEnvironment
    //       .PRODUCTION, // should always be `GatewayEnvironment.PRODUCTION`
    //   "gatewaydemo",
    //   false,
    //   [],
    // );
    // ScgatewayFlutterPlugin.leadGen(
    //     "kishan", "kishan.bhuta1998@gmail.com", "9158874404", "401602");
    // ScgatewayFlutterPlugin.initGateway("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9");
    // ;
    // // ScgatewayFlutterPlugin.triggerGatewayTransaction(
    // //     "TRX_5509340ce4ac475d861df322698f1753");
    // //ScgatewayFlutterPlugin.logoutUser();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      //onWillPop: () => Future.value(false),
      onWillPop: () async {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        final difference = DateTime.now().difference(timebackPressed);
        final isExitWarning = difference >= Duration(seconds: 2);

        timebackPressed = DateTime.now();

        if (isExitWarning) {
          final message = "Press back again to exit";
          print("reached here");
          Fluttertoast.showToast(
            msg: message,
            fontSize: 18,
          );

          return false;
        } else {
          Fluttertoast.cancel();

          SystemNavigator.pop();
          return true;
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
            FutureBuilder(
                future: getSubscriptionWithDetails().getsubsDetail(),
                builder: (ctx, snapshot) {
                  if (snapshot.data == null) {
                    // return Column(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     Center(
                    //       child: Lottie.asset(
                    //         "assets/images/lf30_editor_jc6n8oqe.json",
                    //         repeat: true,
                    //         height: 150.h,
                    //         width: 150.w,
                    //       ),
                    //     ),
                    //   ],
                    // );
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          '${snapshot.error} occured',
                          style: TextStyle(fontSize: 18.sm),
                        ),
                      );
                    }
                  }
                  return Positioned(
                    bottom: 80,
                    left: 20,
                    child: Visibility(
                        visible: !userHasSubscription,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          //height: 52.h,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          Mysubscription())));
                            },
                            child: Image.asset(
                              "assets/images/BannerNew.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        )),
                  );
                }),
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
                // color:
                //     Get.isDarkMode ? Color(0xFFF78104) : Color(0xFFF78104)
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
                // color:
                //     Get.isDarkMode ? Color(0xFFF78104) : Color(0xFFF78104)
              ),
              label: 'Subscribe',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CustomIcons.date_range,
                //  color:
                //       Get.isDarkMode ? Color(0xFFF78104) : Color(0xFFF78104)
              ),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CustomIcons.bottombarbagicon,
                //  color:
                //       Get.isDarkMode ? Color(0xFFF78104) : Color(0xFFF78104),
                size: 22.5,
              ),
              label: 'Dashboard',
            ),
          ],
          currentIndex: _selectedIndex,
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
          backgroundColor: Colors.white, elevation: 2,
          shadowColor: Colors.black,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          // centerTitle: true,
          title: SizedBox(
            // width: 110,
            child: SvgPicture.asset(
              'assets/images/logo4final.svg',
              height: 30.h,
              alignment: Alignment.centerLeft,
            ),
          ),
          leading: Row(
            children: [
              IconButton(
                onPressed: () {
                  _key.currentState!.openDrawer();
                },
                icon: Icon(
                  Icons.menu,
                  color: Get.isDarkMode ? Colors.black : Colors.black,
                ),
                iconSize: 25,
              ),
            ],
          ),
          actions: [
            // IconButton(
            //   onPressed: () {
            //     // buildsmallcase();
            //   },
            //   icon: SvgPicture.asset(
            //     'assets/images/search-icon.svg',
            //   ),
            //   iconSize: 22,
            //   color: const Color(0xFF6B6B6B),
            // ),
            // IconButton(
            //   onPressed: () {
            //     Get.toNamed('/notification');
            //   },
            //   icon: SvgPicture.asset(
            //     'assets/images/notification-icon.svg',
            //   ),
            //   iconSize: 22,
            //   color: const Color(0xFF6B6B6B),
            // ),
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileMain()));
              },
              icon: SvgPicture.asset(
                'assets/images/Profile1.svg',
              ),
              iconSize: 22,
              color: const Color(0xFF303030),
            ),
          ],
        ),
        body: FutureBuilder(
          future: futureGroup.future,
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
                      height: 150.h,
                      width: 150.w,
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
                    style: TextStyle(fontSize: 18.sm),
                  ),
                );
              }
            }
            return _buildBody(
              context,
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody(context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Investment Advisory",
                style: blackStyle(context).copyWith(
                    fontWeight: FontWeight.bold,
                    color: Get.isDarkMode ? Colors.white : Colors.black),
              ),
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Stocks(
                                selectedPage: 0,
                              )));
                },
                child: const CustomListTileHomePage(
                  leadingimage: "assets/images/stocksicon.svg",
                  title: "Stocks",
                  subtitle:
                      "Invest in a portfolio of stocks curated personally for you by our experts",
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Divider(
                indent: MediaQuery.of(context).size.width * 0.24.w,
                thickness: 2,
              ),
              SizedBox(
                height: 10.h,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Stocks(
                                selectedPage: 1,
                              )));
                },
                child: const CustomListTileHomePage(
                  leadingimage: "assets/images/moneyicon.svg",
                  title: "Mutual Funds",
                  subtitle:
                      "Fund your dream home, car, child’s education through mutual fund investments under our expert guidance",
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Financial Advisory",
                style: blackStyle(context).copyWith(
                    fontWeight: FontWeight.bold,
                    color: Get.isDarkMode ? Colors.white : Colors.black),
              ),
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Taxplanning()));
                },
                child: const CustomListTileHomePage(
                  leadingimage: "assets/images/taxicon.svg",
                  title: "Tax Planning",
                  subtitle:
                      "SAVE taxes, EARN on investments and get ITR filing",
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Mysubscription()));
                },
                child: Text(
                  "Comprehensive Financial Planning",
                  style: blackStyle(context).copyWith(
                      fontWeight: FontWeight.bold,
                      color: Get.isDarkMode ? Colors.white : Colors.black),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Mysubscription()));
                },
                child: const CustomListTileHomePage(
                  leadingimage: "assets/images/studyicon.svg",
                  title: "",
                  subtitle:
                      "From investments to insurance, tax to retirement savings, loans to real estate investments – get a comprehensive financial plan to build long term wealth",
                  givepadding: true,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                onTap: (() {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const about()));
                }),
                child: CustomCardHomePage(
                  isimage: false,
                  title: "Simplifying Investment for you",
                  trailingimage: "assets/images/Cardicon1.svg",
                  subtitle: "What is PI advisors?",
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Mysubscription()));
                },
                child: CustomCardHomePage(
                  isimage: false,
                  title: "Get Great Returns with our Expert Advice",
                  trailingimage: "assets/images/cardicon2.svg",
                  subtitle: "Schedule a Free Demo Call Today!",
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SchduleAppointment()));
                },
                child: CustomCardHomePage(
                  isimage: false,
                  title: "Our Unbeatable Performance Speaks for Itself",
                  trailingimage: "assets/images/cardicon3.svg",
                  subtitle: "Book a Meeting with our Performing Expert!",
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              // Row(
              //   // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     Expanded(
              //       child: Container(
              //         margin: const EdgeInsets.only(left: 10.0, right: 10.0),
              //         child: Divider(
              //           indent: MediaQuery.of(context).size.width * 0.16.w,
              //           color: Color(0xFFF78104),
              //           thickness: 2,
              //         ),
              //       ),
              //     ),
              //     Text(
              //       "These brands trust us!",
              //       style: blackStyle(context).copyWith(
              //           fontSize: 14.sm,
              //           color: Get.isDarkMode ? Colors.white : Colors.black),
              //     ),
              //     Expanded(
              //       child: Container(
              //         margin: const EdgeInsets.only(left: 10.0, right: 10.0),
              //         child: Divider(
              //           endIndent: MediaQuery.of(context).size.width * 0.16.w,
              //           color: Color(0xFFF78104),
              //           thickness: 2,
              //           height: 10.h,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: 20.h,
              // ),
              // const ScrollableBrandsList(),
              // SizedBox(
              //   height: 20.h,
              // ),
              // SizedBox(
              //   height: 95.h,
              //   child: GestureDetector(
              //     onTap: () {
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => Mysubscription()));
              //     },
              //     child: CustomCardHomePage(
              //       isimage: false,
              //       title: "Over 1000+ Clients Trust Us!",
              //       trailingimage: "assets/images/Group6041.svg",
              //       subtitle: "Become a Part of Our Family!",
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 30.h,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     Expanded(
              //       child: Container(
              //         margin: const EdgeInsets.only(left: 10.0, right: 10.0),
              //         child: Divider(
              //           indent: MediaQuery.of(context).size.width * 0.16.w,
              //           color: Color(0xFFF78104),
              //           thickness: 2,
              //         ),
              //       ),
              //     ),
              //     Text(
              //       "PI advisors is featured in",
              //       style: blackStyle(context).copyWith(
              //           fontSize: 14.sm,
              //           color: Get.isDarkMode ? Colors.white : Colors.black),
              //     ),
              //     Expanded(
              //       child: Container(
              //         margin: const EdgeInsets.only(left: 10.0, right: 10.0),
              //         child: Divider(
              //           endIndent: MediaQuery.of(context).size.width * 0.16.w,
              //           color: Color(0xFFF78104),
              //           thickness: 2,
              //           height: 10.h,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: 20.h,
              // ),
              // const ScrollableBrandsList(),
              // SizedBox(
              //   height: 30.h,
              // ),
              // SizedBox(
              //   child: GestureDetector(
              //     onTap: (() {
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => const CaseStudy()));
              //     }),
              //     child: CustomCardHomePage(
              //       title: "Our Success Stories",
              //       trailingimage: "assets/images/maskgroup12.png",
              //       subtitle: "Know more!",
              //       isimage: true,
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Gain Some Market Insights",
                    style: blackStyle(context).copyWith(
                        fontSize: 14.sm,
                        color: Get.isDarkMode ? Colors.white : Colors.black),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Blog()));
                    },
                    child: Text(
                      "See All",
                      style: blackStyle(context).copyWith(
                          fontSize: 14.sm,
                          color: Get.isDarkMode ? Colors.white : Colors.black),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Blog()));
                },
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          for (var i = 0; i < 3; i++)
                            SizedBox(
                              child: BottomCards(
                                image: ApiConstant.piImages +
                                    blogs.blogAll![i].blogImage!,
                                title: blogs.blogAll![i].title!,
                                subtitle: blogs.blogAll![i].publishDate!,
                              ),
                            ),
                          // SizedBox(
                          //   width: 5,
                          // ),
                          // BottomCards(
                          //   image: 'assets/images/Stock-Market@3x.png',
                          //   title:
                          //       "Cap on short-term power price tohunt generation as coal",
                          //   subtitle: "May 31 2020, 16:58",
                          // ),
                          // BottomCards(
                          //   image: 'assets/images/Stock-Market@3x.png',
                          //   title:
                          //       "Cap on short-term power price tohunt generation as coal",
                          //   subtitle: "May 31 2020, 16:58",
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              !userHasSubscription
                  ? SizedBox(height: 180.h //250.h,
                      )
                  : SizedBox(
                      height: 37.h,
                    )
              // SizedBox(
              //   height: 50.h,
              // ),
            ],
          ),
        ),
      ],
    ));
  }
}

class BottomCards extends StatelessWidget {
  const BottomCards({
    Key? key,
    required this.image,
    required this.title,
    required this.subtitle,
  }) : super(key: key);
  final String image;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Blog()));
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        child: Card(
          elevation: 2,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Image.network(
                  image,
                  width: 152.w,
                  height: 123.h,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: SizedBox(
                  width: 140.w,
                  height: 75.h,
                  child: Text(
                    title,
                    style: blackStyle(context).copyWith(
                        color: Get.isDarkMode ? Colors.white : Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Text(
                  subtitle,
                  style: blackStyle(context).copyWith(
                      fontSize: 10.sm,
                      color: Get.isDarkMode ? Colors.white : Colors.black),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ScrollableBrandsList extends StatelessWidget {
  const ScrollableBrandsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: IntrinsicHeight(
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/images/zerodha.svg',
            ),
            SizedBox(
              width: 5.w,
            ),
            const VerticalDivider(
              thickness: 2,
            ),
            Image.asset('assets/images/angle.png'),
            SizedBox(
              width: 5.w,
            ),
            const VerticalDivider(
              thickness: 2,
            ),
            SvgPicture.asset(
              'assets/images/zerodha.svg',
            ),
            SizedBox(
              width: 5.w,
            ),
            const VerticalDivider(
              thickness: 2,
            ),
            Image.asset('assets/images/angle.png'),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomCardHomePage extends StatelessWidget {
  CustomCardHomePage({
    Key? key,
    this.trailingimage,
    this.title,
    this.subtitle,
    required this.isimage,
  }) : super(key: key);

  final String? trailingimage;
  final String? title;
  final String? subtitle;
  bool isimage;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white)),
      elevation: 2,
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            title!,
            style: blackStyle(context).copyWith(
                fontWeight: FontWeight.w600,
                color: Get.isDarkMode ? Colors.white : Colors.black),
          ),
        ),
        subtitle: Text(subtitle!,
            style: blackStyle(context).copyWith(
              fontSize: 12.sm,
              color: const Color(0xFFF78104),
              decoration: TextDecoration.underline,
            )),
        trailing: SizedBox(
            width: 75,
            height: 75,
            child: isimage
                ? Image.asset(trailingimage!)
                : SvgPicture.asset(trailingimage!)),
      ),
    );
  }
}

class CustomListTileHomePage extends StatelessWidget {
  const CustomListTileHomePage({
    Key? key,
    required this.leadingimage,
    this.title,
    this.subtitle,
    this.givepadding = false,
  }) : super(key: key);

  final String? leadingimage;
  final String? title;
  final String? subtitle;
  final bool? givepadding;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 37,
      leading: Padding(
        padding: const EdgeInsets.only(top: 13),
        child: SizedBox(
            width: 47.w, height: 42.h, child: SvgPicture.asset(leadingimage!)),
      ),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          title ?? "",
          style: blackStyle(context).copyWith(
              fontWeight: FontWeight.w600,
              color: Get.isDarkMode ? Colors.white : Colors.black),
        ),
      ),
      subtitle: givepadding!
          ? Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(subtitle ?? ""),
            )
          : Text(subtitle ?? ""),
    );
  }
}
