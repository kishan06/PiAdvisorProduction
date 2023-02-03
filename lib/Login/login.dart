// ignore_for_file: prefer_const_constructors, must_be_immutable, sort_child_properties_last, file_names

import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:piadvisory/Common/ConnectivityService.dart';
import 'package:piadvisory/Common/CustomNextButton.dart';
import 'package:piadvisory/Common/NetworkSensitive.dart';
import 'package:piadvisory/Common/VideoYoutube.dart';
import 'package:piadvisory/Login/Repository/LoginMethod.dart';
import 'package:piadvisory/Login/Repository/UserVerified.dart';
import 'package:piadvisory/Login/splash.dart';
import 'package:piadvisory/SideMenu/Subscribe/Repository/getSubscriptionWithDetails.dart';
import 'package:piadvisory/Signup/PhoneVerification.dart';

import 'package:piadvisory/Signup/Repository/Securityfirstpage.dart';
import 'package:piadvisory/Signup/SecurityFirst.dart';
import 'package:piadvisory/Signup/SignupPage.dart';

import 'package:piadvisory/Utils/Dialogs.dart';
import 'package:piadvisory/Utils/base_manager.dart';
import 'package:piadvisory/Utils/textStyles.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../Common/CustomTextFormFields.dart';
import '../HomePage/Homepage.dart';
import '../Utils/Constants.dart';

class Login extends StatefulWidget {
  Login({Key? key, this.showFingerAndPin}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
  String? showFingerAndPin = "none";
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController pincontroller = TextEditingController();
  TextEditingController user_pin = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  DateTime timebackPressed = DateTime.now();
  bool _isyesclicked = true;
  bool _isnoclicked = false;

  bool check = false;
  bool? _hasBioSensor;
  LocalAuthentication authentication = LocalAuthentication();

  Future<void> _validateData() async {
    final isValid = _form.currentState?.validate();
    if (isValid!) {
      replaceSignInBtnWithLoader();
      await UploadData();
    }
  }

  Future<void> UploadData() async {
    Map<String, dynamic> updata = {
      "email": emailcontroller.text,
      "password": passwordcontroller.text,
    };

    final data = await LoginMethod().postPhoneLoginDetails(updata, context);

    if (data.status == ResponseStatus.SUCCESS) {
      //security pin exist api replace

      final data = await UserVerified().getPinexist();
      if (data.status == ResponseStatus.SUCCESS) {
        if (data.data == 0) {
          Get.to(SecurityFirst());
          replaceLoaderWithSignInBtn();
        } else {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => HomePage(
                        showVideo: false,
                      )),
              (Route<dynamic> route) => false);
          getSubscriptionWithDetails().getsubsDetail();
        }
      } else {
        utils.showToast(data.message);
      }

      // final data = await UploadSecurityFirst().checkRegisterCompleted();
      // if (data.status == ResponseStatus.SUCCESS) {
      //   if (checkRegister != null && checkRegister == 0) {
      //     // Flushbar(
      //     //   message: "Please Complete Registration Process",
      //     //   duration: const Duration(seconds: 3),
      //     // ).show(context);
      //     Get.to(SecurityFirst());
      //     replaceLoaderWithSignInBtn();
      //   } else {
      //     replaceLoaderWithSignInBtn();
      //     Navigator.of(context).pushAndRemoveUntil(
      //         MaterialPageRoute(
      //             builder: (context) => HomePage(
      //                   showVideo: false,
      //                 )),
      //         (Route<dynamic> route) => false);
      //     getSubscriptionWithDetails().getsubsDetail();
      //   }
      // }
      //buildGuidedTour();

      /*
      Timer(Duration(seconds: 2), () {
        controller.success();
        Timer(Duration(seconds: 1), () {
          buildGuidedTour();

        });
      });
    */
    } else {
      // _btnController1.error();
      // Timer(Duration(seconds: 2), () {
      //   _btnController1.reset();
      // });
      replaceLoaderWithSignInBtn();
      return utils.showToast(data.message);
    }
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
                                backgroundColor: _isyesclicked
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

  bool isSignInBtnVisible = true;
  bool isSignInBtnLoaderVisible = false;

  void replaceSignInBtnWithLoader() {
    setState(() {
      isSignInBtnVisible = false;
      isSignInBtnLoaderVisible = true;
    });
  }

