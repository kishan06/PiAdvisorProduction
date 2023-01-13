// ignore_for_file: camel_case_types

import 'package:piadvisory/Utils/Constants.dart';
import 'package:piadvisory/Utils/base_manager.dart';

import 'package:dio/dio.dart';
import 'package:piadvisory/Utils/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifyOTP {
  Dio dio = new Dio();

  Verifyotpdetails(Map<String, dynamic> updata, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token").toString();
    Response response;
    try {
      response = await dio.post(
        ApiConstant.verifyotp,
        data: updata,
        options: Options(
          headers: {"authorization": "Bearer $token"},
        ),
      );
      print(response.data);
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      print(response.data);
      return response.data['error'].toString();
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

  Future<ResponseData> VerifydetailsWithoutToken(
      Map<String, dynamic> updata, context) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      response = await dio.post(
        ApiConstant.verifyotpWithoutToken,
        data: updata,
      );
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      Map<String, dynamic> res = response.data;

      await prefs.setString('token', res["token"]);

      Map<String, dynamic> store = {
        'email': res['email'],
        'number': res['number'],
        'fullname': res["fullname"],
      };
      Database().storeUserDetails(store);
      return ResponseData<dynamic>(
          response.data['error'].toString(), ResponseStatus.SUCCESS);
    } else if (response.statusCode == 201) {
      return ResponseData<dynamic>(
          response.data['message'].toString(), ResponseStatus.PRIVATE);
    } else {
      return ResponseData<dynamic>(
          response.statusMessage!, ResponseStatus.FAILED);
    }
  }
}
