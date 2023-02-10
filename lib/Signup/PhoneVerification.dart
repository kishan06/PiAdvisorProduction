// ignore_for_file: unnecessary_import, sized_box_for_whitespace, file_names, implementation_imports, prefer_const_constructors, avoid_print

import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:piadvisory/HomePage/Homepage.dart';
import 'package:piadvisory/Login/Repository/LoginMethod.dart';
import 'package:piadvisory/Login/Repository/UserVerified.dart';
import 'package:piadvisory/SideMenu/Subscribe/AppWidget.dart';
import 'package:piadvisory/SideMenu/Subscribe/Repository/getSubscriptionWithDetails.dart';
import 'package:piadvisory/Signup/Repository/Securityfirstpage.dart';
import 'package:piadvisory/Signup/Repository/SendOtp.dart';
import 'package:piadvisory/Signup/Repository/VerifyOtp.dart';
import 'package:piadvisory/Signup/SecurityFirst.dart';

import 'package:piadvisory/Signup/SecurityQuestions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:piadvisory/Signup/SignupPage.dart';
import 'package:piadvisory/Utils/Dialogs.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:piadvisory/Utils/base_manager.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:timer_button/timer_button.dart';
//import 'package:timer_button/timer_button.dart';
import 'package:timer_button/timer_button.dart';

import '../Common/CustomNextButton.dart';
import '../Common/app_bar.dart';
import '../Utils/textStyles.dart';

class PhoneVerification extends StatefulWidget {
  PhoneVerification({
    Key? key,
    this.number,
  }) : super(key: key);
  String? number;
  @override
  State<PhoneVerification> createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
  TextEditingController? pincode = TextEditingController();

  final mobile = TextEditingController();
  final RoundedLoadingButtonController _btnController1 =
      RoundedLoadingButtonController();

  bool _otpSent = false;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  bool pinfiledshow = false;
  bool _sendOTPclicked = false;

  
  bool isValidPhoneNumber(String phoneNumber) {
  final RegExp phoneNumberExpression = RegExp(r"^0{10}$");
  
  return !phoneNumberExpression.hasMatch(phoneNumber);
}

  void _validateData() {
    final isValid = _form.currentState?.validate();
    if (isValid!) {
      replaceSignInBtnWithLoader();
      UploadData();
    } else {
      utils.showToast("please fill all required fields");
      replaceLoaderWithSignInBtn();
    }
  }

  @override
  void initState() {
    super.initState();
    _btnController1.stateStream.listen((value) {});
    mobile.text = widget.number!;
  }

  Future<void> checkNumberExist() async {
    Map<String, dynamic> updata = {
      "number": mobile.text,
    };
    final data = await LoginMethod().checkMobileExist(updata, context);
    if (data.status == ResponseStatus.SUCCESS) {
      setState(() {
        _otpSent = true;
        _sendOTPclicked = true;
      });

      Map<String, dynamic> updata2 = {
        "mob_number": mobile.text,
      };
      await SendOtp().SendOtpExotel(updata2);
      Flushbar(
        message: "Otp has been sent successfully",
        duration: const Duration(seconds: 3),
      ).show(context);
    } else if (data.status == ResponseStatus.PRIVATE) {
      Flushbar(
        duration: const Duration(seconds: 2),
        message: "Mobile number does not exist",
      ).show(context);
      replaceLoaderWithSignInBtn();
    } else {
      Flushbar(
        duration: const Duration(seconds: 2),
        message: "Some error occured",
      ).show(context);
      replaceLoaderWithSignInBtn();
    }
  }

