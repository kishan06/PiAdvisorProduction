import 'dart:async';
import 'package:dio/dio.dart' as prefix;
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:outline_search_bar/outline_search_bar.dart';
import 'package:piadvisory/HomePage/FilterMutualFunds.dart';
import 'package:piadvisory/HomePage/Mutual%20Funds/MutualFundsGraph.dart';
import 'package:piadvisory/HomePage/Stock/Model/AllMutualFundsModel.dart';

import 'package:piadvisory/HomePage/Stock/Model/MutualFundRanking.dart';
import 'package:piadvisory/HomePage/Stock/StocksRepository/MutualFundsAPImethods.dart';
import 'package:piadvisory/SideMenu/Subscribe/Repository/getSubscriptionWithDetails.dart';
import 'package:piadvisory/Utils/base_manager.dart';
import 'package:piadvisory/Utils/textStyles.dart';

import 'package:shared_preferences/shared_preferences.dart';

class MutualFundsTab extends StatefulWidget {
  MutualFundsTab({Key? key}) : super(key: key);

  @override
  State<MutualFundsTab> createState() => _MutualFundsTabState();
}

String yearsFilter = '1 Year';

TextEditingController textController = TextEditingController();
String value = "";

class _MutualFundsTabState extends State<MutualFundsTab> {
  Future showMutualFilterDialog() async {
    FocusScope.of(context).unfocus();
    final data = await showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: const FilterMutualFunds(),
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

  late FocusNode myFocusNode;
  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    MutualFundsAPIMEthods().importAllMutualFunds();
    super.initState();
  }

