import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:piadvisory/Common/ConnectivityService.dart';
import 'package:provider/provider.dart';


bool ? isOnlineB;

class NetworkSensitive extends StatelessWidget {
  bool checkInternetError = false;
  final Widget? child;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  NetworkSensitive({this.child, this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    _showInSnackBar(String value, bool isOnline) {
      var duration = 10000000;
      var backgroundColors = Colors.red;
      if (isOnline) {
        duration = 3000;
        backgroundColors = Colors.green;
      }
      ScaffoldMessenger.of(context).hideCurrentSnackBar(reason: SnackBarClosedReason.remove);
      return Get.snackbar(
        '',
        value,
        padding: EdgeInsets.only(bottom: 25,left: 10),
        backgroundColor:Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    showInternetError(bool isOnline) async {
      try {
        isOnlineB = isOnline;

        await new Future.delayed(const Duration(milliseconds: 200));

        if (!isOnline) {
          if (checkInternetError) {
            _showInSnackBar("Please Check Your Internet!", isOnline);
          }
        } else {
          if (checkInternetError) {
            checkInternetError = false;
            _showInSnackBar("Back Online!", isOnline);
          }
        }
      } catch (e) {
      }
    }
    // Get our connection status from the provider
    var connectionStatus = Provider.of<ConnectivityStatus>(context);

    if (connectionStatus == ConnectivityStatus.WiFi || connectionStatus == ConnectivityStatus.Cellular) {
      showInternetError(true);


      return child!;
    }
    if (connectionStatus == ConnectivityStatus.Offline) {
      checkInternetError = true;
      showInternetError(false);

      return child!;
    }

    return child!;
  }




}
