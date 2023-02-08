import 'package:piadvisory/Profile/Assets/AssetsRepository/Model/UserFixdeposit.dart';
import 'package:piadvisory/Profile/Assets/AssetsRepository/Model/UserMutualfund.dart';
import 'package:piadvisory/Profile/Assets/AssetsRepository/Model/UserRealestate.dart';
import 'package:piadvisory/Profile/Personalprofilerepository/Model/personalprofilebasicdetails.dart';
import 'package:piadvisory/Utils/Constants.dart';
import 'package:piadvisory/Utils/base_manager.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

UserMutualfund? userMutualfund;
UserFixdeposit? userFixdeposit;
UserRealestate? userRealestate;

class StoreAssetsform {
  Dio dio = new Dio();

  Future<ResponseData> postStoreAssetsformMF(
      Map<String, dynamic> updata) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    try {
      print("task completed");
      response = await dio.post(ApiConstant.postAssetsformMF,
          data: updata,
          options: Options(headers: {"authorization": "Bearer $token"}));
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

  Future<ResponseData> postStoreAssetsformFD(
      Map<String, dynamic> updata) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    try {
      print("I am here");
      response = await dio.post(ApiConstant.postAssetsformFD,
          data: updata,
          options: Options(headers: {"authorization": "Bearer $token"}));
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

  Future<ResponseData> postStoreAssetsformRE(
      Map<String, dynamic> updata) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    try {
      print("I am here");
      response = await dio.post(ApiConstant.postAssetsformRE,
          data: updata,
          options: Options(headers: {"authorization": "Bearer $token"}));
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

  Future<ResponseData> getAssetsMF() async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    try {
      response = await dio.get(ApiConstant.getAssetsmf,
          options: Options(headers: {"authorization": "Bearer $token"}));
    } on Exception catch (_) {
      print("error occured");
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      userMutualfund = UserMutualfund.fromJson(response.data);
      print(" mutual fund resp are  ${response.data} ");
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

  Future<ResponseData> getAssetsFD() async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    try {
      response = await dio.get(ApiConstant.getAssetsfd,
          options: Options(headers: {"authorization": "Bearer $token"}));
      print("$token");
    } on Exception catch (_) {
      print("error occured");
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      userFixdeposit = UserFixdeposit.fromJson(response.data);
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

  Future<ResponseData> getAssetsRE() async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    try {
      response = await dio.get(ApiConstant.getAssetsre,
          options: Options(headers: {"authorization": "Bearer $token"}));
      print("$token");
    } on Exception catch (_) {
      print("error occured");
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      userRealestate = UserRealestate.fromJson(response.data);
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

  Future<ResponseData> deleteMutualFunds(Map<String, dynamic> updata) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    try {
      response = await dio.post(ApiConstant.deleteGoals,
          data: updata,
          options: Options(headers: {"authorization": "Bearer $token"}));
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      // Map<String, dynamic> res = response.data;
      // await prefs.setString('token', res["token"]);

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
