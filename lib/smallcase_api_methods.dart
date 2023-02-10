import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:piadvisory/Utils/Constants.dart';
import 'package:scgateway_flutter_plugin/scgateway_flutter_plugin.dart';

import 'HomePage/equity.dart';
import 'Portfolio/PortfolioMainUI.dart';
import 'SideMenu/Brokerage/broker_account_model.dart';

void openDashboardPage(BuildContext context) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: ((context) => PortfolioMainUI())));
}

void openEquityPage(BuildContext context, Map<String, dynamic> holdings) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: ((context) => Equityinner(holdings: holdings))));
}

//broker account table
//fetch broker accounts
Future<List<BrokerAccountModel>> fetchBrokerAccounts() async {
  final response = await http.Client()
      .get(Uri.parse('${ApiConstant.base}api/get_broker_account_data'));
  final parsed = jsonDecode(response.body);
  return parsed
      .map<BrokerAccountModel>((json) => BrokerAccountModel.fromJson(json))
      .toList();
}

//delete broker account
Future<bool> deleteBrokerAccount(int id) async {
  final response = await http.Client()
      .get(Uri.parse('${ApiConstant.base}api/delete_brokerage_account/$id'));
  if (response.statusCode == 200) return true;
  return false;
}

//post broker account
Future<bool> postBrokerAccount({
  required String userId,
  required String brokerName,
  required String authToken,
  required String txnId,
}) async {
  var response = await http.post(
    Uri.parse('${ApiConstant.base}api/add_broker_account'),
    body: <String, String>{
      "user_id": userId,
      "broker_name": brokerName,
      "auth_token": authToken,
      "transaction_id": txnId,
    },
  );
  if (response.statusCode == 200) return true;
  return false;
}

Future<String> fetchAuthToken() async {
  var response = await http.get(
    Uri.parse(
      '${ApiConstant.base}api/get_small_case_auth_token/',
    ),
  );
  return jsonDecode(response.body)['data'];
}

Future<String> fetchBrokerConnectTxnId({required String authToken}) async {
  var response = await http.get(
    Uri.parse(
      '${ApiConstant.base}api/get_small_case_broker_connect_transaction/$authToken',
    ),
  );
  return jsonDecode(response.body)['data']['transactionId'];
}

Future<http.Response> fetchHoldingsImportTxnId(String authToken) async {
  var response = await http.get(
    Uri.parse(
      '${ApiConstant.base}api/get_small_case_holding_import_transaction_id/$authToken',
    ),
  );
  return response;
}

Future<Map<String, dynamic>> fetchHoldings(String authToken) async {
  var response = await http.get(
    Uri.parse(
      '${ApiConstant.base}api/fetch_small_case_holding/$authToken',
    ),
  );
  return jsonDecode(response.body)['data'];
}

Future<String> fetchStocksOrderTxnId(String authToken, String body) async {
  var response = await http.post(Uri.parse(
      '${ApiConstant.base}api/create_post_transaction_stock_order?body=$body&auth_token=$authToken'));
  var txnId = jsonDecode(response.body)['data']['transactionId'];
  return txnId;
}

enum TradeType {
  BUY,
  SELL,
}

void loginNTrade(String ticker, int quantity, TradeType tradeType) {
  fetchAuthToken().then((fetchedAuthToken) {
    // debugPrint("fetchedAuthToken $fetchedAuthToken");
    fetchBrokerConnectTxnId(authToken: fetchedAuthToken).then(
      (txnId) => ScgatewayFlutterPlugin.initGateway(fetchedAuthToken).then(
        (value) => ScgatewayFlutterPlugin.triggerGatewayTransaction(
          txnId,
        ).then(
          (loginRes) {
            if (loginRes != null) {
              var data = jsonDecode(loginRes)['data'];
              if (data != null) {
                String authToken = jsonDecode(data)['smallcaseAuthToken'];
                String brokerName = jsonDecode(data)['broker'];
                String txnId = jsonDecode(data)['transactionId'];
                String body =
                    '{"intent":"TRANSACTION","orderConfig":{"type":"SECURITIES","securities":[{"ticker":"$ticker","quantity":"$quantity","type":"${tradeType.name}"},{"ticker":"RELIANCE","quantity":1,"type":"BUY"}]}}';
                fetchStocksOrderTxnId(authToken, body).then(
                    (stocksOrderTxnId) => ScgatewayFlutterPlugin
                            .triggerGatewayTransaction(stocksOrderTxnId)
                        .then(
                            (value) => debugPrint("Stocks Order res $value")));
              }
            }
          },
        ),
      ),
    );
  });
}