  Future<void> UploadData() async {
    Map<String, dynamic> updata = {
      "mob_number": mobile.text,
      "otp": pincode!.text,
    };

    final data = await VerifyOTP().VerifydetailsWithoutToken(updata, context);

    if (data.status == ResponseStatus.SUCCESS) {
      final data = await UploadSecurityFirst().checkRegisterCompleted();
      if (data.status == ResponseStatus.SUCCESS) {
        if (checkRegister != null && checkRegister == 0) {
          // Flushbar(
          //   message: "Please Complete Registration Process",
          //   duration: const Duration(seconds: 3),
          // ).show(context);
          Get.to(SignUpPage());
          replaceLoaderWithSignInBtn();
        } else {
          final data = await UserVerified().getPinexist();
          if (data.status == ResponseStatus.SUCCESS) {
            if (data.data == 0) {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SecurityFirst()));

              replaceLoaderWithSignInBtn();
              return;
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
          replaceLoaderWithSignInBtn();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => HomePage(
                        showVideo: false,
                      )),
              (Route<dynamic> route) => false);
          getSubscriptionWithDetails().getsubsDetail();
        }
      } else {
        replaceLoaderWithSignInBtn();
        utils.showToast(data.message);
      }
    } else {
      replaceLoaderWithSignInBtn();
      utils.showToast(data.message);
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
    return Scaffold(
      appBar:
          const CustomAppBar(titleTxt: "Phone Verification", bottomtext: false),
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
                height: 73,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                    child: _otpSent == true
                        ? Text(
                            "OTP sent to",
                            style: TextStyle(
                                //color: Colors.grey,
                                fontFamily: 'Productsans',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.black),
                          )
                        : Container()),
              ),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: Container(
                  height: 55,
                  width: 150,
                  child: Stack(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter number";
                          } else if (value.length < 10) {
                            return "Please enter correct phone number";
                          } else if (!isValidPhoneNumber(value)) {
                            return 'Phone number cannot contain 10 zeros';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: mobile,
                        autofocus: true,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                            fontFamily: 'Productsans',
                            fontSize: 21,
                            fontWeight: FontWeight.w400,
                            color:
                                Get.isDarkMode ? Colors.white : Colors.black),
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF008083)),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF008083)),
                          ),
                          disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF008083)),
                          ),
                          helperText: "",
                          hintText: 'Enter Number',
                          hintStyle: TextStyle(
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black),
                          errorStyle: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Productsans'
                          )
                        ),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                        ],
                        // onFieldSubmitted: (value) {
                        //   setState(() {
                        //     _otpSent = true;
                        //     // pinfiledshow = true;
                        //     Map<String, dynamic> updata = {
                        //       "mob_number": mobile.text
                        //     };
                        //     SendOtp().SendOtpExotel(updata);
                        //     //  SendOtp().sendotp(updata);
                        //   });
                        // },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 27),
                            child: !_sendOTPclicked
                                ? TextButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor: Color(0xFFF78104)),
                                    onPressed: () {
                                      setState(() {
                                        if (mobile.text.isEmpty) {
                                          _otpSent = false;
                                          Flushbar(
                                            message:
                                                "Please Enter Phone Number",
                                            duration:
                                                const Duration(seconds: 3),
                                          ).show(context);
                                        } else {
                                          checkNumberExist();
                                        }
                                      });
                                    },
                                    child: Text(
                                      "Send OTP",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                  )
                                : mobile.text.isEmpty
                                    ? TextButton(
                                        style: TextButton.styleFrom(
                                            backgroundColor: Color(0xFFF78104)),
                                        onPressed: () {
                                          setState(() {
                                            if (mobile.text.isEmpty) {
                                              _otpSent = false;
                                              Flushbar(
                                                message:
                                                    "Please Enter Phone Number",
                                                duration:
                                                    const Duration(seconds: 3),
                                              ).show(context);
                                            } else {
                                              checkNumberExist();
                                            }
                                          });
                                        },
                                        child: Text(
                                          "Resend",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white),
                                        ),
                                      )
                                    : TimerButton(
                                        disabledTextStyle:
                                            TextStyle(color: Colors.white),
                                        activeTextStyle:
                                            TextStyle(color: Colors.white),
                                        buttonType: ButtonType.TextButton,
                                        label: "Resend",
                                        timeOutInSeconds: 60,
                                        //mobile.text.isEmpty ?  1 : 60,
                                        onPressed: () {
                                          setState(() {
                                            if (mobile.text.isEmpty) {
                                              _otpSent = false;
                                              Flushbar(
                                                message:
                                                    "Please Enter Phone Number",
                                                duration:
                                                    const Duration(seconds: 3),
                                              ).show(context);
                                            } else {
                                              checkNumberExist();
                                            }
                                          });
                                        },
                                        disabledColor: Colors.grey,
                                        color: Color(0xFFF78104),
                                      ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                "Enter OTP",
              ),
              SizedBox(
                height: 26,
              ),
              Container(
                  child:
                      //  pinfiledshow
                      //  ?
                      PinCodeTextField(      
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return "Please enter verification code";
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
              )
                  // : null,
                  ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  // Text("Didn't you receive any code?",
                  //     style: blackStyle(context).copyWith(
                  //         color: Get.isDarkMode
                  //             ? Colors.white
                  //             : Color(0xFF444444))),
                  // SizedBox(
                  //   width: 5,
                  // ),
                  // !_sendOTPclicked
                  //     ? Container()
                  //     : GestureDetector(
                  //         onTap: () {
                  //           setState(() {
                  //             pincode!.clear();
                  //             if (mobile.text.isEmpty) {
                  //               _otpSent = false;
                  //               Flushbar(
                  //                       message: "Please Enter Phone Number",
                  //                       duration: Duration(seconds: 3))
                  //                   .show(context);
                  //             } else {
                  //               checkNumberExist();
                  //             }
                  //           });

                  //           // Map<String, dynamic> updata = {"mob_number": mobile.text};
                  //           // SendOtp().sendotp(updata);
                  //           //SendOtp().SendOtpExotel(updata);
                  //           // Flushbar(
                  //           //  message: "Otp has been sent successfully",
                  //           //  duration: const Duration(seconds: 3),
                  //           // ).show(context);
                  //         },
                  //         child: Text("Resend",
                  //             style: blackStyle(context).copyWith(
                  //                 color: Color.fromRGBO(218, 6, 0, 1))),
                  //       ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 228.h,
              ),
              /*
              RoundedLoadingButton(
                height: 60,
                resetAfterDuration: true,
                resetDuration: Duration(seconds: 5),
                width: MediaQuery.of(context).size.width * 1,
                color: const Color.fromRGBO(247, 129, 4, 1),
                successColor: const Color.fromRGBO(247, 129, 4, 1),
                controller: _btnController1,
                onPressed: () => _validateData(),
                valueColor: Colors.black,
                borderRadius: 10,
                child: Text(
                  "Verify",
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 20,
                    fontFamily: 'Productsans',
                  ),
                ),
              ),
              */
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
            ],
          ),
        ),
      )),
    );
  }
}
