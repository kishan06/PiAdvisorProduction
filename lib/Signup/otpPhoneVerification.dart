// ignore_for_file: unnecessary_import, sized_box_for_whitespace, file_names, implementation_imports, prefer_const_constructors, avoid_print

import 'dart:async';
import 'dart:ui';

import 'package:another_flushbar/flushbar.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:piadvisory/Common/CustomNextButton.dart';
import 'package:piadvisory/Common/Signup_appbar.dart';
import 'package:piadvisory/Login/login.dart';

import 'package:piadvisory/Signup/Repository/SendOtp.dart';
import 'package:piadvisory/Signup/Repository/VerifyOtp.dart';
import 'package:piadvisory/Utils/Dialogs.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../Common/app_bar.dart';
import '../Utils/textStyles.dart';

class otpPhoneVerification extends StatefulWidget {
  otpPhoneVerification({
    Key? key,
  }) : super(key: key);

  @override
  State<otpPhoneVerification> createState() => _otpPhoneVerificationState();
}

class _otpPhoneVerificationState extends State<otpPhoneVerification> {
  TextEditingController? pincode = TextEditingController();

  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  String? num;
  void _validateData() {
    final isValid = _form.currentState?.validate();
    if (isValid!) {
      replaceSignInBtnWithLoader();
      UploadData();
    } else {
      utils.showToast("please enter verification code");
    }
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

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> updata = {"mob_number": Get.arguments["mobileno"]};
    //SendOtp().sendotp(updata);
    SendOtp().SendOtpExotel(updata);

    setState(() {
      num = Get.arguments["mobileno"].toString();
    });
  }

  Future<void> UploadData() async {
    Map<String, dynamic> updata = {
      "mob_number": num,
      "otp": pincode!.text,
    };

    // if (pincode!.text == "1111") {
    //   Get.offAllNamed('/signup2');
    // } else {
    //   utils.showToast("Invalid OTP");
    //   replaceLoaderWithSignInBtn();
    // }

    var data = await VerifyOTP().Verifyotpdetails(updata, context);

    if (data == "0") {
      Get.toNamed('/signup2');
    } else {
      replaceLoaderWithSignInBtn();
      return utils.showToast("Invalid OTP");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login()));
        return Future.value(false);
      },
      child: Scaffold(
        appBar: const CustomSignupAppBar(
            titleTxt: "Awaiting for OTP ", bottomtext: false),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: Text(
                    "We have sent you an SMS with a 4-digit verification code on +91 $num",
                    style: TextStyle(
                        //color: Colors.grey,
                        fontFamily: 'Productsans',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Get.isDarkMode ? Colors.white : Colors.black),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),

                // SizedBox(
                //   width: double.infinity,
                //   height: 60,
                //   child: TextButton(
                //     style: TextButton.styleFrom(
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(10),
                //         ),
                //         backgroundColor: Color.fromRGBO(0, 128, 131, 1)),
                //     onPressed: () {},
                //     child: Text(widget.number!,
                //         style: blackStyle(context).copyWith(color: Colors.white)),
                //   ),
                // ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Enter OTP",
                  style: TextStyle(
                      color: Get.isDarkMode ? Colors.white : Colors.black),
                ),
                SizedBox(
                  height: 26,
                ),
                PinCodeTextField(
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return "Please Enter OTP";
                    } else if (value != null && value.length < 4) {
                      return "OTP length should be atleast 4";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  length: 4,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    selectedFillColor: Get.isDarkMode
                        ? Color(0xFF303030).withOpacity(0.4)
                        : Colors.white,
                    inactiveFillColor: Get.isDarkMode
                        ? Color(0xFF303030).withOpacity(0.4)
                        : Colors.white,
                    inactiveColor: Color(0xFF707070),
                    activeColor: Color.fromRGBO(0, 128, 131, 1),
                    selectedColor: Color.fromRGBO(0, 128, 131, 1),
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 70,
                    fieldWidth: 70,
                    activeFillColor: Get.isDarkMode
                        ? Color(0xFF303030).withOpacity(0.4)
                        : Colors.white,
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  enableActiveFill: true,
                  controller: pincode,
                  onCompleted: (v) {
                    print("Completed");
                  },
                  onChanged: (value) {
                    print(value);
                    setState(() {});
                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");

                    return true;
                  },
                  appContext: context,
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Text("Didn't you receive any code?",
                        style: blackStyle(context).copyWith(
                            color:
                                Get.isDarkMode ? Colors.white : Colors.black)),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        pincode!.clear();
                        Map<String, dynamic> updata2 = {"mob_number": num};
                        // SendOtp().sendotp(updata);
                        SendOtp().SendOtpExotel(updata2);
                        Flushbar(
                          message: "Otp has been sent successfully",
                          duration: const Duration(seconds: 3),
                        ).show(context);
                      },
                      child: Text("Resend",
                          style: blackStyle(context)
                              .copyWith(color: Color.fromRGBO(218, 6, 0, 1))),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 130,
                ),

                Visibility(
                  visible: isSignInBtnVisible,
                  child: SizedBox(
                    width: double.maxFinite,
                    height: 48,
                    child: CustomNextButton(
                      text: "Verify",
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
                // RoundedLoadingButton(
                //   height: 60,
                //   resetAfterDuration: true,
                //   resetDuration: Duration(seconds: 5),
                //   width: MediaQuery.of(context).size.width * 1,
                //   color: const Color.fromRGBO(247, 129, 4, 1),
                //   successColor: const Color.fromRGBO(247, 129, 4, 1),
                //   controller: _btnController1,
                //   onPressed: () => _validateData(),

                //   valueColor: Colors.black,
                //   borderRadius: 10,
                //   child: Text(
                //     "Verify",
                //     style: TextStyle(
                //       color: Color(0xFFFFFFFF),
                //       fontSize: 20,
                //       fontFamily: 'Productsans',
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
