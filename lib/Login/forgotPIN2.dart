// ignore_for_file: prefer_const_constructors, avoid_print, file_names

import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lottie/lottie.dart';
import 'package:piadvisory/Common/CustomNextButton.dart';
import 'package:piadvisory/Login/Repository/ResetPin.dart';
import 'package:piadvisory/Login/Repository/Resetpassword.dart';
import 'package:piadvisory/Login/ResetPassword.dart';
import 'package:flutter/material.dart';
import 'package:piadvisory/Signup/Repository/Securityfirstpage.dart';
import 'package:piadvisory/Signup/Repository/SendOtp.dart';
import 'package:piadvisory/Signup/Repository/VerifyOtp.dart';
import 'package:piadvisory/Utils/base_manager.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '/Utils/Dialogs.dart';
import '../Common/app_bar.dart';

class ForgotPIN2 extends StatefulWidget {
  ForgotPIN2({Key? key}) : super(key: key);

  @override
  State<ForgotPIN2> createState() => _ForgotPIN2();
}

class _ForgotPIN2 extends State<ForgotPIN2> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController? pincode = TextEditingController();
  TextEditingController pincontroller = TextEditingController();
  TextEditingController confirmpincontroller = TextEditingController();
  final number = TextEditingController();
  final RoundedLoadingButtonController _btnController1 =
      RoundedLoadingButtonController();
  late final Future? myFuture;
  bool isProceedBtnVisible = true;
  bool isProceedBtnLoaderVisible = false;

  // @override
  // void initState() {
  //   myFuture = ResertPin().postResetPin();
  //   super.initState();
  // }

  void UploadNewPinData() async {
    final isValid = _formKey.currentState?.validate();
    if (isValid!) {
      Map<String, dynamic> updata = {
        "user_pin": pincontroller.text,
      };
      final data = await UploadSecurityFirst().postSecuritypin(updata);
      if (data.status == ResponseStatus.SUCCESS) {
        Get.toNamed("/login");
      } else {
        return utils.showToast(data.message);
      }
    }
  }

  build4digitpin() {
    return showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: false,
      context: context,
      isDismissible: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Positioned(
                  //   top: -80,
                  //   right: MediaQuery.of(context).size.width * 0.4,
                  //   child: InkWell(
                  //       onTap: () {
                  //         Get.toNamed('/security_first');
                  //       },
                  //       child: CircleAvatar(
                  //         backgroundColor: Colors.white,
                  //         radius: 25,
                  //         child: Icon(
                  //           Icons.close,
                  //           color: Colors.black,
                  //         ),
                  //       )),
                  // ),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            "Reset your 4 Digit Pin",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18.sm,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Divider(
                          thickness: 2,
                        ),
                         SizedBox(
                          height: 50.h,
                        ),
                        const Text("Choose a PIN of Your choice"),
                        SizedBox(
                          height: 15.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 15,
                            right: 15,
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 50.h,
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: pincontroller,
                                  textAlign: TextAlign.center,
                                  decoration:  InputDecoration(
                                    //  helperText: '',
                                    hintText: "",
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3.w,
                                            color: Color(0x00000000))),
                                  ),
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(4),
                                  ],
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return 'Pin is Empty';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                         SizedBox(
                          height: 30.h,
                        ),
                        const Text("Please Re-Enter the PIN"),
                        SizedBox(
                          height: 15.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 15,
                            right: 15,
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 50.h,
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: confirmpincontroller,
                                    textAlign: TextAlign.center,
                                    decoration:  InputDecoration(
                                      hintText: "",
                                      //    helperText: '',
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 3.w,
                                              color: Color(0x00000000))),
                                    ),
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(4),
                                    ],
                                    validator: (val) {
                                      if (val == null || val.isEmpty) {
                                        return 'Pin is Empty';
                                      }
                                      if (int.parse(
                                              confirmpincontroller.text) ==
                                          int.parse(pincontroller.text)) {
                                        if (val.length == 4) {
                                          return null;
                                        } else {
                                          return 'Pin must be 4 digit';
                                        }
                                      }
                                      return 'Pin does Not Matched';
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                         SizedBox(
                          height: 30.h,
                        ),
                        Container(
                            height: 50.h,
                            width: double.infinity,
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: CustomNextButton(
                              text: "Reset",
                              ontap: () {
                                UploadNewPinData();
                              },
                            )),
                         SizedBox(
                          height: 30.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void UploadPinData(_btnController1) async {
    Map<String, dynamic> updata = {
      "mob_number": number.text,
      "otp": pincode!.text,
    };

    var data = await VerifyOTP().VerifydetailsWithoutToken(updata, context);

    if (data.message == "0") {
      setState(() {
        isProceedBtnVisible = true;
        isProceedBtnLoaderVisible = false;
        build4digitpin();
      });
      // Timer(Duration(seconds: 2), () {
      //   _btnController1.success();
      //   Timer(Duration(seconds: 1), () {
      //     build4digitpin();
      //   });
      // });
    } else {
      setState(() {
        isProceedBtnVisible = true;
        isProceedBtnLoaderVisible = false;
      });
      // _btnController1.error();
      // _btnController1.reset();

      return utils.showToast("Invalid OTP");
    }
  }

  void _validateData(_btnController1) {
    if (pincode?.text != null && pincode!.text.isNotEmpty) {
      UploadPinData(_btnController1);
    } else {
      // _btnController1.error();
      // Timer(Duration(seconds: 1), () {
      //   _btnController1.reset();
      // });
      setState(() {
        isProceedBtnVisible = true;
        isProceedBtnLoaderVisible = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        titleTxt: "Forgot Pin",
        bottomtext: false,
        showLeading: true,
      ),
      body: SingleChildScrollView(child: _buildBody(context)),
    );
  }

  Widget _buildBody(context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 30,
        left: 20,
        right: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
           SizedBox(
            height: 50.h,
          ),
          const Text(
            "We will send a verification OTP to\nthe Phone Number on your account in order\nto reset your password",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
           SizedBox(
            height: 30.h,
          ),
          TextField(
            onSubmitted: (value) {
              setState(() {
                Map<String, dynamic> updata = {"mob_number": number.text};
                SendOtp().SendOtpExotel(updata);
              });
              Flushbar(
                message: "OTP Sent",
                duration: const Duration(seconds: 3),
              ).show(context);
            },
            controller: number,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: EdgeInsets.only(right: 20),
                child: Icon(
                  Icons.call,
                  color: Color(0xFF008083),
                ),
              ),
              hintText: "Enter Phone Number",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 1.w, color: Colors.grey)),
            ),
          ),
          SizedBox(
            height: 40.h,
          ),
          PinCodeTextField(
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
            // backgroundColor: Color.fromARGB(255, 155, 113, 113),
            enableActiveFill: true,
            // errorAnimationController: errorController,
            controller: pincode,
            onCompleted: (v) {
              print("Completed");
            },
            onChanged: (value) {
              print(value);
              setState(() {
                // currentText = value;
              });
            },
            beforeTextPaste: (text) {
              return true;
            },
            appContext: context,
          ),
          SizedBox(
            height: 50.h,
          ),
          Visibility(
            visible: isProceedBtnVisible,
            child: SizedBox(
              width: double.infinity,
              child: CustomNextButton(
                text: "Proceed",
                ontap: () {
                  setState(() {
                    isProceedBtnVisible = false;
                    isProceedBtnLoaderVisible = true;
                  });
                  _validateData(_btnController1);
                },
              ),
            ),
          ),
          Visibility(
              visible: isProceedBtnLoaderVisible,
              child: Center(child: CircularProgressIndicator()))
          // RoundedLoadingButton(
          //   height: 60,
          //   resetAfterDuration: true,
          //   resetDuration: Duration(seconds: 5),
          //   width: MediaQuery.of(context).size.width * 1,
          //   color: const Color.fromRGBO(247, 129, 4, 1),
          //   successColor: const Color.fromRGBO(247, 129, 4, 1),
          //   controller: _btnController1,
          //   onPressed: () => _validateData(_btnController1),
          //   valueColor: Colors.black,
          //   borderRadius: 10,
          //   child: Text(
          //     "Proceed",
          //     style: TextStyle(
          //       color: Color(0xFFFFFFFF),
          //       fontSize: 20,
          //       fontFamily: 'Productsans',
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}