import 'dart:convert';
import 'dart:math';

import 'package:piadvisory/Profile/KYC/KYCMain.dart';
import 'package:piadvisory/Utils/Constants.dart';
import 'package:piadvisory/Utils/base_manager.dart';

import 'package:dio/dio.dart';
import 'package:piadvisory/Utils/database.dart';
import 'package:piadvisory/Utils/utils.dart';

import 'package:shared_preferences/shared_preferences.dart';

late Map<String, dynamic> kycStatus;

class KYCDigilocker {
  Dio dio = new Dio();

  createLink({
    required String reqid,
    required String randString,
  }) {
    Map<String, dynamic> userdata = Database().restoreUserDetails();
    var email = globalEmailID;
    var logo = ApiConstant.endlogoForDigio;
    String link =
        "https://app.digio.in/#/gateway/login/$reqid/$randString/$email?logo=$logo";

    print(" generated link is $link");

    Database().storeLink(link);
  }

  Future<ResponseData> generateRequestID(
      {required bool kra_ckyc_verfied}) async {
    Response response;
    Map<String, dynamic> userdata = Database().restoreUserDetails();
    print("reached to generate req id");
    String username = 'AIKXNZ35JKSNK9R4TQJEHNAUPU3KYKRV';
    String password = 'YJ2CKKL1YFL87Y6MFJ7DW1EV9GI7KPSG';
    String basicAuth =
        'Basic ' + base64.encode(utf8.encode('$username:$password'));

    try {
      response = await dio.post(
          "https://api.digio.in/client/kyc/v2/request/with_template",
          data: {
            "customer_identifier": globalEmailID,
            "customer_name": userdata['fullname'],
            "reference_id": UtilsMethods().getRandomString(20),
            "template_name": kra_ckyc_verfied ? "CKYC FLOW" : "PI-TEST",
            "notify_customer": true,
            "request_details": {},
            "transaction_id": UtilsMethods().getRandomString(20),
            "generate_access_token": true
          },
          options: Options(headers: {
            "authorization": basicAuth,
          }));
      // await dio.post("https://ext.digio.in:444/client/kyc/v2/request",
      //     data: {
      //       "customer_identifier": userdata['email'],
      //       "customer_name": userdata['fullname'],
      //       "actions": [
      //         {
      //           "type": "DIGILOCKER",
      //           "title": "Digilocker KYC",
      //           "description":
      //               "Please share your aadhaar card and Pan from digilocker",
      //           "document_types": ["AADHAAR", "PAN"]
      //         }
      //       ],
      //       "notify_customer": true,
      //       "generate_access_token": true,
      //       "request_details": {
      //         "transaction_id": UtilsMethods().getRandomString(20)
      //       }
      //     },
      //     options: Options(headers: {
      //       "authorization":
      //           "Basic QUlERjg5SVFTMlRMVFM2T0ZQMUxOUDdXOVlGSDJYR1I6WDE4UlcxRFhIT0xETENBUTJKMTgySkVWR1JKTjlUM0c=",
      //     }));
      print(response);
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Invalid Credentials', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      Map<String, dynamic> res = response.data;

      Map<String, dynamic> store = {
        'requestId': res['id'],
      };
      Database().storeKYCRequestID(store);
      print(Database().restoreKYCRequestID());
      var randString = UtilsMethods().getRandomString(10);
      createLink(
        reqid: res['id'],
        randString: randString,
      );
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

  Future<ResponseData> storeKycDetails() async {
    print("reached");
    Response response;
    //Map<String, dynamic> userdata = Database().restoreUserDetails();
    Map<String, dynamic> requestid = Database().restoreKYCRequestID();
    print(requestid['requestId']);
    var reqid = requestid['requestId'];
    String username = 'AIKXNZ35JKSNK9R4TQJEHNAUPU3KYKRV';
    String password = 'YJ2CKKL1YFL87Y6MFJ7DW1EV9GI7KPSG';
    String basicAuth =
        'Basic ' + base64.encode(utf8.encode('$username:$password'));
    try {
      response = await dio.post(
          "https://api.digio.in/client/kyc/v2/$reqid/response",
          options: Options(headers: {"authorization": basicAuth}));
      print(response);
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Invalid Credentials', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      Map<String, dynamic> res = response.data;

      Map<String, dynamic> store = {
        'requestid': res['id'],
        "kyc_status": res['status'],
        "customer_identifier": res['customer_identifier'],
        "reference_id": res['reference_id'],
        "transaction_id": res['transaction_id'],
        "customer_name": res['customer_name'],
        "expire_in_days": res['expire_in_days'],
      };
      //Database().storeKycDetails(store);
      print("store var is $store");
      storeKycInDB(store);
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

  Future<ResponseData> checkKycDetails() async {
    Response response;

    Map<String, dynamic> requestid = Database().restoreKYCRequestID();
    String username = 'AIKXNZ35JKSNK9R4TQJEHNAUPU3KYKRV';
    String password = 'YJ2CKKL1YFL87Y6MFJ7DW1EV9GI7KPSG';
    String basicAuth =
        'Basic ' + base64.encode(utf8.encode('$username:$password'));
    var reqid = requestid['requestId'];
    try {
      response = await dio.post(
          "https://api.digio.in/client/kyc/v2/$reqid/response",
          options: Options(headers: {"authorization": basicAuth}));
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Invalid Credentials', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      Map<String, dynamic> res = response.data;

      kycStatus = {
        "status": res['status'],
      };

      print("store var is $kycStatus");
      // storeKycInDB(store);
      storeKycDetails();
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

  Future<ResponseData> storeKycInDB(Map<String, dynamic> store) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    try {
      response = await dio.post(ApiConstant.storekycdetails,
          data: store,
          options: Options(headers: {"authorization": "Bearer $token"}));
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Invalid Credentials', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
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
}
