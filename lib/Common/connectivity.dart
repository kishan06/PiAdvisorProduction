import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConnectivityController extends GetxController {
  var connectionType = "".obs;
  final Connectivity connectivity = Connectivity();
  late StreamSubscription streamSubscription;
  @override
  void onInit() {
    super.onInit();
    getConnctionStatus();
    streamSubscription =
        connectivity.onConnectivityChanged.listen(getConnectionType);
  }

  void getConnctionStatus() async {
    ConnectivityResult connectionResult;
    try {
      connectionResult = await connectivity.checkConnectivity();
      // print(connectionResult);
      getConnectionType(connectionResult);
    } catch (e) {
      Get.snackbar("excepetion", "Error during connectivity cheking");
    }
  }

  void getConnectionType(connectionResult) {
    if (connectionResult == ConnectivityResult.wifi) {
      connectionType.value = "Wifi";
      // print('wifi');
      // Get.snackbar('Wifi c ', 'Please check you\'r Inernt connection');
      Get.snackbar(
        'Internet Connection ',
        'Internet Connected',
        colorText: Colors.black,
        backgroundColor: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else if (connectionResult == ConnectivityResult.mobile) {
      connectionType.value = "Mobile Internet";
      // print('Mobile Internet');
      // Get.snackbar('No Internt ', 'Please check you\'r Inernt connection');
      Get.snackbar(
        'Internet Connection',
        'Internet Connected',
        colorText: Colors.black,
        backgroundColor: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      connectionType.value = "No Internet";
      Get.snackbar(
        'No Internet',
        'Please check you\'r Internet connection',
        colorText: Colors.black,
        backgroundColor: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
