import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:piadvisory/Profile/KYC/CKYCpage2.dart';
import 'package:piadvisory/Profile/KYC/Repository/storebasickycuserdetails.dart';
import 'package:piadvisory/Profile/KYC/proofIdentity.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../Utils/base_manager.dart';
import '/Common/CustomNextButton.dart';
import '/Profile/KYC/KYCDigiLocker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/Utils/Dialogs.dart';
import '../../Common/app_bar.dart';
import '../../Utils/textStyles.dart';

class CKYCMain extends StatefulWidget {
  const CKYCMain({Key? key}) : super(key: key);

  @override
  State<CKYCMain> createState() => _CKYCMainState();
}

class _CKYCMainState extends State<CKYCMain> {
  // final selectedLifeExpectancy = TextEditingController();

  final RoundedLoadingButtonController _btnController1 =
      RoundedLoadingButtonController();
  // //  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // bool _isEmailValid = false;
  DateTime? _selectedDate;
  // late final Future? myFuture;

  // @override
  // void initState() {
  //   super.initState();
  //   setControllerValues();
  //   myFuture = StorebasickycuserDetails().getBasicKycDetails();
  // }

  // onEmailChange(String email) {
  //   setState(() {
  //     final emailRegEx = RegExp(
  //         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  //     if (emailRegEx.hasMatch(email)) _isEmailValid = true;
  //   });
  // }

