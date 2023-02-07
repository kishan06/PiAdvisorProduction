// ignore_for_file: must_be_immutable, prefer_const_constructors, duplicate_ignore, avoid_print, sort_child_properties_last, camel_case_types

import 'dart:async';
import 'dart:math';

import 'package:dio/dio.dart' as prefix;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:outline_search_bar/outline_search_bar.dart';
import 'package:piadvisory/Common/StreamEnum.dart';
import 'package:piadvisory/HomePage/FilterMutualFunds.dart';
import 'package:piadvisory/HomePage/Stock/Model/ActiveByValue.dart';
import 'dart:convert';
import 'package:piadvisory/HomePage/Stock/Model/LiveIndices.dart';
import 'package:piadvisory/HomePage/Stock/Model/OnlyBuyers.dart';
import 'package:piadvisory/HomePage/Stock/Model/SearchStocksModel.dart';
import 'package:piadvisory/HomePage/Stock/Model/TopGainersLosers.dart';
import 'package:piadvisory/HomePage/Stock/Model/Week52Model.dart';
import 'package:piadvisory/HomePage/Stock/MutualFundsTab.dart';
import 'package:piadvisory/HomePage/Stock/SearchedStockGraph.dart';
import 'package:piadvisory/HomePage/Stock/WatchListTab.dart';

import 'package:piadvisory/Utils/Constants.dart';
import 'package:piadvisory/Utils/base_manager.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:piadvisory/my_watchlist/mutual_funds_watchlist.dart';
import 'package:piadvisory/my_watchlist/stocks_watchlist.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:piadvisory/Common/CustomAppbarWithIcons.dart';

import 'package:piadvisory/HomePage/Homepage.dart';
import 'package:piadvisory/HomePage/Mutual%20Funds/MutualFundsGraph.dart';
import 'package:piadvisory/HomePage/Stock/FilterStocksData.dart';
import 'package:piadvisory/HomePage/Stock/StockGraph.dart';
import 'package:piadvisory/HomePage/Stock/StocksRepository/MutualFundsAPImethods.dart';
import 'package:piadvisory/Portfolio/PortfolioMainUI.dart';
import 'package:piadvisory/SideMenu/NavDrawer.dart';
import 'package:piadvisory/SideMenu/Subscribe/Mysubscription.dart';
import 'package:piadvisory/SideMenu/Subscribe/Repository/getSubscriptionWithDetails.dart';
import 'package:piadvisory/Utils/textStyles.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../Common/user_id.dart';
import '../../Profile/KYC/SchduleAppointment.dart';

import '../../Utils/custom_icons_icons.dart';

import '../../smallcase_api_methods.dart';

class Stocks extends StatefulWidget {
  Stocks({Key? key, required this.selectedPage}) : super(key: key);

  @override
  State<Stocks> createState() => _StocksState();
  int selectedPage;
}

