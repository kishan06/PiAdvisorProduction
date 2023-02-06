// ignore_for_file: file_names, unused_field

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:piadvisory/Profile/KYC/Repository/storebasicfamilydetails.dart';
import 'package:piadvisory/Profile/ProfileMain.dart';
import 'package:piadvisory/Utils/base_manager.dart';

import '/Common/CustomNextButton.dart';
import '/Profile/KYC/AddIncomeAndExpense.dart';
import '/Profile/KYC/KYCMain.dart';
import '/Utils/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/Utils/Dialogs.dart';
import '../../Common/app_bar.dart';

class FamilyDetails extends StatefulWidget {
  const FamilyDetails({Key? key}) : super(key: key);

  @override
  State<FamilyDetails> createState() => _FamilyDetailsState();
}

class _FamilyDetailsState extends State<FamilyDetails> {
  TextEditingController fathersname = TextEditingController();
  TextEditingController mothersname = TextEditingController();
  TextEditingController husbandwifename = TextEditingController();
  TextEditingController datecontrollerFather = TextEditingController();
  TextEditingController datecontrollerMother = TextEditingController();
  TextEditingController datecontrollerHusbandWife = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController ageMother = TextEditingController();
  TextEditingController ageHusbandWife = TextEditingController();
  final selectedOccupationFather = TextEditingController();
  final selectedOccupationMother = TextEditingController();
  final selectedOccupationHusbandWife = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  String _selectedval = 'yes';
  DateTime? _selectedDate;
  bool _isFather = true;
  bool _isHusbandWife = false;
  int _setChildren = 1;
  late final Future? myFuture;
  @override
  void initState() {
    super.initState();
    setControllerValues();
  }

