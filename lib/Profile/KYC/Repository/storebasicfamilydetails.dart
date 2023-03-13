import 'dart:convert';

import 'package:piadvisory/Utils/Constants.dart';
import 'package:piadvisory/Utils/base_manager.dart';
import 'package:dio/dio.dart';
import 'package:piadvisory/Utils/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Personalprofilerepository/Model/familybasicdetails.dart';

familybasicdetails? familyDetails;

class Storefamilydetails {
  Dio dio = new Dio();

  Future<ResponseData> postStorefamilydetails(
      Map<String, dynamic> updata) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    try {
      response = await dio.post(ApiConstant.poststorefamilydetails,
          data: updata,
          options: Options(headers: {"authorization": "Bearer $token"}));
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }
    print(" resp is $response");
    if (response.statusCode == 200) {
      // Map<String, dynamic> res = response.data;
      // await prefs.setString('token', res["token"]);
      //  familyDetails = familybasicdetails.fromJson(response.data);
      print(response);

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

  Future<ResponseData> getBasicfamilyDetails() async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    try {
      response = await dio.get(ApiConstant.getfamilydetails,
          options: Options(headers: {"authorization": "Bearer $token"}));
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }
    print(" resp is $response");
    if (response.statusCode == 200) {
      familyDetails = familybasicdetails.fromJson(response.data);
      print(response);

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

  Future<ResponseData> postgeneratedkycdetails() async {
    Response response;
    Map<String, dynamic> updata = Database().restoreKYCRequestID();
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    print("reached to generate kyc id");
    String username =
        'AIKXNZ35JKSNK9R4TQJEHNAUPU3KYKRV'; //testing server username
    //'AIDF89IQS2TLTS6OFP1LNP7W9YFH2XGR'; // production server username
    String password =
        'YJ2CKKL1YFL87Y6MFJ7DW1EV9GI7KPSG'; //testing server password
    //'X18RW1DXHOLDLCAQ2J182JEVGRJN9T3G'; //production server password
    String basicAuth =
        'Basic ' + base64.encode(utf8.encode('$username:$password'));

    try {
      response = await dio.post(
          //"https://ext.digio.in:444/client/kyc/v2/${updata['requestId']}/response", // production api
          "https://api.digio.in/client/kyc/v2/${updata['requestId']}/response",
          //KID230310155152512Q955GCQBS254YI
          //${'KID23031014574400568XHDVKZI6YV79'}
          //data: updata,
          options: Options(headers: {"authorization": basicAuth}));
    } on Exception catch (_) {
      print("failed");
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      print("digio cred resp is ${response.data}");

      // String respone = response.data;
      // int myresponse = int.parse(respone);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? user_id = await prefs.getInt('user_id');
      Map<String, dynamic> updata = {
        "user_id": user_id,
        "digilocker_id": response.data["actions"][0]["execution_request_id"],
        "selfie_id": response.data["actions"][2]["file_id"],
        "signature_id": response.data["actions"][3]["file_id"],
        "video_id": response.data["actions"][2]["file_id"],
        "document_flow_id": response.data["actions"][4]["execution_request_id"],
        "image_id": "FIL230310150313168SRRO27FL9UBW95"
      };
      print(updata);
      UploadData(updata);
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

  Future<ResponseData> postDigiocred(Map<String, dynamic> updata) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    try {
      response = await dio.post(ApiConstant.postdigiocred,
          data: updata,
          options: Options(headers: {"authorization": "Bearer $token"}));
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }
    print(" resp is $response");
    if (response.statusCode == 200) {
      // Map<String, dynamic> res = response.data;
      // await prefs.setString('token', res["token"]);
      //  familyDetails = familybasicdetails.fromJson(response.data);
      print(response);
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

  void UploadData(updata) async {
    final data = await Storefamilydetails().postDigiocred(updata);
    if (data.status == ResponseStatus.SUCCESS) {
      //utils.showToast("");
      print('Success');
    } else {
      print('failed');
      //return utils.showToast(data.message);
    }
  }
}