class _StocksState extends State<Stocks> with TickerProviderStateMixin {
  String? selectedValue;
  String _lastSelected = 'TAB: 0';
  final List<String> _tabs = ["Stocks", "Mutual fund", "Watchlist"];
  String? _myHandler;
  late TabController _controller;
  int? randomNum;
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
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
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: ((context) => Stocks(
            //               selectedPage: 0,
            //             ))));
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
  void initState() {
    print(widget.selectedPage);
    super.initState();
    generateRandomNumbers();
    _controller = new TabController(
        length: 3, vsync: this, initialIndex: widget.selectedPage);

    _myHandler = _tabs[0];

    if (widget.selectedPage == 1) {
      _myHandler = _tabs[1];
    }

    _controller.addListener(_handleSelected);
  }

  void _handleSelected() {
    setState(() {
      _myHandler = _tabs[_controller.index];
    });
  }

  generateRandomNumbers() {
    var rng = Random();
    randomNum = rng.nextInt(3);

    print("random generated no is ${randomNum}");
  }

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    //bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return DefaultTabController(
      length: 3,
      initialIndex: widget.selectedPage,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: _key,
        drawer: NavDrawer(),
        // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: showFab
            ? Stack(
                children: [
                  Positioned(
                    bottom: 22,
                    right: MediaQuery.of(context).size.width * 0.43,
                    child: FloatingActionButton(
                      backgroundColor: Color(0xFFF78104),
                      heroTag: "MyFirstPage",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    const Mysubscription())));
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
                  Positioned(
                    bottom: 80,
                    left: 20,
                    child: Visibility(
                        visible: !userHasSubscription,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          Mysubscription())));
                            },
                            child: Image.asset("assets/images/BannerNew.png",
                                fit: BoxFit.cover),
                          ),
                        )
                        //  Container(
                        //   decoration: const BoxDecoration(
                        //       gradient: LinearGradient(
                        //     begin: Alignment.topLeft,
                        //     end: Alignment.bottomRight,
                        //     colors: [
                        //       Color(0xFF000000),
                        //       Color(0xFF009A9E),
                        //       Color(0xFF000000),
                        //     ],
                        //   )),
                        //   width: MediaQuery.of(context).size.width * 0.9,
                        //   height: 52.h,
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     children: [
                        //       Text.rich(
                        //         TextSpan(children: [
                        //           TextSpan(
                        //             text: "Get Started @ ",
                        //           ),
                        //           TextSpan(
                        //               text: "₹199/-",
                        //               style: TextStyle(
                        //                 decorationColor: Colors.red,
                        //                 decoration: TextDecoration.lineThrough,
                        //               )),
                        //           TextSpan(
                        //               text: " FREE",
                        //               style: TextStyle(color: Colors.red)),
                        //         ]),
                        //         // "Get Started @ 199/- only ",
                        //         style: blackStyle(context)
                        //             .copyWith(color: Colors.white),
                        //       ),
                        //       // Text(
                        //       //   "Get Started @ 199/- only ",
                        //       //   style: blackStyle(context)
                        //       //       .copyWith(color: Colors.white),
                        //       // ),
                        //       Container(
                        //         padding: const EdgeInsets.all(8),
                        //         decoration: BoxDecoration(
                        //           border: Border.all(
                        //             color: Colors.white,
                        //           ),
                        //           borderRadius: BorderRadius.circular(25),
                        //         ),
                        //         child: GestureDetector(
                        //           onTap: () {
                        //             Navigator.push(
                        //                 context,
                        //                 MaterialPageRoute(
                        //                     builder: ((context) =>
                        //                         Mysubscription())));
                        //           },
                        //           child: Text(
                        //             "Book Now",
                        //             style: blackStyle(context).copyWith(
                        //                 color: Colors.white, fontSize: 12),
                        //           ),
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        ),
                  ),
                ],
              )
            : null,
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
          currentIndex: 1,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Color(0xFFF78104),
          backgroundColor: Colors.white,
          onTap: (index) {
            print(index);
            _selectedTab(index);
          },
          type: BottomNavigationBarType.fixed,
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: CustomAppBarWithIcons(
            globalkey: _key,
            titleTxt: _myHandler!,
            bottomWidget: TabBar(
              labelColor: Colors.black,
              isScrollable: true,
              controller: _controller,
              indicatorColor: const Color(0xFF008083),
              unselectedLabelStyle: const TextStyle(color: Color(0xFF6B6B6B)),
              labelStyle: const TextStyle(
                color: Color(0xFF000000),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              tabs: [
                SizedBox(
                  width: 80.w,
                  child: const Tab(
                    text: "Stocks",
                  ),
                ),
                SizedBox(
                  width: 110.w,
                  child: const Tab(
                    text: "Mutual Funds",
                  ),
                ),
                SizedBox(
                  width: 110.w,
                  child: const Tab(
                    text: "My Watchlist",
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          controller: _controller,
          children: <Widget>[
            //stocks
            FirstTab(
              randomNumber: randomNum,
            ),
            MutualFundsTab(),
            ThirdTab(),
          ],
        ),
      ),
    );
  }
}

class FirstTab extends StatefulWidget {
  FirstTab({Key? key, this.randomNumber}) : super(key: key);

  int? randomNumber;
  @override
  State<FirstTab> createState() => _FirstTabState();
}

class _FirstTabState extends State<FirstTab> {
  StreamController<LiveIndices> streamController = StreamController();
  StreamController streamController2 = StreamController();
  StreamController<requestResponseState> searchstocksController =
      StreamController.broadcast();
  final searchController = TextEditingController();
  bool searchingStarted = false;
  late FocusNode myFocusNode;
  @override
  void dispose() {
    myFocusNode.dispose();
    streamController.close();
    streamController2.close();
    searchController.dispose();
    super.dispose();
    print("disposed called");
  }

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 2), (timer) {
      live_indices();

      switch (widget.randomNumber) {
        case 0:
          active_by_value();
          break;
        case 1:
          top_loser();
          break;
        case 2:
          active_by_vol();
          break;
        case 3:
          top_gainer();
          break;

        default:
      }
    });
  }

  prefix.Dio dio = new prefix.Dio();
  SearchStocksModel? searchedStocks;
  Future<ResponseData> live_indices() async {
    prefix.Response response;

    try {
      response = await dio.get(
        "https://stock.accordwebservices.com/BSEStockXV/GetLiveIndiceData?ExCode=BE49H6S&Top=&PageNo=1&Pagesize=6&SortExpression=&SortDirection=&token=wG2axAvNa3yX3DT89CHVHyg2x19TOZE5",
      );
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      //  var decodeddata = jsonDecode(response.data);
      var liveIndices = LiveIndices.fromJson(response.data);
      if (!streamController.isClosed) streamController.sink.add(liveIndices);

      // homePage = response.data["HomePageStatus"];
      // print("Homepage  $homePage");

      return ResponseData<dynamic>(
        "success",
        ResponseStatus.SUCCESS,
      );
    } else {
      try {
        return ResponseData<dynamic>(
            response.data['message'].toString(), ResponseStatus.FAILED);
      } catch (_) {
        return ResponseData<dynamic>(
            response.statusMessage!, ResponseStatus.FAILED);
      }
    }
  }

  Future<ResponseData> active_by_value() async {
    prefix.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    try {
      response = await dio.get(
          "https://stock.accordwebservices.com/BSEStockXV/GetValueToppers?ExCode=BE49H6S&Group=all&IndexCode=45&Top=&Option=&PageNo=1&Pagesize=6&SortExpression=&SortDirection=&token=wG2axAvNa3yX3DT89CHVHyg2x19TOZE5",
          options: prefix.Options(headers: {"authorization": "Bearer $token"}));
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      // var decodeddata = jsonDecode(response.data);
      var data = ActiveByValueModel.fromJson(response.data);
      if (!streamController2.isClosed) streamController2.sink.add(data);

      return ResponseData<dynamic>(
        "success",
        ResponseStatus.SUCCESS,
      );
    } else {
      try {
        return ResponseData<dynamic>(
            response.data['message'].toString(), ResponseStatus.FAILED);
      } catch (_) {
        return ResponseData<dynamic>(
            response.statusMessage!, ResponseStatus.FAILED);
      }
    }
  }

  Future<ResponseData> top_loser() async {
    prefix.Response response;

    try {
      response = await dio.get(
        "https://stock.accordwebservices.com/BSEStockXV/GetGainersnLosers?ExCode=BE49H6S&Group=all&Type=lose&Indices=45&Option=&Period=Daily&PageNo=1&Pagesize=6&SortExpression=&SortDirect=Asc&token=wG2axAvNa3yX3DT89CHVHyg2x19TOZE5",
      );
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      // var decodeddata = jsonDecode(response.data);
      var data = TopGainersLosers.fromJson(response.data);
      if (!streamController2.isClosed) streamController2.sink.add(data);

      return ResponseData<dynamic>(
        "success",
        ResponseStatus.SUCCESS,
      );
    } else {
      try {
        return ResponseData<dynamic>(
            response.data['message'].toString(), ResponseStatus.FAILED);
      } catch (_) {
        return ResponseData<dynamic>(
            response.statusMessage!, ResponseStatus.FAILED);
      }
    }
  }

  Future<ResponseData> active_by_vol() async {
    prefix.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    try {
      response = await dio.get(
          "https://stock.accordwebservices.com/BSEStockXV/GetVolumeToppers?ExCode=BE49H6S&Group=all&IndexCode=45&Top=&Option=&PageNo=1&Pagesize=6&SortExpression=&SortDirection=&token=wG2axAvNa3yX3DT89CHVHyg2x19TOZE5",
          options: prefix.Options(headers: {"authorization": "Bearer $token"}));
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      // var decodeddata = jsonDecode(response.data);
      var data = ActiveByValueModel.fromJson(response.data);
      if (!streamController2.isClosed) streamController2.sink.add(data);

      return ResponseData<dynamic>(
        "success",
        ResponseStatus.SUCCESS,
      );
    } else {
      try {
        return ResponseData<dynamic>(
            response.data['message'].toString(), ResponseStatus.FAILED);
      } catch (_) {
        return ResponseData<dynamic>(
            response.statusMessage!, ResponseStatus.FAILED);
      }
    }
  }

  Future<ResponseData> week52() async {
    prefix.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    try {
      response = await dio.get(
          "https://stock.accordwebservices.com/BSEStockXV/GetHighsnLows?ExCode=BE49H6S&Group=all&IndexCode=46&Option=52week&HighOrLow=High&Top=&PageNo=1&Pagesize=6&SortExpression=&SortDirection=asc&token=wG2axAvNa3yX3DT89CHVHyg2x19TOZE5",
          options: prefix.Options(headers: {"authorization": "Bearer $token"}));
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      var data = Week52Model.fromJson(response.data);
      if (!streamController2.isClosed) streamController2.sink.add(data);

      return ResponseData<dynamic>(
        "success",
        ResponseStatus.SUCCESS,
      );
    } else {
      try {
        return ResponseData<dynamic>(
            response.data['message'].toString(), ResponseStatus.FAILED);
      } catch (_) {
        return ResponseData<dynamic>(
            response.statusMessage!, ResponseStatus.FAILED);
      }
    }
  }

  Future<ResponseData> week52Low() async {
    prefix.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    try {
      response = await dio.get(
          "https://stock.accordwebservices.com/BSEStockXV/GetHighsnLows?ExCode=BE49H6S&Group=all&IndexCode=46&Option=52week&HighOrLow=Low&Top=&PageNo=1&Pagesize=6&SortExpression=&SortDirection=asc&token=wG2axAvNa3yX3DT89CHVHyg2x19TOZE5",
          options: prefix.Options(headers: {"authorization": "Bearer $token"}));
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      var data = Week52Model.fromJson(response.data);
      if (!streamController2.isClosed) streamController2.sink.add(data);

      return ResponseData<dynamic>(
        "success",
        ResponseStatus.SUCCESS,
      );
    } else {
      try {
        return ResponseData<dynamic>(
            response.data['message'].toString(), ResponseStatus.FAILED);
      } catch (_) {
        return ResponseData<dynamic>(
            response.statusMessage!, ResponseStatus.FAILED);
      }
    }
  }

  Future<ResponseData> top_gainer() async {
    prefix.Response response;

    try {
      response = await dio.get(
        "https://stock.accordwebservices.com/BSEStockXV/GetGainersnLosers?ExCode=BE49H6S&Group=all&Type=gain&Indices=45&Option=&Period=Daily&PageNo=1&Pagesize=6&SortExpression=&SortDirect=Desc&token=wG2axAvNa3yX3DT89CHVHyg2x19TOZE5",
      );
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      // var decodeddata = jsonDecode(response.data);
      var data = TopGainersLosers.fromJson(response.data);
      if (!streamController2.isClosed) streamController2.sink.add(data);

      return ResponseData<dynamic>(
        "success",
        ResponseStatus.SUCCESS,
      );
    } else {
      try {
        return ResponseData<dynamic>(
            response.data['message'].toString(), ResponseStatus.FAILED);
      } catch (_) {
        return ResponseData<dynamic>(
            response.statusMessage!, ResponseStatus.FAILED);
      }
    }
  }

  Future showFilterDialog() async {
    FocusScope.of(context).unfocus();
    final data = await showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: const FilterStocksData(),
        );
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }

  Future<ResponseData> SearchStocks(String searchText) async {
    prefix.Response response;
    try {
      response = await dio.get(
        "https://stock.accordwebservices.com/BSEStockXV/GetCompanyList?SearchTxt=$searchText&token=wG2axAvNa3yX3DT89CHVHyg2x19TOZE5",
      );
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      searchedStocks = SearchStocksModel.fromJson(response.data);

      searchstocksController.add(requestResponseState.DataReceived);
      return ResponseData<dynamic>(
        "success",
        ResponseStatus.SUCCESS,
      );
    } else {
      try {
        return ResponseData<dynamic>(
            response.data['message'].toString(), ResponseStatus.FAILED);
      } catch (_) {
        return ResponseData<dynamic>(
            response.statusMessage!, ResponseStatus.FAILED);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    myFocusNode = FocusNode();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: Container(
          color: Get.isDarkMode ? Colors.black : Colors.white,
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        // clipBehavior: Clip.none,
                        children: [
                          OutlineSearchBar(
                            borderColor: Color(0xFF6E6E6E),
                            focusNode: myFocusNode,
                            onKeywordChanged: (value) {
                              setState(() {
                                searchController.text.isNotEmpty
                                    ? searchingStarted = true
                                    : searchingStarted = false;
                                SearchStocks(searchController.text);
                                // myDataRequest = registeredusers.data!
                                //     .where(
                                //       (element) => element.email!
                                //           .toLowerCase()
                                //           .contains(
                                //             value.toLowerCase(),
                                //           ),
                                //     )
                                //     .toList();
                              });
                            },
                            textEditingController: searchController,
                            hintText: "Search & Add",
                          ),
                          searchingStarted
                              ? Center(
                                  child: Container(
                                    height: 150.h,
                                    //width: 280.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                      border: Border.all(
                                        width: 1,
                                        color: Color(0xFF6B6B6B),
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: StreamBuilder<
                                              requestResponseState>(
                                          stream: searchstocksController.stream,
                                          builder: (context, snapshot) {
                                            switch (snapshot.connectionState) {
                                              case ConnectionState.waiting:
                                                return Center(
                                                  child: Lottie.asset(
                                                    "assets/images/lf30_editor_jc6n8oqe.json",
                                                    repeat: true,
                                                    height: 50,
                                                    width: 50,
                                                  ),
                                                );

                                              default:
                                                if (snapshot.hasError) {
                                                  return Text("Error Occured");
                                                } else {
                                                  var searchedList =
                                                      searchedStocks!.table!;
                                                  return SizedBox(
                                                    height: 50,
                                                    child: ListView.separated(
                                                      itemCount:
                                                          searchedList.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return SingleChildScrollView(
                                                          child: ListTile(
                                                            title: Text(
                                                                searchedList[
                                                                        index]
                                                                    .sName!),
                                                            onTap: () {
                                                              SystemChannels
                                                                  .textInput
                                                                  .invokeMethod(
                                                                      'TextInput.hide');
                                                              searchController
                                                                  .clear();
                                                              setState(() {
                                                                searchingStarted =
                                                                    false;
                                                              });
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: ((context) =>
                                                                          SearchedStockGraph(
                                                                            bseTicker:
                                                                                searchedList[index].sYMBOL ?? '',
                                                                            fincode:
                                                                                searchedList[index].fINCODE,
                                                                            sName:
                                                                                searchedList[index].sName,

                                                                            // openPrice: searchedList[index].,
                                                                            // prevClose: searchedList[index].pREVCLOSE,
                                                                            // volume: searchedList[index].vOLUME,
                                                                            // value: searchedList[index].vALUE,
                                                                            // perChange: searchedList[index].pERCHG,
                                                                            // lowPrice: searchedList[index].lOWPRICE,
                                                                            // highPrice: searchedList[index].hIGHPRICE,
                                                                          ))));
                                                            },
                                                          ),
                                                        );
                                                      },
                                                      separatorBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return Divider(
                                                          thickness: 1.5,
                                                        );
                                                      },
                                                    ),
                                                  );
                                                }
                                            }
                                          }),
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     showFilterDialog();
                    //   },
                    //   child: Container(
                    //       margin: const EdgeInsets.only(left: 20, right: 20),
                    //       width: 30,
                    //       child: SvgPicture.asset(
                    //         'assets/images/Group 5778.svg',
                    //       )),
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: 1,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Text(
                  "Market Indices",
                  style: TextStyle(
                      fontSize: 16,
                      color: Get.isDarkMode ? Colors.white : Colors.black),
                ),
              ),
              StreamBuilder<LiveIndices>(
                  stream: streamController.stream,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(
                          child: Lottie.asset(
                            "assets/images/lf30_editor_jc6n8oqe.json",
                            repeat: true,
                            height: 50,
                            width: 50,
                          ),
                        );

                      default:
                        if (snapshot.hasError) {
                          return Text("Error Occured");
                        } else {
                          return SizedBox(
                            width: double.infinity,
                            height: 150.h,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 0, top: 10),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.table!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          SystemChannels.textInput
                                              .invokeMethod('TextInput.hide');
                                          searchController.clear();
                                          setState(() {
                                            searchingStarted = false;
                                          });
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: ((context) =>
                                                      SearchedStockGraph(
                                                        bseTicker: '',
                                                        fincode: snapshot
                                                            .data!
                                                            .table![index]
                                                            .iNDEXID,
                                                        sName: snapshot
                                                            .data!
                                                            .table![index]
                                                            .iNDEXLNAME,
                                                        showbuysell: false,
                                                        // openPrice: searchedList[index].,
                                                        prevClose: snapshot
                                                            .data!
                                                            .table![index]
                                                            .pREVCLOSE,
                                                        // volume: searchedList[index].vOLUME,
                                                        // value: searchedList[index].vALUE,
                                                        // perChange: searchedList[index].pERCHG,
                                                        // lowPrice: searchedList[index].lOWPRICE,
                                                        // highPrice: searchedList[index].hIGHPRICE,
                                                      ))));
                                        },
                                        child: ScrollableCards(
                                          colorvalue: 0xFFE12C0F,
                                          title: snapshot
                                              .data!.table![index].iNDEXNAME!,
                                          subtitle: snapshot
                                              .data!.table![index].cLOSE!,
                                          plvalues:
                                              "${snapshot.data!.table![index].cHANGE} (${snapshot.data!.table![index].pERCHANGE!})",
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          );
                        }
                    }
                  }),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Text(
                  "Stock in News",
                  style: TextStyle(
                      fontSize: 16,
                      color: Get.isDarkMode ? Colors.white : Colors.black),
                ),
              ),
              StreamBuilder(
                stream: streamController2.stream,
                builder: (context, snapshot) {
                  var responseData;
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(
                        child: Lottie.asset(
                          "assets/images/lf30_editor_jc6n8oqe.json",
                          repeat: true,
                          height: 50,
                          width: 50,
                        ),
                      );

                    default:
                      if (snapshot.hasError) {
                        return Text("Error Occured");
                      } else {
                        switch (widget.randomNumber) {
                          case 0:
                            responseData = snapshot.data as ActiveByValueModel;
                            break;
                          case 1:
                            responseData = snapshot.data as TopGainersLosers;

                            break;
                          case 2:
                            responseData = snapshot.data as ActiveByValueModel;

                            break;

                          case 3:
                            responseData = snapshot.data as TopGainersLosers;

                            break;

                          default:
                        }
                        return SizedBox(
                          width: double.infinity,
                          height: 150.h,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 0, top: 10),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: responseData.table?.length ?? 0,
                              itemBuilder: (BuildContext context, int index) {
                                switch (widget.randomNumber) {
                                  case 0:
                                    {
                                      return Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              SystemChannels.textInput
                                                  .invokeMethod(
                                                      'TextInput.hide');
                                              searchController.clear();
                                              setState(() {
                                                searchingStarted = false;
                                              });
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: ((context) =>
                                                          StockGraph(
                                                            bseTicker: responseData
                                                                    .table![
                                                                        index]
                                                                    .sYMBOL ??
                                                                "",
                                                            fincode:
                                                                responseData
                                                                    .table![
                                                                        index]
                                                                    .fINCODE,
                                                            sName: responseData
                                                                .table![index]
                                                                .sNAME,
                                                            mCap: responseData
                                                                .table![index]
                                                                .mCAP,
                                                            openPrice:
                                                                responseData
                                                                    .table![
                                                                        index]
                                                                    .price,
                                                            prevClose:
                                                                responseData
                                                                    .table![
                                                                        index]
                                                                    .prevPrice,
                                                            volume: responseData
                                                                .table![index]
                                                                .volume,
                                                            value: responseData
                                                                .table![index]
                                                                .vALUE,
                                                            perChange:
                                                                responseData
                                                                    .table![
                                                                        index]
                                                                    .perChange,
                                                            lowPrice:
                                                                responseData
                                                                    .table![
                                                                        index]
                                                                    .low,
                                                            highPrice:
                                                                responseData
                                                                    .table![
                                                                        index]
                                                                    .high,
                                                          ))));
                                            },
                                            child: ScrollableCards(
                                              colorvalue: 0xFFE12C0F,
                                              title: responseData
                                                  .table![index].sYMBOL!,
                                              subtitle: responseData
                                                  .table![index].price!,
                                              plvalues:
                                                  "${responseData.table![index].change} (${responseData.table![index].perChange!} )",
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      );
                                    }

                                    break;
                                  case 1:
                                    return Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            SystemChannels.textInput
                                                .invokeMethod('TextInput.hide');
                                            searchController.clear();
                                            setState(() {
                                              searchingStarted = false;
                                            });
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: ((context) =>
                                                        StockGraph(
                                                          bseTicker:
                                                              responseData
                                                                      .table![
                                                                          index]
                                                                      .sYMBOL ??
                                                                  '',
                                                          fincode: responseData
                                                              .table![index]
                                                              .fINCODE,
                                                          sName: responseData
                                                              .table![index]
                                                              .sNAME,
                                                          mCap: responseData
                                                              .table![index]
                                                              .mCAP,
                                                          openPrice:
                                                              responseData
                                                                  .table![index]
                                                                  .oPENPRICE,
                                                          prevClose:
                                                              responseData
                                                                  .table![index]
                                                                  .pREVCLOSE,
                                                          volume: responseData
                                                              .table![index]
                                                              .vOLUME,
                                                          value: responseData
                                                              .table![index]
                                                              .vALUE,
                                                          perChange:
                                                              responseData
                                                                  .table![index]
                                                                  .pERCHG,
                                                          lowPrice: responseData
                                                              .table![index]
                                                              .lOWPRICE,
                                                          highPrice:
                                                              responseData
                                                                  .table![index]
                                                                  .hIGHPRICE,
                                                        ))));
                                          },
                                          child: ScrollableCards(
                                            colorvalue: 0xFFE12C0F,
                                            title: responseData
                                                .table![index].sYMBOL!,
                                            subtitle: responseData
                                                .table![index].cLOSEPRICE!,
                                            plvalues:
                                                "${responseData.table![index].nETCHG} (${responseData.table![index].pERCHG!} )",
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    );
                                    break;
                                  case 2:
                                    return Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            SystemChannels.textInput
                                                .invokeMethod('TextInput.hide');
                                            searchController.clear();
                                            setState(() {
                                              searchingStarted = false;
                                            });
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: ((context) =>
                                                        StockGraph(
                                                          bseTicker:
                                                              responseData
                                                                      .table![
                                                                          index]
                                                                      .sYMBOL ??
                                                                  "",
                                                          fincode: responseData
                                                              .table![index]
                                                              .fINCODE,
                                                          sName: responseData
                                                              .table![index]
                                                              .sNAME,
                                                          mCap: responseData
                                                              .table![index]
                                                              .mCAP,
                                                          openPrice:
                                                              responseData
                                                                  .table![index]
                                                                  .price,
                                                          prevClose:
                                                              responseData
                                                                  .table![index]
                                                                  .prevPrice,
                                                          volume: responseData
                                                              .table![index]
                                                              .volume,
                                                          value: responseData
                                                              .table![index]
                                                              .vALUE,
                                                          perChange:
                                                              responseData
                                                                  .table![index]
                                                                  .perChange,
                                                          lowPrice: responseData
                                                              .table![index]
                                                              .low,
                                                          highPrice:
                                                              responseData
                                                                  .table![index]
                                                                  .high,
                                                        ))));
                                          },
                                          child: ScrollableCards(
                                            colorvalue: 0xFFE12C0F,
                                            title: responseData
                                                .table![index].sYMBOL!,
                                            subtitle: responseData
                                                .table![index].price!,
                                            plvalues:
                                                "${responseData.table![index].change} (${responseData.table![index].perChange!} )",
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    );
                                    break;

                                  case 3:
                                    return Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            SystemChannels.textInput
                                                .invokeMethod('TextInput.hide');
                                            searchController.clear();
                                            setState(() {
                                              searchingStarted = false;
                                            });
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: ((context) =>
                                                        StockGraph(
                                                          bseTicker:
                                                              responseData
                                                                      .table![
                                                                          index]
                                                                      .sYMBOL ??
                                                                  '',
                                                          fincode: responseData
                                                              .table![index]
                                                              .fINCODE,
                                                          sName: responseData
                                                              .table![index]
                                                              .sNAME,
                                                          mCap: responseData
                                                              .table![index]
                                                              .mCAP,
                                                          openPrice:
                                                              responseData
                                                                  .table![index]
                                                                  .oPENPRICE,
                                                          prevClose:
                                                              responseData
                                                                  .table![index]
                                                                  .pREVCLOSE,
                                                          volume: responseData
                                                              .table![index]
                                                              .vOLUME,
                                                          value: responseData
                                                              .table![index]
                                                              .vALUE,
                                                          perChange:
                                                              responseData
                                                                  .table![index]
                                                                  .pERCHG,
                                                          lowPrice: responseData
                                                              .table![index]
                                                              .lOWPRICE,
                                                          highPrice:
                                                              responseData
                                                                  .table![index]
                                                                  .hIGHPRICE,
                                                        ))));
                                          },
                                          child: ScrollableCards(
                                            colorvalue: 0xFFE12C0F,
                                            title: responseData
                                                .table![index].sYMBOL!,
                                            subtitle: responseData
                                                .table![index].cLOSEPRICE!,
                                            plvalues:
                                                "${responseData.table![index].nETCHG} (${responseData.table![index].pERCHG!} )",
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    );
                                    break;

                                  default:
                                    return Row(
                                      children: [
                                        ScrollableCards(
                                          colorvalue: 0xFFE12C0F,
                                          title: responseData
                                              .table![index].sYMBOL!,
                                          subtitle:
                                              responseData.table![index].price!,
                                          plvalues:
                                              "${responseData.table![index].change} (${responseData.table![index].perChange!} )",
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    );
                                }
                              },
                            ),
                          ),
                        );
                      }
                  }
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Text(
                      "Market Trends",
                      style: TextStyle(
                          fontSize: 16,
                          color: Get.isDarkMode ? Colors.white : Colors.black),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //     right: 8.0,
                  //   ),
                  //   child: Image.asset("assets/images/icon3.png"),
                  // ),
                ],
              ),
              DefaultTabController(
                length: 8,
                child: Column(
                  children: [
                    TabBar(
                      labelColor: Get.isDarkMode ? Colors.white : Colors.black,
                      indicatorColor: Color(0xFFF78104),
                      isScrollable: true,
                      unselectedLabelStyle: TextStyle(color: Color(0xFF6B6B6B)),
                      labelStyle: TextStyle(
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      padding: EdgeInsets.only(
                        left: 30,
                        right: 30,
                      ),
                      tabs: const [
                        Tab(
                          text: "Top Gainer",
                        ),
                        Tab(
                          text: "Top Losers",
                        ),
                        Tab(
                          text: "Active By Value",
                        ),
                        Tab(
                          text: "Active By Volume",
                        ),
                        Tab(
                          text: "52-Week High",
                        ),
                        Tab(
                          text: "52-Week Low",
                        ),
                        Tab(
                          text: "Only Buyers",
                        ),
                        Tab(
                          text: "Only Sellers",
                        ),
                      ],
                      indicatorWeight: 1.5,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    SizedBox(
                        // color: AppColors.lightGreyColor,
                        height: 500.h,
                        child: TabBarView(children: [
                          TopGainer(),
                          TopLoser(),
                          ActiveByValue(),
                          ActiveByVolume(),
                          Week52(),
                          Week52Low(),
                          OnlyBuyers(),
                          OnlySellers(),
                        ]))
                  ],
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}

class ThirdTab extends StatefulWidget {
  ThirdTab({Key? key}) : super(key: key);

  @override
  State<ThirdTab> createState() => _ThirdTabState();
}

class _ThirdTabState extends State<ThirdTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Get.isDarkMode ? Colors.black : Colors.white,
        width: double.infinity,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultTabController(
              length: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TabBar(
                    labelColor: Get.isDarkMode ? Colors.white : Colors.black,
                    indicatorPadding:
                        EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                    // labelPadding: EdgeInsets.symmetric(horizontal: 50),
                    indicatorColor: Color(0xFF008083),
                    isScrollable: false,
                    unselectedLabelStyle: TextStyle(color: Color(0xFF6B6B6B)),
                    labelStyle: TextStyle(
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    padding: EdgeInsets.only(
                      left: 30,
                      right: 30,
                      top: 10,
                      bottom: 10,
                    ),
                    tabs: [
                      Tab(
                        text: "Stocks",
                      ),
                      Tab(
                        text: "Mutual Funds",
                      ),
                    ],
                    indicatorWeight: 1.5,
                  ),
                  SizedBox(
                      height: 500.h,
                      child: TabBarView(children: [
                        StocksWatchlist(),
                        MutualFundsWatchlist()
                      ]))
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}

class ScrollableCards extends StatefulWidget {
  const ScrollableCards({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.plvalues,
    required this.colorvalue,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String plvalues;
  final int colorvalue;

  @override
  State<ScrollableCards> createState() => _ScrollableCardsState();
}

class _ScrollableCardsState extends State<ScrollableCards> {
  bool negative = true;
  @override
  void initState() {
    super.initState();
    negative = widget.plvalues.contains('-');
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 145,
      height: 123,
      child: Card(
        elevation: 2,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xFF6B6B6B).withOpacity(0.2))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 16,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.subtitle,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                Text(widget.plvalues,
                    textAlign: TextAlign.left,
                    style: negative
                        ? TextStyle(
                            fontSize: 12,
                            color: Color(widget.colorvalue),
                          )
                        : TextStyle(
                            fontSize: 12,
                            color: Colors.green,
                          )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TopGainer extends StatefulWidget {
  const TopGainer({
    Key? key,
  }) : super(key: key);

  @override
  State<TopGainer> createState() => _TopGainerState();
}

class _TopGainerState extends State<TopGainer>
    with AutomaticKeepAliveClientMixin<TopGainer> {
  StreamController<TopGainersLosers> topGainerLoserController =
      StreamController();
  final searchController = TextEditingController();
  bool searchingStarted = false;

  @override
  void dispose() {
    topGainerLoserController.close();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 2), (timer) {
      top_gainer();
    });
  }

  prefix.Dio dio = new prefix.Dio();

  Future<ResponseData> top_gainer() async {
    prefix.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      response = await dio.get(
        "https://stock.accordwebservices.com/BSEStockXV/GetGainersnLosers?ExCode=BE49H6S&Group=all&Type=gain&Indices=45&Option=&Period=Daily&PageNo=1&Pagesize=10&SortExpression=&SortDirect=Desc&token=wG2axAvNa3yX3DT89CHVHyg2x19TOZE5",
      );
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      // var decodeddata = jsonDecode(response.data);
      var data = TopGainersLosers.fromJson(response.data);
      if (!topGainerLoserController.isClosed)
        topGainerLoserController.sink.add(data);

      return ResponseData<dynamic>(
        "success",
        ResponseStatus.SUCCESS,
      );
    } else {
      try {
        return ResponseData<dynamic>(
            response.data['message'].toString(), ResponseStatus.FAILED);
      } catch (_) {
        return ResponseData<dynamic>(
            response.statusMessage!, ResponseStatus.FAILED);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TopGainersLosers>(
        stream: topGainerLoserController.stream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: Lottie.asset(
                  "assets/images/lf30_editor_jc6n8oqe.json",
                  repeat: true,
                  height: 50,
                  width: 50,
                ),
              );

            default:
              if (snapshot.hasError) {
                return Text("Error Occured");
              } else {
                return snapshot.data!.table!.isEmpty
                    ? _buildNoDataBody()
                    : _buildBody(snapshot.data!);
              }
          }
        });
  }

  Widget _buildNoDataBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("No Data Found"),
      ],
    );
  }

  Widget _buildBody(TopGainersLosers data) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            addAutomaticKeepAlives: true,
            itemCount: data.table!.length,
            itemBuilder: (BuildContext context, int index) {
              num percentageChange =
                  num.parse(data.table![index].nETCHG! ?? "0");
              String dateStart = data.table![index].uPDTIME!;
              DateFormat inputFormat = DateFormat('dd/MM/yyyy hh:mm:ss a');
              DateTime now = inputFormat.parse(dateStart);
              String convertedDateTime =
                  "${DateFormat.MMM().format(now)} ${now.day.toString().padLeft(2, '0')}, ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";

              return GestureDetector(
                onTap: () {
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                  searchController.clear();
                  setState(() {
                    searchingStarted = false;
                  });

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => StockGraph(
                              bseTicker: data.table![index].sYMBOL ?? '',
                              fincode: data.table![index].fINCODE,
                              sName: data.table![index].sNAME,
                              mCap: data.table![index].mCAP,
                              openPrice: data.table![index].oPENPRICE,
                              prevClose: data.table![index].pREVCLOSE,
                              volume: data.table![index].vOLUME,
                              value: data.table![index].vALUE,
                              perChange: data.table![index].pERCHG,
                              lowPrice: data.table![index].lOWPRICE,
                              highPrice: data.table![index].hIGHPRICE,
                              closePriceRecvd:
                                  data.table![index].cLOSEPRICE))));
                },
                child: CommonTrends(
                  title1: data.table![index].sYMBOL!,
                  subtitle1: convertedDateTime,
                  title2: data.table![index].cLOSEPRICE!,
                  subtitle2: "Vol:${data.table![index].vOLUME!}",
                  title3: "+${percentageChange.toStringAsFixed(1)}",
                  subtitle3: "(${data.table![index].pERCHG!} %)",
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                thickness: 1.5,
              );
            },
          ),
        ),
        !userHasSubscription
            ? SizedBox(height: 180.h)
            : SizedBox(
                height: 37.h,
              )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class TopLoser extends StatefulWidget {
  const TopLoser({
    Key? key,
  }) : super(key: key);

  @override
  State<TopLoser> createState() => _TopLoserState();
}

