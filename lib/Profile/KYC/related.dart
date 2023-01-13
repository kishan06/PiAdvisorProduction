import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:piadvisory/Common/CustomTextFormFields.dart';
import 'package:piadvisory/Profile/KYC/proofAddress.dart';
import 'package:piadvisory/Profile/KYC/uploadDocumentsdigiopage.dart';

import '../../Common/CustomNextButton.dart';
import '/Common/app_bar.dart';
import '/Utils/textStyles.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RelatedPerson extends StatefulWidget {
  const RelatedPerson({Key? key}) : super(key: key);

  @override
  State<RelatedPerson> createState() => _RelatedPersonState();
}

class _RelatedPersonState extends State<RelatedPerson> {
  bool Guardian = false;
  bool Assignee = false;
  bool Authorized = false;
  TextEditingController name = TextEditingController();
  TextEditingController poi = TextEditingController();
  TextEditingController emailid = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          titleTxt: "Related Person (Optional)", bottomtext: false),
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
                  "Select type of Related Person",
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
                                value: Guardian,
                                onChanged: (bool? value) {
                                  setState(() {
                                    Guardian = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                          Text(
                            "Guardian of Minor:",
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
                                value: Assignee,
                                onChanged: (bool? value) {
                                  setState(() {
                                    Assignee = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                          Text(
                            "Assigne:",
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
                                value: Authorized,
                                onChanged: (bool? value) {
                                  setState(() {
                                    Authorized = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                          Text(
                            "Authorized Representative:",
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
              height: 40,
            ),
            Form(
              key: _form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Enter Name of Related person",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  CustomTextFields(
                    controller: name,
                    hint: "Enter Name of Related Person",
                    errortext: "Enter Name of Related Person",
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Text(
                    "Select and Enter POI details of Related Person",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  CustomTextFields(
                    controller: poi,
                    hint: "Enter POI details of Related Person",
                    errortext: "Enter POI details of Related Person",
                  ),
                  SizedBox(
                    height: 250.h,
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
                                        const UploadDocuments()));
                          } else {}
                        }),
                  ),
                  const SizedBox(
                    height: 40,
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
