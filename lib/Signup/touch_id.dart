// ignore_for_file: prefer_const_constructors, avoid_print, use_build_context_synchronously, non_constant_identifier_names

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:piadvisory/Common/CustomNextButton.dart';
import 'package:piadvisory/Login/login.dart';
import 'package:piadvisory/SideMenu/Subscribe/Repository/getSubscriptionWithDetails.dart';
import 'package:piadvisory/Signup/Repository/Securityfirstpage.dart';
import 'package:piadvisory/Utils/textStyles.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import '../HomePage/Homepage.dart';

class TouchId extends StatefulWidget {
  const TouchId({Key? key}) : super(key: key);

  @override
  State<TouchId> createState() => _TouchIdState();
}

class _TouchIdState extends State<TouchId> {
  bool _isyesclicked = true;
  bool _isnoclicked = false;
  bool check = false;
  bool? _hasBioSensor;
  LocalAuthentication authentication = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    getSubscriptionWithDetails().getsubsDetail();
    _checkBio();
  }

  buildGuidedTour() {
    return showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: false,
      enableDrag: false,
      context: context,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Get.isDarkMode ? Colors.grey : Colors.white),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Container(
            child: IntrinsicWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Divider(
                    color: Color(0xFF303030),
                    indent: 160,
                    endIndent: 160,
                    thickness: 3,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 40,
                      ),
                      Text(
                        'Would you like a guided tour of our app?',
                        style: blackStyle(context).copyWith(
                            fontSize: 16.sm,
                            fontWeight: FontWeight.bold,
                            color:
                                Get.isDarkMode ? Colors.white : Colors.black),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 25,
                      ),
                      Theme(
                        data: ThemeData(
                          unselectedWidgetColor: Color(0xFFF78104),
                        ),
                        child: Checkbox(
                          activeColor: const Color(0xFFF78104),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0))),
                          value: check,
                          onChanged: (bool? check) {
                            setState(() {
                              this.check = check!;
                            });
                          },
                        ),
                      ),
                      Text(
                        "Don't show this message again",
                        style: blackStyle(context).copyWith(
                            fontSize: 14.sm,
                            color:
                                Get.isDarkMode ? Colors.white : Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 15,
                            right: 15,
                          ),
                          child: SizedBox(
                            //width: double.infinity,
                            height: 60,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: _isyesclicked
                                    ? const Color.fromRGBO(247, 129, 4, 1)
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                "Yes",
                                style: TextStyle(
                                  color: _isyesclicked
                                      ? Color(0xFFFFFFFF)
                                      : Color(0xFF585858),
                                  fontSize: 20,
                                  fontFamily: 'Productsans',
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  _isyesclicked = true;
                                  _isnoclicked = false;
                                  //   _saveOptions();
                                });

                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => HomePage(
                                              showVideo: true,
                                            )),
                                    (Route<dynamic> route) => false);
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 15,
                            right: 15,
                          ),
                          child: SizedBox(
                            //   width: double.infinity,
                            height: 50,
                            child: SizedBox(
                              height: 60,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  primary: _isnoclicked
                                      ? const Color.fromRGBO(247, 129, 4, 1)
                                      : Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  "No",
                                  style: TextStyle(
                                    color: _isnoclicked
                                        ? Color(0xFFFFFFFF)
                                        : Color(0xFF585858),
                                    fontSize: 20,
                                    fontFamily: 'Productsans',
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isnoclicked = true;
                                    _isyesclicked = false;
                                  });
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => HomePage(
                                                showVideo: false,
                                              )),
                                      (Route<dynamic> route) => false);
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login()));
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
                          InkWell(
                            onTap: () {
                              // Navigator.pushReplacement(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (builder) =>
                              //         const SuccessScreen(),
                              //   ),
                              // );
                            },
                            child: GestureDetector(
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
        _getAuthwithfinger();
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
        //    buildGuidedTour();
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
