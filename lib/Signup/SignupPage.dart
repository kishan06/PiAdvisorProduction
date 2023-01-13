import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:piadvisory/Common/CustomTextFormFields.dart';
import 'package:piadvisory/Common/Signup_appbar.dart';
import 'package:piadvisory/Login/login.dart';
import 'package:piadvisory/Signup/Repository/RegisterMethod.dart';
import 'package:piadvisory/Signup/Repository/Securityfirstpage.dart';
import 'package:piadvisory/Signup/SecurityQuestions.dart';
import 'package:piadvisory/Utils/base_manager.dart';
import 'package:piadvisory/Utils/textStyles.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/Utils/Dialogs.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../Common/CustomNextButton.dart';
import '../Common/app_bar.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool design = false;
  bool _passwordVisible = false;
  bool _confirmpasswordVisible = false;
  bool _isPasswordEightCar = false;
  bool _isHasOneNumber = false;
  bool _isHasSymboleOrCaptital = false;
  bool _isEmailValid = false;

  //String? selectedlanguage;
  TextEditingController fullNameController = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController passwordcontroller = TextEditingController();

  TextEditingController emailidcontroller = TextEditingController();
  TextEditingController confirmpasscontroller = TextEditingController();
  TextEditingController selectedlanguage = TextEditingController();

  final RoundedLoadingButtonController _btnController1 =
      RoundedLoadingButtonController();

  void _validateData() {
    final isValid = _form.currentState?.validate();
    if (design && isValid!) {
      replaceSignUpBtnWithLoader();
      UploadData();
    } else {
      replaceLoaderWithSignUpBtn();
      // _btnController1.error();
      // Timer(Duration(seconds: 2), () {
      //   _btnController1.reset();
      // });
      design
          ? null
          : Flushbar(
              message: "Please Accept Terms & Conditions",
              duration: const Duration(seconds: 3),
            ).show(context);
    }
  }

  @override
  void initState() {
    super.initState();

    selectedlanguage.text = "select a language";
  }

  Future showtermsandconditions() async {
    FocusScope.of(context).unfocus();
    final data = await showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: const TermsAndConditions(),
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
        design = data;
      });
    }
  }

  Future showlanguagepicker() async {
    FocusScope.of(context).unfocus();
    final data = await showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: const Languagepicker(),
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
        selectedlanguage.text = data;
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

  onEmailChange(String email) {
    setState(() {
      final emailRegEx = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

      if (emailRegEx.hasMatch(email)) _isEmailValid = true;
    });
  }

  void UploadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? user_id = await prefs.getInt('user_id');
    Map<String, dynamic> updata = {
      'user_id': user_id,
      "full_name": fullNameController.text,
      "email": emailidcontroller.text,
      "password": passwordcontroller.text,
    };

    final data = await RegisterUser().postRegisterUser(updata);
    if (data.status == ResponseStatus.SUCCESS) {
      UploadSecurityFirst().updateRegistrationcompleted();

      replaceSignUpBtnWithLoader();

      Get.toNamed('/security_first');
      // Timer(Duration(seconds: 2), () {
      //   controller.success();
      //   Timer(Duration(seconds: 1), () {
      //     Get.toNamed('/security_questions');
      //   });
      // });
    } else {
      replaceLoaderWithSignUpBtn();
      // _btnController1.error();
      // Timer(Duration(seconds: 2), () {
      //   _btnController1.reset();
      // });
      return utils.showToast(data.message);
    }
  }

  bool isSignupBtnVisible = true;
  bool isSignupBtnLoaderVisible = false;

  void replaceSignUpBtnWithLoader() {
    setState(() {
      isSignupBtnVisible = false;
      isSignupBtnLoaderVisible = true;
    });
  }

  void replaceLoaderWithSignUpBtn() {
    setState(() {
      isSignupBtnVisible = true;
      isSignupBtnLoaderVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login()));
        return Future.value(false);
      },
      child: Scaffold(
          appBar:
              const CustomSignupAppBar(titleTxt: "Sign up", bottomtext: false),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: Form(
                    key: _form,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        FullnameTextFormField(
                          controller: fullNameController,
                          keyboardType: TextInputType.text,
                          hint: "Full Name*",
                          errortext: "Please Enter Full Name",
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.grey,
                          style: TextStyle(
                              //color: Colors.grey,
                              fontFamily: 'Productsans',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: emailidcontroller,
                          decoration: InputDecoration(
                            //Theme.of(context).textTheme.headline3!.merge(TextStyle(color:Color(0xFF303030).withOpacity(0.3))),
                            //Theme.of(context).textTheme.headline3,
                            // floatingLabelBehavior: FloatingLabelBehavior.always,
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2.0),
                            ),
                            errorMaxLines: 3,
                            hintText: "Email Id*",
                            hintStyle: blackStyle(context).copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Color(0xFF303030).withOpacity(0.3)),
                            //  errorText: "Please Enter Email ID ",
                            // hintText: hint,
                            // hintStyle: blackStyle(context).copyWith(
                            //     fontSize: 16,
                            //     fontWeight: FontWeight.w600,
                            //     color: Color(0xFF303030).withOpacity(0.3)),
                            fillColor: Get.isDarkMode
                                ? Color(0xFF303030).withOpacity(0.8)
                                : Colors.white,
                            filled: true,
                            errorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2.0),
                            ),
                            focusedErrorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2.0),
                            ),
                            errorStyle: const TextStyle(
                              fontSize: 16.0,
                            ),
                            //errorText: "Please Enter Email ID ",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter your email address';
                            }
                            if (!RegExp(
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                .hasMatch(value)) {
                              return 'Please enter valid email address';
                            }
                            return null;
                          },
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(50),
                          ],
                          onSaved: (value) {},
                          // onChanged: (value) {
                          //   onEmailChange(value);
                          // },
                        ),
                        // CustomTextFormField(
                        //   limitlength: 100,
                        //   controller: emailidcontroller,
                        //   hint: "Email Id*",
                        //   errortext: "Please Enter Email ID Number",

                        // ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (value) => onPasswordChnage(value),

                          cursorColor: Colors.grey,
                          style: TextStyle(
                              //color: Colors.grey,
                              fontFamily: 'Productsans',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black),
                          keyboardType: TextInputType.text,
                          controller: passwordcontroller,
                          obscureText:
                              !_passwordVisible, //This will obscure text dynamically
                          decoration: InputDecoration(
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2.0),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2.0),
                            ),
                            errorMaxLines: 3,
                            hintStyle: blackStyle(context).copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Color(0xFF303030).withOpacity(0.3)),
                            fillColor: Get.isDarkMode
                                ? Color(0xFF303030).withOpacity(0.8)
                                : Colors.white,
                            filled: true,
                            errorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2.0),
                            ),
                            focusedErrorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2.0),
                            ),
                            errorStyle: const TextStyle(
                              fontSize: 16.0,
                            ),
                            hintText: 'Password*',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
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
                              child: _isPasswordEightCar
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.green,
                                      size: 15,
                                    )
                                  : Icon(
                                      Icons.check,
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                      size: 15,
                                    ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                'Has at least 8 characters',
                                style: TextStyle(
                                    fontFamily: 'Productsans',
                                    fontSize: 12,
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Colors.black),
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
                                  : Icon(
                                      Icons.check,
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                      size: 15,
                                    ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                'Has at least 1 uppercase letter & symbol',
                                style: TextStyle(
                                    fontFamily: 'Productsans',
                                    fontSize: 12,
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Colors.black),
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
                                  : Icon(
                                      Icons.check,
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                      size: 15,
                                    ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                'Has a number',
                                style: TextStyle(
                                    fontFamily: 'Productsans',
                                    fontSize: 12,
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          cursorColor: Colors.grey,
                          style: const TextStyle(
                            //color: Colors.grey,
                            fontFamily: 'Productsans',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          keyboardType: TextInputType.text,
                          controller: confirmpasscontroller,
                          obscureText:
                              !_confirmpasswordVisible, //This will obscure text dynamically
                          decoration: InputDecoration(
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2.0),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2.0),
                            ),
                            errorMaxLines: 3,
                            hintStyle: blackStyle(context).copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Color(0xFF303030).withOpacity(0.3)),
                            fillColor: Get.isDarkMode
                                ? Color(0xFF303030).withOpacity(0.8)
                                : Colors.white,
                            filled: true,
                            errorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2.0),
                            ),
                            focusedErrorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2.0),
                            ),
                            errorStyle: const TextStyle(
                              fontSize: 16.0,
                            ),

                            hintText: 'Confirm Password*',
                            // Here is key idea
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                _confirmpasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _confirmpasswordVisible =
                                      !_confirmpasswordVisible;
                                });
                              },
                            ),
                          ),
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Password is Empty';
                            }
                            if (val != passwordcontroller.text) {
                              return 'Password Not Matched';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 10),
                  child: Container(
                    padding: const EdgeInsets.only(right: 20),
                    child: Row(
                      children: [
                        Transform.scale(
                          scale: 1.2,
                          child: Theme(
                            data: ThemeData(
                              unselectedWidgetColor: Color(0xFFF78104),
                            ),
                            child: Checkbox(
                              activeColor: const Color(0xFFF78104),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0))),
                              value: design,
                              onChanged: (bool? design) {
                                setState(() {
                                  this.design = design!;
                                });
                              },
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => showtermsandconditions(),
                          child: Text(
                            "I accept the Terms & Conditions*",
                            style: TextStyle(
                              fontFamily: 'Productsans',
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black,
                              fontSize: 15.sm,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.12,
                ),
                Visibility(
                  visible: isSignupBtnVisible,
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: CustomNextButton(
                        text: "Sign up",
                        ontap: () {
                          setState(() {
                            isSignupBtnVisible = false;
                            isSignupBtnLoaderVisible = true;
                          });
                          _validateData();
                        },
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
                      //     "Sign up",
                      //     style: TextStyle(
                      //       color: Color(0xFFFFFFFF),
                      //       fontSize: 20,
                      //       fontFamily: 'Productsans',
                      //     ),
                      //   ),
                      // ),
                    ),
                  ),
                ),
                Visibility(
                    visible: isSignupBtnLoaderVisible,
                    child: Center(child: CircularProgressIndicator())),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          )),
    );
  }
}

