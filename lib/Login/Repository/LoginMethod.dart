import 'package:piadvisory/Utils/Constants.dart';
import 'package:piadvisory/Utils/base_manager.dart';

import 'package:dio/dio.dart';
import 'package:piadvisory/Utils/database.dart';

import 'package:shared_preferences/shared_preferences.dart';

bool? fingerPrintStatusGlobal;

class LoginMethod {
  Dio dio = new Dio();

  Future<ResponseData> postPhoneLoginDetails(
      Map<String, dynamic> updata, context) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      response = await dio.post(
        ApiConstant.loginAPI,
        data: updata,
      );
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Invalid Credentials', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      Map<String, dynamic> res = response.data;

      await prefs.setString('token', res["token"]);
      await prefs.setInt('user_id', res["user_id"]);

      int userIdList = Database().restoreUserIdAsList();
      if (userIdList == res["user_id"]) {
        fingerPrintStatusGlobal = true;
      } else {
        fingerPrintStatusGlobal = false;
      }

      Map<String, dynamic> store = {
        'email': res['email'],
        'number': res['number'],
        'fullname': res["fullname"],
      };
      Database().storeUserDetails(store);

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

  Future<ResponseData> postPinStatus(updata) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    try {
      response = await dio.post(ApiConstant.postPinStatus,
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

  Future<ResponseData> checkMobileExist(
      Map<String, dynamic> updata, context) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      response = await dio.post(
        ApiConstant.mobileExist,
        data: updata,
      );
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Invalid Credentials', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      print(response);
      if (response.data['status'] == "success") {
        return ResponseData<dynamic>(
          response.data['status'],
          ResponseStatus.SUCCESS,
        );
      } else {
        return ResponseData<dynamic>(
          response.data['status'],
          ResponseStatus.PRIVATE,
        );
      }
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
