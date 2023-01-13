// ignore_for_file: file_names

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:piadvisory/Common/StreamEnum.dart';
import 'package:piadvisory/Profile/KYC/Repository/storebasickycuserdetails.dart';
import 'package:piadvisory/Utils/Constants.dart';
import 'package:piadvisory/Utils/database.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart' as prefix;
import '../../Utils/base_manager.dart';
import '/Common/CustomNextButton.dart';
import '/Profile/KYC/KYCDigiLocker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/Utils/Dialogs.dart';
import '../../Common/app_bar.dart';
import '../../Utils/textStyles.dart';
import 'package:piadvisory/Profile/Personalprofilerepository/Model/kycbasicdetails.dart';
String? globalEmailID;

class KYCMain extends StatefulWidget {
  const KYCMain({
    Key? key,
  }) : super(key: key);

  @override
  State<KYCMain> createState() => _KYCMainState();
}

class _KYCMainState extends State<KYCMain> {
  final selectedOccupation = TextEditingController();

  final selectedResidentialStatus = TextEditingController();
  final selectedLifeExpectancy = TextEditingController();
  final selectedgender = TextEditingController();

  DateTime? _selectedDate;
  late final Future? myFuture;
 StreamController<requestResponseState> kycmainController =
      StreamController.broadcast();
      
  @override
  void initState() {
    super.initState();
     getKYCDetails();
  }
prefix.Dio dio = new prefix.Dio();

  Future<ResponseData> getKYCDetails() async {
    prefix.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    try {
      response = await dio.get(ApiConstant.getbasickycdetails,
          options: Options(headers: {"authorization": "Bearer $token"}));
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }
    print(" resp is $response");
    if (response.statusCode == 200) {
      kycDetails = kycbasicdetails.fromJson(response.data);
       setControllerValues();
  kycmainController.add(requestResponseState.DataReceived);
      return ResponseData<dynamic>(
        "success",
        ResponseStatus.SUCCESS,
      );
    } else {
      try {
        return ResponseData<dynamic>(
            response.data['message'].toString(), ResponseStatus.FAILED);
      } catch (_) {
        return ResponseData<dynamic>(
            response.statusMessage!, ResponseStatus.FAILED);
      }
    }
  }

        


