// ignore_for_file: file_names, unused_import

import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:piadvisory/Common/user_id.dart';
import 'package:piadvisory/HomePage/Mutual%20Funds/MutualFundsPlottableGraph.dart';
import 'package:piadvisory/HomePage/Stock/SampleChart.dart';
import 'package:piadvisory/HomePage/Stock/StocksRepository/MutualFundsAPImethods.dart';
import 'package:piadvisory/SideMenu/Brokerage/broker-login.dart';
import 'package:piadvisory/Utils/textStyles.dart';
import 'package:async/async.dart';
import 'package:piadvisory/api/watchlist/methods/watchlist_mutual_fund_api_methods.dart';
import 'package:piadvisory/api/watchlist/models/watchlist_mutual_fund_model.dart';

import '../../api/watchlist/models/watchlist_stock_model.dart';
import 'package:get/get.dart' as getx;

class MutualFundsGraph extends StatefulWidget {
  MutualFundsGraph({Key? key, this.schemeCode, this.appbartitle})
      : super(key: key);

  @override
  State<MutualFundsGraph> createState() => _MutualFundsGraphState();
  String? appbartitle;
  String? schemeCode;
}

class _MutualFundsGraphState extends State<MutualFundsGraph> {
  FutureGroup futureGroup = FutureGroup();

  bool showWatchlistBtn = true;
  bool showWatchlistBtnLoader = false;
  var userIdAndWatchlistedMutualFundsFutureGroup = FutureGroup();
  var watchlistMutualFundApiMethods = WatchlistMutualFundApiMethods();

  bool isWatchlisted = false;
  int? watchlistedMutualFundId;

  @override
  void initState() {
    print("scheme code is ${widget.schemeCode}");
    futureGroup.add(MutualFundsAPIMEthods().NAVGraph(widget.schemeCode!));
    futureGroup
        .add(MutualFundsAPIMEthods().MFSnapShotSummary(widget.schemeCode!));
    futureGroup.add(MutualFundsAPIMEthods().GetSchemeData(widget.schemeCode!));
    futureGroup
        .add(MutualFundsAPIMEthods().importTopholdings(widget.schemeCode!));
    futureGroup.close();
    //watchlist
    userIdAndWatchlistedMutualFundsFutureGroup.add(getUserId());
    userIdAndWatchlistedMutualFundsFutureGroup
        .add(watchlistMutualFundApiMethods.fetchWatchlistStocks());
    userIdAndWatchlistedMutualFundsFutureGroup.close();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    height: 150,
                    width: 150,
                  ),
                ),
              ],
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            setValues();
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occured',
                  style: TextStyle(fontSize: 18),
                ),
              );
            }
          }
          return _buildMainBody(
            context,
          );
        },
      ),
    );
  }

  List<String> dateList = [];
  List<String> priceList = [];
  String convertedDateTime = "";
  setValues() {
    for (var i = 0; i < priceData!.table!.length; i++) {
      dateList.add(priceData!.table![i].nAVDATE!);
      priceList.add(priceData!.table![i].nAVRS!);
    }

    String dateStart = schemeBasicData!.table!.first.nAVDATE!;
    DateFormat inputFormat = DateFormat('dd/MM/yyyy hh:mm:ss a');
    DateTime now = inputFormat.parse(dateStart);
    convertedDateTime =
        " ${now.day.toString().padLeft(2, '0')} ${DateFormat.MMM().format(now)} ${now.year.toString().padLeft(2, '0')}";
  }