  final searchController = TextEditingController();
  bool searchingStarted = false;
  List<MutualTable> filteredList = [];
  @override
  Widget build(BuildContext context) {
    myFocusNode = FocusNode();
    return SingleChildScrollView(
      child: Container(
        color: Get.isDarkMode ? Colors.black : Colors.white,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      // clipBehavior: Clip.none,
                      children: [
                        OutlineSearchBar(
                          focusNode: myFocusNode,
                          borderColor: Color(0xFF6E6E6E),
                          onKeywordChanged: (value) {
                            setState(() {
                              searchController.text.isNotEmpty
                                  ? searchingStarted = true
                                  : searchingStarted = false;

                              filteredList = allSchemes!.table!
                                  .where(
                                    (element) =>
                                        element.sNAME!.toLowerCase().contains(
                                              value.toLowerCase(),
                                            ),
                                  )
                                  .toList();
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
                                    child: SizedBox(
                                      height: 50,
                                      child: ListView.separated(
                                        itemCount: filteredList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return SingleChildScrollView(
                                            child: ListTile(
                                              title: Text(
                                                  filteredList[index].sNAME!),
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
                                                            MutualFundsGraph(
                                                                appbartitle:
                                                                    filteredList[
                                                                            index]
                                                                        .sNAME!,
                                                                schemeCode:
                                                                    filteredList[
                                                                            index]
                                                                        .sCHEMECODE!))));
                                              },
                                            ),
                                          );
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return Divider(
                                            thickness: 1.5,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            DefaultTabController(
              length: 5,
              child: Column(
                children: [
                  TabBar(
                    labelColor: Colors.black,
                    indicatorColor: Color(0xFFF78104),
                    isScrollable: true,
                    unselectedLabelStyle: TextStyle(color: Color(0xFF6B6B6B)),
                    labelStyle: TextStyle(
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 30,
                    ),
                    tabs: const [
                      Tab(
                        text: "Large Cap",
                      ),
                      Tab(
                        text: "Flexi Cap",
                      ),
                      Tab(
                        text: "Mid Cap",
                      ),
                      Tab(
                        text: "Large & Mid Cap",
                      ),
                      Tab(
                        text: "Small Cap",
                      ),
                    ],
                    indicatorWeight: 1.5,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 25.5,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Top Mutual Funds",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SvgPicture.asset(
                          "assets/images/sort_black_24dp.svg",
                          width: 17,
                          color: Color(0xFFF78104),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        PopupMenuButton(
                          //  initialValue: "1 Year",
                          offset: const Offset(0, 50),
                          color: Color(0xFF6b6b6b),
                          tooltip: '',
                          icon: Text(
                            yearsFilter,
                            style: blackStyle(context).copyWith(
                                fontSize: 12.sm,
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Color(0xFF303030)),
                          ),
                          onSelected: (value) {
                            setState(() {
                              yearsFilter = value.toString();
                            });
                          },
                          itemBuilder: (BuildContext bc) {
                            return [
                              const PopupMenuItem(
                                child: Text(
                                  "1 Year",
                                  style: TextStyle(color: Colors.white),
                                ),
                                value: '1 Year',
                              ),
                              const PopupMenuItem(
                                child: Text(
                                  "3 Year",
                                  style: TextStyle(color: Colors.white),
                                ),
                                value: '3 Year',
                              ),
                              const PopupMenuItem(
                                child: Text(
                                  "5 Year",
                                  style: TextStyle(color: Colors.white),
                                ),
                                value: '5 Year',
                              )
                            ];
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: 500,
                      child: TabBarView(children: [
                        LargeCap(
                          yearsFilter: yearsFilter,
                        ),
                        FlexiCap(
                          yearsFilter: yearsFilter,
                        ),
                        MidCap(
                          yearsFilter: yearsFilter,
                        ),
                        LargeAndMidCap(
                          yearsFilter: yearsFilter,
                        ),
                        SmallCap(
                          yearsFilter: yearsFilter,
                        ),
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

class LargeCap extends StatefulWidget {
  LargeCap({super.key, required this.yearsFilter});
  String yearsFilter;
  @override
  State<LargeCap> createState() => _LargeCapState();
}

class _LargeCapState extends State<LargeCap>
with AutomaticKeepAliveClientMixin<LargeCap>
 {
  StreamController<MutalFundRanking> mutualFundController = StreamController();

  @override
  void dispose() {
    mutualFundController.close();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 2), (timer) {
      allMutualFunds();
    });
  }

  prefix.Dio dio = new prefix.Dio();

  Future<ResponseData> allMutualFunds() async {
    prefix.Response response;
    String yearsFil = "";
    switch (yearsFilter) {
      case "1 Year":
        {
          yearsFil = "1YEARRET";
        }
        break;
      case "3 Year":
        {
          yearsFil = "3YEARRET";
        }
        break;
      case "5 Year":
        {
          yearsFil = "5YEARRET";
        }
        break;

      default:
        throw Error();
    }

    try {
      response = await dio.get(
        "https://mf.accordwebservices.com/MF/MF_SHOW_FUNDRANKING?&Type=1&AMC=&Category=31&Return=$yearsFil&PageNo=1&Pagesize=10&SortExp=&SortDirection=&token=wG2axAvNa3yX3DT89CHVHyg2x19TOZE5",
      );
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      var data = MutalFundRanking.fromJson(response.data);

      if (!mutualFundController.isClosed) mutualFundController.sink.add(data);

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
    return StreamBuilder<MutalFundRanking>(
        stream: mutualFundController.stream,
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

  Widget _buildBody(MutalFundRanking data) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.separated(
            addAutomaticKeepAlives: true,
            itemCount: data.table1!.length,
            itemBuilder: (BuildContext context, int index) {
              num returns = num.parse(data.table1![index].returns!);

              return GestureDetector(
                  onTap: () {
                    SystemChannels
                    .textInput
                    .invokeMethod('TextInput.hide');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => MutualFundsGraph(
                                  appbartitle: data.table1![index].sNAME,
                                  schemeCode: data.table1![index].sCHEMECODE,
                                ))));
                  },
                  child: CommonListTile(
                    title: data.table1![index].sNAME!,
                    trailing: num.parse(returns.toStringAsFixed(2)),
                  ));
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                thickness: 1.5,
              );
            },
          ),
        ),
        !userHasSubscription
            ? SizedBox(
                height: 100.h,
              )
            : SizedBox(
                height: 37.h,
              )
      ],
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}

class FlexiCap extends StatefulWidget {
  FlexiCap({super.key, required this.yearsFilter});
  String yearsFilter;
  @override
  State<FlexiCap> createState() => _FlexiCapState();
}

class _FlexiCapState extends State<FlexiCap>
with AutomaticKeepAliveClientMixin<FlexiCap>
 {
  StreamController<MutalFundRanking> mutualFundController = StreamController();

  @override
  void dispose() {
    mutualFundController.close();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 2), (timer) {
      allMutualFunds();
    });
  }

  prefix.Dio dio = new prefix.Dio();

  Future<ResponseData> allMutualFunds() async {
    prefix.Response response;
    String yearsFil = "";
    switch (yearsFilter) {
      case "1 Year":
        {
          yearsFil = "1YEARRET";
        }
        break;
      case "3 Year":
        {
          yearsFil = "3YEARRET";
        }
        break;
      case "5 Year":
        {
          yearsFil = "5YEARRET";
        }
        break;

      default:
        throw Error();
    }
    try {
      response = await dio.get(
        "https://mf.accordwebservices.com/MF/MF_SHOW_FUNDRANKING?&Type=1&AMC=&Category=83&Return=${yearsFil}&PageNo=1&Pagesize=10&SortExp=&SortDirection=&token=wG2axAvNa3yX3DT89CHVHyg2x19TOZE5",
      );
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      var data = MutalFundRanking.fromJson(response.data);
      if (!mutualFundController.isClosed) mutualFundController.sink.add(data);

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
    return StreamBuilder<MutalFundRanking>(
        stream: mutualFundController.stream,
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

  Widget _buildBody(MutalFundRanking data) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.separated(
            addAutomaticKeepAlives: true,
            itemCount: data.table1!.length,
            itemBuilder: (BuildContext context, int index) {
              num returns = num.parse(data.table1![index].returns!);

              return GestureDetector(
                  onTap: () {
                    SystemChannels
                    .textInput
                    .invokeMethod('TextInput.hide');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => MutualFundsGraph(
                                  appbartitle: data.table1![index].sNAME,
                                  schemeCode: data.table1![index].sCHEMECODE,
                                ))));
                  },
                  child: CommonListTile(
                    title: data.table1![index].sNAME!,
                    trailing: num.parse(returns.toStringAsFixed(2)),
                  ));
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                thickness: 1.5,
              );
            },
          ),
        ),
        !userHasSubscription
            ? SizedBox(
                height: 100.h,
              )
            : SizedBox(
                height: 37.h,
              )
      ],
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}

class MidCap extends StatefulWidget {
  MidCap({super.key, required this.yearsFilter});
  String yearsFilter;
  @override
  State<MidCap> createState() => _MidCapState();
}

class _MidCapState extends State<MidCap>
with AutomaticKeepAliveClientMixin<MidCap>
 {
  StreamController<MutalFundRanking> mutualFundController = StreamController();

  @override
  void dispose() {
    mutualFundController.close();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 2), (timer) {
      allMutualFunds();
    });
  }

  prefix.Dio dio = new prefix.Dio();

  Future<ResponseData> allMutualFunds() async {
    prefix.Response response;

    String yearsFil = "";
    switch (yearsFilter) {
      case "1 Year":
        {
          yearsFil = "1YEARRET";
        }
        break;
      case "3 Year":
        {
          yearsFil = "3YEARRET";
        }
        break;
      case "5 Year":
        {
          yearsFil = "5YEARRET";
        }
        break;

      default:
        throw Error();
    }
    try {
      response = await dio.get(
        "https://mf.accordwebservices.com/MF/MF_SHOW_FUNDRANKING?&Type=1&AMC=&Category=32&Return=${yearsFil}&PageNo=1&Pagesize=10&SortExp=&SortDirection=&token=wG2axAvNa3yX3DT89CHVHyg2x19TOZE5",
      );
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      var data = MutalFundRanking.fromJson(response.data);
      if (!mutualFundController.isClosed) mutualFundController.sink.add(data);

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
    return StreamBuilder<MutalFundRanking>(
        stream: mutualFundController.stream,
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

  Widget _buildBody(MutalFundRanking data) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.separated(
            addAutomaticKeepAlives: true,
            itemCount: data.table1!.length,
            itemBuilder: (BuildContext context, int index) {
              num returns = num.parse(data.table1![index].returns!);

              return GestureDetector(
                  onTap: () {
                    SystemChannels
                    .textInput
                    .invokeMethod('TextInput.hide');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => MutualFundsGraph(
                                  appbartitle: data.table1![index].sNAME,
                                  schemeCode: data.table1![index].sCHEMECODE,
                                ))));
                  },
                  child: CommonListTile(
                    title: data.table1![index].sNAME!,
                    trailing: num.parse(returns.toStringAsFixed(2)),
                  ));
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                thickness: 1.5,
              );
            },
          ),
        ),
        !userHasSubscription
            ? SizedBox(
                height: 100.h,
              )
            : SizedBox(
                height: 37.h,
              )
      ],
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}

class LargeAndMidCap extends StatefulWidget {
  LargeAndMidCap({super.key, required this.yearsFilter});
  String yearsFilter;
  @override
  State<LargeAndMidCap> createState() => _LargeAndMidCapState();
}

class _LargeAndMidCapState extends State<LargeAndMidCap>
with AutomaticKeepAliveClientMixin<LargeAndMidCap>
 {
  StreamController<MutalFundRanking> mutualFundController = StreamController();

  @override
  void dispose() {
    mutualFundController.close();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 2), (timer) {
      allMutualFunds();
    });
  }

  prefix.Dio dio = new prefix.Dio();

  Future<ResponseData> allMutualFunds() async {
    prefix.Response response;

    String yearsFil = "";
    switch (yearsFilter) {
      case "1 Year":
        {
          yearsFil = "1YEARRET";
        }
        break;
      case "3 Year":
        {
          yearsFil = "3YEARRET";
        }
        break;
      case "5 Year":
        {
          yearsFil = "5YEARRET";
        }
        break;

      default:
        throw Error();
    }
    try {
      response = await dio.get(
        "https://mf.accordwebservices.com/MF/MF_SHOW_FUNDRANKING?&Type=1&AMC=&Category=61&Return=${yearsFil}&PageNo=1&Pagesize=10&SortExp=&SortDirection=&token=wG2axAvNa3yX3DT89CHVHyg2x19TOZE5",
      );
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      var data = MutalFundRanking.fromJson(response.data);
      if (!mutualFundController.isClosed) mutualFundController.sink.add(data);

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
    return StreamBuilder<MutalFundRanking>(
        stream: mutualFundController.stream,
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

  Widget _buildBody(MutalFundRanking data) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.separated(
            addAutomaticKeepAlives: true,
            itemCount: data.table1!.length,
            itemBuilder: (BuildContext context, int index) {
              num returns = num.parse(data.table1![index].returns!);

              return GestureDetector(
                  onTap: () {
                    SystemChannels
                    .textInput
                    .invokeMethod('TextInput.hide');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => MutualFundsGraph(
                                  appbartitle: data.table1![index].sNAME,
                                  schemeCode: data.table1![index].sCHEMECODE,
                                ))));
                  },
                  child: CommonListTile(
                    title: data.table1![index].sNAME!,
                    trailing: num.parse(returns.toStringAsFixed(2)),
                  ));
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                thickness: 1.5,
              );
            },
          ),
        ),
        !userHasSubscription
            ? SizedBox(
                height: 100.h,
              )
            : SizedBox(
                height: 37.h,
              )
      ],
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}