  void _presentDatePicker() {
    // showDatePicker is a pre-made funtion of Flutter
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1922),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      // Check if no date is selected
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
        datecontroller.text =
            "${_selectedDate!.day.toString()}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.year.toString().padLeft(2, '0')}";
      });
    });
  }

  void UploadData() async {
    globalEmailID = emailid.text;
    final isValid = _form.currentState?.validate();
    if (isValid!) {
      replaceKycBtnWithLoader();
      Map<String, dynamic> updata = {
        "full_name": fullname.text,
        "address": address.text,
        "email": emailid.text,
        "pan_number": pannumber.text,
        "DOB": datecontroller.text,
        "mob_number": mobilecontroller.text,
        "age": agecontroller.text,
        "occupation": selectedOccupation.text,
        "gender": selectedgender.text,
        "residential_status": selectedResidentialStatus.text
      };
      final data =
          await StorebasickycuserDetails().postStorebasickycuserDetails(updata);
      if (data.status == ResponseStatus.SUCCESS) {
        replaceLoaderWithKycBtn();
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const KYCDigiLocker()));
      } else {
        replaceLoaderWithKycBtn();
        return utils.showToast(data.message);
      }
    }
  }

  bool isContinueBtnVisible = true;
  bool isContinueBtnLoaderVisible = false;

  void replaceKycBtnWithLoader() {
    setState(() {
      isContinueBtnVisible = false;
      isContinueBtnLoaderVisible = true;
    });
  }

  void replaceLoaderWithKycBtn() {
    setState(() {
      isContinueBtnVisible = true;
      isContinueBtnLoaderVisible = false;
    });
  }

  Future _showGenderpicker() async {
    FocusScope.of(context).unfocus();
    final data = await showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: const Gender(),
        );
      },
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Get.isDarkMode ? Colors.grey : Colors.white),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );

    if (data != null) {
      setState(() {
        selectedgender.text = data;
      });
    }
  }

  Future _showResidentialpicker() async {
    FocusScope.of(context).unfocus();
    final data = await showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: const Residential(),
        );
      },
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Get.isDarkMode ? Colors.grey : Colors.white),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );

    if (data != null) {
      setState(() {
        selectedResidentialStatus.text = data;
      });
    }
  }

  Future _showOccupationPicker() async {
    FocusScope.of(context).unfocus();
    final data = await showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: const OccupationPicker(),
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
        selectedOccupation.text = data;
      });
    }
  }

  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController fullname = TextEditingController();
  //TextEditingController lastname = TextEditingController();
  TextEditingController emailid = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController pannumber = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();

  setControllerValues() {
    Map<String, dynamic> userdata = Database().restoreUserDetails();
    fullname.text = userdata['fullname'];
    emailid.text = kycDetails?.user?.email ?? "";
    globalEmailID = emailid.text;
    mobilecontroller.text = userdata['number'].toString();
    address.text = kycDetails?.user?.address ?? "";
    pannumber.text = kycDetails?.user?.panNumber ?? "";
    datecontroller.text = kycDetails?.user?.dOB ?? "";
    agecontroller.text = kycDetails?.user?.age.toString() ?? "";
    selectedOccupation.text = kycDetails?.user?.occupation ?? "";
    selectedgender.text = kycDetails?.user?.gender ?? "";
    selectedResidentialStatus.text = kycDetails?.user?.residentialStatus ?? "";
    //selectedLifeExpectancy.text = kycDetails?.user?.lifeExpectancy ?? "";
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          titleTxt: "KYC",
          bottomtext: false,
        ),
        body:// _buildBody(context)
        StreamBuilder<requestResponseState>(
          stream: kycmainController.stream,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: Lottie.asset(
                    "assets/images/lf30_editor_jc6n8oqe.json",
                    repeat: true,
                    height: 50,
                    width: 50,
                  ),
                );

              default:
                if (snapshot.hasError) {
                  return Text("Error Occured");
                } else {
                  return _buildBody(context);
                }
            }
          }),
        );
  }

  Widget _buildBody(context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.only(
        top: 30,
        left: 20,
        right: 20,
      ),
      child: Form(
        key: _form,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Full Name*",
              style: Theme.of(context).textTheme.headline2,
              //  blackStyle(context).copyWith(
              //   fontSize: 16.sm,
              //   fontWeight: FontWeight.w600,
              // ),
            ),
            CustomTextFields(
              textCapitalization: TextCapitalization.none,
              inputFormatters: [
                LengthLimitingTextInputFormatter(20),
                FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter Full Name";
                } else
                  return null;
              },
              errortext: "Enter Full Name",
              hint: "Enter Full Name",
              controller: fullname,
            ),
            SizedBox(
              height: 40.h,
            ),

            Text(
              "Address with Pincode*",
              style: Theme.of(context).textTheme.headline2,
            ),
            CustomTextFields(
              textCapitalization: TextCapitalization.none,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter Address with Pincode";
                } else
                  return null;
              },
              maxlength: 90,
              limitlength: 90,
              errortext: "Enter Address with Pincode",
              hint: "Enter Address with Pincode",
              controller: address,
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "Email ID*",
              style: Theme.of(context).textTheme.headline2,
            ),
            TextFormField(
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    !value.contains('@') ||
                    !value.contains('.')) {
                  return "Please Enter Valid Email Address";
                }
                return null;
              },
              inputFormatters: [
                LengthLimitingTextInputFormatter(50),
              ],
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
                    borderSide: BorderSide(width: 1, color: Color(0xFF303030))),
              ),
              onSaved: (value) {},
              onChanged: (value) {
                // onEmailChange(value);
              },
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "PAN Number*",
              style: Theme.of(context).textTheme.headline2,
              //  blackStyle(context).copyWith(
              //   fontSize: 16.sp,
              //   fontWeight: FontWeight.w600,
              // ),
            ),
            CustomTextFields(
              textCapitalization: TextCapitalization.characters,
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.allow(RegExp('[A-Z,0-9]')),
              ],
              txtinptype: TextInputType.text,
              errortext: "Enter PAN Number",
              hint: "Enter PAN Number",
              controller: pannumber,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter PAN Number in Capital";
                } else if (value.length != 10) {
                  return "Please Enter Valid PAN Number";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "Date of Birth*",
              style: Theme.of(context).textTheme.headline2,
            ),
            KycDatePickerWidget(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Select Date of Birth";
                }
                return null;
              },
              datecontroller: datecontroller,
              ontap: () => _presentDatePicker(),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "Mobile Number*",
              style: Theme.of(context).textTheme.headline2,
            ),

            CustomTextFields(
              textCapitalization: TextCapitalization.none,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter Phone Number";
                } else if (value.length != 10) {
                  return "Please Enter Valid Phone Number";
                }
                return null;
              },
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.allow(RegExp('[0-9]')),
              ],
              txtinptype: TextInputType.number,
              errortext: "Enter Mobile Number",
              hint: "Enter Mobile Number",

              controller: mobilecontroller,

              // controller: mobilecontroller,
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return "Please Enter Phone Number";
              //   } else if (value.length != 10) {
              //     return "Please Enter Valid Phone Number";
              //   }
              //   return null;
              // },
              // inputFormatters: [
              //   LengthLimitingTextInputFormatter(10),
              //   FilteringTextInputFormatter.allow(RegExp('[0-9]')),
              // ],
            ),

            // CustomTextFields(
            //   txtinptype: TextInputType.number,
            //   errortext: "Enter Mobile Number",
            //   hint: "Enter Mobile Number",
            //   controller: mobilecontroller,
            // ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "Age*",
              style: Theme.of(context).textTheme.headline2,
              // blackStyle(context).copyWith(
              //   fontSize: 16.sp,
              //   fontWeight: FontWeight.w600,
              // ),
            ),
            CustomTextFields(
              textCapitalization: TextCapitalization.none,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter Age";
                } else
                  return null;
              },
              inputFormatters: [
                LengthLimitingTextInputFormatter(2),
                FilteringTextInputFormatter.allow(RegExp('[0-9]')),
              ],
              txtinptype: TextInputType.number,
              errortext: "Enter  Age",
              hint: "Enter Age",
              controller: agecontroller,
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "Occupation*",
              style: Theme.of(context).textTheme.headline2,
              // blackStyle(context).copyWith(
              //   fontSize: 16.sp,
              //   fontWeight: FontWeight.w600,
              // ),
            ),
            CustomTextFields(
              textCapitalization: TextCapitalization.none,
              inputFormatters: [
                LengthLimitingTextInputFormatter(20),
                FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter Occupation";
                } else
                  return null;
              },
              errortext: "Enter Occupation",
              hint: "Enter Occupation",
              controller: selectedOccupation,
            ),
            // CustomDropDownOptions(
            //   controller: selectedOccupation,
            //   ontap: () => _showOccupationPicker(),
            //   hinttext: "Select Occupation",
            // ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "Gender*",
              style: Theme.of(context).textTheme.headline2,
              // blackStyle(context).copyWith(
              //   fontSize: 16.sp,
              //   fontWeight: FontWeight.w600,
              // ),
            ),
            KycCustomDropDownOptions(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Select Gender";
                }
                return null;
              },
              controller: selectedgender,
              hinttext: "Select gender",
              ontap: () => _showGenderpicker(),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "Residential Status*",
              style: Theme.of(context).textTheme.headline2,
              // blackStyle(context).copyWith(
              //   fontSize: 16.sp,
              //   fontWeight: FontWeight.w600,
              // ),
            ),
            KycCustomDropDownOptions(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Select Residential Status";
                  }
                  return null;
                },
                hinttext: "Selected residential status",
                controller: selectedResidentialStatus,
                ontap: () => _showResidentialpicker()),
            // const SizedBox(
            //   height: 40,
            // ),
            // Text(
            //   "Life Expectancy (should be above 70)- For retirement planning",
            //   style: Theme.of(context).textTheme.headline2,
            //   //  blackStyle(context).copyWith(
            //   //   fontSize: 16.sp,
            //   //   fontWeight: FontWeight.w600,
            //   // ),
            // ),
            // CustomDropDownOptions(
            //   controller: selectedLifeExpectancy,
            //   hinttext: "Select Life Expectancy",
            //   ontap: () => _showLifeExpectancypicker(),
            // ),
            SizedBox(
              height: 40.h,
            ),
            Visibility(
              visible: isContinueBtnVisible,
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: CustomNextButton(
                  text: "Continue",
                  ontap: () {
                    // if(selectedgender == "" || selectedgender.text.isEmpty
                    // || selectedResidentialStatus == "" || selectedResidentialStatus.text.isEmpty
                    // || datecontroller == "" || datecontroller.text.isEmpty
                    // ){
                    //   return utils.showToast("Please fill all fields");
                    // }
                    UploadData();
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
                //   onPressed: () {
                //     UploadData();
                //     //=> _validateData(),
                //   },
                //   valueColor: Colors.black,
                //   borderRadius: 10,
                //   child: Text(
                //     "Continue",
                //     style: TextStyle(
                //       color: Color(0xFFFFFFFF),
                //       fontSize: 20,
                //       fontFamily: 'Productsans',
                //     ),
                //   ),
                // ),

                // CustomNextButton(
                //   text: "Continue",
                //   ontap: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => const KYCDigiLocker()));
                // final isValid = _form.currentState?.validate();
                // if (isValid!) {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) =>
                //               const PhoneVerification()));
                // }
                // },
                // ),
              ),
            ),
            Visibility(
                visible: isContinueBtnLoaderVisible,
                child: Center(child: CircularProgressIndicator())),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    ));
  }
}

