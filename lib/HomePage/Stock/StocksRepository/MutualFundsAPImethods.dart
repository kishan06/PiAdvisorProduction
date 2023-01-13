import 'package:piadvisory/HomePage/Stock/Model/AllMutualFundsModel.dart';
import 'package:piadvisory/HomePage/Stock/Model/GetSchemeDataModel.dart';
import 'package:piadvisory/HomePage/Stock/Model/MFSnapshotSummary.dart';
import 'package:piadvisory/HomePage/Stock/Model/MutualFundGraphPlotting.dart';
import 'package:piadvisory/HomePage/Stock/Model/topHoldingsModel.dart';

import 'package:piadvisory/Utils/base_manager.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

late MutualFundGraphPlotting? priceData;
late MFSnapShotSummaryModel? summaryData;
GetSchemeDataModel? schemeBasicData;
late topHoldingsModel? topHoldings;
AllMutualFundsModel? allSchemes;

class MutualFundsAPIMEthods {
  Dio dio = new Dio();

  Future<ResponseData> NAVGraph(String schemecode) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    try {
      response = await dio.get(
        "https://mf.accordwebservices.com/MF/GetMFNAVGraph?SchemeCode=$schemecode&Period=3Y&ChType=RAW&DateOption=&token=wG2axAvNa3yX3DT89CHVHyg2x19TOZE5",
      );
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      priceData = MutualFundGraphPlotting.fromJson(response.data);
      print("nav grap resp is ${response.data}");

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

  Future<ResponseData> MFSnapShotSummary(String schemecode) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    try {
      response = await dio.get(
        "https://mf.accordwebservices.com/MF/GetMFSnapShotSummary?SchemeCode=$schemecode&token=wG2axAvNa3yX3DT89CHVHyg2x19TOZE5",
      );
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      summaryData = MFSnapShotSummaryModel.fromJson(response.data);

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

  Future<ResponseData> GetSchemeData(String schemecode) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    try {
      response = await dio.get(
        "https://mf.accordwebservices.com/MF/GetSchemeDetails_Filter?SchemeCode=$schemecode&AmcCode=&AssetType=&CatCode=&Risk=&OptCode=&PlanType=&SortExp=&SortDir=&PageNo=1&PageSize=10&token=wG2axAvNa3yX3DT89CHVHyg2x19TOZE5",
      );
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      schemeBasicData = GetSchemeDataModel.fromJson(response.data);
      print("scheme data is ${response.data}");
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

  Future<ResponseData> importTopholdings(String schemecode) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    try {
      response = await dio.get(
          "https://mf.accordwebservices.com/MF/GetMFTop10?&SchemeCode=$schemecode&Top=&PageNo=1&Pagesize=10&SortExpression=&SortDirection=&token=wG2axAvNa3yX3DT89CHVHyg2x19TOZE5",
          options: Options(headers: {"authorization": "Bearer $token"}));
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      topHoldings = topHoldingsModel.fromJson(response.data);
      print("scheme data is ${response.data}");
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

  Future<ResponseData> importAllMutualFunds() async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    try {
      response = await dio.get(
          "https://mf.accordwebservices.com/MF/GetScheme?Fund=&Category=&token=wG2axAvNa3yX3DT89CHVHyg2x19TOZE5",
          options: Options(headers: {"authorization": "Bearer $token"}));
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      allSchemes = AllMutualFundsModel.fromJson(response.data);
      print("scheme data is ${response.data}");
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
