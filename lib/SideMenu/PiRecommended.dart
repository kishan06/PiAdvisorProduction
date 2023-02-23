//Profile Uodate implementation static

// ignore_for_file: file_names, avoid_print, must_be_immutable

import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:piadvisory/Common/CreateBottomBar.dart';
import 'package:piadvisory/Common/CustomAppbarWithIcons.dart';
import 'package:piadvisory/Common/CustomNextButton.dart';
import 'package:piadvisory/Common/Customfloatingbutton.dart';
import 'package:piadvisory/Common/GlobalFuntionsVariables.dart';
import 'package:piadvisory/Common/NetworkSensitive.dart';
import 'package:piadvisory/HomePage/Stock/stock.dart';
import 'package:piadvisory/Portfolio/PortfolioMainUI.dart';
import 'package:piadvisory/Profile/BankDetails.dart';
import 'package:piadvisory/Profile/BankdetailsRepository/storeBankdetails.dart';
import 'package:piadvisory/Profile/CustomRiskAssessment.dart';
import 'package:piadvisory/Profile/KYC/KYCMain.dart';
import 'package:piadvisory/Profile/KYC/Repository/storebasicaddincome.dart';
import 'package:piadvisory/Profile/KYC/Repository/storebasicfamilydetails.dart';
import 'package:piadvisory/Profile/KYC/SchduleAppointment.dart';
import 'package:piadvisory/Profile/PasswordAndSecurity/PasswordAndSecurity.dart';
import 'package:piadvisory/Profile/PersonalProfile.dart';
import 'package:piadvisory/Profile/Personalprofilerepository/storePersonalprofile.dart';
import 'package:piadvisory/Profile/ProfileRepository/ProfileMethods.dart';
import 'package:piadvisory/Profile/RiskAssestmentRepository/RiskAssestment.dart';
import 'package:piadvisory/Profile/UpdateRiskProfile.dart';
import 'package:piadvisory/Profile/goal.dart';
import 'package:piadvisory/SideMenu/CartPi.dart';
import 'package:piadvisory/SideMenu/CartPi2.dart';
import 'package:piadvisory/SideMenu/NavDrawer.dart';
import 'package:piadvisory/SideMenu/PiRecommendedRepository/PiRecommendedMethod.dart';
import 'package:piadvisory/SideMenu/Subscribe/AppWidget.dart';
import 'package:piadvisory/SideMenu/Subscribe/Mysubscription.dart';
import 'package:piadvisory/Utils/custom_icons_icons.dart';
import 'package:piadvisory/Utils/textStyles.dart';
import 'package:piadvisory/smallcase_api_methods.dart';
import 'package:scgateway_flutter_plugin/scgateway_flutter_plugin.dart';

import '../Common/app_bar.dart';
import '../HomePage/Homepage.dart';

class PiRecommended extends StatefulWidget {
  const PiRecommended({Key? key}) : super(key: key);

  @override
  State<PiRecommended> createState() => _PiRecommendedState();
}

class _PiRecommendedState extends State<PiRecommended> {
  bool Company = false;
  bool Shree = false;
  bool Indusland = false;
  bool Mutual = false;
  bool Icici = false;
  bool Axis = false;
  bool Mutualone = false;
  bool Icicione = false;
  bool Axisone = false;
  String _lastSelected = 'TAB: 0';
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  Color themeColor = const Color(0xFF43D19E);
  double screenWidth = 600;
  double screenHeight = 400;
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

  List<bool> _isChecked = [];
  late final Future? myFuture;

  List<Map<String, dynamic>> _scSecurities = [];

  late StreamSubscription apiEventListner;

