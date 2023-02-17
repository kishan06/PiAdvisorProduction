// ignore_for_file: file_names

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:piadvisory/Common/StreamEnum.dart';
import 'package:piadvisory/Profile/KYC/LoadingPageCKYCCheck.dart';
import 'package:piadvisory/Profile/KYC/LoadingPageKRACheck.dart';
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
  final selectedSourceWealth = TextEditingController();
  final selectedIncomeSlab = TextEditingController();
  final selectedAccounttype = TextEditingController();
  final selectedDividend = TextEditingController();
  final selectedTaxstatus = TextEditingController();
  final selectedResidentialStatus = TextEditingController();
  final selectedLifeExpectancy = TextEditingController();
  final selectedgender = TextEditingController();

  DateTime? _selectedDate;
  late final Future? myFuture;
  StreamController<requestResponseState> kycmainController =
      StreamController.broadcast();

  String? taxcode;
  String? taxstatus;

  @override
  void initState() {
    super.initState();
    getKYCDetails();
  }

  bool isValidPhoneNumber(String phoneNumber) {
    final RegExp phoneNumberExpression = RegExp(r"^0{10}$");

    return !phoneNumberExpression.hasMatch(phoneNumber);
  }

  bool isValidPanNumber(String phoneNumber) {
    final RegExp panNumberExpression = RegExp(r"^0{10}$");

    return !panNumberExpression.hasMatch(phoneNumber);
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
        var currentTime = DateTime.now();
        agecontroller.text =
            (currentTime.year - _selectedDate!.year).toString();
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
        _storePanAndDob();
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => LoadingPageKRACheck()));
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => const KYCDigiLocker()));
      } else {
        replaceLoaderWithKycBtn();
        return utils.showToast(data.message);
      }
    }
  }

  void UploadFatca() async {
    globalEmailID = emailid.text;
    //final isValid = _form.currentState?.validate();
    //if (isValid!) {
    replaceKycBtnWithLoader();
    Map<String, dynamic> updata = {
      // "full_name": fullname.text,
      // "address": address.text,
      // "email": emailid.text,
      // "pan_number": pannumber.text,
      // "DOB": datecontroller.text,
      // "mob_number": mobilecontroller.text,
      // "age": agecontroller.text,
      // "occupation": selectedOccupation.text,
      // "gender": selectedgender.text,
      // "residential_status": selectedResidentialStatus.text
      "tax_status": taxcode
    };
    final data =
        await StorebasickycuserDetails().postStorebasickycfatcadetails(updata);
    if (data.status == ResponseStatus.SUCCESS) {
      print(updata);
      replaceLoaderWithKycBtn();
      _storePanAndDob();
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => LoadingPageKRACheck()));
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => const KYCDigiLocker()));
    } else {
      replaceLoaderWithKycBtn();
      return utils.showToast(data.message);
    }
    // }
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
          height: 400.h,
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

  Future _showSourceWealthPicker() async {
    FocusScope.of(context).unfocus();
    final data = await showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          height: 400.h,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: const SourceWealthPicker(),
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
        selectedSourceWealth.text = data;
      });
    }
  }

  Future _showIncomeWealth() async {
    FocusScope.of(context).unfocus();
    final data = await showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          height: 400.h,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: const IncomeSlab(),
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
        selectedIncomeSlab.text = data;
      });
    }
  }

  Future _showAccountPicker() async {
    FocusScope.of(context).unfocus();
    final data = await showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: const Accounttype());
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
        selectedAccounttype.text = data;
      });
    }
  }

  Future _showDividendPicker() async {
    FocusScope.of(context).unfocus();
    final data = await showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: const Dividend());
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
        selectedDividend.text = data;
      });
    }
  }

  Future _showTaxstausPicker() async {
    FocusScope.of(context).unfocus();
    final data = await showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
            height: 300.h,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: const Taxstaus());
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
        selectedTaxstatus.text = data;
      });
    }
  }

  setTaxCode_TaxCategory(String selectedTaxstatus) {
    switch (selectedTaxstatus) {
      case "Individual":
        {
          taxcode = "01";
          taxstatus = "Individual";
        }
        break;

      case "On Behalf Of Minor":
        {
          taxcode = "02";
          taxstatus = "On Behalf Of Minor";
        }
        break;

      case "HUF":
        {
          taxcode = "03";
          taxstatus = "HUF";
        }
        break;

      case "Company":
        {
          taxcode = "04";
          taxstatus = "Company";
        }
        break;

      case "AOP/BOI":
        {
          taxcode = "05";
          taxstatus = "AOP/BOI";
        }
        break;

      case "Partnership Firm":
        {
          taxcode = "06";
          taxstatus = "Partnership Firm";
        }
        break;

      case "Body Corporate":
        {
          taxcode = "07";
          taxstatus = "Body Corporate";
        }
        break;

      case "Trust":
        {
          taxcode = "08";
          taxstatus = "Trust";
        }
        break;

      case "Society":
        {
          taxcode = "09";
          taxstatus = "Society";
        }
        break;

      case "Others":
        {
          taxcode = "10";
          taxstatus = "Others";
        }
        break;

      case "NRI-Others":
        {
          taxcode = "11";
          taxstatus = "NRI-Others";
        }
        break;

      case "Banks / Financial Institution":
        {
          taxcode = "12";
          taxstatus = "Banks / Financial Institution";
        }
        break;

      case "Sole Proprietorship":
        {
          taxcode = "13";
          taxstatus = "Sole Proprietorship";
        }
        break;

      case "Banks":
        {
          taxcode = "14";
          taxstatus = "Banks";
        }
        break;

      case "Association of Persons":
        {
          taxcode = "15";
          taxstatus = "Association of Persons";
        }
        break;

      case "NRI - NRE (Repatriation)":
        {
          taxcode = "21";
          taxstatus = "NRI - NRE (Repatriation)";
        }
        break;

      case "Overseas Corporate body":
        {
          taxcode = "22";
          taxstatus = "Overseas Corporate body";
        }
        break;

      case "Foreign Institutional Investor":
        {
          taxcode = "23";
          taxstatus = "Foreign Institutional Investor";
        }
        break;

      case "NRI - NRO [Non Repatriation]":
        {
          taxcode = "24";
          taxstatus = "NRI - NRO [Non Repatriation]";
        }
        break;

      case "Overseas Corporate Body-Others":
        {
          taxcode = "25";
          taxstatus = "Overseas Corporate Body-Others";
        }
        break;

      case "NRI - Minor (NRE)":
        {
          taxcode = "26";
          taxstatus = "NRI - Minor (NRE)";
        }
        break;

      default:
        {
          taxcode = null;
          taxstatus = null;
        }
        break;
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
  TextEditingController placeBirth = TextEditingController();

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

  _storePanAndDob() {
    Map<String, dynamic> pandobmap = {
      "pan_no": pannumber.text,
      "dob": datecontroller.text
    };
    Database().storePanAndDob(pandobmap);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        titleTxt: "KYC",
        bottomtext: false,
      ),
      body: // _buildBody(context)
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
                } else if (!isValidPanNumber(value)) {
                  return 'Pan number cannot contain 10 zeros';
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
                } else if (!isValidPhoneNumber(value)) {
                  return 'Phone number cannot contain 10 zeros';
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
              style: Theme.of(context).textTheme.displayMedium,
              // blackStyle(context).copyWith(
              //   fontSize: 16.sp,
              //   fontWeight: FontWeight.w600,
              // ),
            ),
            CustomTextFields(
              readOnly: true,
              textCapitalization: TextCapitalization.none,
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
            // CustomTextFields(
            //   textCapitalization: TextCapitalization.none,
            //   inputFormatters: [
            //     LengthLimitingTextInputFormatter(20),
            //     FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
            //   ],
            //   validator: (value) {
            //     if (value == null || value.isEmpty) {
            //       return "Please Enter Occupation";
            //     } else
            //       return null;
            //   },
            //   errortext: "Enter Occupation",
            //   hint: "Enter Occupation",
            //   controller: selectedOccupation,
            // ),
            CustomDropDownOptions(
              controller: selectedOccupation,
              ontap: () => _showOccupationPicker(),
              hinttext: "Select Occupation",
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "Source of Wealth*",
              style: Theme.of(context).textTheme.headline2,
              // blackStyle(context).copyWith(
              //   fontSize: 16.sp,
              //   fontWeight: FontWeight.w600,
              // ),
            ),
            CustomDropDownOptions(
              controller: selectedSourceWealth,
              ontap: () => _showSourceWealthPicker(),
              hinttext: "Select Source of Wealth",
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "Place Of Birth*",
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
                  return "Please Enter Place Of Birth";
                } else
                  return null;
              },
              errortext: "Enter Place Of Birth",
              hint: "Enter Place Of Birth",
              controller: placeBirth,
            ),
            SizedBox(
              height: 40.h,
            ),
            Text(
              "Income Slab*",
              style: Theme.of(context).textTheme.headline2,
              // blackStyle(context).copyWith(
              //   fontSize: 16.sp,
              //   fontWeight: FontWeight.w600,
              // ),
            ),
            CustomDropDownOptions(
              controller: selectedIncomeSlab,
              ontap: () => _showIncomeWealth(),
              hinttext: "Select Income Slab",
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "Account Type*",
              style: Theme.of(context).textTheme.headline2,
              // blackStyle(context).copyWith(
              //   fontSize: 16.sp,
              //   fontWeight: FontWeight.w600,
              // ),
            ),
            CustomDropDownOptions(
              controller: selectedAccounttype,
              ontap: () => _showAccountPicker(),
              hinttext: "Select Account Type",
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "Dividend Paymode*",
              style: Theme.of(context).textTheme.headline2,
              // blackStyle(context).copyWith(
              //   fontSize: 16.sp,
              //   fontWeight: FontWeight.w600,
              // ),
            ),
            CustomDropDownOptions(
              controller: selectedDividend,
              ontap: () => _showDividendPicker(),
              hinttext: "Select Dividend Paymode",
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "Tax Status*",
              style: Theme.of(context).textTheme.headline2,
            ),
            CustomDropDownOptions(
              hinttext: "Select Tax Status",
              ontap: () => _showTaxstausPicker(),
              controller: selectedTaxstatus,
            ),
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
                    UploadFatca();
                    // setTaxCode_TaxCategory(selectedTaxstatus.text);
                    print(taxcode);
                    print(taxstatus);
                    //UploadData();
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
      this.readOnly,
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
  final bool? readOnly;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly ?? false,
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
    return Scrollbar(
      thumbVisibility: true,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: Text("Select an Occupation",
                  style: Theme.of(context).textTheme.displayMedium),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                children: [
                  ListTile(
                    onTap: (() {
                      Navigator.pop(context, "Business");
                    }),
                    title: const Text("Bussiness"),
                  ),
                  ListTile(
                    onTap: (() {
                      Navigator.pop(context, "Service");
                    }),
                    title: const Text("Service"),
                  ),
                  ListTile(
                    onTap: (() {
                      Navigator.pop(context, "Professional");
                    }),
                    title: const Text("Professional"),
                  ),
                  ListTile(
                    onTap: (() {
                      Navigator.pop(context, "Agriculturist");
                    }),
                    title: const Text("Agriculturist"),
                  ),
                  ListTile(
                    onTap: (() {
                      Navigator.pop(context, "Retired");
                    }),
                    title: const Text("Retired"),
                  ),
                  ListTile(
                    onTap: (() {
                      Navigator.pop(context, "Housewife");
                    }),
                    title: const Text("Housewife"),
                  ),
                  ListTile(
                    onTap: (() {
                      Navigator.pop(context, "Student");
                    }),
                    title: const Text("Student"),
                  ),
                  ListTile(
                    onTap: (() {
                      Navigator.pop(context, "Others");
                    }),
                    title: const Text("Others"),
                  ),
                  ListTile(
                    onTap: (() {
                      Navigator.pop(context, "Doctor");
                    }),
                    title: const Text("Doctor"),
                  ),
                  ListTile(
                    onTap: (() {
                      Navigator.pop(context, "Private Sector Service");
                    }),
                    title: const Text("Private Sector Service"),
                  ),
                  ListTile(
                    onTap: (() {
                      Navigator.pop(context, "Public Sector Service");
                    }),
                    title: const Text("Public Sector Service"),
                  ),
                  ListTile(
                    onTap: (() {
                      Navigator.pop(context, "Forex Dealer");
                    }),
                    title: const Text("Forex Dealer"),
                  ),
                  ListTile(
                    onTap: (() {
                      Navigator.pop(context, "Government Service");
                    }),
                    title: const Text("Government Service"),
                  ),
                  ListTile(
                    onTap: (() {
                      Navigator.pop(context, "Unknown / Not Applicable");
                    }),
                    title: const Text("Unknown / Not Applicable"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class SourceWealthPicker extends StatefulWidget {
  const SourceWealthPicker({Key? key}) : super(key: key);

  @override
  State<SourceWealthPicker> createState() => _SourceWealthPickerState();
}

class _SourceWealthPickerState extends State<SourceWealthPicker> {
  //final ScrollController _OcscrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: Text("Select Source of Wealth",
                  style: Theme.of(context).textTheme.displayMedium),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                children: [
                  ListTile(
                    onTap: (() {
                      Navigator.pop(context, "Salary");
                    }),
                    title: const Text("Salary"),
                  ),
                  ListTile(
                    onTap: (() {
                      Navigator.pop(context, "Business Income");
                    }),
                    title: const Text("Business Income"),
                  ),
                  ListTile(
                    onTap: (() {
                      Navigator.pop(context, "Gift");
                    }),
                    title: const Text("Gift"),
                  ),
                  ListTile(
                    onTap: (() {
                      Navigator.pop(context, "Ancestral Property");
                    }),
                    title: const Text("Ancestral Property"),
                  ),
                  ListTile(
                    onTap: (() {
                      Navigator.pop(context, "Rental Income");
                    }),
                    title: const Text("Rental Income"),
                  ),
                  ListTile(
                    onTap: (() {
                      Navigator.pop(context, "Prize Money");
                    }),
                    title: const Text("Prize Money"),
                  ),
                  ListTile(
                    onTap: (() {
                      Navigator.pop(context, "Royalty");
                    }),
                    title: const Text("Royalty"),
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
      ),
    );
  }
}

class IncomeSlab extends StatefulWidget {
  const IncomeSlab({Key? key}) : super(key: key);

  @override
  State<IncomeSlab> createState() => _IncomeSlabState();
}

class _IncomeSlabState extends State<IncomeSlab> {
  //final ScrollController _OcscrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: Text("Select Apllicant Income",
                  style: Theme.of(context).textTheme.displayMedium),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                children: [
                  ListTile(
                    onTap: (() {
                      Navigator.pop(context, "Below 1 Lakh");
                    }),
                    title: const Text("Below 1 Lakh"),
                  ),
                  ListTile(
                    onTap: (() {
                      Navigator.pop(context, "Between 1 to 5 Lacs");
                    }),
                    title: const Text("Between 1 to 5 Lacs"),
                  ),
                  ListTile(
                    onTap: (() {
                      Navigator.pop(context, "Between 5 to 10 Lacs");
                    }),
                    title: const Text("Between 5 to 10 Lacs"),
                  ),
                  ListTile(
                    onTap: (() {
                      Navigator.pop(context, "Between 10 to 25 Lacs");
                    }),
                    title: const Text("Between 10 to 25 Lacs"),
                  ),
                  ListTile(
                    onTap: (() {
                      Navigator.pop(context, "25 lacs to 1 Crore");
                    }),
                    title: const Text("25 lacs to 1 Crore"),
                  ),
                  ListTile(
                    onTap: (() {
                      Navigator.pop(context, "Above 1 Crore");
                    }),
                    title: const Text("Above 1 Crore"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class Accounttype extends StatefulWidget {
  const Accounttype({Key? key}) : super(key: key);

  @override
  State<Accounttype> createState() => _AccounttypeState();
}

class _AccounttypeState extends State<Accounttype> {
  //final ScrollController _OcscrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Text("Select Account Type",
                style: Theme.of(context).textTheme.displayMedium),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Savings Bank");
                  }),
                  title: const Text("Savings Bank"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Current Bank");
                  }),
                  title: const Text("Current Bank"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "NRE");
                  }),
                  title: const Text("NRE"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "NRO");
                  }),
                  title: const Text("NRO"),
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