class Languagepicker extends StatefulWidget {
  const Languagepicker({Key? key}) : super(key: key);

  @override
  State<Languagepicker> createState() => _LanguagepickerState();
}

class _LanguagepickerState extends State<Languagepicker> {
  TextEditingController upiidcontroller = TextEditingController();
  TextEditingController amountcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Text("Select a language", style: blackStyle(context)),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "English");
                  }),
                  title: const Text("English"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Marathi");
                  }),
                  title: const Text("Marathi"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Hindi");
                  }),
                  title: const Text("Hindi"),
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

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  bool agree = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Text("Terms And Conditions", style: blackStyle(context)),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: SizedBox(
            height: 150,
            child: SingleChildScrollView(
              child: Text(
                  '''SuperMoney Advisors Private Limited (hereinafter referred to as “SuperMoney” or “We” or “Us” or “Our”) is a company registered with the Securities and Exchange Board of India as an Investment Advisor under SEBI (Investment Advisers) Regulations, 2013 vide registration no. INA000017408 dated December 02, 2022 having its registered office at registered office at Tirupati Nagar Banswara (M), Udaipur Road, Banswara, Rajasthan 327001
 
SuperMoney Advisors Private Limited operates mobile applications and website www.piadvisors.in under brand names PI Advisors enables you (hereinafter referred to as, “You”, “you”, “your” or “User”) to track, save and earn extra by automatically bringing your entire financial life across investments, loans & taxes, all in one app. PI Advisors shall through its Application provide investment and wealth management services to the Users (“Services”). PI Advisors is committed to operating its website and mobile applications with the highest ethical standards and appropriate internal controls.

THESE WEBSITE TERMS IS AN ELECTRONIC RECORD IN THE FORM OF AN ELECTRONIC CONTRACT FORMED UNDER INFORMATION TECHNOLOGY ACT, 2000 AND RULES MADE THEREUNDER AND THE AMENDED PROVISIONS PERTAINING TO ELECTRONIC DOCUMENTS / RECORDS IN VARIOUS STATUTES AS AMENDED BY THE INFORMATION TECHNOLOGY ACT, 2000. THESE TERMS DOES NOT REQUIRE ANY PHYSICAL, ELECTRONIC OR DIGITAL SIGNATURE.

Please note that your visit, use of or access to our websites www.piadvisors.in and mobile applications (collectively referred to as “Application” or “Platform”) are subject to the following terms; if you do not agree to all of the following, you may not use or access the Services and Application in any manner.

When you use any of the Services provided on the Application, including but not limited to only financial services, you shall be subject to the rules, guidelines, policies, terms, and conditions applicable to such service, and they shall be deemed to be incorporated into this Terms of Use and shall be considered as part and parcel of this Terms of Use.

Terms of Use

Please read on to learn the rules and restrictions that govern your use of our Application/Services. These Terms and Conditions (the “Terms” or the “Agreement”) are a binding contract between you and SuperMoney. If you have any questions, comments, or concerns regarding these terms or the Services, please contact us at info@piadvisors.in. 

You must agree to and accept all the Terms, or you don’t have the right to use the Services. Your using the Services in any way means that you agree to all of these Terms, and these Terms will remain in effect while you use the Services. These Terms include the provisions mentioned below, as well as those in the Privacy Policy. 

You are aware and you accept that all information, content, materials, products on the application is protected and secured.

You understand and accept that you are allowed to track your financial life through the use of Application. You agree that you will be allowed to make any transaction through the Application when you complete the KYC process and provide the complete information including personal information in accordance with the Know your client (“KYC”) guidelines issued by Securities and Exchange Board of India or any other regulator/government authorities/agencies/AMCs from time to time.

You acknowledge that you will be responsible for maintaining the confidentiality of your account information and are fully responsible for all activities that occur under Your account and also agree to keep your login credentials safe and confidential at all times. You further agree to promptly inform Us immediately in case of any actual or suspected unauthorized use of Your Account. We cannot and will not be liable for any loss or damage arising from Your failure to comply with this provision.

You acknowledge that the software and hardware underlying the application as well as other Internet related software which are required for accessing the application are the legal property of either SuperMoney or its respective third-party vendors. The permission given by SuperMoney to access the application will not convey any proprietary or ownership rights in the above software/hardware.

You understand and accept that not all the products and services offered on or through the Application are available in all geographic areas and you may not be eligible for all the products or services offered by SuperMoney or third-party providers on the Application. SuperMoney and such third-party providers reserves the right to determine the availability and eligibility for any product or service offered on the application.

You understand and accept that SuperMoney is not responsible for the availability of content or other services on third party sites linked from the application. You are aware that access of hyperlinks to other internet sites are at your own risk and the content, accuracy, opinions expressed, and other links provided by these sites are not verified, monitored or endorsed by SuperMoney in any way. SuperMoney does not make any warranties and expressly disclaims all warranties express or implied, including without limitation, those of merchantability and fitness for a particular purpose, title or non-infringement with respect to any information or services or products that are available or advertised or sold through these third-party platforms. 

You agree that transactions made through SuperMoney Application shall be through your own bank account only and the said transactions do not contravene any Act, Rules, Regulations, Notifications of Income tax Act, Anti money laundering laws, Anti-corruption laws or any other applicable laws.


You agree that you will not use the application for any purpose that is unlawful or prohibited by these Terms. You also agree you will not use the application in any manner that could damage, disable or impair the application or interfere with any other party’s use, legal rights, or enjoyment of the application. You hereby represent and warrant that you shall make use of the Application as a prudent, reasonable and law abiding citizen and you shall comply with relevant necessary laws.

SuoerMoney reserves the right in its sole discretion to delete, block, restrict, disable, suspend your account or part thereof. If the User is found engaging in any fraudulent/illegal activities including but not limited to the following activities i.e. abusing any of the representatives of the organization, indulge in fraudulent activities on the Application, using mass media and/or bots to engage with the platform, using mass media and/or bots to malign the organization’s reputation these activities may be referred to appropriate legal authority for a legal recourse.

Additionally, by continuing using the Application or Services of SuoperMoney you are confirming that:

(a) You are 18 years of age or older and where you are acting as Guardian on behalf of a minor, you have the necessary authority to register/sign up for the Services on behalf of the minor. If SuperMoney learns that we have collected personal information from a person under age 18, we will delete that information as quickly as possible. If you believe that a person under 18 may have provided us with personal information, please contact us at info@piadvisors.in.

(b) You have read and understood the Privacy Policy published on the website and mobile applications of SuperMoney. The information you provide when you register on the Application is true and correct. In the event, your information is not accessible online and you wish to change or delete your personal information or other information that you may have provided, please contact us immediately at info@piadvisors.in.
 
(c) You shall notify SuperMoney of any material change in your personal information and/or profile. SuperMoney would rely on the most recent information provided by you.
 
(d) You agree to be contacted by SuperMoney and its employees and partners over phone and/or E-mail and/or SMS or any other form of electronic communication in connection with your registration, advisory and transactions. This consent overrides any registration for DNC/NDNC. You agree and confirm that if your mobile number is registered in the Do Not Disturb (DND) list of TRAI, you may not receive SMS from SuperMoney. You agree to take steps to deregister from the DND list and shall not hold SuperMoney liable for non-receipt of SMS. You can always opt to stop receiving any or all such communications by writing to info@piadvisors.in. You can also delete your account at any point of time by writing to info@piadvisors.in or by visiting the Delete Account section on the Application

Services 

The Application offers the Services to the Users which include, the advisory services to the Users relating to investing in, purchasing, selling or otherwise dealing in securities or investment products, and advice on investment portfolio containing securities or investment products. 

Please also note that there are other financial products and services, such as, loans, fixed deposit creation etc. manufactured and/or distributed by third party providers, offered by or through the Application. However, it is, hereby, expressly clarified that any or all interaction, communication, dealing, or transaction between the Users and such third party provider in respect of availing of any products/services offered by the third party provider forms a separate and independent transaction between the User and such third party provider without any liability accruing to or on us for any matters arising out of or in relation to the same.

Neither We nor any of our employees or agents shall be liable for any advice or representation made by it/him/her under this Agreement and it will be the User’s responsibility to make an independent assessment pursuant to the availing/using of the Application/Services or availing any product or services from the third-party provider.

You acknowledge and agree that We do not guarantee that availing of the Services from the Application will result in profits or avoid losses or meet the objectives, including the investment objectives, of the User or that availing/using of the Services/Application will not at any time be affected by adverse tax consequences, technical failures, timely regulatory compliance to a new law. We will not be liable to the User for any error of judgement or loss suffered by the User in connection with the Services provided to the User.

SuperMoney does not disburse loans on its own but we enable you to compare the best possible options and apply for loans to various banks and NBFCs (Non-Banking Financial Corporation) in the Indian Market. You acknowledge that the loan rates vary from bank to bank and it is dependent on your credit profile and the loan/policies/scheme you decide to opt for. SuperMoney has nothing to do with the rates offered by Banks/NBFCs.

You agree and understand that by availing the Services you shall be bound by Our Privacy Policy and your information provided on the Application shall be shared with our Group Companies and Business Partners, which shall store your data within Indian jurisdiction as per applicable laws. 

Privacy 

You agree that during your use and access of the Application and/or availing of the Services offered by the Application, you will provide Us with certain information and other data as mentioned under these Terms herein which may or may not be otherwise publicly available. Please note that We respect the privacy and confidentiality of such data and the provisions pertaining to such private information and data as provided by You under these Terms, are governed under the Application’s Privacy Policy of SuperMoney. By using and visiting the Application and availing the Services of the Application, you also agree to the terms and conditions of our Privacy Policy.

Confidentiality

You acknowledge that, in the course of your relationship with SuperMoney and in using the Services, you may obtain information relating to the Services and/or SuperMoney (“Proprietary Information”). Such Proprietary Information shall belong solely to SuperMoney and includes, but is not limited to, the features and mode of operation of the Services, trade secrets, know-how, inventions (whether or not patentable), techniques, processes, programs, ideas, algorithms, schematics, testing procedures, software design and architecture, computer code, internal documentation, design and function specifications, product requirements, problem reports, analysis and performance information, benchmarks, software documents, and other technical, business, product, plans and data. In regard to this Proprietary Information:

You shall not use (except as expressly authorized by this Agreement) or disclose Proprietary Information without the prior written consent of SuperMoney unless such Proprietary Information becomes generally publicly available without your breach of this Agreement.

You agree to take reasonable measures to maintain the Proprietary Information and Services in confidence.

Use and Protection of Intellectual Property Rights

SuperMoney Application is protected by copyright, trademarks, patents, trade secret and/or other relevant intellectual property laws. No information, content or material from the Application may be copied, reproduced, republished, uploaded, posted, transmitted or distributed in any way without SuperMoney's express written permission. You are hereby given a limited licence to use the Application for your personal and non-commercial use, subject to your agreement of these Terms. You agree not to sell, license, distribute, copy, modify, publicly perform or display, transmit, publish, edit, adapt, create derivative works from, or otherwise make unauthorized use of the SuperMoney  Application. 

Limitation of Liability, Indemnity, and Warranty

In no event shall SuperMoney or its directors, employees, associates, partners, or suppliers will be liable to you for any loss or damage that may cause or arise from or in relation to these terms and conditions or due to use of this Application/website or due to investments made using this Application or availing any product or services from any third-party service provider.

You agree to indemnify SuperMoney or its directors, employees, associates, partners or suppliers for all the liabilities (including claims, damages, suits or legal expenses in defending itself in relation to the foregoing) arising due to (i) use or misuse of the Application (ii) non-performance and/or non-observance of the duties and obligations under these terms and conditions or due to your acts or omissions (iii) any act, neglect, misconduct or fraud on your part.

You warrant that all the details and information provided by you to SuperMoney or its directors, employees, associates, partners, or suppliers while using this Application (including for the purposes of carrying out investments) shall be correct, accurate and genuine.

Further, you shall be solely responsible for any investment decision taken by you on the Services and SuperMoney shall not be liable for any loss or damage caused to you or other users of this Application due to such investment decision, or any kind of reliance upon it. You expressly agree that use of the Application is at your sole risk.

To the fullest extent permissible pursuant to applicable law, SuperMoney and its directors, employees, associates, third-party partners or suppliers disclaim all warranties or guarantees – whether statutory, express or implied – including, but not limited to, implied warranties of merchantability, fitness and non-infringement of proprietary rights. No advice or information, whether oral or written, obtained by you from SuperMoney or through the Application will create any warranty or guarantee other than those expressly stated herein.
 
DISCLAIMERS

THE USER AGREES AND UNDERSTANDS THAT THE APPLICATION IS PROVIDED BY US ON AN “AS IS” AND “AS AVAILABLE” BASIS AND WE MAKE NO REPRESENTATIONS OR WARRANTIES OF ANY KIND, EXPRESS OR IMPLIED, AS TO THE OPERATION OF THE APPLICATION OR THE INFORMATION, CONTENT INCLUDED ON THE APPLICATION. YOU EXPRESSLY AGREE THAT YOUR USE OF THE APPLICATION IS AT YOUR SOLE RISK.

TO THE FULLEST EXTENT PERMISSIBLE BY APPLICABLE LAW, WE DISCLAIM ALL WARRANTIES, EXPRESS OR IMPLIED. WE DO NOT WARRANT THAT THE APPLICATION, ITS SERVERS, OR EMAIL/ OTHER COMMUNICATION SENT FROM THE APPLICATION ARE FREE OF VIRUSES OR OTHER HARMFUL COMPONENTS. WE WILL NOT BE LIABLE FOR ANY DAMAGES OF ANY KIND ARISING FROM THE USE OF THE APPLICATION, INCLUDING, BUT NOT LIMITED TO DIRECT, INDIRECT, INCIDENTAL, PUNITIVE AND CONSEQUENTIAL DAMAGES.

ALL INVESTMENTS ARE SUBJECT TO MARKET RISKS. READ ALL SCHEME RELATED THINGS CAREFULLY. PAST PERFORMANCE IS NOT AN INDICATOR OF FUTURE RETURNS.

ALL INTERACTION, COMMUNICATION, DEALING, OR TRANSACTION BETWEEN THE USERS AND THE THIRD-PARTY PROVIDER IN RESPECT OF ANY PRODUCTS/SERVICES OFFERED BY THE THIRD-PARTY PROVIDER IS A SEPARATE AND INDEPENDENT TRANSACTION BETWEEN THE USER AND SUCH THIRD-PARTY PROVIDER WITHOUT ANY LIABILITY ACCRUING TO OR ON US FOR ANY MATTERS ARISING OUT OF OR IN RELATION TO THE SAME. THE USER EXPRESSLY AGREES AND ACKNOWLEDGES TO HOLD HARMLESS US IN RESPECT OF ANY COST, CLAIMS, DAMAGE, LOSS OR EXPENSES ACCRUED, SUFFERED, INCURRED BY US OR ANY THIRD PARTY ARISING OUT OF OR IN CONNECTION WITH ANY SUCH COMMUNICATION, INTERACTION, DEALINGS AND TRANSACTIONS BETWEEN THE USER AND THIRD-PARTY PROVIDERS. THE USER ACKNOWLEDGES THAT WE DO NOT HAVE ANY CONTROL OVER SUCH DEALINGS AND TRANSACTIONS AND PLAYS NO DETERMINATIVE ROLE IN THE PERFORMANCE IN RESPECT OF THE SAME AND WE SHALL NOT BE LIABLE FOR THE OUTCOMES OF SUCH COMMUNICATION, INTERACTION, DEALINGS AND TRANSACTIONS BETWEEN THE USERS AND THE THIRD-PARTY PROVIDERS. 

WE DO NOT WARRANT, ENDORSE, GUARANTEE, OR ASSUME RESPONSIBILITY FOR ANY PRODUCT OR SERVICE ADVERTISED OR OFFERED BY A THIRD-PARTY PROVIDER IN ANY MANNER AND WE WILL NOT BE A PARTY TO OR IN ANY WAY BE RESPONSIBLE FOR ANY TRANSACTION BETWEEN YOU AND SUCH PARTY PROVIDER. AS WITH THE PURCHASE OF A PRODUCT OR SERVICE THROUGH ANY MEDIUM THROUGH SUCH THIRD-PARTY PROVIDER, YOU SHOULD USE YOUR BEST JUDGMENT AND EXERCISE CAUTION WHERE APPROPRIATE.

Consideration
 
SuperMoney shall have the right to charge its Users a fee for use of its platform and for availing advisory services as set out in the Application. SuperMoney may change fee structure as it determines in its sole discretion from time to time and notice regarding the same shall be intimated to you adequately in advance prior to such change in fee structure. All charges and fees shall be exclusive of taxes and all Government taxes including but not limited to GST shall be payable by you. All charges shall be non-transferable. 

Force majeure

If the whole or any part of the performance is prevented, hindered or delayed by a Force Majeure event (as defined below), SuperMoney shall not be liable for any failure to perform any of its obligations under these terms and conditions or those applicable specifically to its services/facilities, and in such case its obligations shall be suspended for so long as the Force Majeure event continues. “Force Majeure Event” means any event, due to any cause beyond the reasonable control of SuperMoney, including without limitations, unavailability of any communication systems, breach, or virus in the digital processes or payment or delivery mechanism, sabotage, fire, flood, explosion, acts of God, civil commotion, strikes or industrial action of any kind, riots, insurrection, war, acts of government, lockdown, computer hacking, unauthorised access to computer data and storage devices, computer crashes, malfunctioning in the computer terminal or the systems getting affected by any malicious, destructive or corrupting code or program, mechanical or technical errors/failures or power shut down, faults or failures in telecommunication etc.

Severability

All illegality, invalidity or unenforceability of any provision of these Terms under the law of any jurisdiction will not affect its legality, validity or enforceability under the law of any other jurisdiction nor the legality, validity or enforceability of any other provision.

Waiver

No failure on the part of any party to exercise, and no delay on its part in exercising any right or remedy under this Agreement will operate as a waiver thereof, nor will any single or partial exercise of any right.

Assignment

You agree that we may transfer, subcontract or otherwise deal with our rights and/or obligations under these terms at any time without any further notice . You agree that you cannot assign or otherwise transfer, subcontract the terms or any rights granted hereunder to any third party, 

Dispute Resolution

Any dispute, controversy, claims or disagreement of any kind whatsoever between the Parties in connection with or arising out of this Agreement shall be referred for arbitration, to a sole arbitrator appointed by SuperMoney, through arbitration to be conducted in accordance with the Arbitration and Conciliation Act, 1996. The seat and venue of such arbitration shall be at Mumbai, India. All proceedings of such arbitration, including, without limitation, any awards, shall be in the English language. The award shall be final and binding on the Parties.

Governing laws

These Terms shall be governed, interpreted, and construed in accordance with the laws of India, without regard to the conflict of law provisions and for resolution of any dispute arising out of your use of the Services or in relation to these Terms. Notwithstanding the foregoing, you agree that (i) SuperMoney has the right to bring any proceedings before any court/forum of competent jurisdiction and you irrevocably submit to the jurisdiction of such courts or forum; and (ii) any proceeding brought by you shall be exclusively before the courts in Mumbai, India.

Entire Agreement

These Terms, together with the other guidelines, rules, terms, conditions and/or policies of the Application, including the Privacy Policy and any other arrangement/agreement in relation the Services, including the Advisory Agreement (applicable to advisory clients), constitute the entire agreement between the User and the Us and supersede all previous agreements, promises, proposals, representations, understandings and negotiations, whether written or oral, between the User and US pertaining to the subject matter hereof.

Survival

Notwithstanding the termination or rescission of this Agreement, the provisions of this Agreement shall continue to apply to those duties and obligations which are intended to survive any such cancellation, termination or rescission, including, without limitation clauses related to Limitation of liability, Indemnity, Warranty, Intellectual Property, Confidentiality, Dispute Resolution, Governing Law and Jurisdiction. Further any provisions of this Agreement which by implication are to survive the termination of this Agreement shall survive such termination. Termination of the Agreement shall not abate the causes of action that have accrued to the Parties prior to such termination.



Modification of Terms

SuperMoney reserves the right to change or modify, from time to time, any provision related to the Service(s) or these Terms, which also include, changing of the extent and scope of the Services and/or include any other category, service, facility or feature within the term ‘Service’, at the sole discretion of the Application. Any such change(s) shall be effective immediately upon the posting of revised Terms and may be notified via Application. You can determine when these Terms were last revised by referring to ‘LAST UPDATED’ at the top of these Terms. By using the services provided through this Application, you shall be deemed to have accepted the Terms herein including the amended Terms published on the Application from time to time. Your continued use of the Application following the posting of changes mean that you accept and agree to the changes. If you do not agree with any such change, your sole and exclusive remedy is to terminate your use of the Application. It is, further, clarified that the User’s use and access of the Application/Service(s) is subject to the most recent version of these Terms made available on the Application at the time of such use. '''),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        // Row(
        //   children: [
        //     Checkbox(
        //         activeColor: const Color(0xFFF78104),
        //         shape: const RoundedRectangleBorder(
        //             borderRadius: BorderRadius.all(Radius.circular(5.0))),
        //         value: agree,
        //         onChanged: (value) {
        //           setState(() {
        //             agree = value ?? false;
        //           });
        //         }),
        //     Flexible(
        //       child: Text(
        //         maxLines: 1,
        //         softWrap: false,
        //         'I have read and accept Terms & Conditions',
        //         style: TextStyle(fontSize: 14.sm),
        //       ),
        //     ),
        //   ],
        // ),
        const SizedBox(
          height: 10,
        ),
        Center(
            child: CustomNextButton(
          text: "Proceed",
          ontap: () {
            Navigator.pop(context, agree);
          },
        )),
        const SizedBox(height: 16),
      ],
    );
  }
}

class FullnameTextFormField extends StatelessWidget {
  const FullnameTextFormField({
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
      style: TextStyle(
          //color: Colors.grey,
          fontFamily: 'Productsans',
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Get.isDarkMode ? Colors.white : Colors.black),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        //   contentPadding: EdgeInsets.all(15),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.grey, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.grey, width: 2.0),
        ),
        errorMaxLines: 3,
        hintText: hint,
        hintStyle: blackStyle(context).copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Get.isDarkMode
                ? Colors.white
                : Color(0xFF303030).withOpacity(0.3)),
        fillColor:
            Get.isDarkMode ? Color(0xFF303030).withOpacity(0.8) : Colors.white,
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
      keyboardType: texttype,
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