  void replaceLoaderWithSignInBtn() {
    setState(() {
      isSignInBtnVisible = true;
      isSignInBtnLoaderVisible = false;
    });
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    ImageProvider logo = AssetImage("assets/images/loginlogo.png");
    return 
    // StreamProvider<ConnectivityStatus>.value(
    //   initialData: ConnectivityStatus.Cellular,
    //   value: ConnectivityService().connectionStatusController.stream,
    //   child: 
      WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(timebackPressed);
        final isExitWarning = difference >= Duration(seconds: 2);

        timebackPressed = DateTime.now();

        if (isExitWarning) {
          final message = "Press back again to exit";
          Fluttertoast.showToast(
            msg: message,
            fontSize: 18,
          );

          return false;
        } else {
          Fluttertoast.cancel();

          SystemNavigator.pop();
          return true;
        }
      },
      child: NetworkSensitive(
        scaffoldKey: _scaffoldKey,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Form(
                key: _form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 102.83.h,
                    ),
                    Center(
                      child: SizedBox(
                        height: 150.17.h,
                        width: 100.w,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: logo,
                          )),
                          child: null,
                        ),
                        //  Image.asset(
                        //   'assets/images/pilogo.png',
                        // ),
                      ),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        "Phone",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Get.isDarkMode ? Colors.white : Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextFormFieldPhone(
                      texttype: TextInputType.number,
                      limitlength: 10,
                      errortext: "Please Enter Phone Number",
                      controller: emailcontroller,
                      hint: "Enter Phone Number",
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          "Password",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Stack(
                      children: [
                        TextFormField(
                          obscureText: true,
                          cursorColor: Color(0xFF303030).withOpacity(0.3),
                          style: const TextStyle(
                            //color: Colors.grey,
                            fontFamily: 'Productsans',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2.0),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2.0),
                            ),
                            errorMaxLines: 3,
                            hintText: "Enter Password",
                            hintStyle: Get.isDarkMode
                                ? Theme.of(context).textTheme.headline3
                                : blackStyle(context).copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Color(0xFF303030).withOpacity(0.3)),
                            fillColor: Get.isDarkMode
                                ? Color(0xFF303030).withOpacity(0.3)
                                : Colors.white,
                            filled: true,
                            errorBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2.0),
                            ),
                            focusedErrorBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2.0),
                            ),
                            errorStyle: const TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          controller: passwordcontroller,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Password";
                            }
                            return null;
                          },
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(20),
                          ],
                          onSaved: (value) {},
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PhoneVerification(
                                                    number:
                                                        emailcontroller.text)));
                                    // Get.toNamed('/phoneverification', arguments: {
                                    //   'number': emailcontroller.text
                                    // });
                                  },
                                  child: const Text(
                                    'Login Using OTP',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFFF78104),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 17.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed('/forgotpassword');
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                                fontSize: 14,
                                color:
                                    Get.isDarkMode ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 140.h,
                    ),
                    Visibility(
                      visible: isSignInBtnVisible,
                      child: SizedBox(
                        width: double.maxFinite,
                        height: 48,
                        child: CustomNextButton(
                          text: "Sign in",
                          ontap: () => _validateData(),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isSignInBtnLoaderVisible,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    SizedBox(
                      height: 51.h,
                    ),
                    Row(
                      children: <Widget>[
                        Text("Don't have an account?",
                            style: blackStyle(context).copyWith(
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Color(0xFF585858),
                                fontSize: 14)),
                        SizedBox(
                          width: 2,
                        ),
                        TextButton(
                          onPressed: () {
                            Get.toNamed('/signupforfree');
                          },
                          child: Text(
                            'Signup for free',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFF78104)),
                          ),
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
   // );
  }
}
   

class CustomTextFormFieldPhone extends StatelessWidget {
  const CustomTextFormFieldPhone({
    Key? key,
    this.controller,
    this.hint,
    this.ontap,
    this.errortext,
    this.limitlength,
    this.maxlength,
    this.texttype,
    this.maxlines,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? hint;
  final String? errortext;
  final Function(String)? ontap;
  final int? limitlength;
  final int? maxlength;
  final TextInputType? texttype;
  final int? maxlines;
  final TextInputType? keyboardType;
  final FilteringTextInputFormatter? inputFormatters;
  final Function(String)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxlines ?? 1,
      maxLength: maxlength,
      cursorColor: Color(0xFF303030).withOpacity(0.3),
      style: const TextStyle(
        //color: Colors.grey,
        fontFamily: 'Productsans',
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        //   contentPadding: EdgeInsets.all(15),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.grey, width: 2.0),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.grey, width: 2.0),
        ),
        errorMaxLines: 3,
        hintText: hint,
        hintStyle: Get.isDarkMode
            ? Theme.of(context).textTheme.headline3
            : blackStyle(context).copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF303030).withOpacity(0.3)),
        fillColor:
            Get.isDarkMode ? Color(0xFF303030).withOpacity(0.3) : Colors.white,
        filled: true,
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
        errorStyle: const TextStyle(
          fontSize: 16.0,
        ),
      ),
      controller: controller,
      keyboardType: texttype,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errortext ?? "Empty value";
        } else if (value.length != 10) {
          return "Please Enter Valid Phone Number";
        }
        return null;
      },
      inputFormatters: [
        LengthLimitingTextInputFormatter(limitlength ?? 20),
        //FilteringTextInputFormatter.digitsOnly
        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
        // FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
      ],
      onSaved: (value) {
        ontap?.call;
      },
    );
  }
}
