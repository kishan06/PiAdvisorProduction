import 'package:piadvisory/Utils/Constants.dart';
import 'package:piadvisory/Utils/base_manager.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storeadvisordetails {
  Dio dio = new Dio();

  Future<ResponseData> postStoreadvisordetails(
      Map<String, dynamic> updata) async {
    print("reached till here");
    print(updata);
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    print("I am here");
    try {
      print("reached");
      response = await dio.post(ApiConstant.poststoreadvisordetails,
          data: updata,
          options: Options(headers: {"authorization": "Bearer $token"}));
    } on Exception catch (_) {
      print("Not reached");
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }
    print(" resp is $response");
    if (response.statusCode == 200) {
      // Map<String, dynamic> res = response.data;
      // await prefs.setString('token', res["token"]);

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
}
