// import 'package:advisor/SideMenu/Brokerage/broker-login.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:piadvisory/Common/user_id.dart';
import 'package:piadvisory/SideMenu/Brokerage/broker-login.dart';
import 'package:piadvisory/SideMenu/Brokerage/broker_account_model.dart';
import 'package:piadvisory/Utils/Constants.dart';
import 'package:scgateway_flutter_plugin/scgateway_flutter_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:async/async.dart';

import '../../Common/app_bar.dart';
import '../../smallcase_api_methods.dart';

class Broker extends StatefulWidget {
  const Broker({Key? key}) : super(key: key);

  @override
  State<Broker> createState() => _BrokerState();
}

class _BrokerState extends State<Broker> {
  Future<String> fetchAuthToken({int? authId}) async {
    String baseUrl = "${ApiConstant.base}api/get_small_case_auth_token/";
    String url = authId == null ? baseUrl : baseUrl + authId.toString();
    var response = await http.get(Uri.parse(url));
    String token = jsonDecode(response.body)['data'];
    debugPrint("token $token");
    return token;
  }

  Future<String> fetchBrokerConnectTransactionId(String authToken) async {
    var response = await http.get(Uri.parse(
        "${ApiConstant.base}api/get_small_case_broker_connect_transaction/$authToken"));
    String txnId = jsonDecode(response.body)['data']['transactionId'];
    debugPrint("txn id: $txnId");
    return txnId;
  }

  bool showAddAccountBtn = true;
  bool showAddAccountBtnLoader = false;

  void replaceAddAccountBtnWithLoader() {
    setState(() {
      showAddAccountBtn = false;
      showAddAccountBtnLoader = true;
    });
  }

  void replaceLoaderWithAddAccountBtn() {
    setState(() {
      showAddAccountBtn = true;
      showAddAccountBtnLoader = false;
    });
  }

  bool showDeleteAccountBtn = true;
  bool showDeleteAccountBtnLoader = false;

  FutureGroup futureGroup = FutureGroup();

  @override
  void initState() {
    super.initState();
    futureGroup.add(getUserId());
    futureGroup.add(fetchBrokerAccounts());
    futureGroup.close();
  }

