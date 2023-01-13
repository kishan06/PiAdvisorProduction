// ignore_for_file: camel_case_types

import 'package:piadvisory/SideMenu/About%20Model/about.dart';
import 'package:piadvisory/Signup/Model/Questions.dart';
import 'package:piadvisory/Utils/Constants.dart';
import 'package:piadvisory/Utils/base_manager.dart';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

aboutus? aboutuspage;

class getAbout {
  Dio dio = new Dio();

  Future<ResponseData> getAboutus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    Response response;
    try {
      response = await dio.get(
        ApiConstant.getabout,
      );
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      aboutuspage = aboutus.fromJson(response.data);
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
