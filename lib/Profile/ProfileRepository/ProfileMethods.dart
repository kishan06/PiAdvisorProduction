import 'package:logger/logger.dart';
import 'package:piadvisory/Utils/Constants.dart';
import 'package:piadvisory/Utils/base_manager.dart';

import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';

late String? kycstatus;
bool? kycsbool;
bool? personalProfile;

class ProfileMethods {
  Dio dio = new Dio();

  Future<ResponseData> getUpdateStatus() async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    var logger = Logger(
      printer: PrettyPrinter(),
    );
    try {
      response = await dio.get(ApiConstant.getUpdateStatus,
          options: Options(headers: {"authorization": "Bearer $token"}));
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      print("response of kyc status is $response");
      if (response.data["status"] == null) {
        kycstatus = null;
        personalProfile = response.data["PersonalProfileStatus"];
      } else {
        kycstatus = response.data["status"]["kyc_status"];
        personalProfile = response.data["PersonalProfileStatus"];
      }

      if (kycstatus == "approval_pending") {
        kycsbool = true;
      } else if (kycstatus == null) {
        kycsbool = false;
      } else {
        kycsbool = false;
      }
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
