// ignore_for_file: prefer_const_constructors, avoid_print, use_build_context_synchronously, non_constant_identifier_names

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:piadvisory/Common/CustomNextButton.dart';
import 'package:piadvisory/Login/Repository/LoginMethod.dart';
import 'package:piadvisory/Login/login.dart';
import 'package:piadvisory/SideMenu/Subscribe/Repository/getSubscriptionWithDetails.dart';
import 'package:piadvisory/Signup/Repository/Securityfirstpage.dart';
import 'package:piadvisory/Utils/database.dart';
import 'package:piadvisory/Utils/textStyles.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import '../HomePage/Homepage.dart';

class TouchID2 extends StatefulWidget {
  const TouchID2({Key? key}) : super(key: key);

  @override
  State<TouchID2> createState() => _TouchID2State();
}

class _TouchID2State extends State<TouchID2> {
  bool check = false;
  bool? _hasBioSensor;
  LocalAuthentication authentication = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    getSubscriptionWithDetails().getsubsDetail();
    //_checkBio();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        // appBar: CustomAppBar(
        //   titleTxt: 'Touch ID',
        // ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(height: 140.h),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Set-up Touch Id",
                            style: blackStyle(context).copyWith(
                                fontSize: 24,
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.black),
                          ),
                          SizedBox(height: 70.h),
                          SizedBox(
                            width: 286.w,
                            height: 286.h,
                            child: SvgPicture.asset(
                              'assets/images/fingerIcon.svg',
                              width: 140,
                            ),
                          ),
                          SizedBox(
                            height: 150.h,
                          ),
                          SizedBox(
                              width: double.infinity,
                              height: 60.h,
                              child: CustomNextButton(
                                text: "Set up Now!",
                                ontap: () {
                                  _checkBio();
                                },
                              )),
                          SizedBox(
                            height: 16.h,
                          ),
                          GestureDetector(
                            onTap: () {
                              //     buildGuidedTour();
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => HomePage(
                                            showVideo: false,
                                          )),
                                  (Route<dynamic> route) => false);
                            },
                            child: Text(
                              'will do it later',
                              style: TextStyle(
                                fontFamily: 'Productsans',
                                fontSize: 14,
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Color(0xFF585858),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _checkBio() async {
    try {
      _hasBioSensor = await authentication.canCheckBiometrics;
      List<BiometricType> availableBiometrics =
          await authentication.getAvailableBiometrics();
      final isDeviceSupported = await authentication.isDeviceSupported();
      print(_hasBioSensor);
      print(availableBiometrics);
      print("device support $isDeviceSupported");
      if (_hasBioSensor!) {
        _getAuth(); //  _getAuthwithfinger();
      } else {
        _getAuth();
        print("fingerprint not available");
      }

      // ignore: empty_catches
    } on PlatformException {}
  }

  Future<void> _getAuthwithfinger() async {
    print("getauth called");
    bool isAuth = false;
    try {
      isAuth = await authentication.authenticate(
        localizedReason: 'Scan your fingerprint to access the app',
        options: const AuthenticationOptions(
          biometricOnly: true,
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
      if (isAuth) {
        UploadSecurityFirst().postFingerPrintStatus();
        // buildGuidedTour();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        int? userid = await prefs.getInt('user_id');
        Database().storeUserIDasList(userid!);
        fingerPrintStatusGlobal = true;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (builder) => HomePage(),
          ),
        );
        return;
      }

      // ignore: empty_catches
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;
  }

  Future<void> _getAuth() async {
    bool isAuth = false;
    try {
      isAuth = await authentication.authenticate(
        localizedReason: 'Enter your Pattern or Pin to unlock',
        options: const AuthenticationOptions(
          biometricOnly: false,
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
      if (isAuth) {
        UploadSecurityFirst().postFingerPrintStatus();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        int? userid = await prefs.getInt('user_id');
        Database().storeUserIDasList(userid!);
        fingerPrintStatusGlobal = true;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (builder) => HomePage(),
          ),
        );
        return;
      }

      // ignore: empty_catches
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;
  }
}