  @override
  void initState() {
    _isChecked = List<bool>.filled(5, false);
    myFuture = getAdvices().getPiRecomAdvice();
    super.initState();
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        key: _key,
        appBar: CustomAppBarWithIcons(
          isprofile: false,
          titleTxt: "Cart",
          globalkey: _key,
        ),
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
              //   child: SvgPicture.asset(
              //     "assets/images/product sans logo wh new.svg",
              //     color: Colors.white,
              //     fit: BoxFit.contain,
              //     width: 28,
              //     height: 24,
              //   ),
              // ),
            ),
          ],
        ),
        bottomNavigationBar:CreateBottomBar(stateBottomNav, "Bottombar", context),
        body: _buildBody(context));
  }

  Widget _buildBody(context) {
    return Scaffold(
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
            print("api resp of pi recom is ${piRecom!.data!.manageMfAdvisors}");
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occured',
                  style: TextStyle(fontSize: 18),
                ),
              );
            }
          }
          if (piRecom?.data == null ||
              piRecom!.data!.manageStockAdvisors!.isEmpty &&
                  piRecom!.data!.manageMfAdvisors!.isEmpty) {
            return _buildNodataBody();
          } else {
            return _buildBodyWithData(
              context,
            );
          }
        },
      ),
    );

    //Content for Pi recommended
  }

  Widget _buildBodyWithData(context) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              piRecom!.data!.manageStockAdvisors!.isEmpty
                  ? Container()
                  : SizedBox(
                      height: 16.h,
                    ),
              piRecom!.data!.manageStockAdvisors!.isEmpty
                  ? Container()
                  : Padding(
                      padding: EdgeInsets.only(left: 40, right: 20),
                      child: Text(
                        "Direct Stocks",
                        style: blackStyle(context).copyWith(
                            fontSize: 18.sm,
                            color: Get.isDarkMode ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
              SizedBox(
                height: 5.h,
              ),
              piRecom!.data!.manageStockAdvisors!.isEmpty
                  ? Container()
                  : Divider(
                      thickness: 1,
                      color: Get.isDarkMode ? Colors.grey : Colors.grey,
                    ),
              SizedBox(
                height: 5.h,
              ),
            ],
          ),
          Column(
            children: [
              if (piRecom!.data!.manageStockAdvisors!.isNotEmpty)
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Transform.scale(
                          scale: 1,
                          child: Theme(
                            data: ThemeData(
                              unselectedWidgetColor: Colors.grey,
                            ),
                            child: Checkbox(
                              activeColor: Colors.amber,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2))),
                              value: Company,
                              onChanged: (bool? value) {
                                setState(() {
                                  Company = value!;
                                  for (var i = 0; i < _isChecked.length; i++) {
                                    _isChecked[i] = value;
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                        Text("Company Name",
                            style: TextStyle(
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 12.sm,
                                fontWeight: FontWeight.w600)),
                        SizedBox(
                          width: 8.w,
                        ),
                        Row(
                          children: [
                            Text(
                              "Buy/Sell",
                              style: TextStyle(
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 12.sm,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Text(
                                "Recommended \nPrice(₹)",
                                style: TextStyle(
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 12.sm,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Text(
                                "No.of \nShares",
                                style: TextStyle(
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 12.sm,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        SizedBox(width: 8.w),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Text(
                                "Approx.\nAmount(₹)",
                                style: TextStyle(
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 12.sm,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Divider(
                      thickness: 2,
                      color: Get.isDarkMode ? Colors.grey : Colors.grey,
                    ),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        itemCount: piRecom?.data?.manageStockAdvisors!.length,
                        itemBuilder: (context, index) {
                          double approxAmt = double.parse(piRecom?.data
                                      ?.manageStockAdvisors![index].price ??
                                  "0") *
                              double.parse(piRecom?.data
                                      ?.manageStockAdvisors![index].quantity ??
                                  "0");
                          //scSecurities
                          String ticker = piRecom!.data!.manageStockAdvisors!
                              .elementAt(index)
                              .ticker!;
                          String qty = piRecom!.data!.manageStockAdvisors!
                              .elementAt(index)
                              .quantity!;
                          String type = piRecom!.data!.manageStockAdvisors!
                              .elementAt(index)
                              .buyOrSell!;
                          _scSecurities.add({
                            '"ticker"': '"$ticker"',
                            '"quantity"': qty,
                            '"type"': '"${type.toUpperCase()}"'
                          });
                          //--
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Transform.scale(
                                scale: 1,
                                child: Theme(
                                  data: ThemeData(
                                    unselectedWidgetColor: Colors.grey,
                                  ),
                                  child: Checkbox(
                                    activeColor: Colors.amber,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(2))),
                                    value: _isChecked[index],
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _isChecked[index] = value!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 80.w,
                                child: Text(
                                    piRecom?.data?.manageStockAdvisors![index]
                                            .stockName ??
                                        "",
                                    style: TextStyle(
                                        color: Get.isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 14.sm,
                                        fontWeight: FontWeight.w200)),
                              ),
                              SizedBox(
                                width: 12.w,
                              ),
                              Text(
                                piRecom?.data?.manageStockAdvisors![index]
                                        .buyOrSell ??
                                    "",
                                style: TextStyle(
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 14.sm,
                                    fontWeight: FontWeight.w200),
                              ),
                              SizedBox(
                                width: 30.w,
                              ),
                              SizedBox(
                                width: 42.w,
                                child: Text(
                                  piRecom?.data?.manageStockAdvisors![index]
                                          .price ??
                                      "",
                                  style: TextStyle(
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 14.sm,
                                      fontWeight: FontWeight.w200),
                                ),
                              ),
                              SizedBox(
                                width: 45.w,
                              ),
                              Row(
                                children: [
                                  Text(
                                    piRecom?.data?.manageStockAdvisors![index]
                                            .quantity ??
                                        "",
                                    style: TextStyle(
                                        color: Get.isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 14.sm,
                                        fontWeight: FontWeight.w200),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 25.w,
                              ),
                              Text(
                                approxAmt.toString(),
                                style: TextStyle(
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 14.sm,
                                    fontWeight: FontWeight.w200),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 40.h,
                          child: CustomNextButton(
                            text: "Invest Now",
                            ontap: () {
                              debugPrint("scSecurities: $_scSecurities");
                              fetchAuthToken().then((fetchedAuthToken) {
                                fetchBrokerConnectTxnId(
                                        authToken: fetchedAuthToken)
                                    .then(
                                  (txnId) => ScgatewayFlutterPlugin.initGateway(
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
                                            debugPrint("authToken: $authToken");
                                            debugPrint(
                                                "brokerName: $brokerName");
                                            debugPrint("txnId: $txnId");
                                            String body =
                                                '{"intent":"TRANSACTION","orderConfig":{"type":"SECURITIES","securities":$_scSecurities}}';
                                            // '{"intent":"TRANSACTION","orderConfig":{"type":"SECURITIES","securities":[{"ticker":"RELIANCE","quantity":10,"type":"BUY"},{"ticker":"RELIANCE","quantity":12,"type":"BUY"},{"ticker":"RELIANCE","quantity":10,"type":"BUY"}]}}';
                                            fetchStocksOrderTxnId(
                                                    authToken, body)
                                                .then((stocksOrderTxnId) =>
                                                    ScgatewayFlutterPlugin
                                                            .triggerGatewayTransaction(
                                                                stocksOrderTxnId)
                                                        .then((value) {
                                                      debugPrint(
                                                          "Stocks Order res $value");
                                                    }));
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                );
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        )
                      ],
                    ),
                  ],
                ),
              if (piRecom!.data!.manageMfAdvisors!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 16.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 40, right: 20),
                      child: Text(
                        "Mutual Fund (SIPs)",
                        style: blackStyle(context).copyWith(
                            fontSize: 18.sm,
                            color: Get.isDarkMode ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    // SizedBox(
                    //   height: 5.h,
                    // ),
                    // Divider(
                    //   thickness: 1,
                    //   color: Get.isDarkMode ? Colors.grey : Colors.grey,
                    // ),
                    // SizedBox(
                    //   height: 5.h,
                    // ),
                    Row(
                      children: [
                        Transform.scale(
                          scale: 1,
                          child: Theme(
                            data: ThemeData(
                              unselectedWidgetColor: Colors.grey,
                            ),
                            child: Checkbox(
                              activeColor: Colors.amber,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2))),
                              value: Mutual,
                              onChanged: (bool? value) {
                                setState(() {
                                  Mutual = value!;
                                });
                              },
                            ),
                          ),
                        ),
                        Text("Mutual Fund Name",
                            style: TextStyle(
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 12.sm,
                                fontWeight: FontWeight.w600)),
                        SizedBox(
                          width: 10.w,
                        ),
                        Row(
                          children: [
                            Text(
                              "Amount(₹)",
                              style: TextStyle(
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 12.sm,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Row(
                          children: [
                            Text(
                              "Frequency",
                              style: TextStyle(
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 12.sm,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 25.w,
                        ),
                        Row(
                          children: [
                            Text(
                              "SIP Type",
                              style: TextStyle(
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 12.sm,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 2,
                      color: Get.isDarkMode ? Colors.grey : Colors.grey,
                    ),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        itemCount: piRecom?.data?.manageMfAdvisors!.length,
                        itemBuilder: (context, index) {
                          String? freq;
                          switch (piRecom
                              ?.data?.manageMfAdvisors![index].frequency) {
                            case "1":
                              {
                                freq = "Daily";
                              }
                              break;

                            case "2":
                              {
                                freq = "Weekly";
                              }
                              break;

                            case "3":
                              {
                                freq = "Monthly";
                              }
                              break;
                            case "4":
                              {
                                freq = "Quarterly";
                              }
                              break;
                            case "5":
                              {
                                freq = "Halfyearly";
                              }
                              break;
                            case "6":
                              {
                                freq = "Yearly";
                              }
                              break;
                            case "":
                              {
                                freq = "NA";
                              }
                              break;

                            default:
                              {
                                throw Error();
                              }
                          }
                          String? type;
                          switch (
                              piRecom?.data?.manageMfAdvisors![index].type) {
                            case "1":
                              {
                                type = "One Time";
                              }
                              break;

                            case "2":
                              {
                                type = "SIP";
                              }
                              break;

                            default:
                              {
                                throw Error();
                              }
                          }
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Transform.scale(
                                scale: 1,
                                child: Theme(
                                  data: ThemeData(
                                    unselectedWidgetColor: Colors.grey,
                                  ),
                                  child: Checkbox(
                                    activeColor: Colors.amber,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(2))),
                                    value: Icici,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        Icici = value!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              // Image.asset(
                              //   'assets/images/icici.png',
                              //   width: 20.w,
                              //   height: 20.h,
                              // ),
                              SizedBox(
                                width: 2.w,
                              ),
                              SizedBox(
                                width: 104.w,
                                child: Text(
                                    piRecom?.data?.manageMfAdvisors![index]
                                            .mutualFundName ??
                                        "",
                                    style: TextStyle(
                                        color: Get.isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 14.sm,
                                        fontWeight: FontWeight.w200)),
                              ),

                              SizedBox(
                                width: 80.w,
                                child: Text(
                                  piRecom?.data?.manageMfAdvisors![index]
                                          .price ??
                                      "",
                                  style: TextStyle(
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 14.sm,
                                      fontWeight: FontWeight.w200),
                                ),
                              ),

                              SizedBox(
                                width: 60.w,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(
                                    //    "Daily",
                                    freq,
                                    style: TextStyle(
                                        color: Get.isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 14.sm,
                                        fontWeight: FontWeight.w200),
                                  ),
                                ),
                              ),
                              Text(
                                type,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 14.sm,
                                    fontWeight: FontWeight.w200),
                              ),
                            ],
                          );
                        },
                      ),
                    ),

                    SizedBox(
                      height: 5.h,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 240),
                      child: Center(
                        child: SizedBox(
                          height: 40.h,
                          child: CustomNextButton(
                            text: "Invest Now",
                            ontap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const CartPI()));
                            },
                          ),
                        ),
                      ),
                    ),
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     SizedBox(
                    //       height: 16.h,
                    //     ),
                    //     Padding(
                    //       padding: EdgeInsets.only(left: 40, right: 20),
                    //       child: Text(
                    //         "Mutual Fund (One-time)",
                    //         style: blackStyle(context).copyWith(
                    //             fontSize: 18,
                    //             color:
                    //                 Get.isDarkMode ? Colors.white : Colors.black,
                    //             fontWeight: FontWeight.bold),
                    //       ),
                    //     ),
                    //     // SizedBox(
                    //     //   height: 5.h,
                    //     // ),
                    //     // Divider(
                    //     //   thickness: 1,
                    //     //   color: Get.isDarkMode ? Colors.grey : Colors.grey,
                    //     // ),
                    //     // SizedBox(
                    //     //   height: 5.h,
                    //     // ),
                    //     Row(
                    //       children: [
                    //         Transform.scale(
                    //           scale: 1,
                    //           child: Theme(
                    //             data: ThemeData(
                    //               unselectedWidgetColor: Colors.grey,
                    //             ),
                    //             child: Checkbox(
                    //               activeColor: Colors.amber,
                    //               shape: const RoundedRectangleBorder(
                    //                   borderRadius:
                    //                       BorderRadius.all(Radius.circular(2))),
                    //               value: Mutualone,
                    //               onChanged: (bool? value) {
                    //                 setState(() {
                    //                   Mutualone = value!;
                    //                   Icicione = value;
                    //                   Axisone = value;
                    //                 });
                    //               },
                    //             ),
                    //           ),
                    //         ),
                    //         Text("Mutual Fund Name",
                    //             style: TextStyle(
                    //                 color: Get.isDarkMode
                    //                     ? Colors.white
                    //                     : Colors.black,
                    //                 fontSize: 12.sm,
                    //                 fontWeight: FontWeight.w600)),
                    //         SizedBox(
                    //           width: 160.w,
                    //         ),
                    //         Row(
                    //           children: [
                    //             Text(
                    //               "Amount(₹)",
                    //               style: TextStyle(
                    //                   color: Get.isDarkMode
                    //                       ? Colors.white
                    //                       : Colors.black,
                    //                   fontSize: 12.sm,
                    //                   fontWeight: FontWeight.w600),
                    //             )
                    //           ],
                    //         ),
                    //       ],
                    //     ),
                    //     Divider(
                    //       thickness: 2,
                    //       color: Get.isDarkMode ? Colors.grey : Colors.grey,
                    //     ),

                    //     SizedBox(
                    //       height: 100,
                    //       child: ListView.builder(
                    //         itemCount: 5,
                    //         itemBuilder: (context, index) {
                    //           return Row(
                    //             mainAxisAlignment: MainAxisAlignment.start,
                    //             children: [
                    //               Transform.scale(
                    //                 scale: 1,
                    //                 child: Theme(
                    //                   data: ThemeData(
                    //                     unselectedWidgetColor: Colors.grey,
                    //                   ),
                    //                   child: Checkbox(
                    //                     activeColor: Colors.amber,
                    //                     shape: const RoundedRectangleBorder(
                    //                         borderRadius: BorderRadius.all(
                    //                             Radius.circular(2))),
                    //                     value: Icicione,
                    //                     onChanged: (bool? value) {
                    //                       setState(() {
                    //                         Icicione = value!;
                    //                       });
                    //                     },
                    //                   ),
                    //                 ),
                    //               ),
                    //               Image.asset(
                    //                 'assets/images/icici.png',
                    //                 width: 20.w,
                    //                 height: 20.h,
                    //               ),
                    //               SizedBox(
                    //                 width: 2.w,
                    //               ),
                    //               Text(
                    //                   "ICICI Prudential Technology \nDirect Plan SM",
                    //                   style: TextStyle(
                    //                       color: Get.isDarkMode
                    //                           ? Colors.white
                    //                           : Colors.black,
                    //                       fontSize: 10.sm,
                    //                       fontWeight: FontWeight.w200)),
                    //               SizedBox(
                    //                 width: 120.w,
                    //               ),
                    //               Row(
                    //                 children: [
                    //                   Padding(
                    //                     padding:
                    //                         const EdgeInsets.only(bottom: 18),
                    //                     child: Text(
                    //                       "50,000",
                    //                       style: TextStyle(
                    //                           color: Get.isDarkMode
                    //                               ? Colors.white
                    //                               : Colors.black,
                    //                           fontSize: 15.sm,
                    //                           fontWeight: FontWeight.w200),
                    //                     ),
                    //                   )
                    //                 ],
                    //               ),
                    //             ],
                    //           );
                    //         },
                    //       ),
                    //     ),

                    //     SizedBox(
                    //       height: 12.h,
                    //     ),

                    //     Padding(
                    //       padding: const EdgeInsets.only(left: 190),
                    //       child: Center(
                    //         child: SizedBox(
                    //           height: 40.h,
                    //           child: Text(
                    //             "TOTAL 95000",
                    //             style: TextStyle(
                    //                 color: Color(0xFF008083),
                    //                 fontSize: 22.sm,
                    //                 fontWeight: FontWeight.w600),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       height: 5.h,
                    //     ),
                    //     Padding(
                    //       padding: const EdgeInsets.only(left: 240),
                    //       child: Center(
                    //         child: SizedBox(
                    //           height: 40.h,
                    //           child: CustomNextButton(
                    //             text: "Invest Now",
                    //             ontap: () {
                    //               Navigator.push(
                    //                   context,
                    //                   MaterialPageRoute(
                    //                       builder: (context) => const CartPI2()));
                    //             },
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       height: 30.h,
                    //     )
                    //   ],
                    // )
                  ],
                )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNodataBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
        SizedBox(height: 1
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
    );
  }
}
