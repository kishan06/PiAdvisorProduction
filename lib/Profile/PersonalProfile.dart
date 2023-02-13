// ignore_for_file: file_names, non_constant_identifier_names

import 'package:csc_picker/csc_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:piadvisory/Profile/Personalprofilerepository/Model/personalprofilebasicdetails.dart';
import 'package:piadvisory/Profile/Personalprofilerepository/storePersonalprofile.dart';
import 'package:piadvisory/Utils/base_manager.dart';
import 'package:piadvisory/Utils/database.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '/Common/CustomNextButton.dart';
import '/Common/app_bar.dart';
import '/Profile/KYC/KYCMain.dart';
import '/Profile/ProfileMain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//mport 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piadvisory/Common/app_bar.dart';
import 'package:piadvisory/Profile/KYC/KYCMain.dart';
import '../../Utils/textStyles.dart';
import '/Utils/Dialogs.dart';

class PersonalProfile extends StatefulWidget {
  const PersonalProfile({Key? key}) : super(key: key);

  @override
  State<PersonalProfile> createState() => _PersonalProfileState();
}

class _PersonalProfileState extends State<PersonalProfile> {
  bool _isEmailValid = false;
  final RoundedLoadingButtonController _btnController1 =
      RoundedLoadingButtonController();
  final selectedOccupation = TextEditingController();
  final selectedResidentialStatus = "Select Residential Status";
  final selectedcity = TextEditingController();
  final selectedstate = TextEditingController();
  DateTime? _selectedDate;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController address = TextEditingController();
  TextEditingController address2 = TextEditingController();
  TextEditingController FullName = TextEditingController();
  TextEditingController mobilenumber = TextEditingController();
  TextEditingController emailid = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController aadharnumber = TextEditingController();
  TextEditingController pannumber = TextEditingController();
  String? cityValue = "";
  String? stateValue = "";
  late final Future? myFuture;

  @override
  void initState() {
    super.initState();
    setControllerValues();
  }

  // onEmailChange(String email) {
  //   setState(() {
  //     final emailRegEx = RegExp(
  //         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  //     if (emailRegEx.hasMatch(email)) _isEmailValid = true;
  //   });
  // }
  @override
  void dispose() {
    // FullName.dispose();
    // emailid.dispose();
    // address.dispose();
    // datecontroller.dispose();
    // mobilenumber.dispose();
    // address.dispose();
    // selectedOccupation.dispose();
    // pincode.dispose();
    // aadharnumber.dispose();
    // pannumber.dispose();
    // selectedOccupation.dispose();

    // print("disposed used");
    super.dispose();
  }

  void _presentDatePicker() {
    // showDatePicker is a pre-made funtion of Flutter
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1922),
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

