// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piadvisory/Utils/Constants.dart';
import 'package:scgateway_flutter_plugin/scgateway_flutter_plugin.dart';

import '../../Common/CustomNextButton.dart';
import '../../Common/app_bar.dart';
import '../../Utils/textStyles.dart';
import 'broker_account_model.dart';
import 'package:http/http.dart' as http;

class Brokerlogin extends StatefulWidget {
  const Brokerlogin({Key? key, this.brokerAccountModel}) : super(key: key);

  final BrokerAccountModel? brokerAccountModel;

  @override
  State<Brokerlogin> createState() => _BrokerloginState();
}

class _BrokerloginState extends State<Brokerlogin> {
  Future<String> getHoldingsImportTransactionId({required authToken}) async {
    var response = await http.get(Uri.parse(
        "${ApiConstant.base}api/get_small_case_holding_import_transaction_id/$authToken"));
    String txnId = jsonDecode(response.body)['data']['transactionId'];
    return txnId;
  }

  Future<String> fetchHoldings({required authToken}) async {
    var response = await http.get(Uri.parse(
        "${ApiConstant.base}api/fetch_small_case_holding/$authToken"));
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await ScgatewayFlutterPlugin.logoutUser();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.brokerAccountModel?.brokerName ?? 'NULL'),
          actions: [
            TextButton(
              onPressed: () {
                ScgatewayFlutterPlugin.logoutUser().then(
                  (value) => Navigator.pop(context),
                );
              },
              child: Text(
                "Logout",
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
        body: const Center(
          child: FlutterLogo(),
        ),
      ),
    );
  }
}
