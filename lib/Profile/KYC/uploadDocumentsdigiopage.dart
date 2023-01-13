import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:piadvisory/Common/CustomTextFormFields.dart';
import 'package:piadvisory/HomePage/Homepage.dart';
import 'package:piadvisory/Profile/KYC/proofAddress.dart';
import 'package:piadvisory/Profile/KYC/related.dart';

import '../../Common/CustomNextButton.dart';
import '/Common/app_bar.dart';
import '/Utils/textStyles.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UploadDocuments extends StatefulWidget {
  const UploadDocuments({Key? key}) : super(key: key);

  @override
  State<UploadDocuments> createState() => _UploadDocumentsState();
}

class _UploadDocumentsState extends State<UploadDocuments> {
  bool Photograph = false;
  bool PAN = false;
  bool Aadhaar = false;
  bool Cancelled = false;
  bool signature = false;
  bool IPV = false;
   bool VideoIPV = false;
  final box1digits =TextEditingController();
  final box2digits =TextEditingController();
  final box3digits =TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController correspondance = TextEditingController();
  TextEditingController emailid = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();
   final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
         CustomAppBar(titleTxt: "Upload Documents or Download of \n Documents from Digi Locker",bottomtext: false),
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
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   textAlign: TextAlign.left,
                //   "Select Proof of Address Documents submitted",
                //   style: blackStyle(context)
                //       .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                // ),
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
                                value: Photograph,
                                onChanged: (bool? value) {
                                  setState(() {
                                    Photograph = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                          Text(
                            "Photograph (Selfie):",
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
                                value: PAN,
                                onChanged: (bool? value) {
                                  setState(() {
                                    PAN = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                          Text(
                            "PAN:",
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
                                value: Aadhaar,
                                onChanged: (bool? value) {
                                  setState(() {
                                    Aadhaar = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                          Text(
                            "Aadhaar:",
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
                                value: Cancelled,
                                onChanged: (bool? value) {
                                  setState(() {
                                    Cancelled = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                          Text(
                            "Cancelled Cheque Leaf:",
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
                                value: signature,
                                onChanged: (bool? value) {
                                  setState(() {
                                    signature = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                          Text(
                            "Image of signature:",
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
                                value: IPV,
                                onChanged: (bool? value) {
                                  setState(() {
                                    IPV = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                          Text(
                            "Self IPV:",
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
                                value: VideoIPV,
                                onChanged: (bool? value) {
                                  setState(() {
                                    VideoIPV = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                          Text(
                            "Video IPV:",
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
                SvgPicture.asset(
                  "assets/images/lock_black_24dp.svg",
                  color: Color(0xFFF78104),
                ),
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
            Form(
              key: _form,
              child: Text(
                  "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut"),
            ),
            SizedBox(
              height: 30,
            ),
            Image.asset("assets/images/pancard.png"),
            SizedBox(
              height: 40,
            ),
            Text("Pleade enter your PAN number ",
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
                 //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 352,
                    height: 80,
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.orange, width: 3),
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Center(child: TextFormField(
                             inputFormatters: [LengthLimitingTextInputFormatter(10)],
                            // keyboardType: TextInputType.number,
                             style:TextStyle(fontSize: 28),
                             controller: box1digits,
                                decoration: InputDecoration(
                       labelText: '',
                       border: InputBorder.none,
                       )
                       ,)
                       ),
                        )
                        ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            SizedBox(
                  width: double.infinity,
                  child: CustomNextButton(
                      text: "Save",
                      ontap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  HomePage()
                                )
                                );
                      }
                    ),
                ),
                const SizedBox(
                  height: 20,
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