  void _presentDatePicker() {
    // showDatePicker is a pre-made funtion of Flutter
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
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

  // void UploadData() async {
  //   final isValid = _form.currentState?.validate();
  //   if (isValid!) {
  //     Map<String, dynamic> updata = {
  //       "firstName": firstname.text,
  //       "lastName": lastname.text,
  //       "address": address.text,
  //       "email": emailid.text,
  //       "pan_number": pannumber.text,
  //       "DOB": datecontroller.text,
  //       "occupation": selectedOccupation.text,
  //       "gender": selectedgender.text,
  //       "residential_status": selectedResidentialStatus.text,
  //       "life_expectancy": selectedLifeExpectancy.text,
  //     };
  //     final data =
  //         await StorebasickycuserDetails().postStorebasickycuserDetails(updata);
  //     if (data.status == ResponseStatus.SUCCESS) {
  //       Navigator.push(context,
  //           MaterialPageRoute(builder: (context) => const KYCDigiLocker()));
  //     } else {
  //       return utils.showToast(data.message);
  //     }
  //   }
  // }

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
        selectedgender.text = data;
      });
    }
  }

  Future _showMaritalpicker() async {
    FocusScope.of(context).unfocus();
    final data = await showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: const Marital(),
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
        selectedmarital.text = data;
      });
    }
  }

  Future _showCitizenshipPicker() async {
    FocusScope.of(context).unfocus();
    final data = await showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: const Citizenship(),
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
        selectedcitizenship.text = data;
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

  // Future _showLifeExpectancypicker() async {
  //   FocusScope.of(context).unfocus();
  //   final data = await showModalBottomSheet<dynamic>(
  //     isScrollControlled: true,
  //     context: context,
  //     builder: (context) {
  //       return Container(
  //         margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
  //         child: const LifeExpectency(),
  //       );
  //     },
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(30),
  //         topRight: Radius.circular(30),
  //       ),
  //     ),
  //     backgroundColor: Theme.of(context).scaffoldBackgroundColor,
  //   );

  //   if (data != null) {
  //     setState(() {
  //       selectedLifeExpectancy.text = data;
  //     });
  //   }
  // }

  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController fathername = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  TextEditingController mothername = TextEditingController();
  final selectedgender = TextEditingController();
  TextEditingController maidenname = TextEditingController();
  final selectedmarital = TextEditingController();
  final selectedcitizenship = TextEditingController();
  final selectedResidentialStatus = TextEditingController();
  final selectedOccupation = TextEditingController();
  TextEditingController emailid = TextEditingController();

  TextEditingController pannumber = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();

  // setControllerValues() {
  //   firstname.text = kycDetails?.user?.firstName ?? "";
  //   lastname.text = kycDetails?.user?.lastName ?? "";
  //   emailid.text = kycDetails?.user?.email ?? "";
  //   address.text = kycDetails?.user?.address ?? "";
  //   pannumber.text = kycDetails?.user?.panNumber ?? "";
  //   datecontroller.text = kycDetails?.user?.dOB ?? "";
  //   mobilecontroller.text = kycDetails?.user?.mobNumber.toString() ?? "";
  //   agecontroller.text = kycDetails?.user?.age.toString() ?? "";
  //   selectedOccupation.text = kycDetails?.user?.occupation ?? "";
  //   selectedgender.text = kycDetails?.user?.gender ?? "";
  //   selectedResidentialStatus.text = kycDetails?.user?.residentialStatus ?? "";
  //   selectedLifeExpectancy.text = kycDetails?.user?.lifeExpectancy ?? "";
  // }

  // @override
  // void dispose() {
  //   firstname.dispose();
  //   lastname.dispose();
  //   emailid.dispose();
  //   address.dispose();
  //   pannumber.dispose();
  //   datecontroller.dispose();
  //   mobilecontroller.dispose();
  //   agecontroller.dispose();
  //   selectedOccupation.dispose();
  //   selectedgender.dispose();
  //   selectedResidentialStatus.dispose();
  //   selectedLifeExpectancy.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titleTxt: "CKYC", bottomtext: false),
      body: SingleChildScrollView(
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
                  "Enter Father/Spouse Name",
                  style: Theme.of(context).textTheme.headline2,
                  //  blackStyle(context).copyWith(
                  //   fontSize: 16.sm,
                  //   fontWeight: FontWeight.w600,
                  // ),
                ),
                CustomTextFields(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(20),
                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                  ],
                  errortext: "Enter Father/Spouse Name",
                  hint: "Enter Father/Spouse Name",
                  controller: fathername,
                ),
                SizedBox(
                  height: 40.h,
                ),
                Text(
                  "Date of Birth*",
                  style: Theme.of(context).textTheme.headline2,
                ),
                DatePickerWidget(
                  datecontroller: datecontroller,
                  ontap: () => _presentDatePicker(),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  "Enter Mother Maiden Name",
                  style: Theme.of(context).textTheme.headline2,
                ),
                CustomTextFields(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(20),
                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                  ],
                  errortext: "Enter Mother Maiden Name",
                  hint: "Enter Mother Maiden Name",
                  controller: mothername,
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  "Select Gender:",
                  style: Theme.of(context).textTheme.headline2,
                  // blackStyle(context).copyWith(
                  //   fontSize: 16.sp,
                  //   fontWeight: FontWeight.w600,
                  // ),
                ),
                // FormBuilderDropdown(
                //   // validator: FormBuilderValidators.required,
                //   controller: selectedgender,
                //   hinttext: "Select gender",
                //   ontap: () => _showGenderpicker(),
                // ),

                CustomDropDownOptions(
                  controller: selectedgender,
                  hinttext: "Select gender",
                  ontap: () => _showGenderpicker(),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  "Enter Maiden Name if any ",
                  style: Theme.of(context).textTheme.headline2,
                ),
                CustomTextFields(
                  hint: "Enter Maiden Name if any",
                  controller: maidenname,
                ),
                SizedBox(
                  height: 40.h,
                ),
                Text(
                  "Select Marital Status:",
                  style: Theme.of(context).textTheme.headline2,
                  // blackStyle(context).copyWith(
                  //   fontSize: 16.sp,
                  //   fontWeight: FontWeight.w600,
                  // ),
                ),
                CustomDropDownOptions(
                  controller: selectedmarital,
                  hinttext: "Select Marital Status",
                  ontap: () => _showMaritalpicker(),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  "Select/Enter Citizenship:",
                  style: Theme.of(context).textTheme.headline2,
                  // blackStyle(context).copyWith(
                  //   fontSize: 16.sp,
                  //   fontWeight: FontWeight.w600,
                  // ),
                ),
                CustomDropDownOptions(
                  controller: selectedcitizenship,
                  hinttext: "Select Citizenship Status",
                  ontap: () => _showCitizenshipPicker(),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  "Select Residential Status:",
                  style: Theme.of(context).textTheme.headline2,
                  // blackStyle(context).copyWith(
                  //   fontSize: 16.sp,
                  //   fontWeight: FontWeight.w600,
                  // ),
                ),
                CustomDropDownOptions(
                    hinttext: "Selected residential status",
                    controller: selectedResidentialStatus,
                    ontap: () => _showResidentialpicker()),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  "Select Occupation:",
                  style: Theme.of(context).textTheme.headline2,
                  // blackStyle(context).copyWith(
                  //   fontSize: 16.sp,
                  //   fontWeight: FontWeight.w600,
                  // ),
                ),
                CustomDropDownOptions(
                  controller: selectedOccupation,
                  ontap: () => _showOccupationPicker(),
                  hinttext: "Select Occupation",
                ),
                SizedBox(
                  height: 40.h,
                ),
                // SizedBox(
                //   width: double.infinity,
                //   height: 60,
                //   child: RoundedLoadingButton(
                //     height: 60,
                //     resetAfterDuration: true,
                //     resetDuration: Duration(seconds: 5),
                //     width: MediaQuery.of(context).size.width * 1,
                //     color: const Color.fromRGBO(247, 129, 4, 1),
                //     successColor: const Color.fromRGBO(247, 129, 4, 1),
                //     controller: _btnController1,
                //     onPressed: () {
                //        Navigator.push(context,
                //       MaterialPageRoute(builder: (context) => const CKYC2()));
                //      // UploadData();
                //       //=> _validateData(),
                //     },
                //     valueColor: Colors.black,
                //     borderRadius: 10,
                //     child: Text(
                //       "Continue",
                //       style: TextStyle(
                //         color: Color(0xFFFFFFFF),
                //         fontSize: 20,
                //         fontFamily: 'Helvetica',
                //       ),
                //     ),
                //   ),

                SizedBox(
                  width: double.infinity,
                  child: CustomNextButton(
                      text: "Continue",
                      ontap: () {
                        final isValid = _form.currentState?.validate();
                        if (isValid!) {
                          if (selectedResidentialStatus.text ==
                              "Resident Individual") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProofIdentity()));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const CKYC2()));
                          }
                        } else {
                          Flushbar(
                            message: "Please Enter all the fields",
                            duration: const Duration(seconds: 3),
                          ).show(context);
                        }
                      }),
                ),
                const SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
      validator: (value) {
        if (value == null && value!.isEmpty) {
          return 'Gender is required';
        }
      },
    );
  }
}