class _TopLoserState extends State<TopLoser>
    with AutomaticKeepAliveClientMixin<TopLoser> {
  StreamController<TopGainersLosers> topGainerLoserController =
      StreamController();
  final searchController = TextEditingController();
  bool searchingStarted = false;

  @override
  void dispose() {
    topGainerLoserController.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 2), (timer) {
      top_losers();
    });
  }

  prefix.Dio dio = new prefix.Dio();

  Future<ResponseData> top_losers() async {
    prefix.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    try {
      response = await dio.get(
        "https://stock.accordwebservices.com/BSEStockXV/GetGainersnLosers?ExCode=BE49H6S&Group=all&Type=lose&Indices=45&Option=&Period=Daily&PageNo=1&Pagesize=10&SortExpression=&SortDirect=asc&token=wG2axAvNa3yX3DT89CHVHyg2x19TOZE5",
        // options: prefix.Options(headers: {"authorization": "Bearer $token"})
      );
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      //   var decodeddata = jsonDecode(response.data);
      var data = TopGainersLosers.fromJson(response.data);
      if (!topGainerLoserController.isClosed)
        topGainerLoserController.sink.add(data);

      return ResponseData<dynamic>(
        "success",
        ResponseStatus.SUCCESS,
      );
    } else {
      try {
        return ResponseData<dynamic>(
            response.data['message'].toString(), ResponseStatus.FAILED);
      } catch (_) {
        return ResponseData<dynamic>(
            response.statusMessage!, ResponseStatus.FAILED);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TopGainersLosers>(
        stream: topGainerLoserController.stream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: Lottie.asset(
                  "assets/images/lf30_editor_jc6n8oqe.json",
                  repeat: true,
                  height: 50,
                  width: 50,
                ),
              );

            default:
              if (snapshot.hasError) {
                return Text("Error Occured");
              } else {
                return snapshot.data!.table!.isEmpty
                    ? _buildNoDataBody()
                    : _buildBody(snapshot.data!);
              }
          }
        });
  }

  Widget _buildNoDataBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("No Data Found"),
      ],
    );
  }

  Widget _buildBody(TopGainersLosers data) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            addAutomaticKeepAlives: true,
            itemCount: data.table!.length,
            itemBuilder: (BuildContext context, int index) {
              num percentageChange =
                  num.parse(data.table![index].nETCHG! ?? "0");
              String dateStart = data.table![index].uPDTIME!;
              DateFormat inputFormat = DateFormat('dd/MM/yyyy hh:mm:ss a');
              DateTime now = inputFormat.parse(dateStart);
              String convertedDateTime =
                  "${DateFormat.MMM().format(now)} ${now.day.toString().padLeft(2, '0')}, ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";

              return GestureDetector(
                onTap: () {
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                  searchController.clear();
                  setState(() {
                    searchingStarted = false;
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => StockGraph(
                              bseTicker: data.table![index].sYMBOL ?? "",
                              fincode: data.table![index].fINCODE,
                              sName: data.table![index].sNAME,
                              mCap: data.table![index].mCAP,
                              openPrice: data.table![index].oPENPRICE,
                              prevClose: data.table![index].pREVCLOSE,
                              volume: data.table![index].vOLUME,
                              value: data.table![index].vALUE,
                              perChange: data.table![index].pERCHG,
                              lowPrice: data.table![index].lOWPRICE,
                              highPrice: data.table![index].hIGHPRICE,
                              closePriceRecvd:
                                  data.table![index].cLOSEPRICE))));
                },
                child: CommonTrends(
                  title1: data.table![index].sYMBOL!,
                  subtitle1: convertedDateTime,
                  title2: data.table![index].cLOSEPRICE!,
                  subtitle2: "Vol:${data.table![index].vOLUME!}",
                  title3: percentageChange.toStringAsFixed(1),
                  subtitle3: "(${data.table![index].pERCHG!} %)",
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                thickness: 1.5,
              );
            },
          ),
        ),
        !userHasSubscription
            ? SizedBox(height: 180.h)
            : SizedBox(
                height: 37.h,
              )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class ActiveByValue extends StatefulWidget {
  const ActiveByValue({
    Key? key,
  }) : super(key: key);

  @override
  State<ActiveByValue> createState() => _ActiveByValueState();
}