class CustomDropDownOptions extends StatelessWidget {
  const CustomDropDownOptions({
    Key? key,
    required this.hinttext,
    required this.ontap,
    this.controller,
  }) : super(key: key);

  final String hinttext;
  final GestureTapCallback ontap;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      onTap: (() => ontap()),
      readOnly: true,
      cursorColor: Colors.grey,
      style: const TextStyle(
        fontFamily: 'Product Sans',
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.grey,
            ),
            onPressed: () {
              ontap();
            },
          ),
          hintStyle: blackStyle(context).copyWith(
              fontSize: 16.sm,
              fontWeight: FontWeight.w400,
              color: Get.isDarkMode
                  ? Colors.white
                  : Color(0xFF303030).withOpacity(0.3)),
          //  Color(0xFF303030).withOpacity(0.3)),
          hintText: hinttext),
    );
  }
}

class KycCustomDropDownOptions extends StatelessWidget {
  const KycCustomDropDownOptions(
      {Key? key,
      required this.hinttext,
      required this.ontap,
      this.controller,
      this.validator})
      : super(key: key);

  final String hinttext;
  final GestureTapCallback ontap;
  final TextEditingController? controller;
  final dynamic validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      onTap: (() => ontap()),
      readOnly: true,
      cursorColor: Colors.grey,
      style: const TextStyle(
        fontFamily: 'Product Sans',
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.grey,
            ),
            onPressed: () {
              ontap();
            },
          ),
          hintStyle: blackStyle(context).copyWith(
              fontSize: 16.sm,
              fontWeight: FontWeight.w400,
              color: Get.isDarkMode
                  ? Colors.white
                  : Color(0xFF303030).withOpacity(0.3)),
          //  Color(0xFF303030).withOpacity(0.3)),
          hintText: hinttext),
    );
  }
}