class Dividend extends StatefulWidget {
  const Dividend({Key? key}) : super(key: key);

  @override
  State<Dividend> createState() => _DividendState();
}

class _DividendState extends State<Dividend> {
  //final ScrollController _OcscrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Text("Select Dividend Paymode",
                style: Theme.of(context).textTheme.displayMedium),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Cheque");
                  }),
                  title: const Text("Cheque"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Direct Credit");
                  }),
                  title: const Text("Direct Credit"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "ECS");
                  }),
                  title: const Text("ECS"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "NEFT");
                  }),
                  title: const Text("NEFT"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "RTGS");
                  }),
                  title: const Text("RTGS"),
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

class Taxstaus extends StatefulWidget {
  const Taxstaus({Key? key}) : super(key: key);

  @override
  State<Taxstaus> createState() => _TaxstausState();
}

class _TaxstausState extends State<Taxstaus> {
  //final ScrollController _OcscrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: Text("Select Tax Status",
                  style: Theme.of(context).textTheme.displayMedium),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                children: [
                  ListTile(
                    onTap: (() {
                      Navigator.pop(context, "Individual");
                    }),
                    title: const Text("Individual"),
                  ),
                  ListTile(
                    onTap: (() {
                      Navigator.pop(context, "On Behalf Of Minor");
                    }),
                    title: const Text("On Behalf Of Minor"),
                  ),
                  ListTile(
                    onTap: (() {
                      Navigator.pop(context, "HUF");
                    }),
                    title: const Text("HUF"),
                  ),
                  ListTile(
                    onTap: (() {
                      Navigator.pop(context, "Company");
                    }),
                    title: const Text("Company"),
                  ),
                  ListTile(
                    onTap: (() {
                      Navigator.pop(context, "AOP/BOI");
                    }),
                    title: const Text("AOP/BOI"),
                  ),
                  ListTile(
                    onTap: (() {
                      Navigator.pop(context, "Partnership Firm");
                    }),
                    title: const Text("Partnership Firm"),
                  ),
                  ListTile(
                    onTap: (() {
                      Navigator.pop(context, "Body Corporate");
                    }),
                    title: const Text("Body Corporate"),
                  ),
                  ListTile(
                    onTap: (() {
                      Navigator.pop(context, "Trust");
                    }),
                    title: const Text("Trust"),
                  ),
                  ListTile(
                    onTap: (() {
                      Navigator.pop(context, "Society");
                    }),
                    title: const Text("Society"),
                  ),
                  ListTile(
                    onTap: (() {
                      Navigator.pop(context, "Others");
                    }),
                    title: const Text("Others"),
                  ),
                  ListTile(
                    onTap: (() {
                      Navigator.pop(context, "NRI-Others");
                    }),
                    title: const Text("NRI-Others"),
                  ),
                  ListTile(
                    onTap: (() {
                      Navigator.pop(context, "Banks / Financial Institution");
                    }),
                    title: const Text("Banks / Financial Institution"),
                  ),
                  ListTile(
                    onTap: (() {
                      Navigator.pop(context, "Sole Proprietorship");
                    }),
                    title: const Text("Sole Proprietorship"),
                  ),
                  ListTile(
                    onTap: (() {
                      Navigator.pop(context, "Banks");
                    }),
                    title: const Text("Banks"),
                  ),
                  ListTile(
                    onTap: (() {
                      Navigator.pop(context, "Association of Persons");
                    }),
                    title: const Text("Association of Persons"),
                  ),
                  ListTile(
                    onTap: (() {
                      Navigator.pop(context, "NRI - NRE (Repatriation)");
                    }),
                    title: const Text("NRI - NRE (Repatriation)"),
                  ),
                  ListTile(
                    onTap: (() {
                      Navigator.pop(context, "Overseas Corporate body");
                    }),
                    title: const Text("Overseas Corporate body"),
                  ),
                  ListTile(
                    onTap: (() {
                      Navigator.pop(context, "Foreign Institutional Investor");
                    }),
                    title: const Text("Foreign Institutional Investor"),
                  ),
                  ListTile(
                    onTap: (() {
                      Navigator.pop(context, "NRI - NRO [Non Repatriation]");
                    }),
                    title: const Text("NRI - NRO [Non Repatriation]"),
                  ),
                  ListTile(
                    onTap: (() {
                      Navigator.pop(context, "Overseas Corporate Body-Others");
                    }),
                    title: const Text("Overseas Corporate Body-Others"),
                  ),
                  ListTile(
                    onTap: (() {
                      Navigator.pop(context, "NRI - Minor (NRE)");
                    }),
                    title: const Text("NRI - Minor (NRE)"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
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
