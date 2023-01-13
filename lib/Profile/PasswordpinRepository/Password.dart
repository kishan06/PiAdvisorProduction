import 'package:dio/dio.dart';
import 'package:piadvisory/Utils/Constants.dart';
import 'package:piadvisory/Utils/base_manager.dart';
import 'package:piadvisory/Utils/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassword {
  Dio dio = new Dio();

  Future<ResponseData> postChangePassword(Map<String, dynamic> updata) async {
    Response response;
    print("reached");
    print(updata);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    try {
      response = await dio.post(
        ApiConstant.postchangepassword,
        data: updata,
        // options: Options(headers: {"authorization": "Bearer $token"})
      );
      print("I am here");
    } on Exception catch (_) {
      print("Not reached");
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }
    print(" resp is $response");
    if (response.statusCode == 200) {
      print("response is ${response.data}");
      return ResponseData<dynamic>(
        "success",
        ResponseStatus.SUCCESS,
      );
    } else if (response.statusCode == 201) {
      return ResponseData<dynamic>(
          response.data['status'].toString(), ResponseStatus.FAILED);
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
