import 'dart:async';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:piadvisory/Common/ConnectivityService.dart';
import 'package:piadvisory/Common/CustomNextButton.dart';
import 'package:piadvisory/Common/NetworkSensitive.dart';
import 'package:piadvisory/HomePage/Stock/MutualFundsTab.dart';
import 'package:piadvisory/Login/Repository/LoginMethod.dart';

import 'package:piadvisory/Signup/Repository/Securityfirstpage.dart';

import 'package:piadvisory/Utils/Dialogs.dart';
import 'package:piadvisory/Utils/base_manager.dart';
import 'package:piadvisory/Utils/textStyles.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '/Utils/Dialogs.dart';
import '../Common/CustomTextFormFields.dart';
import '../HomePage/Homepage.dart';

class PinDialog extends StatefulWidget {
  PinDialog({Key? key, this.showFingerAndPin}) : super(key: key);

  @override
  State<PinDialog> createState() => _PinDialogState();
  String? showFingerAndPin = "none";
}

class _PinDialogState extends State<PinDialog> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  // TextEditingController emailcontroller = TextEditingController();
  // TextEditingController pincontroller = TextEditingController();
  TextEditingController user_pin = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  DateTime timebackPressed = DateTime.now();
  bool _isyesclicked = true;
  bool _isnoclicked = false;
  bool? videoonce;
  bool check = false;
  bool? _hasBioSensor;
  LocalAuthentication authentication = LocalAuthentication();
  FocusNode pinFocusNode = FocusNode();

  final RoundedLoadingButtonController _btnController1 =
      RoundedLoadingButtonController();

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
        Get.toNamed('/home');
        // buildGuidedTour();
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (builder) => Login(),
        //   ),
        // );
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
        //  buildGuidedTour();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => HomePage(
                      showVideo: false,
                    )),
            (Route<dynamic> route) => false);
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (builder) => Login(),
        //   ),
        // );
        return;
      }

      // ignore: empty_catches
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;
  }

  // void _validateData() {
  //   final isValid = _form.currentState?.validate();
  //   if (isValid!) {
  //     UploadData(_btnController1);
  //   } else {
  //     _btnController1.error();
  //     Timer(Duration(seconds: 2), () {
  //       _btnController1.reset();
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();

    debugPrint(pinFocusNode.canRequestFocus.toString());
    String? showFingerAndPin = widget.showFingerAndPin;

    print("show pin $showFingerAndPin");
    if (showFingerAndPin != null && showFingerAndPin == "yes") {
      Timer(Duration(seconds: 2), () {
        Scaffold();
        // buildPinAlertDialog();
        _checkBio();
      });
    } else if (showFingerAndPin != null && showFingerAndPin == "no") {
      Timer(Duration(seconds: 2), () {
        Scaffold();
        //buildPinAlertDialog();
      });
    }
    _btnController1.stateStream.listen((value) {});
  }

  // Future<void> UploadData(RoundedLoadingButtonController controller) async {
  //   Map<String, dynamic> updata = {
  //     "email": emailcontroller.text,
  //     "password": passwordcontroller.text,
  //   };

  //   final data = await LoginMethod().postPhoneLoginDetails(updata, context);

  //   if (data.status == ResponseStatus.SUCCESS) {
  //     Timer(Duration(seconds: 2), () {
  //       controller.success();
  //       Timer(Duration(seconds: 1), () {
  //         buildGuidedTour();
  //       });
  //     });
  //   } else {
  //     _btnController1.error();
  //     Timer(Duration(seconds: 2), () {
  //       _btnController1.reset();
  //     });
  //     return utils.showToast(data.message);
  //   }
  // }

  void UploadPinData() async {
    print("called");
    Map<String, int> updata = {
      "pin": int.parse(user_pin.text),
    };
    print(updata);
    final data = await LoginMethod().postPinStatus(updata);
    if (data.status == ResponseStatus.SUCCESS) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: ((context) => HomePage())));
      // Get.toNamed('/home');
      user_pin.clear();
    } else {
      return utils.showToast(data.message);
    }
  }

  buildFingerPrintAlertDialog() {
    return showDialog(
      context: context,
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
            child: FittedBox(
              child: FloatingActionButton(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    size: 30,
                  )),
            ),
          ),
          AlertDialog(
            insetPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            contentPadding: EdgeInsets.fromLTRB(24, 8, 24, 24),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            // contentPadding:
            //     EdgeInsets.all(
            //         10),
            title: Text(
              "One-Touch",
              style: blackStyle(context).copyWith(fontWeight: FontWeight.bold),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Use your fingerprint to easily log in!",
                  style: blackStyle(context),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 64,
                  height: 77,
                  child: SvgPicture.asset(
                    'assets/images/Thumbprint.svg',
                  ),
                ),
                SizedBox(
                  height: 21,
                ),
                Text("Touch the fingerprint sensor"),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  thickness: 2,
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Login with Pin",
                    style: blackStyle(context).copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF78104),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // buildPinAlertDialog() {
  //   return showGeneralDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     pageBuilder: (context, animation, secondaryAnimation) {

  //       return Scaffold(
  //         body: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //           Padding(
  //             padding: EdgeInsets.all(25),
  //             ),
  //            Padding(
  //              padding: const EdgeInsets.all(13),

  //                child: Text(
  //                 textAlign: TextAlign.left,
  //                 textDirection: TextDirection.ltr,
  //                       "Welcome back",
  //                       style: blackStyle(context).copyWith(
  //                           fontWeight: FontWeight.bold,
  //                           fontSize: 19.sm,
  //                           color: Color(0xFF444444)),
  //                     ),

  //            ),
  //              SizedBox(
  //               height: 10,
  //              ),
  //             Text(
  //               "Use your 4 Digit Pin to easily log in!",

  //               style: blackStyle(context).copyWith(color: Color(0xFF444444)),

  //             ),
  //             SizedBox(
  //               height: 20,
  //             ),
  //             TextFormField(
  //               focusNode: pinFocusNode,
  //               controller: user_pin,
  //               decoration: InputDecoration(
  //                 contentPadding: EdgeInsets.all(20),
  //                 hintText: 'Enter PIN',
  //                 // focusedBorder: const OutlineInputBorder(
  //                 //   borderRadius: BorderRadius.all(Radius.circular(5)),
  //                 //   borderSide:
  //                 //       BorderSide(color: Color(0xFF707070), width: 1.0),
  //                 // ),
  //                 // enabledBorder: const OutlineInputBorder(
  //                 //   borderRadius: BorderRadius.all(Radius.circular(5)),
  //                 //   borderSide:
  //                 //       BorderSide(color: Color(0xFF707070), width: 1.0),
  //                 // ),
  //                 hintStyle: blackStyle(context).copyWith(
  //                     fontSize: 16,
  //                     fontWeight: FontWeight.w600,
  //                     color: Color(0xFF303030).withOpacity(0.3)),
  //                 // errorBorder: const OutlineInputBorder(
  //                 //   borderRadius: BorderRadius.all(Radius.circular(5)),
  //                 //   borderSide: BorderSide(color: Colors.red, width: 1.0),
  //                 // ),
  //                 // focusedErrorBorder: const OutlineInputBorder(
  //                 //   borderRadius: BorderRadius.all(Radius.circular(5)),
  //                 //   borderSide: BorderSide(color: Colors.red, width: 1.0),
  //                 // ),
  //                 errorStyle: const TextStyle(
  //                   fontSize: 16.0,
  //                 ),
  // suffixIcon: GestureDetector(
  //   onTap: () {
  //     UploadPinData();
  //   },
  //   child: Container(
  //     padding: EdgeInsets.only(right: 25),
  //     width: 10,
  //     height: 10,
  //     child: SvgPicture.asset(
  //       'assets/images/nextbuttonicon.svg',
  //     ),
  //   ),
  // ),
  //               ),
  //               maxLength: 4,
  //               keyboardType: TextInputType.number,
  //               autovalidateMode: AutovalidateMode.onUserInteraction,
  //               validator: (val) {
  //                 if (val == null || val.isEmpty) {
  //                   return 'Pin is Empty';
  //                 } else {
  //                   return null;
  //                 }
  //               },
  //             ),
  //             SizedBox(
  //               height: 22,
  //             ),
  //               Padding(
  //             padding: const EdgeInsets.only(left: 20, right: 20),
  //             child: SizedBox(
  //               width: double.infinity,
  //               height: 60,
  //               child: CustomNextButton(
  //                 text: 'GO',
  //                 ontap: () {
  //                   UploadPinData();
  //                 },
  //               ),
  //             ),
  //           ),
  //              SizedBox(
  //               height: 22,
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.only(right: 10),
  //               child: Align(
  //                 alignment: Alignment.centerRight,
  //                 child: GestureDetector(
  //                   onTap: () {
  //                     Get.toNamed("/forgotpin2");
  //                   },
  //                   child: Text(
  //                     "Forgot PIN?",
  //                     style: blackStyle(context).copyWith(
  //                         color: Color(0xFF6B6B6B), fontWeight: FontWeight.w600),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             SizedBox(
  //               height: 20,
  //             ),
  //              Padding(
  //               padding: const EdgeInsets.only(right: 10),
  //               child: Align(
  //                 alignment: Alignment.centerRight,
  //                 child: GestureDetector(
  //                   onTap: () {
  //                     Get.toNamed("/login");
  //                   },
  //                   child: Text(
  //                     "Switch Account?",
  //                     style: blackStyle(context).copyWith(
  //                         color: Colors.black, fontWeight: FontWeight.w600),
  //                   ),
  //                 ),
  //               ),
  //             ),

  //           ],
  //         ),
  //       );

  //     },
  //     /*
  //     builder: (context) => StatefulBuilder(
  //       builder: (context, setState) {
  //         return Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             // SizedBox(
  //             //   height: 40,
  //             //   child: FittedBox(
  //             //     child: FloatingActionButton(
  //             //         elevation: 0,
  //             //         backgroundColor: Colors.white,
  //             //         onPressed: () {
  //             //           Navigator.pop(context);
  //             //         },
  //             //         child: Icon(
  //             //           Icons.close,
  //             //           size: 30,
  //             //         )),
  //             //   ),
  //             // ),
  //             WillPopScope(
  //               onWillPop: () async => false,
  //               child:

  //               AlertDialog(
  //                 insetPadding:
  //                     EdgeInsets.symmetric(vertical: 10, horizontal: 15),
  //                 contentPadding: EdgeInsets.fromLTRB(24, 8, 24, 24),
  //                 shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.all(Radius.circular(10))),
  //                 // contentPadding:
  //                 //     EdgeInsets.all(
  //                 //         10),
  //                 title: Text(
  //                   "4 Digit Pin",
  //                   style: blackStyle(context).copyWith(
  //                       fontWeight: FontWeight.bold,
  //                       fontSize: 19.sm,
  //                       color: Color(0xFF444444)),
  //                 ),
  //                 content:

  //                 Column(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     Text(
  //                       "Use your 4 Digit Pin to easily log in!",
  //                       style: blackStyle(context)
  //                           .copyWith(color: Color(0xFF444444)),
  //                     ),
  //                     SizedBox(
  //                       height: 20,
  //                     ),
  //                     TextFormField(
  //                       controller: user_pin,
  //                       decoration: InputDecoration(
  //                         contentPadding: EdgeInsets.all(20),
  //                         hintText: 'Enter PIN',
  //                         focusedBorder: const OutlineInputBorder(
  //                           borderRadius: BorderRadius.all(Radius.circular(5)),
  //                           borderSide: BorderSide(
  //                               color: Color(0xFF707070), width: 1.0),
  //                         ),
  //                         enabledBorder: const OutlineInputBorder(
  //                           borderRadius: BorderRadius.all(Radius.circular(5)),
  //                           borderSide: BorderSide(
  //                               color: Color(0xFF707070), width: 1.0),
  //                         ),
  //                         hintStyle: blackStyle(context).copyWith(
  //                             fontSize: 16,
  //                             fontWeight: FontWeight.w600,
  //                             color: Color(0xFF303030).withOpacity(0.3)),
  //                         errorBorder: const OutlineInputBorder(
  //                           borderRadius: BorderRadius.all(Radius.circular(5)),
  //                           borderSide:
  //                               BorderSide(color: Colors.red, width: 1.0),
  //                         ),
  //                         focusedErrorBorder: const OutlineInputBorder(
  //                           borderRadius: BorderRadius.all(Radius.circular(5)),
  //                           borderSide:
  //                               BorderSide(color: Colors.red, width: 1.0),
  //                         ),
  //                         errorStyle: const TextStyle(
  //                           fontSize: 16.0,
  //                         ),
  //                         suffixIcon: GestureDetector(
  //                           onTap: () {
  //                             UploadPinData();
  //                           },
  //                           child: Container(
  //                             padding: EdgeInsets.only(right: 25),
  //                             width: 10,
  //                             height: 10,
  //                             child: SvgPicture.asset(
  //                               'assets/images/nextbuttonicon.svg',
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                       maxLength: 4,
  //                       keyboardType: TextInputType.number,
  //                       autovalidateMode: AutovalidateMode.onUserInteraction,
  //                       validator: (val) {
  //                         if (val == null || val.isEmpty) {
  //                           return 'Pin is Empty';
  //                         } else {
  //                           return null;
  //                         }
  //                       },
  //                     ),
  //                     SizedBox(
  //                       height: 22,
  //                     ),
  //                     Align(
  //                       alignment: Alignment.centerRight,
  //                       child: GestureDetector(
  //                         onTap: () {
  //                           Get.toNamed("/forgotpin2");
  //                         },
  //                         child: Text(
  //                           "Forgot PIN?",
  //                           style: blackStyle(context).copyWith(
  //                               color: Color(0xFF6B6B6B),
  //                               fontWeight: FontWeight.w600),
  //                         ),
  //                       ),
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ],
  //         );
  //       },
  //     ),
  //   */
  //   );
  // }

  _saveOptions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('video', true);
    setState(() {});
    _getOptions();
  }

  _getOptions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    videoonce = prefs.getBool('video') ?? false;
  }

  buildGuidedTour() {
    return showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: false,
      enableDrag: false,
      context: context,
      shape: const RoundedRectangleBorder(
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
                            fontSize: 16.sm, fontWeight: FontWeight.bold),
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
                        ),
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
                                  _saveOptions();
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

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(25),
          ),
          Padding(
            padding: const EdgeInsets.all(13),
            child: Text(
              textAlign: TextAlign.left,
              textDirection: TextDirection.ltr,
              "Welcome back",
              style: blackStyle(context).copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 19.sm,
                  color: Get.isDarkMode ? Colors.white : Color(0xFF444444)),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Use your 4 Digit Pin to easily log in!",
            style: blackStyle(context).copyWith(
                color: Get.isDarkMode ? Colors.white : Color(0xFF444444)),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            focusNode: pinFocusNode,
            controller: user_pin,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(20),
              hintText: 'Enter PIN',
              // focusedBorder: const OutlineInputBorder(
              //   borderRadius: BorderRadius.all(Radius.circular(5)),
              //   borderSide:
              //       BorderSide(color: Color(0xFF707070), width: 1.0),
              // ),
              // enabledBorder: const OutlineInputBorder(
              //   borderRadius: BorderRadius.all(Radius.circular(5)),
              //   borderSide:
              //       BorderSide(color: Color(0xFF707070), width: 1.0),
              // ),
              hintStyle: blackStyle(context).copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Get.isDarkMode
                      ? Colors.white
                      : Color(0xFF303030).withOpacity(0.3)),
              // errorBorder: const OutlineInputBorder(
              //   borderRadius: BorderRadius.all(Radius.circular(5)),
              //   borderSide: BorderSide(color: Colors.red, width: 1.0),
              // ),
              // focusedErrorBorder: const OutlineInputBorder(
              //   borderRadius: BorderRadius.all(Radius.circular(5)),
              //   borderSide: BorderSide(color: Colors.red, width: 1.0),
              // ),
              errorStyle: const TextStyle(
                fontSize: 16.0,
              ),
              // suffixIcon: GestureDetector(
              //   onTap: () {
              //     UploadPinData();
              //   },
              //   child: Container(
              //     padding: EdgeInsets.only(right: 25),
              //     width: 10,
              //     height: 10,
              //     child: SvgPicture.asset(
              //       'assets/images/nextbuttonicon.svg',
              //     ),
              //   ),
              // ),
            ),

            maxLength: 4,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[0-9]')),
            ],
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return 'Pin is Empty';
              } else {
                return null;
              }
            },
            //onEditingComplete:() => UploadPinData(),
            //onFieldSubmitted:(value) => UploadPinData(),
          ),
          SizedBox(
            height: 22,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 130, right: 130),
            child: SizedBox(
              width: double.infinity,
              height: 40,
              child: CustomNextButton(
                text: 'GO',
                ontap: () {
                  UploadPinData();
                },
              ),
            ),
          ),
          SizedBox(
            height: 22,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Get.toNamed("/forgotpin2");
                },
                child: Text(
                  "Forgot PIN?",
                  style: blackStyle(context).copyWith(
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () async {
                  Get.toNamed("/login");
                  SharedPreferences preferences =
                  await SharedPreferences.getInstance();
                  await preferences.remove('token');
                  await preferences.remove('video');
                },
                child: Text(
                  "Switch Account?",
                  style: blackStyle(context).copyWith(
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomNextButton2 extends StatelessWidget {
  const CustomNextButton2({
    Key? key,
    GlobalKey<FormState>? form,
    this.ontap,
    required this.text,
    this.colorchange = false,
  }) : super(key: key);

  final String text;
  final GestureTapCallback? ontap;
  final bool colorchange;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          // ignore: deprecated_member_use

          primary:
              colorchange ? Colors.white : const Color.fromRGBO(247, 129, 4, 1),
          shape: RoundedRectangleBorder(
            side: colorchange
                ? BorderSide(color: Color(0xFF707070))
                : BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: colorchange ? Color(0xFF303030) : Colors.white,
            fontSize: 20.sm,
            fontFamily: 'Productsans',
          ),
        ),
        onPressed: () {
          ontap!();
        },
      ),
    );
  }
}