class _ActiveByValueState extends State<ActiveByValue>
    with AutomaticKeepAliveClientMixin<ActiveByValue> {
  StreamController<ActiveByValueModel> topGainerLoserController =
      StreamController();
  final searchController = TextEditingController();
  bool searchingStarted = false;

  @override
  void dispose() {
    topGainerLoserController.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 2), (timer) {
      active_by_value();
    });
  }

  prefix.Dio dio = new prefix.Dio();

  Future<ResponseData> active_by_value() async {
    prefix.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    try {
      response = await dio.get(
          "https://stock.accordwebservices.com/BSEStockXV/GetValueToppers?ExCode=BE49H6S&Group=all&IndexCode=45&Top=&Option=&PageNo=1&Pagesize=10&SortExpression=&SortDirection=&token=wG2axAvNa3yX3DT89CHVHyg2x19TOZE5",
          options: prefix.Options(headers: {"authorization": "Bearer $token"}));
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      // var decodeddata = jsonDecode(response.data);
      var data = ActiveByValueModel.fromJson(response.data);
      if (!topGainerLoserController.isClosed)
        topGainerLoserController.sink.add(data);

      return ResponseData<dynamic>(
        "success",
        ResponseStatus.SUCCESS,
      );
    } else {
      try {
        return ResponseData<dynamic>(
            response.data['message'].toString(), ResponseStatus.FAILED);
      } catch (_) {
        return ResponseData<dynamic>(
            response.statusMessage!, ResponseStatus.FAILED);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ActiveByValueModel>(
        stream: topGainerLoserController.stream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: Lottie.asset(
                  "assets/images/lf30_editor_jc6n8oqe.json",
                  repeat: true,
                  height: 50,
                  width: 50,
                ),
              );

            default:
              if (snapshot.hasError) {
                return Text("Error Occured");
              } else {
                return snapshot.data!.table!.isEmpty
                    ? _buildNoDataBody()
                    : _buildBody(snapshot.data!);
              }
          }
        });
  }

  Widget _buildNoDataBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("No Data Found"),
      ],
    );
  }

  Widget _buildBody(ActiveByValueModel data) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            addAutomaticKeepAlives: true,
            itemCount: data.table!.length,
            itemBuilder: (BuildContext context, int index) {
              num percentageChange = num.parse(data.table![index].change!);
              String dateStart = data.table![index].uPDTIME!;
              DateFormat inputFormat = DateFormat('dd/MM/yyyy hh:mm:ss a');
              DateTime now = inputFormat.parse(dateStart);
              String convertedDateTime =
                  "${DateFormat.MMM().format(now)} ${now.day.toString().padLeft(2, '0')}, ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";

              return GestureDetector(
                onTap: () {
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                  searchController.clear();
                  setState(() {
                    searchingStarted = false;
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => StockGraph(
                              bseTicker: data.table![index].sYMBOL ?? "",
                              fincode: data.table![index].fINCODE,
                              sName: data.table![index].sNAME,
                              mCap: data.table![index].mCAP,
                              openPrice: data.table![index].price,
                              prevClose: data.table![index].prevPrice,
                              volume: data.table![index].volume,
                              value: data.table![index].vALUE,
                              perChange: data.table![index].perChange,
                              lowPrice: data.table![index].low,
                              highPrice: data.table![index].high,
                              closePriceRecvd: data.table![index].price))));
                },
                child: CommonTrends(
                  title1: data.table![index].sYMBOL!,
                  subtitle1: convertedDateTime,
                  title2: data.table![index].price!,
                  subtitle2: "Vol:${data.table![index].volume!}",
                  title3: percentageChange.toStringAsFixed(1),
                  subtitle3: "(${data.table![index].perChange!} %)",
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                thickness: 1.5,
              );
            },
          ),
        ),
        !userHasSubscription
            ? SizedBox(height: 180.h)
            : SizedBox(
                height: 37.h,
              )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class ActiveByVolume extends StatefulWidget {
  const ActiveByVolume({
    Key? key,
  }) : super(key: key);

  @override
  State<ActiveByVolume> createState() => _ActiveByVolumeState();
}

