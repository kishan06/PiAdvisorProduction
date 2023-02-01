// ignore_for_file: file_names

import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:piadvisory/Common/user_id.dart';
import 'package:piadvisory/HomePage/FinancialOverview.dart';
import 'package:piadvisory/HomePage/OurAnalysis.dart';
import 'package:piadvisory/HomePage/Stock/Model/IntradayPriceChartModel.dart';
import 'package:piadvisory/HomePage/Stock/Model/PriceChartModel.dart';
import 'package:piadvisory/HomePage/Stock/SampleChart.dart';

import 'package:piadvisory/HomePage/Stock/StocksRepository/MutualFundsAPImethods.dart';

import 'package:piadvisory/HomePage/insights.dart';
import 'package:piadvisory/Utils/base_manager.dart';
import 'package:piadvisory/Utils/textStyles.dart';
import 'package:piadvisory/api/watchlist/methods/watchlist_stock_api_methods.dart';
import 'package:piadvisory/api/watchlist/models/watchlist_stock_model.dart';
import 'package:scgateway_flutter_plugin/scgateway_flutter_plugin.dart';

import '../../SideMenu/Brokerage/broker-login.dart';
import '../../smallcase_api_methods.dart';
import 'package:get/get.dart' as getx;
import 'package:async/async.dart';

bool isonce = true;

class StockGraph extends StatefulWidget {
  StockGraph({
    Key? key,
    this.fincode,
    this.mCap,
    this.openPrice,
    this.perChange,
    this.prevClose,
    this.sName,
    this.value,
    this.volume,
    this.lowPrice,
    this.highPrice,
    this.bseTicker,
    this.closePriceRecvd,
  }) : super(key: key);

  String? fincode;
  String? sName;
  String? openPrice;
  String? prevClose;
  String? volume;
  String? value;
  String? perChange;
  String? mCap;
  String? lowPrice;
  String? highPrice;
  String? bseTicker;
  String? closePriceRecvd;
  @override
  State<StockGraph> createState() => _StockGraphState();
}

class _StockGraphState extends State<StockGraph> {
  late final Future? myFuture;

  bool showWatchlistBtn = true;
  bool showWatchlistBtnLoader = false;
  bool isWatchlisted = false;
  int? watchlistedStockId;
  var stockname = '';

  StreamController<PriceChartModel> streamController = StreamController();
  StreamController<IntradayPriceChartModel> streamPriceController =
      StreamController();

  var isonce = true;
  late PriceChartModel priceData;
  late IntradayPriceChartModel intraPriceData;
  WatchlistStockApiMethods watchlistStockApiMethods =
      WatchlistStockApiMethods();
  var userIdAndWatchlistedStocksFutureGroup = FutureGroup();

  bool showTradeBtn = true;
  bool showTradeBtnLoader = false;
  num? netAssests;
  void replaceBuyandSellBtnWithLoader() {
    setState(() {
      showTradeBtn = false;
      showTradeBtnLoader = true;
    });
  }

  void replaceLoaderWithBuyandSellBtn() {
    setState(() {
      showTradeBtn = true;
      showTradeBtnLoader = false;
    });
  }

  @override
  void initState() {
    print("fincode is ${widget.fincode}");
    stockname = widget.sName ?? '';
    userIdAndWatchlistedStocksFutureGroup.add(getUserId());
    userIdAndWatchlistedStocksFutureGroup
        .add(watchlistStockApiMethods.fetchWatchlistStocks());
    userIdAndWatchlistedStocksFutureGroup.close();
    netAssests = num.parse(widget.mCap ?? "0");
    Timer.periodic(Duration(seconds: 3), (timer) {
      priceChart();
      IntradatePriceChart();
    });

    super.initState();
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }

  Dio dio = new Dio();

