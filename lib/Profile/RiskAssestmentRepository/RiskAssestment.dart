import 'package:piadvisory/Profile/Model/RiskAnswers.dart';
import 'package:piadvisory/Profile/Model/RiskQuestions.dart';
import 'package:piadvisory/Utils/Constants.dart';
import 'package:piadvisory/Utils/base_manager.dart';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

late RiskQuestions question;
late RiskAnswers answers;

int? riskscore;
late String portfolioType;

class getRiskQuestions {
  Dio dio = new Dio();

  Future<ResponseData> getQuestions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    Response response;
    try {
      response = await dio.get(ApiConstant.riskQuestions
          // options: Options(
          //   headers: {"authorization": "Bearer $token"},
          // ),
          );
      // print("response is  ${response.data}");
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      print("response is  ${response.data}");
      question = RiskQuestions.fromJson(response.data);

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

  Future<ResponseData> getAnswers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    Response response;
    try {
      response = await dio.get(
        ApiConstant.riskAnswers,
        options: Options(
          headers: {"authorization": "Bearer $token"},
        ),
      );
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      print("get ans response is ${response.data}");
      answers = RiskAnswers.fromJson(response.data);

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

  Future<ResponseData> postQuestions(List<Map<String, dynamic>> updata) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    print(updata);
    Response response;
    try {
      response = await dio.post(
        ApiConstant.storeUserRiskProfile,
        data: {"data": updata},
        options: Options(
          headers: {"authorization": "Bearer $token"},
        ),
      );
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      // question = RiskQuestions.fromJson(response.data);
      print(response.data);
      riskscore = response.data['total score is'];
      if (riskscore! <= 40) {
        portfolioType = "Very Conservative";
      } else if (41 <= riskscore! && riskscore! <= 50) {
        portfolioType = "Conservative";
      } else if (51 <= riskscore! && riskscore! <= 65) {
        portfolioType = "Moderate";
      } else if (66 <= riskscore! && riskscore! <= 75) {
        portfolioType = "Moderately Aggressive";
      } else if (76 <= riskscore! && riskscore! <= 84) {
        portfolioType = "Aggressive";
      } else if (85 <= riskscore! && riskscore! <= 100) {
        portfolioType = "Very Aggressive";
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