class _ActiveByVolumeState extends State<ActiveByVolume>
    with AutomaticKeepAliveClientMixin<ActiveByVolume> {
  StreamController<ActiveByValueModel> topGainerLoserController =
      StreamController();
  final searchController = TextEditingController();
  bool searchingStarted = false;

  @override
  void dispose() {
    topGainerLoserController.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 2), (timer) {
      active_by_vol();
    });
  }

  prefix.Dio dio = new prefix.Dio();

  Future<ResponseData> active_by_vol() async {
    prefix.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    try {
      response = await dio.get(
          "https://stock.accordwebservices.com/BSEStockXV/GetVolumeToppers?ExCode=BE49H6S&Group=all&IndexCode=45&Top=&Option=&PageNo=1&Pagesize=10&SortExpression=&SortDirection=&token=wG2axAvNa3yX3DT89CHVHyg2x19TOZE5",
          options: prefix.Options(headers: {"authorization": "Bearer $token"}));
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      // var decodeddata = jsonDecode(response.data);
      var data = ActiveByValueModel.fromJson(response.data);
      if (!topGainerLoserController.isClosed)
        topGainerLoserController.sink.add(data);

      return ResponseData<dynamic>(
        "success",
        ResponseStatus.SUCCESS,
      );
    } else {
      try {
        return ResponseData<dynamic>(
            response.data['message'].toString(), ResponseStatus.FAILED);
      } catch (_) {
        return ResponseData<dynamic>(
            response.statusMessage!, ResponseStatus.FAILED);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ActiveByValueModel>(
        stream: topGainerLoserController.stream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: Lottie.asset(
                  "assets/images/lf30_editor_jc6n8oqe.json",
                  repeat: true,
                  height: 50,
                  width: 50,
                ),
              );

            default:
              if (snapshot.hasError) {
                return Text("Error Occured");
              } else {
                return snapshot.data!.table!.isEmpty
                    ? _buildNoDataBody()
                    : _buildBody(snapshot.data!);
              }
          }
        });
  }

  Widget _buildNoDataBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("No Data Found"),
      ],
    );
  }

  Widget _buildBody(ActiveByValueModel data) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            addAutomaticKeepAlives: true,
            itemCount: data.table!.length,
            itemBuilder: (BuildContext context, int index) {
              String dateStart = data.table![index].uPDTIME!;
              DateFormat inputFormat = DateFormat('dd/MM/yyyy hh:mm:ss a');
              DateTime now = inputFormat.parse(dateStart);
              String convertedDateTime =
                  "${DateFormat.MMM().format(now)} ${now.day.toString().padLeft(2, '0')}, ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";

              return GestureDetector(
                onTap: () {
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                  searchController.clear();
                  setState(() {
                    searchingStarted = false;
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => StockGraph(
                              bseTicker: data.table![index].sYMBOL ?? "",
                              fincode: data.table![index].fINCODE,
                              sName: data.table![index].sNAME,
                              mCap: data.table![index].mCAP,
                              openPrice: data.table![index].price,
                              prevClose: data.table![index].prevPrice,
                              volume: data.table![index].volume,
                              value: data.table![index].vALUE,
                              perChange: data.table![index].perChange,
                              lowPrice: data.table![index].low,
                              highPrice: data.table![index].high,
                              closePriceRecvd: data.table![index].price))));
                },
                child: CommonTrends(
                  title1: data.table![index].sYMBOL!,
                  subtitle1: convertedDateTime,
                  title2: data.table![index].price!,
                  subtitle2: "Vol:${data.table![index].volume!}",
                  title3: data.table![index].change!,
                  subtitle3: "(${data.table![index].perChange!} %)",
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                thickness: 1.5,
              );
            },
          ),
        ),
        !userHasSubscription
            ? SizedBox(height: 180.h)
            : SizedBox(
                height: 37.h,
              )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class Week52 extends StatefulWidget {
  const Week52({
    Key? key,
  }) : super(key: key);

  @override
  State<Week52> createState() => _Week52State();
}

