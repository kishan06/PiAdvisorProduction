import 'package:piadvisory/Login/Repository/GetSecurityQuestions.dart';
import 'package:piadvisory/Utils/Constants.dart';
import 'package:piadvisory/Utils/base_manager.dart';

import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';

bool fingerPrintStatus = false;
int? checkPinExist;

class UserVerified {
  Dio dio = new Dio();

  Future<ResponseData> getVerifiedStatus() async {
    Response response;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    try {
      response = await dio.get(ApiConstant.getVerifiedStatus,
          options: Options(headers: {"authorization": "Bearer $token"}));
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Invalid Credentials', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      Map<String, dynamic> res = response.data;

      return ResponseData<dynamic>("success", ResponseStatus.SUCCESS,
          data: res['isVerified']);
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

  Future<ResponseData> getOtpVerifiedStatus() async {
    Response response;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    try {
      response = await dio.get(ApiConstant.getOtpVerifiedStatus,
          options: Options(headers: {"authorization": "Bearer $token"}));
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Invalid Credentials', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      Map<String, dynamic> res = response.data;

      return ResponseData<dynamic>("success", ResponseStatus.SUCCESS,
          data: res['isotpVerified']);
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

  Future<ResponseData> getSecurityQuestions() async {
    Response response;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    try {
      response = await dio.get(ApiConstant.getSecurity_Questions,
          options: Options(headers: {"authorization": "Bearer $token"}));
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Invalid Credentials', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      Map<String, dynamic> res = response.data;

      return ResponseData<dynamic>("success", ResponseStatus.SUCCESS,
          data: res['is_securityquestion']);
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

  Future<ResponseData> getPinexist() async {
    Response response;
    print("called");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    try {
      response = await dio.get(ApiConstant.getPinexist,
          options: Options(headers: {"authorization": "Bearer $token"}));
      print(response);
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Invalid Credentials', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      Map<String, dynamic> res = response.data;
      checkPinExist = res['pin_exists'];
      return ResponseData<dynamic>("success", ResponseStatus.SUCCESS,
          data: res['pin_exists']);
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

  Future<ResponseData> getFingerPrintStatus() async {
    Response response;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    try {
      response = await dio.get(ApiConstant.getFingerPrintStatus,
          options: Options(headers: {"authorization": "Bearer $token"}));
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Invalid Credentials', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      Map<String, dynamic> res = response.data;
      if (res['is_fignerprint'] == 1) {
        fingerPrintStatus = true;
      } else {
        fingerPrintStatus = false;
      }

      return ResponseData<dynamic>("success", ResponseStatus.SUCCESS,
          data: res['is_fignerprint']);
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

  Future<ResponseData> postUpdateFingerstatus(
      Map<String, dynamic> updata) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    try {
      response = await dio.post(ApiConstant.postupdatefingerstatus,
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
      var msg = res['message'];
      print(response);

      return ResponseData<dynamic>(
        msg,
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
