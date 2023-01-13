// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:piadvisory/Profile/PasswordpinRepository/Password.dart';
import 'package:piadvisory/Utils/base_manager.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/HomePage/Homepage.dart';
import '/Profile/KYC/KYCMain.dart';
import '/Profile/PasswordAndSecurity/PinChangePage.dart';
import '/Utils/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Common/app_bar.dart';
import '../ProfileMain.dart';
import '/Utils/Dialogs.dart';

class PasswordAndSecurity extends StatefulWidget {
  const PasswordAndSecurity({Key? key}) : super(key: key);

  @override
  State<PasswordAndSecurity> createState() => _PasswordAndSecurityState();
}

class _PasswordAndSecurityState extends State<PasswordAndSecurity> {
  bool _passwordVisible = false;
  bool _confirmpasswordVisible = false;
  bool _newpasswordVisible = false;
  bool _isPasswordEightCar = false;
  bool _isHasOneNumber = false;
  bool _isHasSymboleOrCaptital = false;
  bool _iscancelselected = false;
  bool _issaveselected = false;
  String _selectedValue = '0';
  final selectedQuestions = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpasscontroller = TextEditingController();
  TextEditingController newpasswordcontroller = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RoundedLoadingButtonController _btnController1 =
      RoundedLoadingButtonController();

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
        selectedQuestions.text = data;
      });
    }
  }

  onPasswordChnage(String password) {
    setState(() {
      final numricRegex = RegExp(r'[0-9]');
      final alphaRegex = RegExp(r'[A-Z](?=.*[@$!%*#?&])');

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
      print("userid is $user_id");
      Map<String, dynamic> updata = {
        'user_id': user_id,
        "current_password": passwordcontroller.text,
        "new_password": newpasswordcontroller.text,
      };
      
      final data =
          await ChangePassword().postChangePassword(updata);
      if (data.status == ResponseStatus.SUCCESS) {
        Navigator.push(
            context, MaterialPageRoute(builder: ((context) => HomePage())));
        return utils.showToast("Password changed successfully");
      } else {
        return utils.showToast(data.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const CustomAppBar(titleTxt: "Change Password", bottomtext: false),
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
              // SizedBox(
              //   height: 40.h,
              // ),
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
              //     controller: selectedQuestions,
              //     hinttext: "-Select-",
              //     ontap: () => _showQuestionsPicker()),
              SizedBox(
                height: 35.h,
              ),
              Text(
                "Current Password*",
                style: blackStyle(context)
                    .copyWith(fontSize: 16, fontWeight: FontWeight.w600,
                    color: Get.isDarkMode? Colors.white: Colors.black
                    ),
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                cursorColor: Colors.grey,
                style: const TextStyle(
                  //color: Colors.grey,
                  fontFamily: 'Product Sans',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                keyboardType: TextInputType.text,
                controller: passwordcontroller,
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  errorMaxLines: 3,
                  fillColor:Get.isDarkMode? Colors.grey: Colors.white,
                  filled: true,
                  errorStyle: const TextStyle(
                    fontSize: 16,
                  ),
                  hintText: 'Enter your password',
                  hintStyle: blackStyle(context).copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color:  Get.isDarkMode? Colors.black:Color(0xFF303030).withOpacity(0.3)),
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
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Password is Empty';
                  }
                  if (!RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                      .hasMatch(val)) {
                    return 'Enter valid password';
                  } else {
                    return null;
                  }
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
                              _selectedValue = value!;
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
                          value: 'Change Pin',
                          groupValue: _selectedValue,
                          onChanged: (value) {
                            setState(() {
                              _selectedValue = value!;
                            });
                            Get.off(()=> PinChangePage());
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: ((context) =>
                            //             const PinChangePage())));
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
              SizedBox(
                height: 35.h,
              ),
              Text(
                "New Password*",
                style: blackStyle(context)
                    .copyWith(fontSize: 16, fontWeight: FontWeight.w600,color: Get.isDarkMode? Colors.white:Colors.black),
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (value) => onPasswordChnage(value),
                cursorColor: Colors.grey,
                style: const TextStyle(
                  fontFamily: 'Product Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                keyboardType: TextInputType.text,
                controller: newpasswordcontroller,
                obscureText: !_newpasswordVisible,
                decoration: InputDecoration(
                  errorMaxLines: 3,
                  fillColor: Get.isDarkMode ? Colors.grey: Colors.white,
                  filled: true,
                  errorStyle: const TextStyle(
                    fontSize: 16.0,
                  ),
                  hintText: 'Enter your password',
                  hintStyle: blackStyle(context).copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Get.isDarkMode? Colors.black: Color(0xFF303030).withOpacity(0.3)),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _newpasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Get.isDarkMode? Colors.black: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _newpasswordVisible = !_newpasswordVisible;
                      });
                    },
                  ),
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Password is Empty';
                  }
                  if (!RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                      .hasMatch(val)) {
                    return 'Enter valid password';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(
                      milliseconds: 500,
                    ),
                    width: 20,
                    height: 20,
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(50),
                    //   border: Border.all(
                    //     color: Colors.grey,
                    //   ),
                    // ),
                    child: _isPasswordEightCar
                        ? const Icon(
                            Icons.check,
                            color: Colors.green,
                            size: 15,
                          )
                        :  Icon(
                            Icons.check,
                            color: Get.isDarkMode ? Colors.white:Colors.black,
                            size: 15,
                          ),
                  ),
                   Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'Has at least 8 characters.',
                      style: TextStyle(
                          fontFamily: 'Product Sans',
                          fontSize: 12,
                          color: Get.isDarkMode ? Colors.white:Colors.black),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(
                      milliseconds: 500,
                    ),
                    width: 20,
                    height: 20,
                    child: _isHasSymboleOrCaptital
                        ? const Icon(
                            Icons.check,
                            color: Colors.green,
                            size: 15,
                          )
                        :  Icon(
                            Icons.check,
                            color:Get.isDarkMode ? Colors.white: Colors.black,
                            size: 15,
                          ),
                  ),
                   Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'Has at least 1 uppercase letter & symbol.',
                      style: TextStyle(
                          fontFamily: 'Product Sans',
                          fontSize: 12,
                          color: Get.isDarkMode ? Colors.white: Colors.black),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(
                      milliseconds: 500,
                    ),
                    width: 20,
                    height: 20,
                    child: _isHasOneNumber
                        ? const Icon(
                            Icons.check,
                            color: Colors.green,
                            size: 15,
                          )
                        :  Icon(
                            Icons.check,
                            color: Get.isDarkMode ? Colors.white:Colors.black,
                            size: 15,
                          ),
                  ),
                   Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'Has a number',
                      style: TextStyle(
                          fontFamily: 'Product Sans',
                          fontSize: 12,
                          color: Get.isDarkMode ? Colors.white:Colors.black),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Enter your Confirm Password*",
                style: blackStyle(context)
                    .copyWith(fontSize: 16, fontWeight: FontWeight.w600,color: Get.isDarkMode?Colors.white:Colors.black),
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
                keyboardType: TextInputType.text,
                controller: confirmpasscontroller,
                obscureText: !_confirmpasswordVisible,
                decoration: InputDecoration(
                  errorMaxLines: 3,

                  fillColor: Get.isDarkMode? Colors.grey: Colors.white,
                  filled: true,

                  errorStyle: const TextStyle(
                    fontSize: 16.0,
                  ),

                  hintText: 'Confirm password',
                  hintStyle: blackStyle(context).copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Get.isDarkMode?Colors.black: Color(0xFF303030).withOpacity(0.3)),
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
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Password is Empty';
                  if (val != newpasswordcontroller.text) {
                    return 'Password Not Matched';
                  }
                  return null;
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
                          }; 
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: ((context) => HomePage())));
                        });
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
                      child: GestureDetector(
                        onTap: () {
                         
                          
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => ProfileMain())));
                        },
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