  void UploadData() async {
    final isValid = _form.currentState?.validate();
    if (isValid! &&
        stateValue != null &&
        stateValue!.isNotEmpty &&
        cityValue != null &&
        cityValue!.isNotEmpty &&
        stateValue! != "Select State*" &&
        cityValue! != "Select City*") {
      print("api calling now");
      replacePersonalProfileBtnWithLoader();
      Map<String, dynamic> updata = {
        "fullname": FullName.text,
        "mob_number": mobilenumber.text,
        "email_id": emailid.text,
        "dob": datecontroller.text,
        "occupation": selectedOccupation.text,
        "address": address.text,
        // "Enter Address": address2.text,
        "city": cityValue,
        "state": stateValue,
        "pincode": pincode.text,
        "aadhar_number": aadharnumber.text,
        "pan_number": pannumber.text,
      };
      final data =
          await StorePersonalprofile().postStorePersonalprofile(updata);
      if (data.status == ResponseStatus.SUCCESS) {
        replaceLoaderWithPersonalProfileBtn();
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ProfileMain()));
      } else {
        replaceLoaderWithPersonalProfileBtn();
        return utils.showToast(data.message);
      }
    } else {
      return utils.showToast("Please fill all fields");
    }
  }

  bool isPersonalprofileBtnVisible = true;
  bool isPersonalprofileBtnLoaderVisible = false;

  void replacePersonalProfileBtnWithLoader() {
    setState(() {
      isPersonalprofileBtnVisible = false;
      isPersonalprofileBtnLoaderVisible = true;
    });
  }

  void replaceLoaderWithPersonalProfileBtn() {
    setState(() {
      isPersonalprofileBtnVisible = true;
      isPersonalprofileBtnLoaderVisible = false;
    });
  }

 bool isValidPhoneNumber(String phoneNumber) {
  final RegExp phoneNumberExpression = RegExp(r"^0{10}$");
  
  return !phoneNumberExpression.hasMatch(phoneNumber);
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
        selectedOccupation.text = data;
      });
    }
  }

  Future _showCityPicker() async {
    FocusScope.of(context).unfocus();
    final data = await showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: const CityPicker(),
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
        selectedcity.text = data;
      });
    }
  }

  Future _showStatePicker() async {
    FocusScope.of(context).unfocus();
    final data = await showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: const StatePicker(),
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
        selectedstate.text = data;
      });
    }
  }

  setControllerValues() {
    Map<String, dynamic> userdata = Database().restoreUserDetails();
    FullName.text = userdata['fullname'];
    emailid.text = userdata['email'];
    mobilenumber.text = userdata['number'].toString();
    datecontroller.text = personalprofileDetails?.user?.dob ?? "";
    selectedOccupation.text = personalprofileDetails?.user?.occupation ?? "";
    address.text = personalprofileDetails?.user?.address ?? "";
    cityValue = personalprofileDetails?.user?.city ?? "";
    stateValue = personalprofileDetails?.user?.state ?? "";
    pincode.text = personalprofileDetails?.user?.pincode ?? "";
    aadharnumber.text = personalprofileDetails?.user?.aadharNumber ?? "";
    pannumber.text = personalprofileDetails?.user?.panNumber ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            const CustomAppBar(titleTxt: "Personal Profile", bottomtext: false),
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
        //       // setControllerValues();
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
              "Full Name*",
              style: blackStyle(context).copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Get.isDarkMode ? Colors.white : Colors.black),
            ),
            CustomTextFields(
              textCapitalization: TextCapitalization.none,
              inputFormatters: [
                LengthLimitingTextInputFormatter(20),
                FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
              ],
              errortext: "Enter Full Name",
              hint: "Enter Full Name",
              controller: FullName,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter Full Name ";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "Mobile Number*",
              style: blackStyle(context).copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Get.isDarkMode ? Colors.white : Colors.black),
            ),

            CustomTextFields(
              textCapitalization: TextCapitalization.none,
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.allow(RegExp('[0-9]')),
              ],
              txtinptype: TextInputType.number,
              errortext: "Enter Mobile Number",
              hint: "Enter Mobile Number",
              controller: mobilenumber,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter Mobile Number";
                } else if (value.length != 10) {
                  return "Please Enter Valid Mobile Number";
                } else if (!isValidPhoneNumber(value)) {
                            return 'Phone number cannot contain 10 zeros';
                          }
                return null;
              },
            ),

            // CustomTextFields(
            //   txtinptype: TextInputType.number,
            //   errortext: "Enter Mobile Number",
            //   hint: "Enter Mobile Number",
            //   controller: mobilenumber,

            //  ),

            const SizedBox(
              height: 40,
            ),
            Text(
              "Email ID*",
              style: blackStyle(context).copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Get.isDarkMode ? Colors.white : Colors.black),
            ),
            TextFormField(
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
                  color: Get.isDarkMode
                      ? Colors.white
                      : Color(0xFF303030).withOpacity(0.3),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Color(0xFF303030))),
              ),
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
              onSaved: (value) {},
              onChanged: (value) {
                //  onEmailChange(value);
              },
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "Date of Birth*",
              style: blackStyle(context).copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Get.isDarkMode ? Colors.white : Colors.black),
            ),
            ProfileDatePickerWidget(
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
              "Occupation*",
              style: blackStyle(context).copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Get.isDarkMode ? Colors.white : Colors.black),
            ),
            CustomOccupationDropDownOptions(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Select Occupattion";
                }
                return null;
              },
              controller: selectedOccupation,
              hinttext: "Select Occupation",
              ontap: () => _showOccupationPicker(),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "Address*",
              style: blackStyle(context).copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Get.isDarkMode ? Colors.white : Colors.black),
            ),
            CustomTextFields(
              textCapitalization: TextCapitalization.none,
              limitlength: 30,
              errortext: "Enter Address",
              hint: "Enter Address",
              controller: address,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter Address";
                } else
                  return null;
              },
            ),
            // const SizedBox(
            //   height: 20,
            // ),
            // CustomTextFields(
            //   limitlength: 30,
            //   errortext: "Enter Address",
            //   hint: "Enter Address",
            //   controller: address2,
            // ),
            const SizedBox(
              height: 40,
            ),
            CSCPicker(
              layout: Layout.vertical,
              disableCountry: true,
              showStates: true,
              showCities: true,
              currentState: stateValue,
              currentCity: cityValue,
              flagState: CountryFlag.DISABLE,
              defaultCountry: DefaultCountry.India,
              dropdownDecoration: BoxDecoration(
                // borderRadius: BorderRadius.all(Radius.circular(2)),
                color: Get.isDarkMode ? Colors.grey : Colors.white,
                border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.grey),
                ),
                //border: Border.all(color: Colors.grey.shade300, width: 1)
              ),
              disabledDropdownDecoration: BoxDecoration(
                // borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Get.isDarkMode ? Colors.grey : Colors.white,
                border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.grey),
                ),
                //border: Border.all(color: Colors.grey.shade300, width: 1)
              ),
              //countrySearchPlaceholder: "Country",
              stateSearchPlaceholder: "State",
              citySearchPlaceholder: "City",
              //countryDropdownLabel: "*Country",
              stateDropdownLabel: stateValue ??  "Select State*",
              cityDropdownLabel: cityValue ?? "Select City*",
              selectedItemStyle: TextStyle(
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold),
              dropdownHeadingStyle: TextStyle(
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
              dropdownItemStyle: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
              dropdownDialogRadius: 10.0,
              searchBarRadius: 10.0,
              onStateChanged: (value) {
                setState(() {
                  ///store value in city variable
                  stateValue = value;
                });
              },
              onCityChanged: (value) {
                setState(() {
                  ///store value in city variable
                  cityValue = value;
                });
              },
            ),
            // CustomDropDownOptions(
            //   controller: selectedcity,
            //   hinttext: "Select City",
            //   ontap: () => _showCityPicker(),
            // ),
            // const SizedBox(
            //   height: 40,
            // ),
            // CustomDropDownOptions(
            //   controller: selectedstate,
            //   hinttext: "Select State",
            //   ontap: () => _showStatePicker(),
            // ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "Pincode*",
              style: blackStyle(context).copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Get.isDarkMode ? Colors.white : Colors.black),
            ),
            CustomTextFields(
              textCapitalization: TextCapitalization.none,
              inputFormatters: [
                LengthLimitingTextInputFormatter(6),
                FilteringTextInputFormatter.allow(RegExp('[0-9]')),
              ],
              txtinptype: TextInputType.number,
              errortext: "Enter  Pincode",
              hint: "Enter Pincode",
              controller: pincode,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter Pincode";
                } else if (value.length != 6) {
                  return "Please Enter Valid Pincode";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "Aadhaar Number*",
              style: blackStyle(context).copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Get.isDarkMode ? Colors.white : Colors.black),
            ),
            CustomTextFields(
              textCapitalization: TextCapitalization.none,
              inputFormatters: [
                LengthLimitingTextInputFormatter(12),
                FilteringTextInputFormatter.allow(RegExp('[0-9]')),
              ],
              txtinptype: TextInputType.number,
              errortext: "Enter  Aadhaar Number",
              hint: "Enter Aadhaar Number",
              controller: aadharnumber,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter Aadhaar Number";
                } else if (value.length != 12) {
                  return "Please Enter Valid Aadhaar Number";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "PAN Number*",
              style: blackStyle(context).copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Get.isDarkMode ? Colors.white : Colors.black),
            ),
            CustomTextFields(
              textCapitalization: TextCapitalization.characters,
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.allow(RegExp('[A-Z,0-9]')),
              ],
              errortext: "Enter PAN Number",
              hint: "Enter PAN Number",
              controller: pannumber,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter PAN Number";
                } else if (value.length != 10) {
                  return "Please Enter Valid PAN Number";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 40,
            ),
            Visibility(
              visible: isPersonalprofileBtnVisible,
              child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfileMain()));
                    },

                    //  RoundedLoadingButton(
                    //   height: 60,
                    //   resetAfterDuration: true,
                    //   resetDuration: Duration(seconds: 5),
                    //   width: MediaQuery.of(context).size.width * 1,
                    //   color: const Color.fromRGBO(247, 129, 4, 1),
                    //   successColor: const Color.fromRGBO(247, 129, 4, 1),
                    //   controller: _btnController1,
                    //   onPressed: () {
                    //     UploadData();
                    //   },
                    //   valueColor: Colors.black,
                    //   borderRadius: 10,
                    //   child: Text(
                    //     "Save",
                    //     style: TextStyle(
                    //       color: Color(0xFFFFFFFF),
                    //       fontSize: 20,
                    //       fontFamily: 'Productsans',
                    //     ),
                    //   ),
                    // ),
                    child: SizedBox(
                      width: double.infinity,
                      child: CustomNextButton(
                          text: "Save",
                          ontap: () {
                            // if (stateValue == null ||
                            //     cityValue == null ) {
                            //   return utils.showToast("Please fill all fields");
                            // }
                            UploadData();
                          }

                          //=> UploadData(),
                          ),
                    ),
                  )),
            ),
            Visibility(
                visible: isPersonalprofileBtnLoaderVisible,
                child: Center(child: CircularProgressIndicator())),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    ));
  }
}

class CityPicker extends StatefulWidget {
  const CityPicker({Key? key}) : super(key: key);

  @override
  State<CityPicker> createState() => _CityPickerState();
}

class _CityPickerState extends State<CityPicker> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Text("Select City", style: blackStyle(context)),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Mumbai ");
                  }),
                  title: const Text("Mumbai"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Thane");
                  }),
                  title: const Text("Thane"),
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

class StatePicker extends StatefulWidget {
  const StatePicker({Key? key}) : super(key: key);

  @override
  State<StatePicker> createState() => _StatePickerState();
}

class _StatePickerState extends State<StatePicker> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Text("Select State", style: blackStyle(context)),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Maharashtra ");
                  }),
                  title: const Text("Maharashtra"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Gujrat");
                  }),
                  title: const Text("Gujrat"),
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

class CustomOccupationDropDownOptions extends StatelessWidget {
  const CustomOccupationDropDownOptions(
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

class ProfileDatePickerWidget extends StatelessWidget {
  const ProfileDatePickerWidget(
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