class _Week52State extends State<Week52>
    with AutomaticKeepAliveClientMixin<Week52> {
  StreamController<Week52Model> topGainerLoserController = StreamController();
  final searchController = TextEditingController();
  bool searchingStarted = false;
  @override
  void dispose() {
    topGainerLoserController.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 2), (timer) {
      week52();
    });
  }

  prefix.Dio dio = new prefix.Dio();

  Future<ResponseData> week52() async {
    prefix.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    try {
      response = await dio.get(
          "https://stock.accordwebservices.com/BSEStockXV/GetHighsnLows?ExCode=BE49H6S&Group=all&IndexCode=46&Option=52week&HighOrLow=High&Top=&PageNo=1&Pagesize=10&SortExpression=&SortDirection=asc&token=wG2axAvNa3yX3DT89CHVHyg2x19TOZE5",
          options: prefix.Options(headers: {"authorization": "Bearer $token"}));
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      var data = Week52Model.fromJson(response.data);
      if (!topGainerLoserController.isClosed)
        topGainerLoserController.sink.add(data);

      return ResponseData<dynamic>(
        "success",
        ResponseStatus.SUCCESS,
      );
    } else {
      try {
        return ResponseData<dynamic>(
            response.data['message'].toString(), ResponseStatus.FAILED);
      } catch (_) {
        return ResponseData<dynamic>(
            response.statusMessage!, ResponseStatus.FAILED);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Week52Model>(
        stream: topGainerLoserController.stream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: Lottie.asset(
                  "assets/images/lf30_editor_jc6n8oqe.json",
                  repeat: true,
                  height: 50,
                  width: 50,
                ),
              );

            default:
              if (snapshot.hasError) {
                return Text("Error Occured");
              } else {
                return snapshot.data!.table!.isEmpty
                    ? _buildNoDataBody()
                    : _buildBody(snapshot.data!);
              }
          }
        });
  }

  Widget _buildNoDataBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("No Data Found"),
      ],
    );
  }

  Widget _buildBody(Week52Model data) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            addAutomaticKeepAlives: true,
            itemCount: data.table!.length,
            itemBuilder: (BuildContext context, int index) {
              String dateStart = data.table![index].uPDTIME!;
              DateFormat inputFormat = DateFormat('dd-MMM-yyyy');
              DateTime now = inputFormat.parse(dateStart);
              String convertedDateTime =
                  "${DateFormat.MMM().format(now)} ${now.day.toString().padLeft(2, '0')}";

              return GestureDetector(
                onTap: () {
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                  searchController.clear();
                  setState(() {
                    searchingStarted = false;
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => StockGraph(
                              bseTicker: data.table![index].sYMBOL ?? "",
                              fincode: data.table![index].fINCODE,
                              sName: data.table![index].sNAME,
                              //  mCap: data.table![index].mCAP,
                              openPrice: data.table![index].openPrice,
                              // prevClose: data.table![index].prevPrice,
                              volume: data.table![index].volume,
                              value: data.table![index].value,
                              perChange: data.table![index].perChange,
                              lowPrice: data.table![index].lOWPrice,
                              highPrice: data.table![index].highPrice,
                              closePriceRecvd: data.table![index].lastPrice))));
                },
                child: CommonTrends(
                  title1: data.table![index].sYMBOL!,
                  subtitle1: convertedDateTime,
                  title2: data.table![index].lastPrice!,
                  subtitle2: "Vol:${data.table![index].volume!}",
                  title3: data.table![index].change!,
                  subtitle3: "(${data.table![index].perChange!} %)",
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                thickness: 1.5,
              );
            },
          ),
        ),
        !userHasSubscription
            ? SizedBox(height: 180.h)
            : SizedBox(
                height: 37.h,
              )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class Week52Low extends StatefulWidget {
  const Week52Low({
    Key? key,
  }) : super(key: key);

  @override
  State<Week52Low> createState() => _Week52LowState();
}

