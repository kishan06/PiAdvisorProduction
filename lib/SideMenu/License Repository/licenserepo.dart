// ignore_for_file: camel_case_types

//import 'package:piadvisory/SideMenu/license.dart';
import 'package:piadvisory/SideMenu/License%20Model/license.dart';
import 'package:piadvisory/Signup/Model/Questions.dart';
import 'package:piadvisory/Utils/Constants.dart';
import 'package:piadvisory/Utils/base_manager.dart';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

license? licensepage;

class getLicense {
  Dio dio = new Dio();

  Future<ResponseData> License() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    Response response;
    try {
      response = await dio.get(
        ApiConstant.getlicense, //implement general api
      );
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      print("resp of licences is ${response.data}");
      licensepage = license.fromJson(response.data);
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
