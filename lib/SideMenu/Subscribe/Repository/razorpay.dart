import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/instance_manager.dart';
import 'package:logger/logger.dart';
import 'package:piadvisory/SideMenu/Subscribe/Model/getPaymentDetails.dart';
import 'package:piadvisory/Utils/Constants.dart';
import 'package:piadvisory/Utils/base_manager.dart';
import 'package:piadvisory/Utils/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

late String orderID;
late transactionDetails paymentdata;

class RazorpayMethods {
  Dio dio = new Dio();
  var logger = Logger(
    printer: PrettyPrinter(),
  );
  Future<ResponseData> createOrder() async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    Map<String, dynamic> planDetails =
        Get.find<Database>().restorePriceAndPlanName();
    Map<String, dynamic> updata = {
      "amount": planDetails['amount'],
    };
    try {
      response = await dio.post(ApiConstant.createOrder,
          data: updata,
          options: Options(headers: {"authorization": "Bearer $token"}));
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }
    print(" resp is $response");
    if (response.statusCode == 200) {
      Map<String, dynamic> res = response.data;
      // await prefs.setString('token', res["token"]);
      orderID = res['data']['id'];
      print(orderID);

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

  Future<ResponseData> postpaymentverification(
      Map<String, dynamic> updata) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    try {
      response = await dio.post(ApiConstant.postpaymentverification,
          data: updata,
          options: Options(headers: {"authorization": "Bearer $token"}));
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }
    print(" resp is $response");
    if (response.statusCode == 200) {
      // Map<String, dynamic> res = response.data;
      // await prefs.setString('token', res["token"]);

      print(response);

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

  Future<ResponseData> getPaymentDetails(String orderid) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    String username = 'rzp_test_ryPoiSUUJmfLXB';
    String password = 'wtLBbDf43iYaW84MQJSkKWfT';
    String basicAuth =
        'Basic ' + base64.encode(utf8.encode('$username:$password'));
    try {
      response =
          await dio.get("https://api.razorpay.com/v1/orders/$orderid/payments",
              //  data: updata,
              options: Options(headers: {
                "authorization": basicAuth,
              }));
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      paymentdata = transactionDetails.fromJson(response.data);
      logger.d("razor orderid details is ${paymentdata.items!.first.bank}");
      storeTransactionDetails();
      //  try {
      //   globalpostdata = GlobalPostPageModel.fromJson(response.data);

      //   print(globalpostdata.postDetails!.fullName);
      //   return globalpostdata;
      // } catch (err) {
      //   return ResponseData<dynamic>(err.toString(), ResponseStatus.FAILED);
      // }
      // print(response);

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

  Future<ResponseData> storeTransactionDetails() async {
    logger.d("store transaction details reached here");
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    final planDetails = Get.find<Database>().restorePriceAndPlanName();
    int planid = fetchPlanIdFromName(planDetails);
    print("plain id retrived is $planid");
    Map<String, dynamic> updata = {
      "plan_id": planid.toString(),
      "paymentId": paymentdata.items?.first.id ?? "error",
      "amount": paymentdata.items?.first.amount ?? "error",
      "currency": paymentdata.items!.first.currency.toString(),
      "status": paymentdata.items!.first.status.toString(),
      "order_id": paymentdata.items!.first.orderId,
      "invoice_id": paymentdata.items!.first.invoiceId.toString(),
      "payment_method": paymentdata.items!.first.method.toString(),
      "amount_refunded": paymentdata.items!.first.amountRefunded.toString(),
      "refund_status": paymentdata.items!.first.refundStatus.toString(),
      "captured": paymentdata.items!.first.captured.toString(),
      "description": paymentdata.items!.first.captured.toString(),
      "bank": paymentdata.items!.first.bank.toString(),
      "wallet": paymentdata.items!.first.wallet.toString(),
      "vpa": paymentdata.items!.first.vpa.toString(),
      "error_code": paymentdata.items!.first.errorCode.toString(),
      "error_description": paymentdata.items!.first.errorDescription.toString(),
      "error_source": paymentdata.items!.first.errorSource.toString(),
      "error_step": paymentdata.items!.first.errorStep.toString(),
      "error_reason": paymentdata.items!.first.errorReason.toString(),
      "isSuccess": 1,
      "reason": "dsf"
    };
    logger.d("updata for db storing is  $updata");
    try {
      response = await dio.post(ApiConstant.storeTransactionDetails,
          data: updata,
          options: Options(headers: {"authorization": "Bearer $token"}));
    } on Exception catch (_) {
      logger.d("exception caughted");
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }
    logger.d("resp is $response.data");

    if (response.statusCode == 200) {
      print("transaction response is");
      logger.d(response.data);
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

  fetchPlanIdFromName(Map<String, dynamic> planMap) {
    if (planMap['planName'] == "Investment Advisory") {
      return 1;
    } else if (planMap['planName'] == "Tax Planning") {
      return 2;
    } else if (planMap['planName'] == "Financial Planning") {
      return 3;
    }
  }

  Future<ResponseData> storeSubsTemp() async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    final planDetails = Get.find<Database>().restorePriceAndPlanName();
    int planid = fetchPlanIdFromName(planDetails);
    Map<String, dynamic> updata = {"plan_id": planid.toString()};
    try {
      response = await dio.post("${ApiConstant.base}api/store_subs_temp",
          data: updata,
          options: Options(headers: {"authorization": "Bearer $token"}));
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      print("substemp response is");
      logger.d(response.data);
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
}