class DatePickerWidget extends StatelessWidget {
  const DatePickerWidget({
    Key? key,
    required this.datecontroller,
    required this.ontap,
  }) : super(key: key);

  final TextEditingController datecontroller;
  final GestureTapCallback ontap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: datecontroller,
      onTap: (() => ontap()),
      readOnly: true,
      cursorColor: Colors.grey,
      style: const TextStyle(
        fontFamily: 'Product Sans',
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: const Icon(
              Icons.date_range,
              color: Color(0xFF008083),
            ),
            onPressed: () {
              ontap();
            },
          ),
          hintStyle:
              // Theme.of(context).textTheme.headline3,
              blackStyle(context).copyWith(
                  fontSize: 16.sm,
                  fontWeight: FontWeight.w400,
                  color: Get.isDarkMode
                      ? Colors.white
                      : Color(0xFF303030).withOpacity(0.3)),
          hintText: "Select Date"),
    );
  }
}

class KycDatePickerWidget extends StatelessWidget {
  const KycDatePickerWidget(
      {Key? key,
      required this.datecontroller,
      required this.ontap,
      this.validator})
      : super(key: key);

  final TextEditingController datecontroller;
  final GestureTapCallback ontap;
  final dynamic validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: datecontroller,
      onTap: (() => ontap()),
      readOnly: true,
      cursorColor: Colors.grey,
      style: const TextStyle(
        fontFamily: 'Product Sans',
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: const Icon(
              Icons.date_range,
              color: Color(0xFF008083),
            ),
            onPressed: () {
              ontap();
            },
          ),
          hintStyle:
              // Theme.of(context).textTheme.headline3,
              blackStyle(context).copyWith(
                  fontSize: 16.sm,
                  fontWeight: FontWeight.w400,
                  color: Get.isDarkMode
                      ? Colors.white
                      : Color(0xFF303030).withOpacity(0.3)),
          hintText: "Select Date"),
    );
  }
}

