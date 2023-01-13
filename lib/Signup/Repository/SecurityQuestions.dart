// ignore_for_file: camel_case_types

import 'package:piadvisory/Signup/Model/Questions.dart';
import 'package:piadvisory/Utils/Constants.dart';
import 'package:piadvisory/Utils/base_manager.dart';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

late Questions question;

class getSecurityQuestions {
  Dio dio = new Dio();

  Future<ResponseData> getQuestions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    Response response;
    try {
      response = await dio.get(
        ApiConstant.securityQuestions,
        options: Options(
          headers: {"authorization": "Bearer $token"},
        ),
      );
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      question = Questions.fromJson(response.data);

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

  Future<ResponseData> PostAnswers(Map<String, dynamic> updata) async {
    print("post answer called");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    Response response;
    try {
      response = await dio.post(
        ApiConstant.securityAnswers,
        data: updata,
        options: Options(
          headers: {"authorization": "Bearer $token"},
        ),
      );
      print('post called');
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      //question = Questions.fromJson(response.data);
      print(response.data);
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
