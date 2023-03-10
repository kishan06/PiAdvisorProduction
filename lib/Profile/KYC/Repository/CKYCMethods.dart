import 'dart:convert';
import 'dart:math';

import 'package:piadvisory/Profile/KYC/KYCMain.dart';
import 'package:piadvisory/Utils/Constants.dart';
import 'package:piadvisory/Utils/base_manager.dart';

import 'package:dio/dio.dart';
import 'package:piadvisory/Utils/database.dart';
import 'package:piadvisory/Utils/utils.dart';

import 'package:shared_preferences/shared_preferences.dart';

Map<String, dynamic>? CkycStatus;
Map<String, dynamic>? kraStatus;

class CKYCMethods {
  Dio dio = new Dio();

  Future<ResponseData> KRACheck(Map<String, dynamic> updata) async {
    Response response;
    try {
      response = await dio.post(
          "https://ext.digio.in:444/v3/client/kyc/kra/get_pan_details",
          data: updata,
          options: Options(headers: {
            "authorization":
                "Basic QUlERjg5SVFTMlRMVFM2T0ZQMUxOUDdXOVlGSDJYR1I6WDE4UlcxRFhIT0xETENBUTJKMTgySkVWR1JKTjlUM0c=",
          }));
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Invalid Credentials', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      Map<String, dynamic> res = response.data;

      kraStatus = {
        "status": res['status'],
      };

      print("store var is $CkycStatus");

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

  Future<ResponseData> CkycCheck(Map<String, dynamic> idno) async {
    String basicAuth = 'Basic ' +
        base64.encode(utf8.encode(
            'AIKXNZ35JKSNK9R4TQJEHNAUPU3KYKRV:YJ2CKKL1YFL87Y6MFJ7DW1EV9GI7KPSG'));
    Response response;
    try {
      response =
          await dio.post("https://api.digio.in/v3/client/kyc/ckyc/search",
              data: idno,
              options: Options(headers: {
                "authorization": basicAuth,
              }));
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Invalid Credentials', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      Map<String, dynamic> res = response.data;

      CkycStatus = {
        "status": res['success'],
      };

      print("store var is $CkycStatus");

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