// class FormBuilderDropdown extends StatelessWidget {
//    FormBuilderDropdown({
//     Key? key,
//     required this.hinttext,
//     required this.ontap,
//     this.controller,
//    // this.validator,
//   }) : super(key: key);

//   final String hinttext;
//   final GestureTapCallback ontap;
//   final TextEditingController? controller;
//  // final FormBuilderValidators = validator;

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       onTap: (() => ontap()),
//       readOnly: true,
//       cursorColor: Colors.grey,
//       style: const TextStyle(
//         fontFamily: 'Product Sans',
//         fontSize: 16,
//         fontWeight: FontWeight.w500,
//       ),
//       keyboardType: TextInputType.text,
//       decoration: InputDecoration(
//           suffixIcon: IconButton(
//             icon: const Icon(
//               Icons.keyboard_arrow_down,
//               color: Colors.grey,
//             ),
//             onPressed: () {
//               ontap();
//             },
//           ),
//           hintStyle: blackStyle(context).copyWith(
//               fontSize: 16.sm,
//               fontWeight: FontWeight.w400,
//               color: Get.isDarkMode
//                   ? Colors.white
//                   : Color(0xFF303030).withOpacity(0.3)),
//           //  Color(0xFF303030).withOpacity(0.3)),
//           hintText: hinttext),
//           // validator: FormBuilderValidators.required,
//       //    validator: (value) {
//       //    if (value == null && value!.isEmpty) {
//       //     return 'Select all fields';
//       //    }
//       //  },
//     );
//   }
// }

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
      //   validator: (value) {
      //   if (value == null || value.isEmpty) {
      //    return errortext ?? "Empty value";
      //  }
      //  return null;
      // },
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
    this.inputFormatters,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? hint;
  final String? errortext;
  final Function(String)? ontap;
  final int? limitlength;
  final int? maxlength;
  final Function(String)? onchanged;
  final TextInputType? txtinptype;
  final dynamic inputFormatters;
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
                    Navigator.pop(context,
                        "Services - Private Sector, Public Sector, Government Sector");
                  }),
                  title: const Text(
                      "Services- Private Sector,  Public Sector, Government Sector"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context,
                        "Others - Professional, Self Employed, Retired, Housewife, Student");
                  }),
                  title: const Text(
                      "Others - Professional, Self Employed, Retired, Housewife, Student"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Business");
                  }),
                  title: const Text("Business"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Categorised");
                  }),
                  title: const Text("Categorised"),
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

class Marital extends StatefulWidget {
  const Marital({Key? key}) : super(key: key);

  @override
  State<Marital> createState() => _MaritalState();
}

class _MaritalState extends State<Marital> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Text("Select Marital Status",
                style: Theme.of(context).textTheme.headline3),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Married");
                  }),
                  title: const Text("Married"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Un-Married");
                  }),
                  title: const Text("Un-Married"),
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

class Citizenship extends StatefulWidget {
  const Citizenship({Key? key}) : super(key: key);

  @override
  State<Citizenship> createState() => _CitizenshipState();
}

class _CitizenshipState extends State<Citizenship> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Text("Select Citizenship Status",
                style: Theme.of(context).textTheme.headline3),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Indian");
                  }),
                  title: const Text("Indian"),
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
