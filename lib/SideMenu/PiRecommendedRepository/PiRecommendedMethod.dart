// ignore_for_file: camel_case_types

//import 'package:piadvisory/SideMenu/license.dart';
import 'package:piadvisory/Common/user_id.dart';
import 'package:piadvisory/SideMenu/License%20Model/license.dart';
import 'package:piadvisory/Signup/Model/PiRecommendedModel.dart';
import 'package:piadvisory/Signup/Model/Questions.dart';
import 'package:piadvisory/Utils/Constants.dart';
import 'package:piadvisory/Utils/base_manager.dart';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

PiRecommendedModel? piRecom;

class getAdvices {
  Dio dio = new Dio();

  Future<ResponseData> getPiRecomAdvice() async {
    Response response;
    int? userId = await getUserId();
    print("user id is $userId");
    try {
      // response = await dio.get(
      //   "https://pi.betadelivery.com/pi_advisors/api/get_manage_advisors" +
      //       '/$userId', //implement general api
      response = await dio.get(
        '${ApiConstant.pirecommeded}' + '/$userId', //implement general api
      );
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      print("resp of pirecom is ${response.data}");
      piRecom = PiRecommendedModel.fromJson(response.data);
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
