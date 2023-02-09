// ignore_for_file: file_names

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:piadvisory/Profile/PasswordpinRepository/Pin.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/base_manager.dart';
import '/Profile/KYC/KYCMain.dart';
import '/Profile/PasswordAndSecurity/PasswordAndSecurity.dart';
import '/Profile/ProfileMain.dart';
import '/Utils/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Common/app_bar.dart';
import '/Utils/Dialogs.dart';

class PinChangePage extends StatefulWidget {
  const PinChangePage({Key? key}) : super(key: key);

  @override
  State<PinChangePage> createState() => _PinChangePageState();
}

class _PinChangePageState extends State<PinChangePage> {
  bool _passwordVisible = false;
  bool _confirmpasswordVisible = false;
  bool _newpasswordVisible = false;
  bool _isPasswordEightCar = false;
  bool _isHasOneNumber = false;
  bool _isHasSymboleOrCaptital = false;
  bool _iscancelselected = false;
  bool _issaveselected = false;
  String _selectedValue = '1';
  String selectedQuestions = "-Select-";
  TextEditingController pincontroller = TextEditingController();
  TextEditingController confirmpincontroller = TextEditingController();
  TextEditingController newpincontroller = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future _showQuestionsPicker() async {
    FocusScope.of(context).unfocus();
    final data = await showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: const QuestionsPicker(),
        );
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );

    if (data != null) {
      setState(() {
        selectedQuestions = data;
      });
    }
  }

  onPasswordChnage(String password) {
    setState(() {
      final numricRegex = RegExp(r'[0-9]');
      final alphaRegex = RegExp(r'[A-Z]|(?=.*[@$!%*#?&])');

      _isPasswordEightCar = false;
      if (password.length >= 8) _isPasswordEightCar = true;

      _isHasOneNumber = false;
      if (numricRegex.hasMatch(password)) _isHasOneNumber = true;

      _isHasSymboleOrCaptital = false;
      if (alphaRegex.hasMatch(password)) _isHasSymboleOrCaptital = true;
    });
  }

  void UploadData() async {
    final isValid = _formKey.currentState?.validate();
    if (isValid!) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? user_id = await prefs.getInt('user_id');
      Map<String, dynamic> updata = {
        'user_id': user_id,
        "pin": int.parse( pincontroller.text),
        "new_pin": int.parse(newpincontroller.text),
   
      };

      final data = await ChangePin().postChangePin(updata); 
      if (data.status == ResponseStatus.SUCCESS) {
        Navigator.push(
            context, MaterialPageRoute(builder: ((context) => ProfileMain())));
        return utils.showToast("Pin changed successfully");
      } else {
        return utils.showToast(data.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titleTxt: "Change Pin", bottomtext: false),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40.h,
              ),
              // Row(
              //   children: [
              //     Text(
              //       "Question",
              //       style:
              //           blackStyle(context).copyWith(fontWeight: FontWeight.bold),
              //     ),
              //     const SizedBox(
              //       width: 5,
              //     ),
              //     Text(
              //       "(Required)",
              //       style: blackStyle(context)
              //           .copyWith(fontSize: 12, fontWeight: FontWeight.bold),
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: 35.h,
              // ),
              // CustomDropDownOptions(
              //     hinttext: selectedQuestions,
              //     ontap: () => _showQuestionsPicker()),
              // SizedBox(
              //   height: 35.h,
              // ),
              Padding(
                padding: const EdgeInsets.only(left: 9),
                child: Text(
                  "Current Pin",
                  style: blackStyle(context)
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w600,color: Get.isDarkMode? Colors.white: Colors.black),
                ),
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,

                cursorColor: Colors.grey,
                style: const TextStyle(
                  //color: Colors.grey,
                  fontFamily: 'Product Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                keyboardType: TextInputType.number,
                controller: pincontroller,
                obscureText:
                    !_passwordVisible, //This will obscure text dynamically
                decoration: InputDecoration(
                  errorMaxLines: 3,
                  hintStyle: blackStyle(context).copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Get.isDarkMode? Colors.black: Color(0xFF303030).withOpacity(0.3)),
                  fillColor:Get.isDarkMode? Colors.grey: Colors.white,
                  filled: true,
                  errorStyle: const TextStyle(
                    fontSize: 16.0,
                  ),
                  hintText: 'Current Pin*',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color:Get.isDarkMode? Colors.black: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(4),
                  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                ],
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Pin is Empty';
                  } else if (val.length != 4) {
                    return "Pin length should be 4";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                padding: EdgeInsets.all(5),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF008083),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1,
                    color: const Color(0xFFDCDCDC),
                  ),
                ),
                child: Wrap(
                  runSpacing: 10,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Radio<String>(
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => Colors.white),
                          focusColor: const Color(0xFF008083),
                          activeColor: Colors.white,
                          value: '0',
                          groupValue: _selectedValue,
                          onChanged: (value) {
                            setState(() {
                              print(value);
                              _selectedValue = value!;
                              Get.off(()=> PasswordAndSecurity());
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: ((context) =>
                              //             const PasswordAndSecurity())));
                            });
                          },
                        ),
                        Text(
                          "Change Password",
                          style:
                              blackStyle(context).copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Radio<String>(
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => Colors.white),
                          focusColor: const Color(0xFF008083),
                          activeColor: Colors.white,
                          value: '1',
                          groupValue: _selectedValue,
                          onChanged: (value) {
                            setState(() {
                              _selectedValue = value!;
                            });
                          },
                        ),
                        Text(
                          "Change Pin",
                          style:
                              blackStyle(context).copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 9),
                child: Text(
                  "New PIN*",
                  style: blackStyle(context)
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w600,color: Get.isDarkMode? Colors.white:Colors.black),
                ),
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (value) => onPasswordChnage(value),

                cursorColor: Colors.grey,
                style: const TextStyle(
                  //color: Colors.grey,
                  fontFamily: 'Product Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                keyboardType: TextInputType.number,
                controller: newpincontroller,
                obscureText:
                    !_newpasswordVisible, //This will obscure text dynamically
                decoration: InputDecoration(
                  errorMaxLines: 3,
                  hintStyle: blackStyle(context).copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Get.isDarkMode? Colors.black:Color(0xFF303030).withOpacity(0.3)),
                  fillColor:  Get.isDarkMode ? Colors.grey:Colors.white,
                  filled: true,
                  errorStyle: const TextStyle(
                    fontSize: 16.0,
                  ),
                  hintText: 'Enter new Pin',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _newpasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color:Get.isDarkMode? Colors.black:  Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _newpasswordVisible = !_newpasswordVisible;
                      });
                    },
                  ),
                ),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(4),
                  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                ],
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Pin is Empty';
                  } else if (val.length != 4) {
                    return "Pin length should be 4";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 9),
                child: Text(
                  "Confirm PIN*",
                  style: blackStyle(context)
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w600,color: Get.isDarkMode?Colors.white:Colors.black),
                ),
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                cursorColor: Colors.grey,
                style: const TextStyle(
                  //color: Colors.grey,
                  fontFamily: 'Product Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                keyboardType: TextInputType.number,
                controller: confirmpincontroller,
                obscureText: !_confirmpasswordVisible,
                decoration: InputDecoration(
                  errorMaxLines: 3,
                  hintStyle: blackStyle(context).copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Get.isDarkMode?Colors.black: Color(0xFF303030).withOpacity(0.3)),
                  fillColor:Get.isDarkMode? Colors.grey: Colors.white,
                  filled: true,

                  errorStyle: const TextStyle(
                    fontSize: 16.0,
                  ),

                  hintText: 'Enter Confirm Pin',
                  // Here is key idea
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _confirmpasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Get.isDarkMode ? Colors.black: Colors.grey,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        _confirmpasswordVisible = !_confirmpasswordVisible;
                      });
                    },
                  ),
                ),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(4),
                  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                ],
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Pin is Empty';
                  }
                  if (confirmpincontroller.text ==
                      newpincontroller.text) {
                    if (val.length == 4) {
                      return null;
                    } else {
                      return 'Pin must be 4 digit';
                    }
                  }
                  return 'Pin does Not Matched';
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: 60,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _issaveselected = true;
                          _iscancelselected = false;
                          final isValid = _formKey.currentState?.validate();
                          if (isValid!) {
                            UploadData();
                          }
                        });

                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: ((context) => ProfileMain())));
                      },
                      style: ButtonStyle(
                        backgroundColor: _issaveselected
                            ? MaterialStateProperty.all<Color>(
                                const Color(0xFFF78104))
                            : MaterialStateProperty.all<Color>(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: const BorderSide(
                              width: 2,
                              color: Color(0xFFF78104),
                            ),
                          ),
                        ),
                      ),
                      child: Text(
                        "Save",
                        style: blackStyle(context).copyWith(
                            fontSize: 20,
                            color:
                                _issaveselected ? Colors.white : Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: 60,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _iscancelselected = true;
                          _issaveselected = false;
                        });

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => ProfileMain())));
                      },
                      style: ButtonStyle(
                        backgroundColor: _iscancelselected
                            ? MaterialStateProperty.all<Color>(
                                const Color(0xFFF78104))
                            : MaterialStateProperty.all<Color>(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: const BorderSide(
                              width: 2,
                              color: Color(0xFFF78104),
                            ),
                          ),
                        ),
                      ),
                      child: Text(
                        "Cancel",
                        style: blackStyle(context).copyWith(
                            fontSize: 20,
                            color: _iscancelselected
                                ? Colors.white
                                : Colors.black),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}

class QuestionsPicker extends StatefulWidget {
  const QuestionsPicker({Key? key}) : super(key: key);

  @override
  State<QuestionsPicker> createState() => _QuestionsPickerState();
}

class _QuestionsPickerState extends State<QuestionsPicker> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Text("Select Question", style: blackStyle(context)),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Question 1 ");
                  }),
                  title: const Text("Question 1"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Question 2");
                  }),
                  title: const Text("Question 2"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
