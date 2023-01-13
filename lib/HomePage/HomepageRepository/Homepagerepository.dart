import 'package:piadvisory/Utils/Constants.dart';
import 'package:piadvisory/Utils/base_manager.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

late String? homestatus;
bool? homepopupbool;
late bool homePage;

class GetHomepagePopup {
  Dio dio = new Dio();

  Future<ResponseData> getHomepagePopup() async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    try {
      response = await dio.get(ApiConstant.gethomepagepopup,
          options: Options(headers: {"authorization": "Bearer $token"}));
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      homepopupbool = response.data["useridexist"];
      // homePage = response.data["HomePageStatus"];
      // print("Homepage  $homePage");

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

    // print(" resp is $response");
    // if (response.statusCode == 200) {
    //   print("resp $response");

    //   return ResponseData<dynamic>(
    //     "success",
    //     ResponseStatus.SUCCESS,
    //   );
    // } else {
    //   try {
    //     return ResponseData<dynamic>(
    //         response.data['message'].toString(), ResponseStatus.FAILED);
    //   } catch (_) {
    //     return ResponseData<dynamic>(
    //         response.statusMessage!, ResponseStatus.FAILED);
    //   }
    // }
  }
}