class SmallCap extends StatefulWidget {
  SmallCap({super.key, required this.yearsFilter});
  String yearsFilter;
  @override
  State<SmallCap> createState() => _SmallCapState();
}

class _SmallCapState extends State<SmallCap>
with AutomaticKeepAliveClientMixin<SmallCap>
 {
  StreamController<MutalFundRanking> mutualFundController = StreamController();

  @override
  void dispose() {
    mutualFundController.close();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 2), (timer) {
      allMutualFunds();
    });
  }

  prefix.Dio dio = new prefix.Dio();

  Future<ResponseData> allMutualFunds() async {
    prefix.Response response;
    String yearsFil = "";
    switch (yearsFilter) {
      case "1 Year":
        {
          yearsFil = "1YEARRET";
        }
        break;
      case "3 Year":
        {
          yearsFil = "3YEARRET";
        }
        break;
      case "5 Year":
        {
          yearsFil = "5YEARRET";
        }
        break;

      default:
        throw Error();
    }
    try {
      response = await dio.get(
        "https://mf.accordwebservices.com/MF/MF_SHOW_FUNDRANKING?&Type=1&AMC=&Category=33&Return=${yearsFil}&PageNo=1&Pagesize=10&SortExp=&SortDirection=&token=wG2axAvNa3yX3DT89CHVHyg2x19TOZE5",
      );
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      var data = MutalFundRanking.fromJson(response.data);
      if (!mutualFundController.isClosed) mutualFundController.sink.add(data);

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
    return StreamBuilder<MutalFundRanking>(
        stream: mutualFundController.stream,
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

  Widget _buildBody(MutalFundRanking data) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.separated(
            addAutomaticKeepAlives: true,
            itemCount: data.table1!.length,
            itemBuilder: (BuildContext context, int index) {
              num returns = num.parse(data.table1![index].returns!);

              return GestureDetector(
                  onTap: () {
                    SystemChannels
                    .textInput
                    .invokeMethod('TextInput.hide');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => MutualFundsGraph(
                                  appbartitle: data.table1![index].sNAME,
                                  schemeCode: data.table1![index].sCHEMECODE,
                                ))));
                  },
                  child: CommonListTile(
                    title: data.table1![index].sNAME!,
                    trailing: num.parse(returns.toStringAsFixed(2)),
                  ));
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                thickness: 1.5,
              );
            },
          ),
        ),
        !userHasSubscription
            ? SizedBox(
                height: 100.h,
              )
            : SizedBox(
                height: 37.h,
              )
      ],
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}

class CommonListTile extends StatefulWidget {
  CommonListTile({super.key, this.title, this.trailing});

  @override
  State<CommonListTile> createState() => _CommonListTileState();
  String? title;
  num? trailing;
}

class _CommonListTileState extends State<CommonListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.title!),
      trailing: Text(
        widget.trailing!.toString(),
        textAlign: TextAlign.center,
        style: widget.trailing!.toString().contains('-')
            ? TextStyle(
                fontSize: 16.sm,
                color: Colors.red,
              )
            : TextStyle(
                fontSize: 16.sm,
                color: Color(0xFF2CAB41),
              ),
      ),
    );
  }
}
