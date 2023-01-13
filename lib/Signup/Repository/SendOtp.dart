// ignore_for_file: camel_case_types

import 'package:piadvisory/Utils/Constants.dart';
import 'package:piadvisory/Utils/base_manager.dart';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SendOtp {
  Dio dio = new Dio();

  sendotp(Map<String, dynamic> updata) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    Response response;
    try {
      response = await dio.post(
        ApiConstant.sendotp,
        data: updata,
        // options: Options(
        //   headers: {"authorization": "Bearer $token"},
        // ),
      );
      print(response);
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
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

  SendOtpExotel(Map<String, dynamic> updata) async {
    Response response;
    print("exotel called for sending otp");
    try {
      response = await dio.post(
        ApiConstant.sendotp,
        data: updata,
        // options: Options(
        //   headers: {"authorization": "Bearer $token"},
        // ),
      );
      print(response);
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      print(" exotel resp is ${response.data}");
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
