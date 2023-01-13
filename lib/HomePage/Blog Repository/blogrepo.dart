// ignore_for_file: camel_case_types

import 'package:piadvisory/HomePage/Blog%20Repository/Model/BlogModel.dart';
import 'package:piadvisory/Signup/Model/Questions.dart';
import 'package:piadvisory/Utils/Constants.dart';
import 'package:piadvisory/Utils/base_manager.dart';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

late Blogs blogs;

class getBlogs {
  Dio dio = new Dio();

  Future<ResponseData> getBlogsandNews() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    Response response;
    try {
      response = await dio.get(
        ApiConstant.getblogs,
        options: Options(
          headers: {"authorization": "Bearer $token"},
        ),
      );
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      blogs = Blogs.fromJson(response.data);

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