class _Week52LowState extends State<Week52Low>
    with AutomaticKeepAliveClientMixin<Week52Low> {
  StreamController<Week52Model> topGainerLoserController = StreamController();
  final searchController = TextEditingController();
  bool searchingStarted = false;
  @override
  void dispose() {
    topGainerLoserController.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 2), (timer) {
      week52Low();
    });
  }

  prefix.Dio dio = new prefix.Dio();

  Future<ResponseData> week52Low() async {
    prefix.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    try {
      response = await dio.get(
          "https://stock.accordwebservices.com/BSEStockXV/GetHighsnLows?ExCode=BE49H6S&Group=all&IndexCode=46&Option=52week&HighOrLow=Low&Top=&PageNo=1&Pagesize=10&SortExpression=&SortDirection=asc&token=wG2axAvNa3yX3DT89CHVHyg2x19TOZE5",
          options: prefix.Options(headers: {"authorization": "Bearer $token"}));
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      var data = Week52Model.fromJson(response.data);
      if (!topGainerLoserController.isClosed)
        topGainerLoserController.sink.add(data);

      return ResponseData<dynamic>(
        "success",
        ResponseStatus.SUCCESS,
      );
    } else {
      try {
        return ResponseData<dynamic>(
            response.data['message'].toString(), ResponseStatus.FAILED);
      } catch (_) {
        return ResponseData<dynamic>(
            response.statusMessage!, ResponseStatus.FAILED);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Week52Model>(
        stream: topGainerLoserController.stream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: Lottie.asset(
                  "assets/images/lf30_editor_jc6n8oqe.json",
                  repeat: true,
                  height: 50,
                  width: 50,
                ),
              );

            default:
              if (snapshot.hasError) {
                return Text("Error Occured");
              } else {
                return snapshot.data!.table!.isEmpty
                    ? _buildNoDataBody()
                    : _buildBody(snapshot.data!);
              }
          }
        });
  }

  Widget _buildNoDataBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("No Data Found"),
      ],
    );
  }

  Widget _buildBody(Week52Model data) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            addAutomaticKeepAlives: true,
            itemCount: data.table!.length,
            itemBuilder: (BuildContext context, int index) {
              String dateStart = data.table![index].uPDTIME!;
              DateFormat inputFormat = DateFormat('dd-MMM-yyyy');
              DateTime now = inputFormat.parse(dateStart);
              String convertedDateTime =
                  "${DateFormat.MMM().format(now)} ${now.day.toString().padLeft(2, '0')}";

              return GestureDetector(
                onTap: () {
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                  searchController.clear();
                  setState(() {
                    searchingStarted = false;
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => StockGraph(
                              bseTicker: data.table![index].sYMBOL ?? "",
                              fincode: data.table![index].fINCODE,
                              sName: data.table![index].sNAME,
                              //  mCap: data.table![index].mCAP,
                              openPrice: data.table![index].openPrice,
                              // prevClose: data.table![index].prevPrice,
                              volume: data.table![index].volume,
                              value: data.table![index].value,
                              perChange: data.table![index].perChange,
                              lowPrice: data.table![index].lOWPrice,
                              highPrice: data.table![index].highPrice,
                              closePriceRecvd: data.table![index].lastPrice))));
                },
                child: CommonTrends(
                  title1: data.table![index].sYMBOL!,
                  subtitle1: convertedDateTime,
                  title2: data.table![index].lastPrice!,
                  subtitle2: "Vol:${data.table![index].volume!}",
                  title3: data.table![index].change!,
                  subtitle3: "(${data.table![index].perChange!} %)",
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                thickness: 1.5,
              );
            },
          ),
        ),
        !userHasSubscription
            ? SizedBox(height: 180.h)
            : SizedBox(
                height: 37.h,
              )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class OnlyBuyers extends StatefulWidget {
  const OnlyBuyers({
    Key? key,
  }) : super(key: key);

  @override
  State<OnlyBuyers> createState() => _OnlyBuyersState();
}

class _OnlyBuyersState extends State<OnlyBuyers>
    with AutomaticKeepAliveClientMixin<OnlyBuyers> {
  StreamController<OnlyBuyersModel> topGainerLoserController =
      StreamController();
  final searchController = TextEditingController();
  bool searchingStarted = false;

  @override
  void dispose() {
    topGainerLoserController.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 2), (timer) {
      onlyBuyers();
    });
  }

  prefix.Dio dio = new prefix.Dio();

  Future<ResponseData> onlyBuyers() async {
    prefix.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    try {
      response = await dio.get(
          "https://stock.accordwebservices.com/BSEStockXV/GetOnlyBuyernSellers?ExCode=BE49H6S&Group=&SectorCode=&IndexCode=46&Option=B&Top=&PageNo=1&Pagesize=10&SortExpression=&SortDirection=&token=wG2axAvNa3yX3DT89CHVHyg2x19TOZE5",
          options: prefix.Options(headers: {"authorization": "Bearer $token"}));
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      var data = OnlyBuyersModel.fromJson(response.data);
      if (!topGainerLoserController.isClosed)
        topGainerLoserController.sink.add(data);

      return ResponseData<dynamic>(
        "success",
        ResponseStatus.SUCCESS,
      );
    } else {
      try {
        return ResponseData<dynamic>(
            response.data['message'].toString(), ResponseStatus.FAILED);
      } catch (_) {
        return ResponseData<dynamic>(
            response.statusMessage!, ResponseStatus.FAILED);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<OnlyBuyersModel>(
        stream: topGainerLoserController.stream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: Lottie.asset(
                  "assets/images/lf30_editor_jc6n8oqe.json",
                  repeat: true,
                  height: 50,
                  width: 50,
                ),
              );

            default:
              if (snapshot.hasError) {
                return Text("Error Occured");
              } else {
                return snapshot.data!.table!.isEmpty
                    ? _buildNoDataBody()
                    : _buildBody(snapshot.data!);
              }
          }
        });
  }

  Widget _buildNoDataBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("No Data Found"),
      ],
    );
  }

  Widget _buildBody(OnlyBuyersModel data) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            addAutomaticKeepAlives: true,
            itemCount: data.table!.length,
            itemBuilder: (BuildContext context, int index) {
              // String dateStart = data.table![index].uPDTIME!;
              // DateFormat inputFormat = DateFormat('dd-MMM-yyyy');
              // DateTime now = inputFormat.parse(dateStart);
              // String convertedDateTime =
              //     "${DateFormat.MMM().format(now)} ${now.day.toString().padLeft(2, '0')}";

              return GestureDetector(
                onTap: () {
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                  searchController.clear();
                  setState(() {
                    searchingStarted = false;
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => StockGraph(
                              bseTicker: data.table![index].sYMBOL ?? "",
                              fincode: data.table![index].fINCODE,
                              sName: data.table![index].sNAME,
                              //  mCap: data.table![index].mCAP,
                              // openPrice: data.table![index].openPrice,
                              prevClose: data.table![index].prevClose,
                              volume: data.table![index].volume,
                              // value: data.table![index].vALUE,
                              perChange: data.table![index].perChng,
                              //  lowPrice: data.table![index].lOWPrice,
                              //  highPrice: data.table![index].highPrice,
                              closePriceRecvd: data.table![index].lastPrice))));
                },
                child: CommonTrends(
                  title1: data.table![index].sYMBOL!,
                  // subtitle1: convertedDateTime,
                  title2: data.table![index].lastPrice!,
                  subtitle2: "Vol:${data.table![index].volume!}",
                  title3: data.table![index].chng!,
                  subtitle3: "(${data.table![index].perChng!} %)",
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                thickness: 1.5,
              );
            },
          ),
        ),
        !userHasSubscription
            ? SizedBox(height: 180.h)
            : SizedBox(
                height: 37.h,
              )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class OnlySellers extends StatefulWidget {
  const OnlySellers({
    Key? key,
  }) : super(key: key);

  @override
  State<OnlySellers> createState() => _OnlySellersState();
}

class _OnlySellersState extends State<OnlySellers>
    with AutomaticKeepAliveClientMixin<OnlySellers> {
  StreamController<OnlyBuyersModel> topGainerLoserController =
      StreamController();
  final searchController = TextEditingController();
  bool searchingStarted = false;

  @override
  void dispose() {
    topGainerLoserController.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 2), (timer) {
      onlySellers();
    });
  }

  prefix.Dio dio = new prefix.Dio();

  Future<ResponseData> onlySellers() async {
    prefix.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    try {
      response = await dio.get(
          "https://stock.accordwebservices.com/BSEStockXV/GetOnlyBuyernSellers?ExCode=BE49H6S&Group=&SectorCode=&IndexCode=46&Option=S&Top=&PageNo=1&Pagesize=10&SortExpression=&SortDirection=&token=wG2axAvNa3yX3DT89CHVHyg2x19TOZE5",
          options: prefix.Options(headers: {"authorization": "Bearer $token"}));
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      var data = OnlyBuyersModel.fromJson(response.data);
      if (!topGainerLoserController.isClosed)
        topGainerLoserController.sink.add(data);

      return ResponseData<dynamic>(
        "success",
        ResponseStatus.SUCCESS,
      );
    } else {
      try {
        return ResponseData<dynamic>(
            response.data['message'].toString(), ResponseStatus.FAILED);
      } catch (_) {
        return ResponseData<dynamic>(
            response.statusMessage!, ResponseStatus.FAILED);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<OnlyBuyersModel>(
        stream: topGainerLoserController.stream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: Lottie.asset(
                  "assets/images/lf30_editor_jc6n8oqe.json",
                  repeat: true,
                  height: 50,
                  width: 50,
                ),
              );

            default:
              if (snapshot.hasError) {
                return Text("Error Occured");
              } else {
                return snapshot.data!.table!.isEmpty
                    ? _buildNoDataBody()
                    : _buildBody(snapshot.data!);
              }
          }
        });
  }

  Widget _buildNoDataBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("No Data Found"),
      ],
    );
  }

  Widget _buildBody(OnlyBuyersModel data) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            addAutomaticKeepAlives: true,
            itemCount: data.table!.length,
            itemBuilder: (BuildContext context, int index) {
              // String dateStart = data.table![index].uPDTIME!;
              // DateFormat inputFormat = DateFormat('dd-MMM-yyyy');
              // DateTime now = inputFormat.parse(dateStart);
              // String convertedDateTime =
              //     "${DateFormat.MMM().format(now)} ${now.day.toString().padLeft(2, '0')}";

              return GestureDetector(
                onTap: () {
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                  searchController.clear();
                  setState(() {
                    searchingStarted = false;
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => StockGraph(
                              bseTicker: data.table![index].sYMBOL ?? "",
                              fincode: data.table![index].fINCODE,
                              sName: data.table![index].sNAME,
                              //  mCap: data.table![index].mCAP,
                              // openPrice: data.table![index].openPrice,
                              prevClose: data.table![index].prevClose,
                              volume: data.table![index].volume,
                              // value: data.table![index].vALUE,
                              perChange: data.table![index].perChng,
                              //  lowPrice: data.table![index].lOWPrice,
                              //  highPrice: data.table![index].highPrice,
                              closePriceRecvd: data.table![index].lastPrice))));
                },
                child: CommonTrends(
                  title1: data.table![index].sYMBOL!,
                  // subtitle1: convertedDateTime,
                  title2: data.table![index].lastPrice!,
                  subtitle2: "Vol:${data.table![index].volume!}",
                  title3: data.table![index].chng!,
                  subtitle3: "(${data.table![index].perChng!} %)",
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                thickness: 1.5,
              );
            },
          ),
        ),
        !userHasSubscription
            ? SizedBox(height: 180.h)
            : SizedBox(
                height: 37.h,
              )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
