import 'package:piadvisory/Profile/Model/RiskQuestions.dart';
import 'package:piadvisory/SideMenu/Subscribe/Model/SubscriptionFullDetails.dart';
import 'package:piadvisory/Utils/Constants.dart';
import 'package:piadvisory/Utils/base_manager.dart';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import '../Model/SubscriptionPlans.dart';

late SubscriptionFullDetails subsDetail;
//SubscriptionPlans? subsPlans;
late bool userHasSubscription = false;

class getSubscriptionWithDetails {
  Dio dio = new Dio();

  Future<ResponseData> getsubsDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    Response response;
    try {
      print("api calling");
      response = await dio.get(
        "${ApiConstant.base}api/getSubs_with_detail",
        options: Options(
          headers: {"authorization": "Bearer $token"},
        ),
      );
      print(response.data);
    } on Exception catch (_) {
      print("error in subs api");
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      print("success");
      print(response.data);
      subsDetail = SubscriptionFullDetails.fromJson(response.data);
      if (subsDetail.message == "failed") {
        userHasSubscription = false;
      } else {
        userHasSubscription = true;
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

  // Future<ResponseData> getPlans() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? token = await prefs.getString('token').toString();
  //   Response response;
  //   try {
  //     print("api calling");
  //     response = await dio.get(
  //       "${ApiConstant.base}api/get_all_plans",
  //       options: Options(
  //         headers: {"authorization": "Bearer $token"},
  //       ),
  //     );
  //     print(response.data);
  //   } on Exception catch (_) {
  //     print("error in subs api");
  //     return ResponseData<dynamic>(
  //         'Oops something Went Wrong', ResponseStatus.FAILED);
  //   }

  //   if (response.statusCode == 200) {
  //     print("success");
  //     print(response.data);
  //     subsPlans = SubscriptionPlans.fromJson(response.data);

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
