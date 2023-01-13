// ignore_for_file: file_names, sized_box_for_whitespace

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lottie/lottie.dart';
import 'package:piadvisory/Common/CustomNextButton.dart';
import 'package:piadvisory/Common/CustomTextFormFields.dart';
import 'package:piadvisory/Common/Signup_appbar.dart';
import 'package:piadvisory/Signup/Repository/SecurityQuestions.dart';
import 'package:piadvisory/Signup/SecurityFirst.dart';
import 'package:piadvisory/Utils/base_manager.dart';
import '/Utils/Dialogs.dart';
import 'package:piadvisory/Utils/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../Common/app_bar.dart';

class SecurityQuestions extends StatefulWidget {
  const SecurityQuestions({Key? key}) : super(key: key);

  @override
  State<SecurityQuestions> createState() => _SecurityQuestionsState();
}

class _SecurityQuestionsState extends State<SecurityQuestions> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  List<TextEditingController> _controller = [];
  bool isSubmitBtnVisible = true;
  bool isSubmitBtnLoaderVisible = false;
  @override
  void initState() {
    super.initState();
    final controllers = [answer1, answer2, answer3, answer4];
    _controller = controllers;
  }

  void _validateData() {
    final isValid = _form.currentState?.validate();
    if (isValid!) {
      UploadData(_btnController1);
    } else {
      // _btnController1.error();
      // Timer(Duration(seconds: 2), () {
      //   _btnController1.reset();
      // });
      setState(() {
        isSubmitBtnVisible = true;
        isSubmitBtnLoaderVisible = false;
      });
    }
  }

  final RoundedLoadingButtonController _btnController1 =
      RoundedLoadingButtonController();
  final answer1 = TextEditingController();
  final answer2 = TextEditingController();
  final answer3 = TextEditingController();
  final answer4 = TextEditingController();

  Future<void> UploadData(RoundedLoadingButtonController controller) async {
    print(answer1.text);
    print(answer2.text);
    print(answer3.text);
    print(answer4.text);

    Map<String, Map<String, dynamic>> updata = {
      "question_id_answers": {
        "1": answer1.text,
        "2": answer2.text,
        "3": answer3.text,
        "4": answer4.text
      }
    };

    final data = await getSecurityQuestions().PostAnswers(updata);
    if (data.status == ResponseStatus.SUCCESS) {
      Timer(Duration(seconds: 2), () {
        controller.success();
        Timer(Duration(seconds: 1), () async {
          await Get.toNamed('/security_first');
          setState(() {
            isSubmitBtnVisible = true;
            isSubmitBtnLoaderVisible = false;
          });
        });
      });
    } else {
      setState(() {
        isSubmitBtnVisible = true;
        isSubmitBtnLoaderVisible = false;
      });
      // _btnController1.error();
      // Timer(Duration(seconds: 2), () {
      //   _btnController1.reset();
      // });
      return utils.showToast(data.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const CustomSignupAppBar(titleTxt: "Security Questions", bottomtext: false),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: getSecurityQuestions().getQuestions(),
          builder: (ctx, snapshot) {
            if (snapshot.data == null) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Lottie.asset(
                      "assets/images/lf30_editor_jc6n8oqe.json",
                      repeat: true,
                      height: 150,
                      width: 150,
                    ),
                  ),
                ],
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error} occured',
                    style: TextStyle(fontSize: 18),
                  ),
                );
              }
            }
            return _buildBody(
              context,
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody(context) {
    return Form(
      key: _form,
      child: Column(
        children: [
          ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: question.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 34,
                      ),
                      Text(
                        question.data![index].questions.toString(),
                        
                        style: blackStyle(context).copyWith(color: Get.isDarkMode?Colors.white: Colors.black),
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      AnswerTextFormField(
                        controller: _controller[index],
                        keyboardType: TextInputType.text,
                        hint: "Answer",
                        errortext: "Enter Answer",
                      ),
                      // CustomTextFormField(
                      //   controller: _controller[index],
                      //   hint: "Answer",
                      //   errortext: "Enter Answer",
                      // ),
                    ],
                  ),
                );
              }),
          SizedBox(
            height: 50,
          ),
          Visibility(
            visible: isSubmitBtnVisible,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: SizedBox(
                width: double.infinity,
                child: CustomNextButton(
                  text: 'Next',
                  ontap: () {
                    setState(() {
                      isSubmitBtnVisible = false;
                      isSubmitBtnLoaderVisible = true;
                    });
                    _validateData();
                  },
                ),
              ),
              //  RoundedLoadingButton(
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
              //     "Next",
              //     style: TextStyle(
              //       color: Color(0xFFFFFFFF),
              //       fontSize: 20,
              //       fontFamily: 'Productsans',
              //     ),
              //   ),
              // ),
            ),
          ),
          Visibility(
              visible: isSubmitBtnLoaderVisible,
              child: Center(child: CircularProgressIndicator()))
        ],
      ),
    );
  }
}

class AnswerTextFormField extends StatelessWidget {
  const AnswerTextFormField({
    Key? key,
    this.controller,
    this.hint,
    this.ontap,
    this.errortext,
    this.limitlength,
    this.maxlength,
    this.texttype,
    this.maxlines,
    this.keyboardType,
    this.inputFormatters,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? hint;
  final String? errortext;
  final Function(String)? ontap;
  final int? limitlength;
  final int? maxlength;
  final TextInputType? texttype;
  final int? maxlines;
  final TextInputType? keyboardType;
  final FilteringTextInputFormatter? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
      maxLines: maxlines ?? 1,
      maxLength: maxlength,
      cursorColor: Colors.grey,
      style: const TextStyle(
        //color: Colors.grey,
        fontFamily: 'Productsans',
        fontSize: 16,
        fontWeight: FontWeight.w500,

      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        //   contentPadding: EdgeInsets.all(15),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.grey, width: 2.0),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.grey, width: 2.0),
        ),
        errorMaxLines: 3,
        hintText: hint,
        hintStyle: blackStyle(context).copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color:Get.isDarkMode?Colors.white: Color(0xFF303030).withOpacity(0.3)),
        fillColor:Get.isDarkMode?Color(0xFF303030).withOpacity(0.8): Colors.white,
        filled: true,
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
        errorStyle: const TextStyle(
          fontSize: 16.0,
        ),
      ),
      controller: controller,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errortext ?? "Empty value";
        }
        return null;
      },
      inputFormatters: [
        LengthLimitingTextInputFormatter(limitlength ?? 20),
        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
      ],
      onSaved: (value) {
        ontap?.call;
      },
    );
  }
}
