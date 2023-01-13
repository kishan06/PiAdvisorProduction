import 'dart:async';

import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'package:piadvisory/Login/Repository/UserVerified.dart';
import 'package:piadvisory/Login/login.dart';
import 'package:piadvisory/Login/pindialog.dart';
import 'package:piadvisory/Profile/ProfileRepository/ProfileMethods.dart';
import 'package:piadvisory/SideMenu/Subscribe/Repository/getSubscriptionWithDetails.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';

int? isPinVerifiedGlobal;

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

var _isverified;
var _isotpverified;
var _isecurityverified;
var _ispinverified;
var _isFingerPrint;

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    OneSignal.shared.setLogLevel(OSLogLevel.debug, OSLogLevel.none);

    OneSignal.shared.setAppId("9b2d66fa-dcc1-402c-b847-684d5d52b41d");
    _ischeck();
  }

  Future<void> _ischeck() async {
    // final data2 = await UserVerified().getOtpVerifiedStatus();
    // final data = await UserVerified().getVerifiedStatus();
    // final data3 = await UserVerified().getSecurityQuestions();

    //  final data4 = await UserVerified().getPinexist();
    // final data1 = await UserVerified().getFingerPrintStatus();
    final result = await Future.wait([
      UserVerified().getPinexist(),
      UserVerified().getFingerPrintStatus(),
      getSubscriptionWithDetails().getsubsDetail(),
      ProfileMethods().getUpdateStatus()
    ]);

    setState(() {
      // _isotpverified = data2.data;
      // _isverified = data.data;
      // _isecurityverified = data3.data;
      _ispinverified = result[0].data; //data4.data;
      _isFingerPrint = result[1].data; // data1.data;
      isPinVerifiedGlobal = _ispinverified;
      // print("_isotpverified?   $_isotpverified");
      // print("_isverified? $_isverified");
      // print("_isecurityverified? $_isecurityverified");
      print("_ispinverified? $_ispinverified");
      print("_isFingerPrint? $_isFingerPrint");
    });
    countDownTime();
  }

  Map<String, bool> data = {"show_fingerprint": true};
  countDownTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? pinenabled = await prefs.getBool('pinenabled');

    return Timer(
      Duration(seconds: 1),
      () async {
        FlutterNativeSplash.remove();
        print("time out");
        bool? uid = await prefs.getBool('intro');
        if (uid != null && uid == true) {
          String? hastoken = await prefs.getString('token');
          print("token is $hastoken");
          if (hastoken != null) {
            pinenabled != null && !pinenabled
                ? _ispinverified == 1
                    ? _isFingerPrint == 1
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => PinDialog(
                                      showFingerAndPin: "yes",
                                    ))))
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => PinDialog(
                                      showFingerAndPin: "no",
                                    ))))
                    : Get.toNamed("/login")
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => PinDialog(
                              showFingerAndPin: "yes",
                            ))));
          } else {
            Get.toNamed('/login');
          }
        } else {
          Get.toNamed('/splashslider');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/pilogo.png',
                  height: 150.0,
                  width: 150.0,
                ),
              ]),
        ),
      ),
    );
  }
}
