// ignore_for_file: file_names, prefer_const_constructors, unnecessary_const

import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:piadvisory/Login/Repository/Resetpassword.dart';
import 'package:piadvisory/Utils/base_manager.dart';

import '../Common/CustomNextButton.dart';
import '../Common/app_bar.dart';
import '../Utils/textStyles.dart';
import '../Utils/Dialogs.dart';

// ignore: camel_case_types
class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

// ignore: camel_case_types
class _ResetPasswordState extends State<ResetPassword> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  bool _passwordVisible = false;
  bool _confirmpasswordVisible = false;
  bool _isPasswordEightCar = false;
  bool _isHasOneNumber = false;
  bool _isHasSymboleOrCaptital = false;
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpasscontroller = TextEditingController();

  final number = TextEditingController();
  void initState() {
    number.text = Get.arguments['number'];
    super.initState();
  }

  void UploadResetPinData() async {
    Map<String, dynamic> updata = {
      "number": int.parse(number.text),
      "password": confirmpasscontroller.text,
    };
    print(updata);
    final data = await ResetPasword().postResetPassword(updata);
    if (data.status == ResponseStatus.SUCCESS) {
      Get.toNamed('/login');
      return utils.showToast("Password changed successfully try sign in again");
    } else {
      return utils.showToast(data.message);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode? Colors.black:Colors.white,
      appBar: CustomAppBar(titleTxt: "Reset Password", bottomtext: false),
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
                height: 50,
              ),
              Text("New Password", style: blackStyle(context).copyWith(color: Get.isDarkMode? Colors.white: Colors.black)),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (value) => onPasswordChnage(value),

                cursorColor: Colors.grey,
                style: const TextStyle(
                  //color: Colors.grey,
                  fontFamily: 'Productsans',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                keyboardType: TextInputType.text,
                controller: passwordcontroller,
                obscureText:
                    !_passwordVisible, //This will obscure text dynamically
                decoration: InputDecoration(
                  errorMaxLines: 3,
                  hintStyle:  TextStyle(
                    fontSize: 16,
                     color:Get.isDarkMode? Colors.white: Colors.grey.withOpacity(0.8),
                    fontFamily: 'Productsans',
                  ),
                  fillColor: Get.isDarkMode? Color(0xFF303030).withOpacity(0.3): Colors.white,
                  filled: true,
                  errorStyle: const TextStyle(
                    fontSize: 16.0,
                    color:  Colors.red
                  ),
                  hintText: 'Enter your password',
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
                            color:Get.isDarkMode? Colors.white: Colors.black,
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
                          color: _isPasswordEightCar
                              ? Colors.green
                              :Get.isDarkMode? Colors.white: Colors.black),
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

                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(50),
                      //   border: Border.all(
                      //     color: Colors.grey,
                      //   ),
                      // ),
                      child: _isHasSymboleOrCaptital
                          ? const Icon(
                              Icons.check,
                              color: Colors.green,
                              size: 15,
                            )
                          :  Icon(
                              Icons.check,
                              color:Get.isDarkMode? Colors.white: Colors.black,
                              size: 15,
                            )),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'Has at least 1 uppercase letter & symbol',
                      style: TextStyle(
                          fontFamily: 'Productsans',
                          fontSize: 12,
                          color: _isHasSymboleOrCaptital
                              ? Colors.green
                              :Get.isDarkMode? Colors.white: Colors.black),
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
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(50),
                    //   border: Border.all(
                    //     color: Colors.grey,
                    //   ),
                    // ),
                    child: _isHasOneNumber
                        ? const Icon(
                            Icons.check,
                            color: Colors.green,
                            size: 15,
                          )
                        :  Icon(
                            Icons.check,
                            color:Get.isDarkMode? Colors.white: Colors.black,
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
                          color: _isHasOneNumber ? Colors.green :Get.isDarkMode? Colors.white: Colors.black),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 35,
              ),
              Text(
                'Confirm Password',
                style: blackStyle(context).copyWith(color: Get.isDarkMode? Colors.white: Colors.black),
              ),
              SizedBox(
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
                  // focusedBorder: const OutlineInputBorder(
                  //   borderSide: BorderSide(color: Colors.grey, width: 2.0),
                  // ),
                  // enabledBorder: const OutlineInputBorder(
                  //   borderSide: BorderSide(color: Colors.grey, width: 2.0),
                  // ),
                  errorMaxLines: 3,
                  hintStyle:  TextStyle(
                    fontSize: 16,
                     color:Get.isDarkMode? Colors.white: Colors.grey.withOpacity(0.8),
                    fontFamily: 'Productsans',
                  ),
                  fillColor:Get.isDarkMode? Color(0xFF303030).withOpacity(0.3) : Colors.white,
                  filled: true,
                  // errorBorder: const OutlineInputBorder(
                  //   borderSide: BorderSide(color: Colors.red, width: 2.0),
                  // ),
                  // focusedErrorBorder: const OutlineInputBorder(
                  //   borderSide: const BorderSide(color: Colors.red, width: 2.0),
                  // ),
                  errorStyle:  TextStyle(
                    fontSize: 16.0,
                    color:  Colors.red
                  ),

                  hintText: 'Confirm password',
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
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        _confirmpasswordVisible = !_confirmpasswordVisible;
                      });
                    },
                  ),
                ),
                validator: (val) {
                  if (val == null || val.isEmpty)
                   return 'Password is Empty';
                  if (val != passwordcontroller.text) {
                    return 'Password Not Matched';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 60,
                width: double.infinity,
                // padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: CustomNextButton(
                  text: "Reset Password",
                  form: _form,
                  ontap: () {
                    final isValid = _form.currentState?.validate();
                    if (isValid!) {
                      UploadResetPinData();
                    } else {}
                  },
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
