import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:piadvisory/SideMenu/Subscribe/Repository/getSubscriptionWithDetails.dart';
import 'package:piadvisory/api/watchlist/methods/watchlist_mutual_fund_api_methods.dart';
import 'package:piadvisory/api/watchlist/models/watchlist_mutual_fund_model.dart';

import '../Common/user_id.dart';
import '../HomePage/Mutual Funds/MutualFundsGraph.dart';
import '../Utils/textStyles.dart';
import '../api/watchlist/methods/watchlist_stock_api_methods.dart';
import 'package:async/async.dart';

class MutualFundsWatchlist extends StatefulWidget {
  const MutualFundsWatchlist({super.key});

  @override
  State<MutualFundsWatchlist> createState() => _MutualFundsWatchlistState();
}

class _MutualFundsWatchlistState extends State<MutualFundsWatchlist> {
  var watchlistMutualFundApiMethods = WatchlistMutualFundApiMethods();

  late FutureGroup userIdAndWatchlistedMutualFundFutureGroup;

  var watchlistedMutualFundsStreamController = StreamController();

  void setStream() {
    userIdAndWatchlistedMutualFundFutureGroup = FutureGroup();
    userIdAndWatchlistedMutualFundFutureGroup.add(getUserId());
    userIdAndWatchlistedMutualFundFutureGroup
        .add(watchlistMutualFundApiMethods.fetchWatchlistStocks());
    userIdAndWatchlistedMutualFundFutureGroup.close();
    watchlistedMutualFundsStreamController.addStream(
        Stream.fromFuture(userIdAndWatchlistedMutualFundFutureGroup.future));
  }

  @override
  void initState() {
    super.initState();
    setStream();
  }

  bool showDelBtn = true;
  bool showDelBtnLoader = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        children: [
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Advisory Mutual Funds",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // SvgPicture.asset(
              //   "assets/images/sort_black_24dp.svg",
              //   width: 17,
              //   color: Color(0xFFF78104),
              // ),
              // SizedBox(
              //   width: 3,
              // ),
              // Text(
              //   "3 Years",
              //   style: blackStyle(context).copyWith(
              //       fontSize: 10,
              //       color: Get.isDarkMode ? Colors.white : Color(0xFF303030)),
              // )
            ],
          ),
          SizedBox(height: 8),
          Divider(
              height: 2,
              thickness: 2,
              color: Color.fromARGB(130, 104, 104, 104)),
          LimitedBox(
            maxHeight: 70.0,
            child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => MutualFundsGraph(
                                  appbartitle:
                                      "IDBI India Top 100 Equity Fund(G)",
                                  schemeCode: "16706"))));
                    },
                    child: MutualFundsWatchlistElement())),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Watchlisted Mutual Funds",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // SvgPicture.asset(
              //   "assets/images/sort_black_24dp.svg",
              //   width: 17,
              //   color: Color(0xFFF78104),
              // ),
              // SizedBox(
              //   width: 3,
              // ),
              // Text(
              //   "3 Years",
              //   style: blackStyle(context).copyWith(
              //       fontSize: 10,
              //       color: Get.isDarkMode ? Colors.white : Color(0xFF303030)),
              // )
            ],
          ),
          SizedBox(height: 8),
          Divider(
              height: 2,
              thickness: 2,
              color: Color.fromARGB(130, 104, 104, 104)),
          Expanded(
            child: StreamBuilder(
              stream: watchlistedMutualFundsStreamController.stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active &&
                    snapshot.hasData) {
                  var snapshotData = snapshot.data! as List;
                  int userId = snapshotData[0];
                  var stocksWatchlistResponse = snapshotData[1]
                      as Response<List<WatchlistMutualFundModel>>;
                  List<WatchlistMutualFundModel> watchlistedStocks =
                      stocksWatchlistResponse.body!;
                  List<WatchlistMutualFundModel> myWatchlistedStocks = [];
                  try {
                    myWatchlistedStocks.addAll(
                        watchlistedStocks.where((e) => e.userId == userId));
                  } catch (e) {}
                  if (myWatchlistedStocks.isEmpty)
                    return Center(child: Text("No Mutual Funds Watchlisted"));
                  return ListView.builder(
                    itemCount: myWatchlistedStocks.length,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(MutualFundsGraph(
                                      schemeCode: myWatchlistedStocks
                                          .elementAt(index)
                                          .schemeCode,
                                      appbartitle: myWatchlistedStocks
                                          .elementAt(index)
                                          .companyName,
                                    ));
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        myWatchlistedStocks
                                            .elementAt(index)
                                            .companyName,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.sm,
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        myWatchlistedStocks
                                            .elementAt(index)
                                            .schemeCode,
                                        style: TextStyle(fontSize: 11.sm),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                  watchlistMutualFundApiMethods
                                      .deleteMutualFundFromWatchlist(
                                          myWatchlistedStocks
                                              .elementAt(index)
                                              .id)
                                      .then((response) {
                                    Navigator.pop(context);
                                    if (response.statusCode == 200) {
                                      setStream();
                                    }
                                  });
                                },
                                icon: Icon(Icons.bookmark_added),
                              )
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color.fromARGB(130, 104, 104, 104),
                          )
                        ],
                      );
                    },
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
          !userHasSubscription
              ? SizedBox(
                  height: 160.h,
                )
              : SizedBox(
                  height: 5.h,
                )
        ],
      ),
    );
  }
}

class MutualFundsWatchlistElement extends StatelessWidget {
  const MutualFundsWatchlistElement({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color.fromARGB(130, 104, 104, 104),
            ),
          ),
          color: Get.isDarkMode
              ? Color(0xFF303030).withOpacity(0.4)
              : Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("IDBI India Top", style: TextStyle(color: Colors.black)),
              Text("17.78", style: TextStyle(color: Color(0xFF2CAB41))),
            ],
          ),
        ));
  }
}
