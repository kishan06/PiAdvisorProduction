import 'dart:async';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:piadvisory/Common/CustomNextButton.dart';
import 'package:piadvisory/Common/Signup_appbar.dart';
import 'package:piadvisory/Common/app_bar.dart';
import 'package:piadvisory/Login/login.dart';
import 'package:piadvisory/Signup/Repository/RegisterMethod.dart';
import 'package:piadvisory/Signup/otpPhoneVerification.dart';
import 'package:flutter/services.dart';
import 'package:piadvisory/Utils/Dialogs.dart';
import 'package:piadvisory/Utils/base_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piadvisory/Utils/base_manager.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class VerifyPhoneNumber extends StatefulWidget {
  const VerifyPhoneNumber({Key? key}) : super(key: key);

  @override
  State<VerifyPhoneNumber> createState() => _VerifyPhoneNumberState();
}

class _VerifyPhoneNumberState extends State<VerifyPhoneNumber> {
  final mobile = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  void _validateData() {
    final isValid = _form.currentState?.validate();
    if (isValid!) {
      replaceSignInBtnWithLoader();
      UploadData();
    }
  }

  Future<void> UploadData() async {
    Map<String, dynamic> updata = {
      "mob_number": mobile.text,
    };

    final data = await RegisterUser().postRegisterNumber(updata);

    if (data.status == ResponseStatus.SUCCESS) {
      replaceLoaderWithSignInBtn();
      Get.toNamed('/RegistrationOTPverification',
          arguments: {"mobileno": int.parse(mobile.text)});
    } else {
      replaceLoaderWithSignInBtn();
      return utils.showToast(data.message);
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
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login()));
        return Future.value(false);
      },
      child: Scaffold(
        appBar: const CustomSignupAppBar(
            titleTxt: "Verify Your Number", bottomtext: false),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Form(
              key: _form,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  Container(
                    color: Get.isDarkMode
                        ? Color(0xFF303030).withOpacity(0.8)
                        : Colors.white,
                    // decoration: BoxDecoration(
                    //    border: Border.all(color: const Color(0xFFDFDFDF)),

                    //   //backgroundColor: Get.isDarkMode? Colors.black:Colors.white,
                    // ),

                    child: SvgPicture.asset(
                      "assets/images/Group 6172.svg",

                      //color: Get.isDarkMode? Colors.white: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Please enter your mobile number",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 60,
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          readOnly: true,
                          //  controller: countryCode,
                          autofocus: true,
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              fontFamily: 'Productsans',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                          decoration: InputDecoration(
                              helperText: '',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF008083), width: 1.5),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF008083), width: 1.5),
                              ),
                              hintText: '+91',
                              hintStyle: TextStyle(
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 20)),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                          ],
                          // onSubmitted: (value) {
                          //   setState(() {
                          //     //  _otpSent = true;
                          //   });
                          // },
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.55,
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: mobile,
                          autofocus: true,
                          cursorColor:
                              Get.isDarkMode ? Colors.white : Colors.black,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              fontFamily: 'Productsans',
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black),
                          decoration: InputDecoration(
                              helperText: '',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF008083), width: 1.5),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF008083), width: 1.5),
                              ),
                              hintText: 'Enter Number',
                              hintStyle: TextStyle(
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 20)),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Number";
                            } else if (value.length < 10) {
                              return "Please Enter Correct Phone Number";
                            }
                            return null;
                          },
                          // onSubmitted: (value) {
                          //   setState(() {
                          //     //  _otpSent = true;
                          //   });
                          // },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Visibility(
                    visible: isSignInBtnVisible,
                    child: SizedBox(
                      width: double.maxFinite,
                      height: 48,
                      child: CustomNextButton(
                        text: "Get Started",
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
                    height: 20.h,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
