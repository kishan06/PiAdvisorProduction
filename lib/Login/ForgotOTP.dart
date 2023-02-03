// ignore_for_file: prefer_const_constructors, avoid_print, file_names

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:piadvisory/Common/CustomNextButton.dart';
import 'package:piadvisory/Common/CustomRoundedloadingbutton.dart';
import 'package:piadvisory/Login/Repository/Resetpassword.dart';
import 'package:piadvisory/Login/ResetPassword.dart';
import 'package:flutter/material.dart';
import 'package:piadvisory/Signup/Repository/SendOtp.dart';
import 'package:piadvisory/Signup/Repository/VerifyOtp.dart';
import 'package:piadvisory/Utils/base_manager.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '/Utils/Dialogs.dart';
import '../Common/app_bar.dart';

// ignore: camel_case_types
class ForgotOTP extends StatefulWidget {
  ForgotOTP({Key? key}) : super(key: key);

  @override
  State<ForgotOTP> createState() => _ForgotOTPState();
}

class _ForgotOTPState extends State<ForgotOTP> {
  TextEditingController? pincode = TextEditingController();
  final number = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
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
    number.text = Get.arguments['number'];

    Map<String, dynamic> updata = {"mob_number": number.text};
    //SendOtp().sendotp(updata);
    SendOtp().SendOtpExotel(updata);
    super.initState();
  }

  _validateData() {
    final isValid = _form.currentState?.validate();
    if (isValid!) {
      replaceSignInBtnWithLoader();
      UploadData();
    } else {
      utils.showToast("please enter verification code");
      replaceLoaderWithSignInBtn();
    }
  }

  Future<void> UploadData() async {
    print("mobile number in controller is ${number.text}");
    Map<String, dynamic> updata = {
      "mob_number": number.text,
      "otp": pincode!.text,
    };

    // if (pincode!.text == "1111") {
    //   Get.toNamed('/resetPassword', arguments: {'number': number.text});
    // } else {
    //   utils.showToast("Invalid OTP");
    //   replaceLoaderWithSignInBtn();
    // }
    //util content is approved
    final data = await VerifyOTP().VerifydetailsWithoutToken(updata, context);
    print("data message is  ${data.message}");
    if (data.message == "0") {
      replaceLoaderWithSignInBtn();
     Get.offNamed('/resetPassword', arguments: {'number': number.text});
    } else {
      replaceLoaderWithSignInBtn();
      utils.showToast(data.message);
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
                const SizedBox(
                  height: 50,
                ),
                Text(
                  "We will send a verification otp to\nthe number on your account in order\nto reset your password",
                  style: TextStyle(
                      fontSize: 15,
                      color: Get.isDarkMode ? Colors.white : Colors.black),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  readOnly: true,
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
                    hintStyle: TextStyle(
                        color: Get.isDarkMode ? Colors.white : Colors.black),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.grey)),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  "OTP Sent to registered mobile number",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF008083),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                PinCodeTextField(
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return "Please Enter verification code";
                    } else if (value != null && value.length < 4) {
                      return "OTP length should be atleast 4";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                 FilteringTextInputFormatter.allow(RegExp('[0-9]')),
              ],
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
                    print("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                  appContext: context,
                ),
                SizedBox(
                  height: 50,
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
          ),
        ),
      ),
    );
  }
}
