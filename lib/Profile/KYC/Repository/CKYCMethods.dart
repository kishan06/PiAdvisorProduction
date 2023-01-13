import 'dart:convert';
import 'dart:math';

import 'package:piadvisory/Profile/KYC/KYCMain.dart';
import 'package:piadvisory/Utils/Constants.dart';
import 'package:piadvisory/Utils/base_manager.dart';

import 'package:dio/dio.dart';
import 'package:piadvisory/Utils/database.dart';
import 'package:piadvisory/Utils/utils.dart';

import 'package:shared_preferences/shared_preferences.dart';

late Map<String, dynamic> CkycStatus;

class CKYCMethods {
  Dio dio = new Dio();

  Future<ResponseData> KRACheck(updata) async {
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

      CkycStatus = {
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

  Future<ResponseData> CkycCheck(updata) async {
    Response response;
    try {
      response =
          await dio.post("https://ext.digio.in:444/v3/client/kyc/ckyc/search",
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
