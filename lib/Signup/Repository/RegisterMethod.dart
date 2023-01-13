// ignore_for_file: camel_case_types

import 'package:piadvisory/Utils/Constants.dart';
import 'package:piadvisory/Utils/base_manager.dart';
import 'package:dio/dio.dart';
import 'package:piadvisory/Utils/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterUser {
  Dio dio = new Dio();

  Future<ResponseData> postRegisterUser(Map<String, dynamic> updata) async {
    Response response;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();

    response = await dio.post(ApiConstant.registerUser,
        data: updata,
        options: Options(headers: {"authorization": "Bearer $token"}));

    if (response.statusCode == 200) {
      Map<String, dynamic> res = response.data;
      print("response is  $res ");
      Map<String, dynamic> store = {
        'email': res['email'].first,
        'number': res['number'].first,
        'fullname': res["fullname"].first,
      };
      print("stored value is $store");
      Database().storeUserDetails(store);
      return ResponseData<dynamic>(
        "success",
        ResponseStatus.SUCCESS,
      );
    } else if (response.statusCode == 201) {
      return ResponseData<dynamic>(
          response.data['status'].toString(), ResponseStatus.FAILED);
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

  Future<ResponseData> postRegisterNumber(Map<String, dynamic> updata) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      response = await dio.post(
        ApiConstant.registerNumber,
        data: updata,
      );
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      Map<String, dynamic> res = response.data;
      await prefs.setString('token', res["token"]);
      await prefs.setInt('user_id', res["user_id"]);
      print("response is ${response.data}");
      return ResponseData<dynamic>(
        "success",
        ResponseStatus.SUCCESS,
      );
    } else if (response.statusCode == 201) {
      print(response.data);
      return ResponseData<dynamic>(
          response.data['message'].toString(), ResponseStatus.FAILED);
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