  List<BrokerAccountModel> myBrokerAccounts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const CustomAppBar(titleTxt: "Brokerage Account", bottomtext: false),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            SizedBox(height: 40.h),
            Container(
              color: const Color(0xFF008083),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: showAddAccountBtn,
                      child: SizedBox(
                        width: 160,
                        height: 40,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            replaceAddAccountBtnWithLoader();
                            Timer.periodic(Duration(seconds: 8), (timer) {
                              replaceLoaderWithAddAccountBtn();
                              timer.cancel();
                            });
                            fetchAuthToken().then((fetchedAuthToken) {
                              debugPrint("fetchedAuthToken $fetchedAuthToken");
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
                                        var data = jsonDecode(loginRes)['data'];
                                        if (data != null) {
                                          String authToken = jsonDecode(
                                              data)['smallcaseAuthToken'];
                                          String brokerName =
                                              jsonDecode(data)['broker'];
                                          String txnId =
                                              jsonDecode(data)['transactionId'];
                                          getUserId().then((userId) {
                                            postBrokerAccount(
                                                    userId: userId!.toString(),
                                                    brokerName: brokerName,
                                                    authToken: authToken,
                                                    txnId: txnId)
                                                .then((isPosted) {
                                              replaceLoaderWithAddAccountBtn();
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Broker()));
                                              ScaffoldMessenger.of(context)
                                                  .clearSnackBars();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          'New broker account is added')));
                                            });
                                          });
                                          replaceLoaderWithAddAccountBtn();
                                        }
                                      }
                                    },
                                  ),
                                ),
                              );
                            });
                          },
                          icon: const Icon(
                            FontAwesomeIcons.circlePlus,
                            color: Color(0xFF585858),
                          ),
                          label: const Text(
                            "Add Account",
                            style: TextStyle(color: Color(0xFF585858)),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: showAddAccountBtnLoader,
                      child: const SizedBox(
                        width: 160,
                        height: 40,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 12),
            Expanded(
              child: FutureBuilder<List>(
                future: futureGroup.future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    List<BrokerAccountModel> fetchedAccounts =
                        snapshot.data![1];
                    try {
                      myBrokerAccounts.addAll(fetchedAccounts.where(
                          (e) => e.userId == snapshot.data![0].toString()));
                    } catch (e) {}
                    if (myBrokerAccounts.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset("assets/images/Group 5953.svg"),
                            Text(
                              "No Account Found",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ],
                        ),
                      );
                    } else {
                      List<BrokerAccountModel> data = snapshot.data![1]
                          .where((element) =>
                              element.userId == snapshot.data![0].toString())
                          .toList();
                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 18.0),
                            child: Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(border: Border.all()),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      data.elementAt(index).brokerName ??
                                          "NULL",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  StatefulBuilder(
                                      builder: (context, setBtnState) {
                                    return Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder:
                                                    (context) => AlertDialog(
                                                          title: Text(
                                                            "Delete Account",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 18,
                                                            ),
                                                          ),
                                                          content: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Text(
                                                                'Your broker account will be permanently deleted from pi advisory',
                                                              ),
                                                              SizedBox(
                                                                height: 18,
                                                              ),
                                                              StatefulBuilder(
                                                                builder: (context,
                                                                    setDialogActionState) {
                                                                  return Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      Visibility(
                                                                        visible:
                                                                            showDeleteAccountBtn,
                                                                        child: OutlinedButton(
                                                                            style: OutlinedButton.styleFrom(
                                                                              foregroundColor: Color(0xFF585858),
                                                                            ),
                                                                            onPressed: () => Navigator.pop(context),
                                                                            child: Text("Cancel")),
                                                                      ),
                                                                      SizedBox(
                                                                          width:
                                                                              12),
                                                                      Visibility(
                                                                        visible:
                                                                            showDeleteAccountBtn,
                                                                        child:
                                                                            ElevatedButton(
                                                                          style:
                                                                              ElevatedButton.styleFrom(
                                                                            backgroundColor:
                                                                                Color(0xFF585858),
                                                                            foregroundColor:
                                                                                Colors.white,
                                                                          ),
                                                                          onPressed:
                                                                              () {
                                                                            setDialogActionState(
                                                                              () {
                                                                                showDeleteAccountBtn = false;
                                                                                showDeleteAccountBtnLoader = true;
                                                                              },
                                                                            );
                                                                            String?
                                                                                id =
                                                                                data.elementAt(index).id;
                                                                            debugPrint(id ??
                                                                                'NULL');
                                                                            if (id !=
                                                                                null) {
                                                                              deleteBrokerAccount(int.parse(id)).then((isDeleted) {
                                                                                if (isDeleted) {
                                                                                  Navigator.pop(context);
                                                                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Broker()));
                                                                                  ScaffoldMessenger.of(context).clearSnackBars();
                                                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                                    content: Text("Successfully Deleted"),
                                                                                  ));
                                                                                } else {
                                                                                  Navigator.pop(context);
                                                                                  ScaffoldMessenger.of(context).clearSnackBars();
                                                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Cannot Delete")));
                                                                                }
                                                                                setDialogActionState(
                                                                                  () {
                                                                                    showDeleteAccountBtn = true;
                                                                                    showDeleteAccountBtnLoader = false;
                                                                                  },
                                                                                );
                                                                              });
                                                                            }
                                                                            ScgatewayFlutterPlugin.logoutUser();
                                                                          },
                                                                          child:
                                                                              Text('Delete'),
                                                                        ),
                                                                      ),
                                                                      Visibility(
                                                                        visible:
                                                                            showDeleteAccountBtnLoader,
                                                                        child:
                                                                            Expanded(
                                                                          child:
                                                                              Center(
                                                                            child: SizedBox(
                                                                                width: 22,
                                                                                height: 22,
                                                                                child: CircularProgressIndicator(
                                                                                  strokeWidth: 3,
                                                                                  color: Color(0xFF585858),
                                                                                )),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              )
                                                            ],
                                                          ),
                                                        ));
                                          },
                                          child: Icon(Icons.close_rounded),
                                        )
                                      ],
                                    );
                                  }),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
