import 'dart:async';

import 'package:dio/dio.dart' as prefix;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:async/async.dart';
import 'package:lottie/lottie.dart';
import 'package:piadvisory/Common/user_id.dart';
import 'package:piadvisory/HomePage/Stock/Model/IntradayPriceChartModel.dart';
import 'package:piadvisory/HomePage/Stock/SearchedStockGraph.dart';
import 'package:piadvisory/SideMenu/Subscribe/Repository/getSubscriptionWithDetails.dart';
import 'package:piadvisory/Utils/base_manager.dart';
import 'package:intl/intl.dart' show DateFormat;
import '../HomePage/Stock/StockGraph.dart';
import '../api/watchlist/methods/watchlist_stock_api_methods.dart';
import '../api/watchlist/models/watchlist_stock_model.dart';

class StocksWatchlist extends StatefulWidget {
  const StocksWatchlist({super.key});

  @override
  State<StocksWatchlist> createState() => _StocksWatchlistState();
}

class _StocksWatchlistState extends State<StocksWatchlist> {
  WatchlistStockApiMethods watchlistStockApiMethods =
      WatchlistStockApiMethods();

  late FutureGroup userIdAndWatchlistedStocksFutureGroup;

  var watchlistedStocksStreamController = StreamController();
  StreamController<IntradayPriceChartModel> streamPriceController =
      StreamController();
  void setStream() {
    userIdAndWatchlistedStocksFutureGroup = FutureGroup();
    userIdAndWatchlistedStocksFutureGroup.add(getUserId());
    userIdAndWatchlistedStocksFutureGroup
        .add(watchlistStockApiMethods.fetchWatchlistStocks());
    userIdAndWatchlistedStocksFutureGroup.close();
    watchlistedStocksStreamController.addStream(
        Stream.fromFuture(userIdAndWatchlistedStocksFutureGroup.future));
  }

  @override
  void initState() {
    super.initState();
    setStream();
    IntradatePriceChart();
  }

  bool showDelBtn = true;
  bool showDelBtnLoader = false;
  prefix.Dio dio = new prefix.Dio();
  late IntradayPriceChartModel intraPriceData;
  Future<ResponseData> IntradatePriceChart() async {
    prefix.Response response;

    try {
      response = await dio.get(
        "https://stock.accordwebservices.com/BSEStockXV/GetChartData?ExCode=BE49H6S&Type=I&FINCODE=100387&DateOption=M&DateCount=1&StartDate=&EndDate=&token=wG2axAvNa3yX3DT89CHVHyg2x19TOZE5",
      );
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      intraPriceData = IntradayPriceChartModel.fromJson(response.data);
      if (!streamPriceController.isClosed)
        streamPriceController.sink.add(intraPriceData);
      // print("price chart data is ${response.data}");
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        children: [
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Advisory Stocks",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                textAlign: TextAlign.left,
                "Price       ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              // Text(
              //   "Change",
              //   style: TextStyle(
              //     fontWeight: FontWeight.bold,
              //     color: Colors.black,
              //   ),
              // ),
            ],
          ),
          SizedBox(height: 8),
          Divider(
              height: 2,
              thickness: 2,
              color: Color.fromARGB(130, 104, 104, 104)),
          StreamBuilder<IntradayPriceChartModel>(
              stream: streamPriceController.stream,
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
                      String dateStart = intraPriceData.table!.last.date!;
                      DateFormat inputFormat =
                          DateFormat('dd/MM/yyyy hh:mm:ss a');
                      DateTime now = inputFormat.parse(dateStart);
                      String convertedDateTime =
                          "${DateFormat.MMM().format(now)} ${now.day.toString().padLeft(2, '0')}, ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";

                      return LimitedBox(
                        maxHeight: 70.0,
                        child: ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => SearchedStockGraph(
                                            bseTicker: "SHREECEM",
                                            fincode: "100387",
                                            sName: "Shree Cement",

                                            // openPrice: searchedList[index].,
                                            // prevClose: searchedList[index].pREVCLOSE,
                                            // volume: searchedList[index].vOLUME,
                                            // value: searchedList[index].vALUE,
                                            // perChange: searchedList[index].pERCHG,
                                            // lowPrice: searchedList[index].lOWPRICE,
                                            // highPrice: searchedList[index].hIGHPRICE,
                                          ))));
                            },
                            child: StocksWatchlistElement(
                              title1: "Shree Cements",
                              subtitle1: "May 02, 12:55",
                              title2: intraPriceData.table!.last.price!,
                              subtitle2:
                                  "Vol: ${intraPriceData.table!.last.volume}",
                              title3: "+84.65",
                              subtitle3: "(3.95%)",
                            ),
                          ),
                        ),
                      );
                    }
                }
              }),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Watchlisted Stocks",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                "", //price
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                "", //change
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Divider(
            height: 2,
            thickness: 2,
            color: Color.fromARGB(130, 104, 104, 104),
          ),
          Expanded(
            child: StreamBuilder(
              stream: watchlistedStocksStreamController.stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active &&
                    snapshot.hasData) {
                  var snapshotData = snapshot.data! as List;
                  int userId = snapshotData[0];
                  var stocksWatchlistResponse =
                      snapshotData[1] as Response<List<WatchlistStockModel>>;
                  List<WatchlistStockModel> watchlistedStocks =
                      stocksWatchlistResponse.body!;
                  List<WatchlistStockModel> myWatchlistedStocks = [];
                  try {
                    myWatchlistedStocks.addAll(
                        watchlistedStocks.where((e) => e.userId == userId));
                  } catch (e) {}
                  if (myWatchlistedStocks.isEmpty)
                    return Center(child: Text("No Stocks Watchlisted"));
                  return ListView.builder(
                    itemCount: myWatchlistedStocks.length,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.to(StockGraph(
                                    fincode: myWatchlistedStocks
                                        .elementAt(index)
                                        .fincode,
                                    sName: myWatchlistedStocks
                                        .elementAt(index)
                                        .companyName,
                                    bseTicker: myWatchlistedStocks
                                        .elementAt(index)
                                        .tickerCode,
                                  ));
                                },
                                child: Column(
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
                                          .tickerCode,
                                      style: TextStyle(fontSize: 11.sm),
                                    ),
                                  ],
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
                                  watchlistStockApiMethods
                                      .deleteStockFromWatchlist(
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
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color.fromARGB(130, 104, 104, 104),
          ),
        ),
        color:
            Get.isDarkMode ? Color(0xFF303030).withOpacity(0.4) : Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
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
                SizedBox(height: 2),
                Text(
                  subtitle1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11.sm,
                    color: Get.isDarkMode ? Colors.white : Color(0xFF464646),
                  ),
                ),
              ],
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
                SizedBox(height: 2),
                Text(
                  subtitle2,
                  style: TextStyle(
                    fontSize: 11,
                    color: Get.isDarkMode ? Colors.white : Color(0xFF464646),
                  ),
                ),
              ],
            ),
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Text(
            //       title3,
            //       style: const TextStyle(
            //         fontSize: 16,
            //         color: Color(0xFF2CAB41),
            //       ),
            //     ),
            //     SizedBox(height: 2),
            //     Text(
            //       subtitle3,
            //       style: TextStyle(
            //         fontSize: 11,
            //         color: Color(0xFF2CAB41),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