class CustomTextFields extends StatelessWidget {
  const CustomTextFields(
      {Key? key,
      this.controller,
      this.hint,
      this.errortext,
      this.ontap,
      this.limitlength,
      this.maxlength,
      this.onchanged,
      this.txtinptype,
      this.inputFormatters,
      this.textCapitalization,
      this.validator})
      : super(key: key);

  final TextEditingController? controller;
  final String? hint;
  final String? errortext;
  final Function(String)? ontap;
  final int? limitlength;
  final int? maxlength;
  final Function(String)? onchanged;
  final TextInputType? txtinptype;
  final dynamic inputFormatters;
  final dynamic textCapitalization;
  final dynamic validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: textCapitalization,
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
      validator: validator,
      // (value) {
      //   if (value == null || value.isEmpty) {
      //     return errortext ?? "Empty value";
      //   }
      //   return null;
      // },
      inputFormatters: inputFormatters,

      onSaved: (value) {
        ontap?.call;
      },
      onChanged: (value) {
        onchanged?.call(value);
      },
    );
  }
}

class OccupationPicker extends StatefulWidget {
  const OccupationPicker({Key? key}) : super(key: key);

  @override
  State<OccupationPicker> createState() => _OccupationPickerState();
}

class _OccupationPickerState extends State<OccupationPicker> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Text("Select an Occupation",
                style: Theme.of(context).textTheme.headline3),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                ListTile(
                  onTap: (() {
                    Navigator.pop(
                        context, " Salaried – Private Sector/Corporates");
                  }),
                  title: const Text(" Salaried – Private Sector/Corporates"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(
                        context, "Salaried - Government Sector/PSUs/PSBs");
                  }),
                  title: const Text("Salaried - Government Sector/PSUs/PSBs"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context,
                        "Self-employed Professional (Doctors, Lawyers, ");
                  }),
                  title: const Text(
                      "Self-employed Professional (Doctors, Lawyers, "),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(
                        context, "Self-employed trader/Business Owner");
                  }),
                  title: const Text("Self-employed trader/Business Owner"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Others");
                  }),
                  title: const Text("Others"),
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

class CustomBottomSelection extends StatelessWidget {
  const CustomBottomSelection({
    Key? key,
    this.hint,
    this.ontap,
  }) : super(key: key);

  final String? hint;

  final GestureTapCallback? ontap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onTap: (() => ontap?.call),
      readOnly: true,
      cursorColor: Colors.grey,
      style: const TextStyle(
        fontFamily: 'Product Sans',
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          hintStyle: blackStyle(context).copyWith(
              fontSize: 16.sm,
              fontWeight: FontWeight.w600,
              color: Color(0xFF303030).withOpacity(0.3)),
          hintText: hint),
    );
  }
}

class Residential extends StatefulWidget {
  const Residential({Key? key}) : super(key: key);

  @override
  State<Residential> createState() => _ResidentialState();
}

class _ResidentialState extends State<Residential> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Text("Select Residential Status",
                style: Theme.of(context).textTheme.headline2),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Resident Individual");
                  }),
                  title: const Text("Resident Individual"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Non Resident Indian");
                  }),
                  title: const Text("Non Resident Indian"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Foreign National");
                  }),
                  title: const Text("Foreign National"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Person of Indian Origin");
                  }),
                  title: const Text("Person of Indian Origin"),
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

class LifeExpectency extends StatefulWidget {
  const LifeExpectency({Key? key}) : super(key: key);

  @override
  State<LifeExpectency> createState() => _LifeExpectencyState();
}

class _LifeExpectencyState extends State<LifeExpectency> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Text("Select Residential Status",
                style: Theme.of(context).textTheme.headline2),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Age1");
                  }),
                  title: const Text("Age1"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Age2");
                  }),
                  title: const Text("Age2"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Age3");
                  }),
                  title: const Text("Age3"),
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

class Gender extends StatefulWidget {
  const Gender({Key? key}) : super(key: key);

  @override
  State<Gender> createState() => _GenderState();
}

class _GenderState extends State<Gender> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Text("Select Gender",
                style: Theme.of(context).textTheme.headline3),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Male");
                  }),
                  title: const Text("Male"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Female");
                  }),
                  title: const Text("Female"),
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