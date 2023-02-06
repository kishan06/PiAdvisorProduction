// ignore_for_file: avoid_unnecessary_containers, file_names, unnecessary_import, sized_box_for_whitespace, prefer_const_constructors, duplicate_ignore, avoid_print

import 'dart:async';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/get_core.dart';

import 'package:get/get_core/src/get_main.dart';

import 'package:get/get_navigation/get_navigation.dart';
import 'package:piadvisory/Common/Signup_appbar.dart';
import 'package:piadvisory/Login/login.dart';
import 'package:piadvisory/Signup/Repository/Securityfirstpage.dart';
import 'package:piadvisory/Signup/touch_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piadvisory/Utils/base_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Common/CustomNextButton.dart';
import '../Common/app_bar.dart';
import '/Utils/Dialogs.dart';

class SecurityFirst extends StatefulWidget {
  const SecurityFirst({Key? key}) : super(key: key);

  @override
  State<SecurityFirst> createState() => _SecurityFirstState();
}

class _SecurityFirstState extends State<SecurityFirst> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var ReenterPin;

  @override
  void initState() {
    Timer(Duration(seconds: 1), () {
      build4digitpin();
    });

    super.initState();
  }

  _saveOptions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('pinenabled', true);
  }

  void UploadData() async {
    final isValid = _formKey.currentState?.validate();
    if (isValid!) {
      Map<String, dynamic> updata = {
        "user_pin": pincontroller.text,
      };
      final data = await UploadSecurityFirst().postSecuritypin(updata);
      _saveOptions();
      if (data.status == ResponseStatus.SUCCESS) {
        // Timer(Duration(seconds: 2), () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (builder) => const TouchId(),
          ),
        );
        // });
        //Navigator.pop(context);
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
                            "Let's set your 4 Digit Pin",
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
                        Text("Choose a PIN of Your choice"),
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
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  keyboardType: TextInputType.number,
                                  controller: pincontroller,
                                  textAlign: TextAlign.center,
                                  decoration: const InputDecoration(
                                    //  helperText: '',
                                    hintText: "",
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3,
                                            color: Color(0x00000000))),
                                  ),
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(4),
                                     FilteringTextInputFormatter.allow(RegExp('[0-9]')),
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
                          height: 15.h,
                        ),
                        const Text("Please Re-Enter the PIN"),
                        SizedBox(
                          height: 25.h,
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
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    keyboardType: TextInputType.number,
                                    controller: confirmpincontroller,
                                    textAlign: TextAlign.center,
                                    decoration: const InputDecoration(
                                      hintText: "",
                                      //    helperText: '',
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 3,
                                              color: Color(0x00000000))),
                                    ),
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(4),
                                       FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                                    ],
                                    validator: (val) {
                                      if (val == null || val.isEmpty) {
                                        return 'Pin is Empty';
                                      }
                                      //changes done for format exception
                                      if (confirmpincontroller.text
                                              .toString() ==
                                          pincontroller.text) {
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
                              text: "Submit",
                              ontap: () {
                                UploadData();
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

  String gender = "4 Digit PIN";
  bool onclickoftouchid = false;
  bool onclickofpin = true;
  TextEditingController pincontroller = TextEditingController();
  TextEditingController confirmpincontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomSignupAppBar(
          titleTxt: "Security First", bottomtext: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 30.h,
              ),
              Text(
                "Select to login Method",
                style: TextStyle(
                  fontSize: 18,
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Container(
                // ignore: prefer_const_constructors
                height: 125.h,
                decoration: BoxDecoration(
                  color: onclickofpin ? const Color(0xFF008083) : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1,
                    color: Colors.black,
                  ),
                ),
                alignment: const Alignment(50, 0),
                padding: const EdgeInsets.all(5),
                child: ListTile(
                  trailing: SvgPicture.asset(
                    onclickofpin
                        ? "assets/images/four-dg-white.svg"
                        : "assets/images/four-dg-black.svg",
                  ),
                  onTap: () {
                    //onclickofpin ? build4digitpin() : null;
                  },
                  title: Text(
                    "4 Digit PIN",
                    style: TextStyle(
                        color: onclickofpin ? Colors.white : Colors.black),
                  ),
                  leading: Transform.scale(
                    scale: 1.5,
                    child: Radio(
                        activeColor: (Colors.white),
                        value: "4 Digit PIN",
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            print(value);
                            onclickoftouchid = false;
                            onclickofpin = true;
                            gender = value.toString();
                            //  build4digitpin();
                          });
                        }),
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Container(
                height: 125.h,
                decoration: BoxDecoration(
                  color:
                      onclickoftouchid ? const Color(0xFF008083) : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1,
                    color: Colors.black,
                  ),
                ),
                alignment: const Alignment(50, 0),
                padding: const EdgeInsets.all(5),
                child: ListTile(
                  onTap: () {
                    onclickoftouchid ? Get.toNamed('/touchid') : null;
                  },
                  trailing: SvgPicture.asset(
                    onclickoftouchid
                        ? "assets/images/touch-white.svg"
                        : "assets/images/touch-black.svg",
                  ),
                  title: Text(
                    "Touch Id",
                    style: TextStyle(
                        color: onclickoftouchid ? Colors.white : Colors.black),
                  ),
                  leading: Transform.scale(
                    scale: 1.5,
                    child: Radio(
                        // fillColor:
                        //     MaterialStateProperty.all<Color>(Color(0xFF008083)),
                        focusColor: const Color(0xFF008083),
                        activeColor: (Colors.white),
                        value: "Touch Id",
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            onclickoftouchid = true;
                            onclickofpin = false;

                            gender = value.toString();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (builder) => const TouchId(),
                              ),
                            );
                          });
                        }),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
