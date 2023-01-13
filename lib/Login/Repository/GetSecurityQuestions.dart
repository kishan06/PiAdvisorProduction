import 'package:piadvisory/Utils/Constants.dart';
import 'package:piadvisory/Utils/base_manager.dart';

import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';

class GetSecurityQuestions {
  Dio dio = new Dio();

  Future<ResponseData> getSecurityQuestions() async {
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
}