/*
class MutualFundsWatchlist extends StatelessWidget {
  const MutualFundsWatchlist({
    Key? key,
    required this.title1,
    required this.subtitle1,
    required this.title2,
    required this.image,
  }) : super(key: key);

  final String title1;
  final String subtitle1;
  final String title2;
  final String image;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => StockGraph())));
            },
            child: 
            MutualFundsElement(
              image: 'assets/images/icici.png',
              title1: "ICICI Prudential Technology \nDirect Plan SM",
              subtitle1: "Equity Sectoral / Thematic",
              title2: "34.75%",
            ),
            
      )],
       
        ));
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            "My Mutual Fund",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        )
        Expanded(child: ListView())
      ],
    );
    /*
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 10,
              ),
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Text(
                      "Advisory Mutual Fund",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    Spacer(),
                    SvgPicture.asset(
                      "assets/images/sort_black_24dp.svg",
                      width: 17,
                      color: Color(0xFFF78104),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                      "3 Years",
                      style: blackStyle(context)
                          .copyWith(fontSize: 10, color: Color(0xFF303030)),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              child: Column(
                children: const [
                  Commonsmutulfunds(
                    image: 'assets/images/icici.png',
                    title1: "ICICI Prudential Technology \nDirect Plan SM",
                    subtitle1: "Equity Sectoral / Thematic",
                    title2: "34.75%",
                  ),
                  Commonsmutulfunds(
                    image: 'assets/images/icici.png',
                    title1: "ICICI Prudential Technology \nDirect Plan SM",
                    subtitle1: "Equity Sectoral / Thematic",
                    title2: "34.75%",
                  ),
                  Commonsmutulfunds(
                    image: 'assets/images/icici.png',
                    title1: "ICICI Prudential Technology \nDirect Plan SM",
                    subtitle1: "Equity Sectoral / Thematic",
                    title2: "34.75%",
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 10,
              ),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  "My Mutual Fund",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Column(
              children: const [
                Commonsmutulfunds(
                  image: 'assets/images/icici.png',
                  title1: "ICICI Prudential Technology \nDirect Plan SM",
                  subtitle1: "Equity Sectoral / Thematic",
                  title2: "34.75%",
                ),
                Commonsmutulfunds(
                  image: 'assets/images/icici.png',
                  title1: "ICICI Prudential Technology \nDirect Plan SM",
                  subtitle1: "Equity Sectoral / Thematic",
                  title2: "34.75%",
                ),
                Commonsmutulfunds(
                  image: 'assets/images/icici.png',
                  title1: "ICICI Prudential Technology \nDirect Plan SM",
                  subtitle1: "Equity Sectoral / Thematic",
                  title2: "34.75%",
                ),
                Commonsmutulfunds(
                  image: 'assets/images/icici.png',
                  title1: "ICICI Prudential Technology \nDirect Plan SM",
                  subtitle1: "Equity Sectoral / Thematic",
                  title2: "34.75%",
                ),
              ],
            ),
            SizedBox(
              height: 130.h,
            )
          ],
        ),
      ),
    );
  */
  }
}
*/

class CommonTrends extends StatelessWidget {
  const CommonTrends({
    Key? key,
    required this.title1,
    this.subtitle1 = "",
    required this.title2,
    required this.subtitle2,
    required this.title3,
    required this.subtitle3,
  }) : super(key: key);

  final String title1;
  final String subtitle1;
  final String title2;
  final String subtitle2;
  final String title3;
  final String subtitle3;

  // @override
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: SizedBox(
        child: Container(
          decoration: BoxDecoration(
            // border: Border(
            //   bottom: BorderSide(
            //     color: Color.fromARGB(130, 104, 104, 104),
            //   ),
            //   // bottom: BorderSide(color: Colors.black),
            // ),
            color: Get.isDarkMode
                ? Color(0xFF303030).withOpacity(0.4)
                : Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        //   width: 70,
                        child: Text(
                          title1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.sm,
                            color: Get.isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      Text(
                        subtitle1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11.sm,
                          color:
                              Get.isDarkMode ? Colors.white : Color(0xFF464646),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        //   width: 70,
                        child: Text(
                          "₹ $title2",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.sm,
                            color: Get.isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      Text(
                        subtitle2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11.sm,
                          color:
                              Get.isDarkMode ? Colors.white : Color(0xFF464646),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title3,
                        textAlign: TextAlign.center,
                        style: title3.contains('-')
                            ? TextStyle(
                                fontSize: 16.sm,
                                color: Colors.red,
                              )
                            : TextStyle(
                                fontSize: 16.sm,
                                color: Color(0xFF2CAB41),
                              ),
                      ),
                      Text(subtitle3,
                          textAlign: TextAlign.center,
                          style: title3.contains('-')
                              ? TextStyle(
                                  fontSize: 11.sm,
                                  color: Colors.red,
                                )
                              : TextStyle(
                                  fontSize: 11.sm,
                                  color: Color(0xFF2CAB41),
                                )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StocksWatchlistElement extends StatelessWidget {
  const StocksWatchlistElement({
    Key? key,
    required this.title1,
    required this.subtitle1,
    required this.title2,
    required this.subtitle2,
    required this.title3,
    required this.subtitle3,
  }) : super(key: key);

  final String title1;
  final String subtitle1;
  final String title2;
  final String subtitle2;
  final String title3;
  final String subtitle3;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: SizedBox(
        child: Card(
          elevation: 0.0,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color.fromARGB(130, 104, 104, 104),
                ),
                // bottom: BorderSide(color: Colors.black),
              ),
              color: Get.isDarkMode
                  ? Color(0xFF303030).withOpacity(0.4)
                  : Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.sm,
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      Text(
                        subtitle1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11.sm,
                          color:
                              Get.isDarkMode ? Colors.white : Color(0xFF464646),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title2,
                      style: TextStyle(
                        fontSize: 16,
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    Text(
                      subtitle2,
                      style: TextStyle(
                        fontSize: 11,
                        color:
                            Get.isDarkMode ? Colors.white : Color(0xFF464646),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title3,
                      // textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF2CAB41),
                      ),
                    ),
                    Text(
                      subtitle3,
                      //    textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFF2CAB41),
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

/*
class StocksWatchlist extends StatelessWidget {
  const StocksWatchlist({required this.myWatchlistedStockModels, Key? key})
      : super(key: key);

  final List<WatchlistStockModel> myWatchlistedStockModels;

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Advisory Stocks",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                    fontSize: 18,
                  ),
                ),
                Text(
                  "Price",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Change(%)",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),

                ),
              ),
              Text(
                "Price",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              Text(
                "Change",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Get.isDarkMode ? Colors.white : Colors.black,

                  fontSize: 18,

                ),
              ),
            ],
          ),
        ),
        //advisory stocks
        Expanded(
            child: ListView(
          children: [
            StocksWatchlistElement(
              title1: "Shree Cements",
              subtitle1: "NSE: May 02, 12:55",
              title2: "24,058.30",
              subtitle2: "Vol: 6.30m",
              title3: "84.65",
              subtitle3: "+3.95%",
            ),
            StocksWatchlistElement(
              title1: "Shree Cements",
              subtitle1: "NSE: May 02, 12:55",
              title2: "24,058.30",
              subtitle2: "Vol: 6.30m",
              title3: "84.65",
              subtitle3: "+3.95%",
            ),
            StocksWatchlistElement(
              title1: "Shree Cements",
              subtitle1: "NSE: May 02, 12:55",
              title2: "24,058.30",
              subtitle2: "Vol: 6.30m",
              title3: "84.65",
              subtitle3: "+3.95%",
            ),
            StocksWatchlistElement(
              title1: "Shree Cements",
              subtitle1: "NSE: May 02, 12:55",
              title2: "24,058.30",
              subtitle2: "Vol: 6.30m",
              title3: "84.65",
              subtitle3: "+3.95%",
            ),
          ],
        )),
        /*
        Column(
          children: const [
            commonwatchlist(
              title1: "Shree Cements",
              title2: "24,058.30",
              title3: "84.65",
              subtitle1: "NSE: May 02, 12:55",
              subtitle2: "Vol: 6.30m",
              subtitle3: "+3.95%",
            ),
            commonwatchlist(
              title1: "Shree Cements",
              title2: "24,058.30",
              title3: "84.65",
              subtitle1: "NSE: May 02, 12:55",
              subtitle2: "Vol: 6.30m",
              subtitle3: "+3.95%",
            ),
            commonwatchlist(
              title1: "Indusland Bank",
              title2: "1,017.40",
              title3: "38.65",
              subtitle1: "NSE: May 02, 12:55",
              subtitle2: "Vol: 6.30m",
              subtitle3: "+3.95%",
            ),
          ],
        ),
        */
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10),
          child: SizedBox(
            width: double.infinity,
            child: Text(
              "My Watchlist",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Get.isDarkMode ? Colors.white : Colors.black,
                fontSize: 18,
              ),
            ),
          ),
        ),
        //my watchlist
        Expanded(
          child: ListView.builder(
              itemCount: myWatchlistStockList.length,
              itemBuilder: (context, index) =>
                  myWatchlistStockList.elementAt(index)),
        )
      ],
    );
  }
}
*/