  Future _showOccupationPicker(bool isFather, bool isHusbandWife) async {
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
        if (isFather) {
          selectedOccupationFather.text = data;
        } else if (isHusbandWife) {
          selectedOccupationHusbandWife.text = data;
        } else {
          selectedOccupationMother.text = data;
        }
      });
    }
  }

  void UploadData() async {
    final isValid = _form.currentState?.validate();
    if (isValid!) {
      Map<String, dynamic> updata = {
        "Fathers_name": fathersname.text,
        "fathers_occupation": selectedOccupationFather.text,
        "fathers_dob": datecontrollerFather.text,
        "fathers_age": age.text,
        "Mothers_name": mothersname.text,
        "mothers_occupation": selectedOccupationMother.text,
        "mothers_age": ageMother.text,
        "mothers_dob": datecontrollerMother.text,
        "Husband_wife_name": husbandwifename.text,
        "Husband_wife_occupation": selectedOccupationHusbandWife.text,
        "Husband_wife_dob": datecontrollerHusbandWife.text,
        "Husband_wife_age": ageHusbandWife.text,
        "children": _selectedval
      };
      final data = await Storefamilydetails().postStorefamilydetails(updata);
      if (data.status == ResponseStatus.SUCCESS) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AddIncomeAndExpenseDetails()));
        utils.showToast("Family Details added successfully");
      } else {
        return utils.showToast(data.message);
      }
    }
  }

  Future _presentDatePicker(bool isFather, bool isHusbandWife) async {
    // showDatePicker is a pre-made funtion of Flutter
    await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1800),
            lastDate: DateTime.now())
        .then((pickedDate) {
      // Check if no date is selected
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
        if (isFather) {
          datecontrollerFather.text =
              "${_selectedDate!.day.toString()}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.year.toString().padLeft(2, '0')}";
        } else if (isHusbandWife) {
          datecontrollerHusbandWife.text =
              "${_selectedDate!.day.toString()}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.year.toString().padLeft(2, '0')}";
        } else {
          datecontrollerMother.text =
              "${_selectedDate!.day.toString()}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.year.toString().padLeft(2, '0')}";
        }
      });
    });
  }

  setControllerValues() {
    fathersname.text = familyDetails?.user?.fathersName ?? "";
    selectedOccupationFather.text =
        familyDetails?.user?.fathersOccupation ?? "";
    datecontrollerFather.text = familyDetails?.user?.fathersDob ?? "";
    age.text = familyDetails?.user?.fathersAge ?? "";
    mothersname.text = familyDetails?.user?.mothersName ?? "";
    selectedOccupationMother.text =
        familyDetails?.user?.mothersOccupation ?? "";
    ageMother.text = familyDetails?.user?.mothersAge ?? "";
    datecontrollerMother.text = familyDetails?.user?.mothersDob ?? "";
    husbandwifename.text = familyDetails?.user?.husbandWifeName ?? "";
    selectedOccupationHusbandWife.text =
        familyDetails?.user?.husbandWifeOccupation ?? "";
    datecontrollerHusbandWife.text = familyDetails?.user?.husbandWifeDob ?? "";
    ageHusbandWife.text = familyDetails?.user?.husbandWifeAge ?? "";
    _selectedval = familyDetails?.user?.children ?? "";
  }

  @override
  void dispose() {
    // fathersname.dispose();
    // selectedOccupationFather.dispose();
    // datecontrollerFather.dispose();
    // age.dispose();
    // mothersname.dispose();
    // selectedOccupationMother.dispose();
    // ageMother.dispose();
    // datecontrollerMother.dispose();
    // husbandwifename.dispose();
    // selectedOccupationHusbandWife.dispose();
    // datecontrollerHusbandWife.dispose();
    // ageHusbandWife.dispose();
    // int.parse(_selectedval);
    print("disposed used");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => const ProfileMain())));

        throw new FormatException();
      },
      child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              height: 50,
              decoration: const BoxDecoration(),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: false,
            titleSpacing: 0,
            // centerTitle: true,
            title: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                "Family Details",
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                    //  fontFamily: 'Helvetica',
                    fontSize: 20.sm,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const ProfileMain())));
              },
              icon: Icon(
                Icons.arrow_back,
              ),
              iconSize: 22.sm,
              color: Color(0xFF6B6B6B),
            ),
          ),
          //const CustomAppBar(titleTxt: "Family Details", bottomtext: false),
          body: _buildBody(context)
          // FutureBuilder(
          //   future: myFuture,
          //   builder: (ctx, snapshot) {
          //     if (snapshot.data == null) {
          //       return Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: [
          //           Center(child: CircularProgressIndicator()),
          //         ],
          //       );
          //     }
          //     if (snapshot.connectionState == ConnectionState.done) {
          //       if (snapshot.hasError) {
          //         return Center(
          //           child: Text(
          //             '${snapshot.error} occured',
          //             style: TextStyle(fontSize: 18),
          //           ),
          //         );
          //       }
          //     }
          //     return _buildBody(
          //       context,
          //     );
          //   },
          // ),
          ),
    );
  }

  Widget _buildBody(context) {
    return SingleChildScrollView(
        child: Padding(
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
              height: 40,
            ),
            Text(
              "Father's Name*",
              style: Theme.of(context).textTheme.headline2,
            ),
            CustomTextFields(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter Father Name";
                } else
                  return null;
              },
              txtinptype: TextInputType.name,
              inputFormatters: [
                LengthLimitingTextInputFormatter(20),
                FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
              ],
              textCapitalization: TextCapitalization.none,
              errortext: "Enter Name",
              hint: "Enter Name",
              controller: fathersname,
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "Occupation*",
              style: blackStyle(context).copyWith(
                fontSize: 16.sm,
                fontWeight: FontWeight.w600,
                color: Get.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            OccupationCustomDropDownOptions(
              controller: selectedOccupationFather,
              hinttext: "Select occupation",
              ontap: () => _showOccupationPicker(
                  _isFather = true, _isHusbandWife = false),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "Date of Birth*",
              style: blackStyle(context).copyWith(
                fontSize: 16.sm,
                fontWeight: FontWeight.w600,
                color: Get.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            familyDatePickerWidget(
              datecontroller: datecontrollerFather,
              ontap: () =>
                  _presentDatePicker(_isFather = true, _isHusbandWife = false),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "Age*",
              style: blackStyle(context).copyWith(
                fontSize: 16.sm,
                fontWeight: FontWeight.w600,
                color: Get.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            CustomTextFields(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter Age";
                } else if (value != null && value.length >= 3) {
                  return "Please Enter Correct Age";
                } else
                  return null;
              },
              inputFormatters: [
                LengthLimitingTextInputFormatter(2),
                FilteringTextInputFormatter.allow(RegExp('[0-9]')),
              ],
              textCapitalization: TextCapitalization.none,
              txtinptype: TextInputType.number,
              errortext: "Enter  Age",
              hint: "Enter Age",
              controller: age,
            ),
            //mother
            const SizedBox(
              height: 40,
            ),
            Text(
              "Mother's Name*",
              style: blackStyle(context).copyWith(
                fontSize: 16.sm,
                fontWeight: FontWeight.w600,
                color: Get.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            CustomTextFields(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter Mother Name";
                } else
                  return null;
              },
              txtinptype: TextInputType.name,
              inputFormatters: [
                LengthLimitingTextInputFormatter(20),
                FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
              ],
              textCapitalization: TextCapitalization.none,
              errortext: "Enter Name",
              hint: "Enter Name",
              controller: mothersname,
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "Occupation*",
              style: blackStyle(context).copyWith(
                fontSize: 16.sm,
                fontWeight: FontWeight.w600,
                color: Get.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            OccupationCustomDropDownOptions(
              controller: selectedOccupationMother,
              hinttext: "select",
              ontap: () => _showOccupationPicker(
                  _isFather = false, _isHusbandWife = false),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "Date of Birth*",
              style: blackStyle(context).copyWith(
                fontSize: 16.sm,
                fontWeight: FontWeight.w600,
                color: Get.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            familyDatePickerWidget(
              datecontroller: datecontrollerMother,
              ontap: () =>
                  _presentDatePicker(_isFather = false, _isHusbandWife = false),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "Age*",
              style: blackStyle(context).copyWith(
                fontSize: 16.sm,
                fontWeight: FontWeight.w600,
                color: Get.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            CustomTextFields(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter Age";
                } else if (value != null && value.length >= 3) {
                  return "Please Enter Correct Age";
                } else
                  return null;
              },
              inputFormatters: [
                LengthLimitingTextInputFormatter(2),
                FilteringTextInputFormatter.allow(RegExp('[0-9]')),
              ],
              textCapitalization: TextCapitalization.none,
              txtinptype: TextInputType.number,
              errortext: "Enter  Age",
              hint: "Enter Age",
              controller: ageMother,
            ),

            const SizedBox(
              height: 40,
            ),
            Text(
              "Husband/Wife Name*",
              style: blackStyle(context).copyWith(
                fontSize: 16.sm,
                fontWeight: FontWeight.w600,
                color: Get.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            CustomTextFields(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter Husband/Wife Name";
                } else
                  return null;
              },
              txtinptype: TextInputType.name,
              inputFormatters: [
                LengthLimitingTextInputFormatter(20),
                FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
              ],
              textCapitalization: TextCapitalization.none,
              errortext: "Enter Name",
              hint: "Enter Name",
              controller: husbandwifename,
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "Occupation*",
              style: blackStyle(context).copyWith(
                fontSize: 16.sm,
                fontWeight: FontWeight.w600,
                color: Get.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            OccupationCustomDropDownOptions(
              controller: selectedOccupationHusbandWife,
              hinttext: "Select Occupation",
              ontap: () => _showOccupationPicker(
                  _isFather = false, _isHusbandWife = true),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "Date of Birth*",
              style: blackStyle(context).copyWith(
                fontSize: 16.sm,
                fontWeight: FontWeight.w600,
                color: Get.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            familyDatePickerWidget(
              datecontroller: datecontrollerHusbandWife,
              ontap: () =>
                  _presentDatePicker(_isFather = false, _isHusbandWife = true),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "Age*",
              style: blackStyle(context).copyWith(
                fontSize: 16.sm,
                fontWeight: FontWeight.w600,
                color: Get.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            CustomTextFields(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter Age";
                } else if (value != null && value.length >= 3) {
                  return "Please Enter Correct Age";
                } else
                  return null;
              },
              inputFormatters: [
                LengthLimitingTextInputFormatter(2),
                FilteringTextInputFormatter.allow(RegExp('[0-9]')),
              ],
              textCapitalization: TextCapitalization.none,
              txtinptype: TextInputType.number,
              errortext: "Enter Age",
              hint: "Enter Age",
              controller: ageHusbandWife,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Children*",
              style: blackStyle(context).copyWith(
                  fontSize: 16.sm,
                  fontWeight: FontWeight.w600,
                  color: Get.isDarkMode ? Colors.white : Colors.black),
            ),
            Row(
              children: [
                Radio<String>(
                    focusColor: const Color(0xFF008083),
                    activeColor: (const Color(0xFF008083)),
                    value: "yes",
                    groupValue: _selectedval,
                    onChanged: (value) {
                      setState(() {
                        if (_selectedval == "yes") {
                          _setChildren = 1;
                        } else {
                          _setChildren = 0;
                        }
                        _selectedval = value!;
                        print("value is $_selectedval");
                      });
                    }),
                const Text("Yes"),
                const SizedBox(
                  width: 10,
                ),
                Radio<String>(
                    focusColor: const Color(0xFF008083),
                    activeColor: (const Color(0xFF008083)),
                    value: "no",
                    groupValue: _selectedval,
                    onChanged: (value) {
                      setState(() {
                        if (_selectedval == "yes") {
                          _setChildren = 1;
                        } else {
                          _setChildren = 0;
                        }
                        _selectedval = value!;
                        print("value is $_selectedval");
                      });
                    }),
                const Text("No"),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                width: double.infinity,
                height: 60,
                child: CustomNextButton(
                  text: "Continue",
                  ontap: () {
                    UploadData();
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: ((context) =>
                    //             const AddIncomeAndExpenseDetails())));
                  },
                )),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    ));
  }
}

class OccupationCustomDropDownOptions extends StatelessWidget {
  const OccupationCustomDropDownOptions({
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please Enter Occupation";
        } else
          return null;
      },
    );
  }
}

class familyDatePickerWidget extends StatelessWidget {
  const familyDatePickerWidget({
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please Select Date of Birth";
        }
        return null;
      },
    );
  }
}
