import 'package:piadvisory/Profile/KYC/Model/AppointmentsByDate.dart';
import 'package:piadvisory/Profile/KYC/Model/appointments.dart';
import 'package:piadvisory/Profile/KYC/Model/slotModel.dart';
import 'package:piadvisory/Profile/Personalprofilerepository/Model/kycbasicdetails.dart';
import 'package:piadvisory/Utils/Constants.dart';
import 'package:piadvisory/Utils/base_manager.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Personalprofilerepository/Model/addincomebasicdetails.dart';

//appointment? appointData;
slotModel? slotsData;
AppointmentsByDate? appointmentbyDates;

class ScheduleAppointment {
  Dio dio = new Dio();

  Future<ResponseData> fetchSlotDetails(Map<String, dynamic> updata) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    try {
      response = await dio.post(ApiConstant.fetchslotDetails,
          data: updata,
          options: Options(headers: {"authorization": "Bearer $token"}));
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      // Map<String, dynamic> res = response.data;
      // await prefs.setString('token', res["token"]);
      slotsData = slotModel.fromJson(response.data);
      print(" resp is $response");
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

  Future<ResponseData> postAppointmentDetails(
      Map<String, dynamic> updata) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    try {
      response = await dio.post(ApiConstant.appointmentDetails,
          data: updata,
          options: Options(headers: {"authorization": "Bearer $token"}));
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      // Map<String, dynamic> res = response.data;
      // await prefs.setString('token', res["token"]);

      print(" resp is ${response.data}");
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

  // Future<ResponseData> fetchappointments() async {
  //   Response response;
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? token = await prefs.getString('token').toString();
  //   try {
  //     response = await dio.get(ApiConstant.fetchAppointments,
  //         options: Options(headers: {"authorization": "Bearer $token"}));
  //   } on Exception catch (_) {
  //     return ResponseData<dynamic>(
  //         'Oops something Went Wrong', ResponseStatus.FAILED);
  //   }

  //   if (response.statusCode == 200) {
  //     // Map<String, dynamic> res = response.data;
  //     // await prefs.setString('token', res["token"]);

  //     if (response.data["status"] == "no data exist") {
  //     } else {
  //       appointData = appointment.fromJson(response.data);
  //     }

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

  Future<ResponseData> fetchAppointmentDetailsByDate(
      Map<String, dynamic> updata) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    try {
      response = await dio.post(ApiConstant.fetchAppointmentsDate,
          data: updata,
          options: Options(headers: {"authorization": "Bearer $token"}));
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      // Map<String, dynamic> res = response.data;
      // await prefs.setString('token', res["token"]);
      appointmentbyDates = AppointmentsByDate.fromJson(response.data);
      print(" resp is ${response.data}");
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
