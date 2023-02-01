import 'package:piadvisory/Profile/Personalprofilerepository/Model/personalprofilebasicdetails.dart';
import 'package:piadvisory/Utils/Constants.dart';
import 'package:piadvisory/Utils/base_manager.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreLiabilitiesform {
  Dio dio = new Dio();

  Future<ResponseData> postStoreLiabilitiesformHL(
      Map<String, dynamic> updata) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    try {
      print("I am here");
      response = await dio.post(ApiConstant.postLiabiltiesformHL,
          data: updata,
          options: Options(headers: {"authorization": "Bearer $token"})
          );
      print(updata);
      print("token is $token");
    } on Exception catch (_) {
      print("task failed");
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }
    print(" resp is $response");
    if (response.statusCode == 200) {
      // Map<String, dynamic> res = response.data;
      // await prefs.setString('token', res["token"]);

     print("mf response is ${response.data}");

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

    Future<ResponseData> postStoreLiabilitiesformPL(
      Map<String, dynamic> updata) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    try {
      print("I am here");
      response = await dio.post(ApiConstant.postLiabiltiesformPL,
          data: updata,
          options: Options(headers: {"authorization": "Bearer $token"})
          );
      print(updata);
      print("token is $token");
    } on Exception catch (_) {
      print("task failed");
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }
    print(" resp is $response");
    if (response.statusCode == 200) {
      // Map<String, dynamic> res = response.data;
      // await prefs.setString('token', res["token"]);

      print("mf response is ${response.data}");

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

      Future<ResponseData> postStoreLiabilitiesformCL(
      Map<String, dynamic> updata) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    try {
      print("I am here");
      response = await dio.post(ApiConstant.postLiabiltiesformCL,
          data: updata,
          options: Options(headers: {"authorization": "Bearer $token"})
          );
      print(updata);
      print("token is $token");
    } on Exception catch (_) {
      print("task failed");
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }
    print(" resp is $response");
    if (response.statusCode == 200) {
      // Map<String, dynamic> res = response.data;
      // await prefs.setString('token', res["token"]);

     print("mf response is ${response.data}");

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

  // Future<ResponseData> getPersonalprofile() async {
  //   Response response;
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? token = await prefs.getString('token').toString();
  //   try {
  //     response = await dio.get(ApiConstant.getpersonalprofiledetails,
  //         options: Options(headers: {"authorization": "Bearer $token"}));
  //   } on Exception catch (_) {
  //     return ResponseData<dynamic>(
  //         'Oops something Went Wrong', ResponseStatus.FAILED);
  //   }
  //   print(" resp is $response");
  //   if (response.statusCode == 200) {
  //     // personalprofileDetails =
  //     //     personalprofilebasicdetails.fromJson(response.data);
  //     print(response);

  //     return ResponseData<dynamic>(
  //       "success",
  //       ResponseStatus.SUCCESS,
  //     );
  //   } else {
  //     try {
  //       return ResponseData<dynamic>(
  //           response.data['message'].toString(), ResponseStatus.FAILED);
  //     } catch (_) {
  //       return ResponseData<dynamic>(
  //           response.statusMessage!, ResponseStatus.FAILED);
  //     }
  //   }
  // }
}
