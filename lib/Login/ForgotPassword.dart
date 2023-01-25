// ignore_for_file: prefer_const_constructors, must_be_immutable, sort_child_properties_last, file_namesimport 'package:piadvisory/Login/forgot-password.dart';, avoid_unnecessary_containers, file_names
import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:piadvisory/Common/CustomNextButton.dart';
import 'package:piadvisory/Login/ForgotOTP.dart';
import 'package:flutter/material.dart';
import 'package:piadvisory/Login/Repository/LoginMethod.dart';
import 'package:piadvisory/Utils/base_manager.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '/Utils/Dialogs.dart';
import '../Common/app_bar.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController numberController = TextEditingController();

  void _validateData() {
    final isValid = _form.currentState?.validate();
    if (isValid!) {
      checkNumberExist();
    }
  }

  UploadData() async {
    Map<String, dynamic> updata = {"number": numberController.text};
    final data = await LoginMethod().checkMobileExist(updata, context);

    if (data.message == "success") {
      replaceLoaderWithSignInBtn();
      Get.toNamed('/forgototp', arguments: {'number': numberController.text});
    } else {
      replaceLoaderWithSignInBtn();
      return utils.showToast("Please Enter Registered Mobile Number");
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

  Future<void> checkNumberExist() async {
    Map<String, dynamic> updata = {
      "number": numberController.text,
    };
    final data = await LoginMethod().checkMobileExist(updata, context);
    if (data.status == ResponseStatus.SUCCESS) {
      setState(() {
        replaceSignInBtnWithLoader();
        UploadData();
        //_otpSent = true;
      });

      // Map<String, dynamic> updata2 = {
      //   "mob_number": numberController.text,
      // };
      //await SendOtp().SendOtpExotel(updata2);
      // Flushbar(
      //   message: "Taking to next page",
      //   duration: const Duration(seconds: 3),
      // ).show(context);
    } else if (data.status == ResponseStatus.PRIVATE) {
      Flushbar(
        duration: const Duration(seconds: 2),
        message: "Mobile number does not exist",
      ).show(context);
      //replaceLoaderWithSignInBtn();
      //replaceLoaderWithSignInBtn();
    } else {
      Flushbar(
        duration: const Duration(seconds: 2),
        message: "Some error occured",
      ).show(context);
      //replaceLoaderWithSignInBtn();
      //replaceLoaderWithSignInBtn();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const CustomAppBar(titleTxt: "Forgot Password", bottomtext: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 30,
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
                  height: 50,
                ),
                Text(
                  "We will send a verification otp to\nthe phone number on your account in order\nto reset your password",
                  style: TextStyle(
                      fontSize: 15,
                      color: Get.isDarkMode ? Colors.white : Colors.black),
                ),
                SizedBox(
                  height: 63.h,
                ),
                Container(
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: numberController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Icon(
                          Icons.call,
                          color: Color(0xFF008083),
                        ),
                      ),
                      hintText: "Enter Phone Number",
                      hintStyle: TextStyle(
                          color: Get.isDarkMode ? Colors.white : Colors.black),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.grey)),
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter Mobile Number";
                      } else if (value.length < 10) {
                        return "Please Enter Correct Mobile Number";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                // Text(
                //   "OTP Sent to registered mobile number",
                //   style: TextStyle(
                //     fontSize: 16,
                //     color: Color(0xFF008083),
                //   ),
                // ),
                SizedBox(
                  height: 46.h,
                ),
                Visibility(
                  visible: isSignInBtnVisible,
                  child: SizedBox(
                    width: double.maxFinite,
                    height: 48,
                    child: CustomNextButton(
                      text: "Proceed",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
