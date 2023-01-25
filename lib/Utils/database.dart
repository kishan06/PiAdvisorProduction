import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';

class Database extends GetxController {
  final box = GetStorage();

  Future<void> initStorage() async {
    await GetStorage.init();
  }

  void storePriceModel(int value) {
    if (value == 0) {
      box.write('amount', 100);
      box.write('planName', "Investment Advisory");
    } else if (value == 1) {
      box.write('amount', 199900);
      box.write('planName', "Tax Planning");
    } else if (value == 2) {
      box.write('amount', 99900);
      box.write('planName', "Investment Advisory+ Tax Planning");
    }
  }

  storeUserDetails(Map<String, dynamic> value) {
    box.write('email', value['email']);
    box.write('number', value['number']);
    box.write('fullname', value['fullname']);
  }

  storeKYCRequestID(Map<String, dynamic> value) {
    box.write('requestId', value['requestId']);
  }

  storeKycDetails(Map<String, dynamic> value) {
    box.write('kycdetails', value);
  }

  restoreKycDetails() {
    String data = box.read('kycdetails');

    return data;
  }

  storeLink(String value) {
    box.write('link', value);
  }

  restoreLink() {
    String link = box.read('link');
    debugPrint("link is $link");

    return link;
  }

  deleteStorage() {
    box.erase();
  }

  restoreKYCRequestID() {
    Map<String, dynamic> updata = {'requestId': box.read('requestId') ?? {}};
    return updata;
  }

  restoreUserDetails() {
    Map<String, dynamic> updata = {
      'email': box.read('email') ?? {},
      'number': box.read('number') ?? {},
      'fullname': box.read('fullname') ?? {}
    };
    return updata;
  }

  restorePriceAndPlanName() {
    Map<String, dynamic> updata = {
      'amount': box.read('amount') ?? 100,
      'planName': box.read('planName') ?? "Investment Advisory",
    };

    return updata;
  }

  storePanAndDob(Map<String, dynamic> value) {
    box.write('pan_no', value['pan_no']);
    box.write('dob', value['dob']);
  }

  restorePanAndDob() {
    Map<String, dynamic> updata = {
      'pan_no': box.read('pan_no'),
      'dob': box.read('dob'),
    };

    return updata;
  }

  storeUserIDasList(int value) {
    // List<int> data = [];
    //  box.write('user_id_list', () => data.add(value));
    box.write('user_id_list', value);
  }

  restoreUserIdAsList() {
    return box.read('user_id_list');
  }
}
