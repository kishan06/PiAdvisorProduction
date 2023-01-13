import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:piadvisory/Common/CustomTextFormFields.dart';
import 'package:piadvisory/Profile/KYC/proofAddress.dart';
import 'package:piadvisory/Profile/KYC/related.dart';

import '../../Common/CustomNextButton.dart';
import '/Common/app_bar.dart';
import '/Utils/textStyles.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProofAddress extends StatefulWidget {
  const ProofAddress({Key? key}) : super(key: key);

  @override
  State<ProofAddress> createState() => _ProofAddressState();
}

class _ProofAddressState extends State<ProofAddress> {
  bool Passport = false;
  bool Voter = false;
  bool NGREA = false;
  bool National = false;
  bool UID = false;
  final box1digits = TextEditingController();
  final box2digits = TextEditingController();
  final box3digits = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController correspondance = TextEditingController();
  TextEditingController emailid = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomAppBar(titleTxt: "Proof of Address (POA)", bottomtext: true),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  textAlign: TextAlign.left,
                  "Select Proof of Address Documents submitted",
                  style: blackStyle(context)
                      .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Container(
                  color: const Color(0xFFF2F5FA),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Transform.scale(
                            scale: 1,
                            child: Theme(
                              data: ThemeData(
                                unselectedWidgetColor: Color(0xFFF78104),
                              ),
                              child: Checkbox(
                                activeColor: Colors.amber,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(2))),
                                value: Passport,
                                onChanged: (bool? value) {
                                  setState(() {
                                    Passport = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                          Text(
                            "Passport:",
                            style: blackStyle(context).copyWith(
                              fontSize: 14,
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Transform.scale(
                            scale: 1,
                            child: Theme(
                              data: ThemeData(
                                unselectedWidgetColor: Color(0xFFF78104),
                              ),
                              child: Checkbox(
                                activeColor: Colors.amber,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(2))),
                                value: Voter,
                                onChanged: (bool? value) {
                                  setState(() {
                                    Voter = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                          Text(
                            "Voter Identity Card:",
                            style: blackStyle(context).copyWith(
                              fontSize: 14,
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Transform.scale(
                            scale: 1,
                            child: Theme(
                              data: ThemeData(
                                unselectedWidgetColor: Color(0xFFF78104),
                              ),
                              child: Checkbox(
                                activeColor: Colors.amber,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(2))),
                                value: NGREA,
                                onChanged: (bool? value) {
                                  setState(() {
                                    NGREA = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                          Text(
                            "NGREA Job Card:",
                            style: blackStyle(context).copyWith(
                              fontSize: 14,
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Transform.scale(
                            scale: 1,
                            child: Theme(
                              data: ThemeData(
                                unselectedWidgetColor: Color(0xFFF78104),
                              ),
                              child: Checkbox(
                                activeColor: Colors.amber,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(2))),
                                value: National,
                                onChanged: (bool? value) {
                                  setState(() {
                                    National = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                          Text(
                            "National Population Register Letter:",
                            style: blackStyle(context).copyWith(
                              fontSize: 14,
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Transform.scale(
                            scale: 1,
                            child: Theme(
                              data: ThemeData(
                                unselectedWidgetColor: Color(0xFFF78104),
                              ),
                              child: Checkbox(
                                activeColor: Colors.amber,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(2))),
                                value: UID,
                                onChanged: (bool? value) {
                                  setState(() {
                                    UID = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                          Text(
                            "UID (Aadhaar):",
                            style: blackStyle(context).copyWith(
                              fontSize: 14,
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              "Upload",
              style: blackStyle(context)
                  .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            DottedBorder(
              color: Color(0xFF6B6B6B),
              strokeWidth: 3,
              dashPattern: const [10, 5, 10, 5, 10, 5],
              borderType: BorderType.RRect,
              radius: const Radius.circular(20),
              child: Container(
                width: double.infinity,
                height: 140,
                decoration: BoxDecoration(
                    color: const Color(0xFFF2F5FA),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/images/Path 4171.svg"),
                    const SizedBox(height: 16),
                    const Text(
                      "Upload your file here",
                      style: TextStyle(
                        color: Color(0xFF444444),
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Browse",
                      style: blackStyle(context)
                          .copyWith(fontSize: 12, color: Color(0xFF008083)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                // SvgPicture.asset(
                //   "assets/images/lock_black_24dp.svg",
                //   color: Color(0xFFF78104),
                // ),
                Flexible(
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut",
                    style: blackStyle(
                      context,
                    ).copyWith(fontSize: 10),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 17,
            ),
            Text(
                "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut"),
            SizedBox(
              height: 30,
            ),
            Image.asset("assets/images/Aadhaar.png"),
            SizedBox(
              height: 30,
            ),
            Text("Enter Your Aadhaar Number ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                )),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 110,
                    height: 80,
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.orange, width: 3),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Center(
                              child: TextFormField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(4)
                            ],
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontSize: 28),
                            controller: box1digits,
                            decoration: InputDecoration(
                              labelText: '',
                              border: InputBorder.none,
                            ),
                          )),
                        )),
                  ),
                  SizedBox(
                    width: 110,
                    height: 80,
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.orange, width: 3),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Center(
                              child: TextFormField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(4)
                            ],
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontSize: 28),
                            controller: box2digits,
                            decoration: InputDecoration(
                              labelText: '',
                              border: InputBorder.none,
                            ),
                          )),
                        )),
                  ),
                  SizedBox(
                    width: 110,
                    height: 80,
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.orange, width: 3),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Center(
                              child: TextFormField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(4)
                            ],
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontSize: 28),
                            controller: box3digits,
                            decoration: InputDecoration(
                              labelText: '',
                              border: InputBorder.none,
                            ),
                          )),
                        )),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Form(
              key: _form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Enter Address details",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  CustomTextFields(
                    controller: address,
                    hint: "Enter Address",
                    errortext: "Enter Address",
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    "Enter Correspondance Address details",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  CustomTextFields(
                    controller: correspondance,
                    hint: "Enter Correspondance Address",
                    errortext: "Enter Correspondance Address",
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    "Email ID",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.grey,
                    style: const TextStyle(
                      //color: Colors.grey,
                      fontFamily: 'Product Sans',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: emailid,
                    decoration: InputDecoration(
                      hintText: "Enter Email ID",
                      hintStyle: blackStyle(context).copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Get.isDarkMode
                              ? Colors.white
                              : Color(0xFF303030).withOpacity(0.3)),
                      //Theme.of(context).textTheme.headline3!.merge(TextStyle(color:Color(0xFF303030).withOpacity(0.3))),
                      //Theme.of(context).textTheme.headline3,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFF303030))),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Valid Email ID";
                      }
                      return null;
                    },
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(50),
                    ],
                    onSaved: (value) {},
                    onChanged: (value) {
                      // onEmailChange(value);
                    },
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    "Mobile Number",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    //maxLength: maxlength,
                    cursorColor: Colors.grey,
                    style: TextStyle(
                      fontFamily: 'Product Sans',
                      fontSize: 16.sm,
                      fontWeight: FontWeight.w500,
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: mobilecontroller,
                    decoration: InputDecoration(
                      hintText: "Enter Mobile Number",
                      hintStyle: blackStyle(context).copyWith(
                        fontSize: 16.sm,
                        fontWeight: FontWeight.w400,
                        color: Get.isDarkMode
                            ? Colors.white
                            : Color(0xFF303030).withOpacity(0.3),
                      ),
                      //Theme.of(context).textTheme.headline3,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      focusedBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFF303030))),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Mobile Number";
                      } else if (value.length < 10) {
                        return "Please Enter Correct Phone Number";
                      }
                      return null;
                    },
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                  ),

                  // CustomTextFields(
                  //   txtinptype: TextInputType.number,
                  //   errortext: "Enter Mobile Number",
                  //   hint: "Enter Mobile Number",
                  //   controller: mobilecontroller,
                  // ),
                  SizedBox(
                    height: 40.h,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: CustomNextButton(
                        text: "Continue",
                        form: _form,
                        ontap: () {
                          final isValid = _form.currentState?.validate();
                          if (isValid!) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RelatedPerson()));
                          } else {}
                        }),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class CustomTextFields extends StatelessWidget {
  const CustomTextFields({
    Key? key,
    this.controller,
    this.hint,
    this.errortext,
    this.ontap,
    this.limitlength,
    this.maxlength,
    this.onchanged,
    this.txtinptype,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? hint;
  final String? errortext;
  final Function(String)? ontap;
  final int? limitlength;
  final int? maxlength;
  final Function(String)? onchanged;
  final TextInputType? txtinptype;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: txtinptype ?? TextInputType.text,
      maxLength: maxlength,
      cursorColor: Colors.grey,
      style: TextStyle(
        fontFamily: 'Product Sans',
        fontSize: 16.sm,
        fontWeight: FontWeight.w500,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: blackStyle(context).copyWith(
          fontSize: 16.sm,
          fontWeight: FontWeight.w400,
          color: Get.isDarkMode
              ? Colors.white
              : Color(0xFF303030).withOpacity(0.3),
        ),
        //Theme.of(context).textTheme.headline3,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(width: 1, color: Color(0xFF303030))),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errortext ?? "Empty value";
        }
        return null;
      },
      inputFormatters: [
        LengthLimitingTextInputFormatter(limitlength ?? 20),
      ],
      onSaved: (value) {
        ontap?.call;
      },
      onChanged: (value) {
        onchanged?.call(value);
      },
    );
  }
}