  Future<ResponseData> priceChart() async {
    Response response;

    try {
      response = await dio.get(
        "https://stock.accordwebservices.com/BSEStockXV/GetChartData?ExCode=BE49H6S&Type=H&FINCODE=${widget.fincode}&DateOption=M&DateCount=1&StartDate=&EndDate=&token=wG2axAvNa3yX3DT89CHVHyg2x19TOZE5",
      );
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      priceData = PriceChartModel.fromJson(response.data);
      if (!streamController.isClosed) streamController.sink.add(priceData);
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

  Future<ResponseData> IntradatePriceChart() async {
    Response response;

    try {
      response = await dio.get(
        "https://stock.accordwebservices.com/BSEStockXV/GetChartData?ExCode=BE49H6S&Type=I&FINCODE=${widget.fincode}&DateOption=M&DateCount=1&StartDate=&EndDate=&token=wG2axAvNa3yX3DT89CHVHyg2x19TOZE5",
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
    debugPrint("BSE TICKER: ${widget.bseTicker}");
    return Scaffold(
      appBar: AppBar(
        actions: [
          // FlutterSwitch(
          //   activeText: "NSE",
          //   inactiveText: "BSE",
          //   toggleColor: Colors.white,
          //   activeColor: const Color(0xFF008083),
          //   inactiveColor: Colors.grey,
          //   value: something,
          //   valueFontSize: 13.0,
          //   width: 65,
          //   height: 25,
          //   borderRadius: 30.0,
          //   showOnOff: true,
          //   onToggle: (val) {
          //     setState(() {
          //       something = val;
          //     });
          //   },
          // ),
          Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: FutureBuilder<List>(
                future: userIdAndWatchlistedStocksFutureGroup.future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    int userId = snapshot.data![0]!;
                    var data = snapshot.data![1]
                        as getx.Response<List<WatchlistStockModel>>?;
                    WatchlistStockModel? watchlistStockModel;
                    if (data != null) {
                      try {
                        watchlistStockModel = data.body!.singleWhere((e) =>
                            e.tickerCode == widget.bseTicker &&
                            e.userId == userId);
                      } catch (e) {}
                      if (watchlistStockModel != null) {
                        isWatchlisted = true;
                        watchlistedStockId = watchlistStockModel.id;
                      }
                    }
                    return StatefulBuilder(
                      builder: (context, setWatchlistBtnState) {
                        return Row(
                          children: [
                            Visibility(
                              visible: showWatchlistBtn,
                              child: IconButton(
                                onPressed: () {
                                  if (isWatchlisted) {
                                    //remove from watchlist
                                    setWatchlistBtnState(() {
                                      showWatchlistBtn = false;
                                      showWatchlistBtnLoader = true;
                                    });
                                    getUserId().then(
                                      (userId) {
                                        watchlistStockApiMethods
                                            .deleteStockFromWatchlist(
                                                watchlistedStockId!)
                                            .then(
                                          (deleteRes) {
                                            if (deleteRes.statusCode == 200) {
                                              setWatchlistBtnState(() {
                                                showWatchlistBtn = true;
                                                showWatchlistBtnLoader = false;
                                                isWatchlisted = false;
                                              });
                                              ScaffoldMessenger.of(context)
                                                  .removeCurrentSnackBar();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      "Removed from watchlist"),
                                                ),
                                              );
                                            } else {
                                              setWatchlistBtnState(() {
                                                showWatchlistBtn = true;
                                                showWatchlistBtnLoader = false;
                                              });
                                              ScaffoldMessenger.of(context)
                                                  .removeCurrentSnackBar();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      "Cannot Remove from watchlist"),
                                                ),
                                              );
                                            }
                                          },
                                        );
                                      },
                                    );
                                  } else {
                                    //add to watchlist
                                    setWatchlistBtnState(() {
                                      showWatchlistBtn = false;
                                      showWatchlistBtnLoader = true;
                                    });
                                    getUserId().then((userId) {
                                      watchlistStockApiMethods
                                          .addStockToWatchlist(
                                        userId: userId!,
                                        companyName: widget.sName!,
                                        tickerCode: widget.bseTicker!,
                                        fincode: widget.fincode!,
                                      )
                                          .then((addRes) {
                                        if (addRes.statusCode == 200) {
                                          watchlistedStockId =
                                              addRes.body as int;
                                          setWatchlistBtnState(() {
                                            isWatchlisted = true;
                                            showWatchlistBtn = true;
                                            showWatchlistBtnLoader = false;
                                          });
                                          ScaffoldMessenger.of(context)
                                              .removeCurrentSnackBar();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'Added to watchlist')));
                                        } else {
                                          setWatchlistBtnState(() {
                                            isWatchlisted = false;
                                            showWatchlistBtn = true;
                                            showWatchlistBtnLoader = false;
                                          });
                                          ScaffoldMessenger.of(context)
                                              .removeCurrentSnackBar();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'Cannot add to watchlist')));
                                        }
                                      });
                                    });
                                  }
                                },
                                icon: Icon(
                                  isWatchlisted
                                      ? Icons.bookmark_added
                                      : Icons.bookmark_outline,
                                ),
                              ),
                            ),
                            Visibility(
                              visible: showWatchlistBtnLoader,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2.5),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                  return SizedBox();
                },
              ))
        ],
        flexibleSpace: Container(
          height: 50,
          decoration: const BoxDecoration(),
        ),

        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,

        titleSpacing: 0,
        // centerTitle: true,
        title: Text(
          stockname,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Product Sans',
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
          ),
          iconSize: 22,
          color: Color(0xFF6B6B6B),
        ),
      ),
      body: StreamBuilder<PriceChartModel>(
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
                  return _buildBody(context, snapshot.data!);
                }
            }
          }),
    );
  }

  List<String> dateList = [];
  List<String> priceList = [];
  setValues() {
    if (isonce) {
      for (var i = 0; i < priceData.table!.length; i++) {
        dateList.add(priceData.table![i].date!);
        priceList.add(priceData.table![i].price!);
      }
      print("date val is ${dateList.length}");
      isonce = false;
    }
  }

  Widget _buildBody(context, PriceChartModel priceData) {
    String percentage = widget.perChange ?? "";
    final screenSize = MediaQuery.of(context).size;
    setValues();
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                                return Text(
                                  intraPriceData.table!.last.price ?? "",
                                  style: blackStyle(context).copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                );
                              }
                          }
                        }),
                    Text("${percentage}%",
                        style: percentage.contains('-')
                            ? blackStyle(context).copyWith(color: Colors.red)
                            : blackStyle(context)
                                .copyWith(color: Colors.green)),
                  ],
                ),
                StatefulBuilder(builder: (context, tradeBtnState) {
                  debugPrint('TICKER: ${widget.bseTicker}');
                  return Row(
                    children: [
                      Visibility(
                        visible: showTradeBtn,
                        child: Row(
                          children: [
                            SizedBox(
                              height: 30,
                              child: ElevatedButton(
                                onPressed: () {
                                  tradeBtnState(
                                    () {
                                      replaceBuyandSellBtnWithLoader();
                                    },
                                  );
                                  Timer.periodic(Duration(seconds: 8), (timer) {
                                    tradeBtnState(
                                      () {
                                        replaceLoaderWithBuyandSellBtn();
                                      },
                                    );
                                    timer.cancel();
                                  });
                                  fetchAuthToken().then((fetchedAuthToken) {
                                    fetchBrokerConnectTxnId(
                                            authToken: fetchedAuthToken)
                                        .then(
                                      (txnId) =>
                                          ScgatewayFlutterPlugin.initGateway(
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
                                                debugPrint(
                                                    "authToken: $authToken");
                                                debugPrint(
                                                    "brokerName: $brokerName");
                                                debugPrint("txnId: $txnId");
                                                String body =
                                                    '{"intent":"TRANSACTION","orderConfig":{"type":"SECURITIES","securities":[{"ticker":"${widget.bseTicker}","quantity":1,"type":"BUY"}]}}';
                                                fetchStocksOrderTxnId(
                                                        authToken, body)
                                                    .then((stocksOrderTxnId) =>
                                                        ScgatewayFlutterPlugin
                                                                .triggerGatewayTransaction(
                                                                    stocksOrderTxnId)
                                                            .then((value) {
                                                          debugPrint(
                                                              "Stocks Order res $value");
                                                          tradeBtnState(
                                                            () {
                                                              showTradeBtn =
                                                                  true;
                                                              showTradeBtnLoader =
                                                                  false;
                                                            },
                                                          );
                                                        }));
                                              }
                                            }
                                          },
                                        ),
                                      ),
                                    );
                                  });
                                },
                                child: Text("BUY"),
                              ),
                            ),
                            SizedBox(width: 8),
                            SizedBox(
                              height: 30,
                              child: ElevatedButton(
                                onPressed: () {
                                  tradeBtnState(
                                    () {
                                      replaceBuyandSellBtnWithLoader();
                                    },
                                  );
                                  Timer.periodic(Duration(seconds: 8), (timer) {
                                    tradeBtnState(
                                      () {
                                        replaceLoaderWithBuyandSellBtn();
                                      },
                                    );
                                    timer.cancel();
                                  });
                                  fetchAuthToken().then((fetchedAuthToken) {
                                    fetchBrokerConnectTxnId(
                                            authToken: fetchedAuthToken)
                                        .then(
                                      (txnId) =>
                                          ScgatewayFlutterPlugin.initGateway(
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
                                                debugPrint(
                                                    "authToken: $authToken");
                                                debugPrint(
                                                    "brokerName: $brokerName");
                                                debugPrint("txnId: $txnId");
                                                String body =
                                                    '{"intent":"TRANSACTION","orderConfig":{"type":"SECURITIES","securities":[{"ticker":"${widget.bseTicker}","quantity":1,"type":"SELL"}]}}';
                                                fetchStocksOrderTxnId(
                                                        authToken, body)
                                                    .then((stocksOrderTxnId) =>
                                                        ScgatewayFlutterPlugin
                                                                .triggerGatewayTransaction(
                                                                    stocksOrderTxnId)
                                                            .then((value) {
                                                          debugPrint(
                                                              "Stocks Order res $value");
                                                          tradeBtnState(
                                                            () {
                                                              showTradeBtn =
                                                                  true;
                                                              showTradeBtnLoader =
                                                                  false;
                                                            },
                                                          );
                                                        }));
                                              }
                                            }
                                          },
                                        ),
                                      ),
                                    );
                                  });
                                },
                                child: Text("SELL"),
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Color(0xFF008083),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
/*
                      //trade btn
                      Visibility(
                        visible: showTradeBtn,
                        child: SizedBox(
                          height: 30,
                          child: TextButton(
                            onPressed: () {
                              tradeBtnState(() {
                                showTradeBtn = false;
                                showTradeBtnLoader = true;
                              });
                              fetchAuthToken().then((fetchedAuthToken) {
                                debugPrint(
                                    "fetchedAuthToken $fetchedAuthToken");
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
                                        tradeBtnState(() {
                                          showTradeBtn = true;
                                          showTradeBtnLoader = false;
                                        });
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
                                                '{"intent":"TRANSACTION","orderConfig":{"type":"SECURITIES","securities":[{"ticker":"${widget.bseTicker!}","quantity":1,"type":"BUY"}]}}';
                                            fetchStocksOrderTxnId(
                                                    authToken, body)
                                                .then((stocksOrderTxnId) =>
                                                    ScgatewayFlutterPlugin
                                                            .triggerGatewayTransaction(
                                                                stocksOrderTxnId)
                                                        .then((value) {
                                                      debugPrint(
                                                          "Stocks Order res $value");
                                                      tradeBtnState(() {
                                                        showTradeBtn = true;
                                                        showTradeBtnLoader =
                                                            false;
                                                      });
                                                    }));
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                );
                              });
                            },
                            child: Text(
                              "Trade Now",
                              style: blackStyle(context)
                                  .copyWith(color: Colors.white, fontSize: 14),
                            ),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Color(0xFF008083),
                                ),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        side: BorderSide(
                                            color: Color(0xFF008083),
                                            width: 2)))),
                          ),
                        ),
                      ),
*/
                      Visibility(
                        visible: showTradeBtnLoader,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 46),
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              color: Color(0xFF008083),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                })
              ],
            ),
          ),
          SizedBox(
              height: screenSize.width,
              width: screenSize.width,
              child: SampleChart(
                lastMonthDate: priceData.table!.first.date!,
                dateList: dateList,
                priceList: priceList,
              )),
          const SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Text(
                          "Overview",
                          style: blackStyle(context).copyWith(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            //decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      Container(
                        height: 2,
                        color: Colors.amber,
                      )
                    ],
                  ),
                  // const SizedBox(
                  //   width: 5,
                  // ),
                  // const VerticalDivider(
                  //   indent: 5,
                  //   thickness: 2,
                  // ),
                  // const SizedBox(
                  //   width: 5,
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: ((context) => const OurAnalysis())));
                  //   },
                  //   child: Text(
                  //     "Our Analysis",
                  //     style: blackStyle(context).copyWith(fontSize: 14),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   width: 5,
                  // ),
                  // const VerticalDivider(
                  //   indent: 5,
                  //   thickness: 2,
                  // ),
                  // const SizedBox(
                  //   width: 5,
                  // ),
                  // GestureDetector(
                  //   onTap: (() {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: ((context) => const Insights())));
                  //   }),
                  //   child: Text(
                  //     "Insights",
                  //     style: blackStyle(context).copyWith(fontSize: 14),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   width: 5,
                  // ),
                  // const VerticalDivider(
                  //   indent: 5,
                  //   thickness: 2,
                  // ),
                  // const SizedBox(
                  //   width: 5,
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: ((context) =>
                  //                 const FinancialOverview())));
                  //   },
                  //   child: Text(
                  //     "Financial Overview",
                  //     style: blackStyle(context).copyWith(fontSize: 14),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            "Performance",
            style: blackStyle(context).copyWith(fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Todays Low",
                  ),
                  Text(widget.lowPrice ?? "NA"),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("Todays High"),
                  Text(widget.highPrice ?? "NA"),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          LinearPercentIndicator(
            lineHeight: 2,
            percent: double.parse(widget.lowPrice ?? "0.0") /
                double.parse(widget.highPrice ?? "0.0"),
            backgroundColor: Colors.grey,
            progressColor: Color(0xFF008083),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Open",
                    style: blackStyle(context)
                        .copyWith(fontSize: 12, color: Color(0xFF707070)),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(widget.openPrice ?? "NA"),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Prev. Close",
                    style: blackStyle(context)
                        .copyWith(fontSize: 12, color: Color(0xFF707070)),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(widget.prevClose ?? "NA"),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Volume",
                    style: blackStyle(context)
                        .copyWith(fontSize: 12, color: Color(0xFF707070)),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(widget.volume ?? "NA"),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            thickness: 2,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Market Cap",
                    style: blackStyle(context)
                        .copyWith(fontSize: 12, color: Color(0xFF707070)),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "₹ ${netAssests?.toStringAsFixed(0) ?? "NA"} Cr",
                  ),
                ],
              ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Text(
              //       "Ask Price",
              //       style: blackStyle(context)
              //           .copyWith(fontSize: 12, color: Color(0xFF707070)),
              //     ),
              //     SizedBox(
              //       height: 5,
              //     ),
              //     Text("196.45"),
              //   ],
              // ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Value(Lacks)",
                    style: blackStyle(context)
                        .copyWith(fontSize: 12, color: Color(0xFF707070)),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(widget.value ?? "NA"),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            thickness: 2,
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    ));
  }
}