//
  Widget _buildMainBody(context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: FutureBuilder<List>(
                future: userIdAndWatchlistedMutualFundsFutureGroup.future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    int userId = snapshot.data![0]!;
                    var data = snapshot.data![1]
                        as getx.Response<List<WatchlistMutualFundModel>>?;
                    WatchlistMutualFundModel? watchlistMutualFundModel;
                    if (data != null) {
                      try {
                        watchlistMutualFundModel = data.body!.singleWhere((e) =>
                            e.schemeCode == widget.schemeCode! &&
                            e.userId == userId);
                      } catch (e) {}
                      if (watchlistMutualFundModel != null) {
                        isWatchlisted = true;
                        watchlistedMutualFundId = watchlistMutualFundModel.id;
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
                                        watchlistMutualFundApiMethods
                                            .deleteMutualFundFromWatchlist(
                                                watchlistedMutualFundId!)
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
                                      watchlistMutualFundApiMethods
                                          .addMutualFundToWatchlist(
                                        userId: userId!,
                                        companyName: widget.appbartitle!,
                                        schemeCode: widget.schemeCode!,
                                      )
                                          .then((addRes) {
                                        debugPrint("ADD RES $addRes");
                                        if (addRes.statusCode == 200) {
                                          watchlistedMutualFundId =
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
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Cannot add to watchlist'),
                                            ),
                                          );
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
              )),
        ],
        bottom: PreferredSize(
            child: Row(
              children: [
                SizedBox(
                  width: 60,
                ),
                Text(
                  schemeBasicData!.table!.first.rISK!,
                  style: blackStyle(context).copyWith(fontSize: 12),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  " •  ${schemeBasicData!.table!.first.aSSETTYPE}",
                  style: blackStyle(context).copyWith(fontSize: 12),
                ),
              ],
            ),
            preferredSize: Size(20, 10)),

        flexibleSpace: Container(
          height: 50,
          decoration: const BoxDecoration(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,

        titleSpacing: 0,
        // centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: Text(
                widget.appbartitle!,
                softWrap: false,
                maxLines: 2,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontFamily: 'Product Sans',
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
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
      body: _buildBody(context, convertedDateTime),
    );
  }

  Widget _buildBody(context, convertedDateTime) {
    num threeYearReturns = 0;
    num oneYearReturns = 0;
    num fiveYearReturns = 0;
    num allYearReturns = 0;
    num yearReturns = 0;
    num netAssests = 0;
    try {
      allYearReturns = num.parse(schemeBasicData!.table!.first.iNCRET ?? "0");
      oneYearReturns = num.parse(schemeBasicData!.table!.first.s1YRRET ?? "0");
      threeYearReturns =
          num.parse(schemeBasicData!.table!.first.s3YEARRET ?? "0");
      fiveYearReturns =
          num.parse(schemeBasicData!.table!.first.s5YEARRET ?? "0");

      yearReturns = num.parse(schemeBasicData!.table!.first.s3YEARRET ?? "0");
      netAssests = num.parse(summaryData!.table!.first.netAsset ?? "0");
    } catch (e) {}

    final screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        threeYearReturns == 0
                            ? Row(
                                children: [
                                  Text(
                                    "${allYearReturns.toStringAsFixed(2)} %",
                                    style: blackStyle(context).copyWith(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Annualised")
                                ],
                              )
                            : Row(
                                children: [
                                  Text(
                                    "${threeYearReturns.toStringAsFixed(2)} %",
                                    style: blackStyle(context).copyWith(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("3Y Annualised")
                                ],
                              ),
                      ],
                    ),
                    // SizedBox(
                    //   height: 30,
                    //   child: TextButton(
                    //     onPressed: () {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: ((context) => Brokerlogin())));
                    //     },
                    //     child: Text(
                    //       "Invest Now",
                    //       style: blackStyle(context)
                    //           .copyWith(color: Colors.white, fontSize: 14),
                    //     ),
                    //     style: ButtonStyle(
                    //         backgroundColor: MaterialStateProperty.all<Color>(
                    //           Color(0xFF008083),
                    //         ),
                    //         shape: MaterialStateProperty.all<
                    //                 RoundedRectangleBorder>(
                    //             const RoundedRectangleBorder(
                    //                 borderRadius:
                    //                     BorderRadius.all(Radius.circular(5)),
                    //                 side: BorderSide(
                    //                     color: Color(0xFF008083), width: 2)))),
                    //   ),
                    // )
                  ],
                ),
              ),
              SizedBox(
                  height: screenSize.width,
                  width: screenSize.width,
                  child: MutualFundsPlottableGraph(
                    dateList: dateList,
                    priceList: priceList,
                  )),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nav $convertedDateTime",
                        style: blackStyle(context)
                            .copyWith(fontSize: 12, color: Color(0xFF6B6B6B)),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "₹ ${schemeBasicData!.table!.first.nAV}",
                        style:
                            blackStyle(context).copyWith(color: Colors.black),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Min.SIP amount",
                        style: blackStyle(context)
                            .copyWith(fontSize: 12, color: Color(0xFF6B6B6B)),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "₹ ${summaryData!.table!.first.miniRedumptAmnt}",
                        style:
                            blackStyle(context).copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Rating",
                        style: blackStyle(context)
                            .copyWith(fontSize: 12, color: Color(0xFF6B6B6B)),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "NA",
                        style:
                            blackStyle(context).copyWith(color: Colors.black),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Fund Size",
                        style: blackStyle(context)
                            .copyWith(fontSize: 12, color: Color(0xFF6B6B6B)),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "₹ ${netAssests.toStringAsFixed(2)} Cr",
                        style:
                            blackStyle(context).copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Divider(
                thickness: 1,
              ),
              SizedBox(
                height: 10,
              ),
              // Text(
              //   "Monthly orders trend",
              //   style: blackStyle(context)
              //       .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: const [
              //         Text("SIP orders"),
              //         Text("90.8%"),
              //       ],
              //     ),
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.end,
              //       children: const [
              //         Text("One-time orders"),
              //         Text("9.2%"),
              //       ],
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 6,
              // ),
              // LinearPercentIndicator(
              //   lineHeight: 2,
              //   percent: 0.8,
              //   backgroundColor: Colors.grey,
              //   progressColor: Colors.blue,
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
            ],
          ),
        ),
        Accordion(
          disableScrolling: true,

          maxOpenSections: 6,
          scaleWhenAnimating: true,
          openAndCloseAnimation: true,
          // headerPadding:
          //     const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
          sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
          sectionClosingHapticFeedback: SectionHapticFeedback.light,
          children: [
            AccordionSection(
              isOpen: true,
              headerBackgroundColor: Color(0xFFFCFAFA),
              headerBackgroundColorOpened: Color(0xFFF2F9F9),
              contentBackgroundColor: Color(0xFFF2F9F9),
              contentBorderColor: Color(0xFFF2F9F9),
              contentBorderRadius: 0,
              headerBorderRadius: 0,
              rightIcon: Icon(Icons.keyboard_arrow_down, size: 20),
              header: Text(
                'Returns & Ranking',
              ),
              content: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Category: ${schemeBasicData!.table!.first.cATEGORYNAME}",
                          style: blackStyle(context).copyWith(fontSize: 12),
                        ),
                      ),
                      SvgPicture.asset("assets/images/Annualisted.svg"),
                      SizedBox(
                        width: 5,
                      ),
                      SvgPicture.asset("assets/images/updownarrow.svg"),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: Text(
                          "",
                          style: blackStyle(context).copyWith(fontSize: 12),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "1Y",
                          style: blackStyle(context).copyWith(fontSize: 12),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "3Y",
                          style: blackStyle(context).copyWith(fontSize: 12),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "5Y",
                          style: blackStyle(context).copyWith(fontSize: 12),
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: Text(
                          "All",
                          style: blackStyle(context).copyWith(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: Text(
                          "Fund Returns(%)",
                          style: blackStyle(context).copyWith(fontSize: 12),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "${oneYearReturns.toStringAsFixed(2)}",
                          style: blackStyle(context).copyWith(fontSize: 12),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "${threeYearReturns.toStringAsFixed(2)}",
                          style: blackStyle(context).copyWith(fontSize: 12),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "${fiveYearReturns.toStringAsFixed(2)}",
                          style: blackStyle(context).copyWith(fontSize: 12),
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: Text(
                          "${allYearReturns.toStringAsFixed(2)}",
                          style: blackStyle(context).copyWith(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       flex: 6,
                  //       child: Text(
                  //         "Category Avg.",
                  //         style: blackStyle(context).copyWith(fontSize: 12),
                  //       ),
                  //     ),
                  //     Expanded(
                  //       flex: 2,
                  //       child: Text(
                  //         "92.4",
                  //         style: blackStyle(context).copyWith(fontSize: 12),
                  //       ),
                  //     ),
                  //     Expanded(
                  //       flex: 2,
                  //       child: Text(
                  //         "56.2",
                  //         style: blackStyle(context).copyWith(fontSize: 12),
                  //       ),
                  //     ),
                  //     Expanded(
                  //       flex: 2,
                  //       child: Text(
                  //         "45",
                  //         style: blackStyle(context).copyWith(fontSize: 12),
                  //       ),
                  //     ),
                  //     Expanded(
                  //       flex: 0,
                  //       child: Text(
                  //         "24.9",
                  //         style: blackStyle(context).copyWith(fontSize: 12),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
              contentHorizontalPadding: 20,
              // onOpenSection: () => print('onOpenSection ...'),
              // onCloseSection: () => print('onCloseSection ...'),
            ),
            AccordionSection(
              isOpen: true,
              headerBackgroundColor: Color(0xFFFCFAFA),
              headerBackgroundColorOpened: Color(0xFFF2F9F9),
              contentBackgroundColor: Color(0xFFF2F9F9),
              contentBorderColor: Color(0xFFF2F9F9),
              contentBorderRadius: 0,
              headerBorderRadius: 0,
              rightIcon: Icon(Icons.keyboard_arrow_down, size: 20),
              header: Text(
                'Holding',
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Top 10 Holdings",
                          style: blackStyle(context).copyWith(fontSize: 12),
                        ),
                      ),
                      SvgPicture.asset("assets/images/Assets.svg"),
                      SizedBox(
                        width: 5,
                      ),
                      SvgPicture.asset("assets/images/updownarrow.svg"),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: topHoldings!.table!.length,
                      itemBuilder: (BuildContext context, int index) {
                        num topholdings =
                            num.parse(topHoldings!.table![index].holdPer!);
                        return Column(
                          children: [
                            CommonHoldingsRow(
                              title: topHoldings!.table![index].compname,
                              subtitle: topholdings.toStringAsFixed(2),
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        );
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // SvgPicture.asset("assets/images/seeholdings.svg"),
                ],
              ),
              contentHorizontalPadding: 20,
              // onOpenSection: () => print('onOpenSection ...'),
              // onCloseSection: () => print('onCloseSection ...'),
            ),
            //   AccordionSection(
            //     isOpen: true,
            //     headerBackgroundColor: Color(0xFFFCFAFA),
            //     headerBackgroundColorOpened: Color(0xFFF2F9F9),
            //     contentBackgroundColor: Color(0xFFF2F9F9),
            //     contentBorderColor: Color(0xFFF2F9F9),
            //     contentBorderRadius: 0,
            //     headerBorderRadius: 0,
            //     rightIcon: Icon(Icons.keyboard_arrow_down, size: 20),
            //     header: Text(
            //       'Expense ratio,exit load & tax',
            //     ),
            //     content: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         SizedBox(
            //           height: 10,
            //         ),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [],
            //         ),
            //         Text(
            //           "• Expense ration: 0.71%",
            //           style: blackStyle(context).copyWith(fontSize: 12),
            //         ),
            //         SizedBox(
            //           height: 5,
            //         ),
            //         Padding(
            //           padding: const EdgeInsets.only(left: 8.0),
            //           child: Text(
            //             "Inclusive of GST",
            //             style: blackStyle(context).copyWith(fontSize: 10),
            //           ),
            //         ),
            //         SizedBox(
            //           height: 10,
            //         ),
            //         Text(
            //           "• Exit Load",
            //           style: blackStyle(context).copyWith(fontSize: 12),
            //         ),
            //         SizedBox(
            //           height: 5,
            //         ),
            //         Padding(
            //           padding: const EdgeInsets.only(left: 8.0),
            //           child: Text(
            //             "Exit load of 1% if redeemed withing 15 days",
            //             style: blackStyle(context).copyWith(fontSize: 10),
            //           ),
            //         ),
            //         SizedBox(
            //           height: 10,
            //         ),
            //         Text(
            //           "• Stamp Duty on investment",
            //           style: blackStyle(context).copyWith(fontSize: 12),
            //         ),
            //         SizedBox(
            //           height: 5,
            //         ),
            //         Padding(
            //           padding: const EdgeInsets.only(left: 8.0),
            //           child: Text(
            //             "0.005% (from July 1st. 2020)",
            //             style: blackStyle(context).copyWith(fontSize: 10),
            //           ),
            //         ),
            //         SizedBox(
            //           height: 10,
            //         ),
            //         Text(
            //           "• Tax implications",
            //           style: blackStyle(context).copyWith(fontSize: 12),
            //         ),
            //         SizedBox(
            //           height: 5,
            //         ),
            //         Padding(
            //           padding: const EdgeInsets.only(left: 8.0),
            //           child: Text(
            //             "Returns are taxed at 15% if you redeem before one year, After 1 year, you are required to pay LTCG of 10% returns of Rs 1 Lakh+ in a financial year.",
            //             style: blackStyle(context).copyWith(fontSize: 10),
            //           ),
            //         ),
            //       ],
            //     ),
            //     contentHorizontalPadding: 20,
            //     // onOpenSection: () => print('onOpenSection ...'),
            //     // onCloseSection: () => print('onCloseSection ...'),
            //   ),
            //   AccordionSection(
            //     isOpen: true,
            //     headerBackgroundColor: Color(0xFFFCFAFA),
            //     headerBackgroundColorOpened: Color(0xFFF2F9F9),
            //     contentBackgroundColor: Color(0xFFF2F9F9),
            //     contentBorderColor: Color(0xFFF2F9F9),
            //     contentBorderRadius: 0,
            //     headerBorderRadius: 0,
            //     rightIcon: Icon(Icons.keyboard_arrow_down, size: 20),
            //     header: Text(
            //       'Fund Management',
            //     ),
            //     content: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Expanded(
            //               child: Text(
            //                 "Priyanka Khandelwal",
            //                 style: blackStyle(context).copyWith(fontSize: 12),
            //               ),
            //             ),
            //             SvgPicture.asset("assets/images/Show Details.svg"),
            //             SizedBox(
            //               width: 5,
            //             ),
            //             SvgPicture.asset(
            //                 "assets/images/Icon ionic-ios-arrow-back.svg")
            //           ],
            //         ),
            //         SizedBox(
            //           height: 5,
            //         ),
            //         Text(
            //           "July 2007- Present",
            //           style: blackStyle(context).copyWith(fontSize: 10),
            //         ),
            //         SizedBox(
            //           height: 20,
            //         ),
            //         Text(
            //           "Education",
            //           style: blackStyle(context).copyWith(fontSize: 10),
            //         ),
            //         SizedBox(
            //           height: 5,
            //         ),
            //         Text(
            //           "Ms. Khandelwal is chartered Accountant and Company Secretary",
            //           style: blackStyle(context).copyWith(fontSize: 10),
            //         ),
            //         SizedBox(
            //           height: 20,
            //         ),
            //         Text(
            //           "Experience",
            //           style: blackStyle(context).copyWith(fontSize: 10),
            //         ),
            //         SizedBox(
            //           height: 5,
            //         ),
            //         Text(
            //           "She has been working with ICICI Preduential Mutual Fund Since October 2014",
            //           style: blackStyle(context).copyWith(fontSize: 10),
            //         ),
            //       ],
            //     ),
            //     contentHorizontalPadding: 20,
            //     // onOpenSection: () => print('onOpenSection ...'),
            //     // onCloseSection: () => print('onCloseSection ...'),
            //   ),
            //   AccordionSection(
            //     isOpen: true,
            //     headerBackgroundColor: Color(0xFFFCFAFA),
            //     headerBackgroundColorOpened: Color(0xFFF2F9F9),
            //     contentBackgroundColor: Color(0xFFF2F9F9),
            //     contentBorderColor: Color(0xFFF2F9F9),
            //     contentBorderRadius: 0,
            //     headerBorderRadius: 0,
            //     rightIcon: Icon(Icons.keyboard_arrow_down, size: 20),
            //     header: Text(
            //       'Fund house & Investment objective',
            //     ),
            //     content: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Expanded(
            //               child: Text(
            //                 "Rank (total assests)",
            //                 style: blackStyle(context).copyWith(fontSize: 12),
            //               ),
            //             ),
            //             Text(
            //               "#3 in India",
            //               style: blackStyle(context).copyWith(fontSize: 12),
            //             ),
            //           ],
            //         ),
            //         SizedBox(
            //           height: 10,
            //         ),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Text(
            //               "Total assests under management",
            //               style: blackStyle(context).copyWith(fontSize: 12),
            //             ),
            //             Text(
            //               "₹4,70,644 Cr.",
            //               style: blackStyle(context).copyWith(fontSize: 12),
            //             ),
            //           ],
            //         ),
            //         SizedBox(
            //           height: 10,
            //         ),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Expanded(
            //               child: Text(
            //                 "Date of Incorporation",
            //                 style: blackStyle(context).copyWith(fontSize: 12),
            //               ),
            //             ),
            //             Text(
            //               "12 October, 1993",
            //               style: blackStyle(context).copyWith(fontSize: 12),
            //             ),
            //             SizedBox(
            //               height: 10,
            //             ),
            //           ],
            //         ),
            //         SizedBox(
            //           height: 20,
            //         ),
            //         Text(
            //           "Investment Objective",
            //           style: blackStyle(context).copyWith(fontSize: 12),
            //         ),
            //         SizedBox(
            //           height: 10,
            //         ),
            //         Text(
            //           "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut consectetur ipsum aliquam, convallis urna a, hendrerit turpis. Nam eget luctus diam. Integer quam magna, consectetur eget condimentum nec, ",
            //           style: blackStyle(context).copyWith(fontSize: 10),
            //         ),
            //       ],
            //     ),
            //     contentHorizontalPadding: 20,
            //     // onOpenSection: () => print('onOpenSection ...'),
            //     // onCloseSection: () => print('onCloseSection ...'),
            //   ),
          ],
        ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 20, right: 20),
        //   child: IntrinsicHeight(
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         SvgPicture.asset("assets/images/Recently Viewed.svg"),
        //         SizedBox(
        //           height: 20,
        //         ),
        //         Divider(
        //           thickness: 1,
        //         ),
        //         Row(
        //           children: [
        //             Expanded(
        //               child: Text(
        //                 "ICICI Prudential Technology Direct Plan Growth",
        //                 style: blackStyle(context).copyWith(fontSize: 16),
        //               ),
        //             ),
        //             Expanded(
        //               flex: 0,
        //               child: Column(
        //                 children: [
        //                   Text(
        //                     "34.75%",
        //                     style: blackStyle(context)
        //                         .copyWith(fontSize: 16, color: Colors.green),
        //                   ),
        //                   SizedBox(
        //                     height: 5,
        //                   ),
        //                   Text(
        //                     "3 Years",
        //                     style: blackStyle(context)
        //                         .copyWith(fontSize: 12, color: Colors.green),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ],
        //         ),
        //         SizedBox(
        //           height: 10,
        //         ),
        //         Divider(
        //           thickness: 1,
        //         ),
        //         Row(
        //           children: [
        //             Expanded(
        //               child: Text(
        //                 "Canara Robeco Bluechip Equity Fund - Regular Plan - Growth",
        //                 style: blackStyle(context).copyWith(fontSize: 16),
        //               ),
        //             ),
        //             Expanded(
        //               flex: 0,
        //               child: Column(
        //                 children: [
        //                   Text(
        //                     "16.99%",
        //                     style: blackStyle(context)
        //                         .copyWith(fontSize: 16, color: Colors.green),
        //                   ),
        //                   SizedBox(
        //                     height: 5,
        //                   ),
        //                   Text(
        //                     "3 Years",
        //                     style: blackStyle(context)
        //                         .copyWith(fontSize: 12, color: Colors.green),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ],
        //         ),
        //         SizedBox(
        //           height: 10,
        //         ),
        //         Divider(
        //           thickness: 1,
        //         ),
        //         Row(
        //           children: [
        //             Expanded(
        //               child: Text(
        //                 "Canara Robeco Bluechip Equity Fund - Regular Plan - Growth",
        //                 style: blackStyle(context).copyWith(fontSize: 16),
        //               ),
        //             ),
        //             Expanded(
        //               flex: 0,
        //               child: Column(
        //                 children: [
        //                   Text(
        //                     "16.99%",
        //                     style: blackStyle(context)
        //                         .copyWith(fontSize: 16, color: Colors.green),
        //                   ),
        //                   SizedBox(
        //                     height: 5,
        //                   ),
        //                   Text(
        //                     "3 Years",
        //                     style: blackStyle(context)
        //                         .copyWith(fontSize: 12, color: Colors.green),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ],
        //         ),
        //         SizedBox(
        //           height: 40,
        //         )
        //       ],
        //     ),
        //   ),
        // )
      ],
    ));
  }
}

class CommonHoldingsRow extends StatelessWidget {
  CommonHoldingsRow({Key? key, this.title, this.subtitle})
      : super(
          key: key,
        );
  String? title;
  String? subtitle;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            title!,
            style: blackStyle(context).copyWith(fontSize: 12),
          ),
        ),
        Flexible(
          child: Text(
            subtitle!,
            style: blackStyle(context).copyWith(fontSize: 12),
          ),
        ),
      ],
    );
  }
}
