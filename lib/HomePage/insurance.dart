// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:piadvisory/HomePage/UploadDocuments.dart';
import 'package:piadvisory/HomePage/tax-planning.dart';
import 'package:piadvisory/api/tax_planning/methods/insurance_premium_tax_planning_api_methods.dart';
import 'package:piadvisory/api/tax_planning/models/insurance_premium_tax_planning_model.dart';
import '../Common/CustomNextButton.dart';
import '../Common/app_bar.dart';
import '../Utils/textStyles.dart';
import '../api/tax_planning/models/documents_upload_tax_planning_model.dart';

class InsurancePremium extends StatefulWidget {
  const InsurancePremium({
    required this.userUploadedDocs,
    required this.userInsurancePremium,
    required this.userId,
    Key? key,
  }) : super(key: key);

  final InsurancePremiumTaxPlanningModel? userInsurancePremium;
  final DocumentsUploadTaxPlanningModel? userUploadedDocs;
  final int userId;

  @override
  State<InsurancePremium> createState() => _InsurancePremiumState();
}

class _InsurancePremiumState extends State<InsurancePremium> {
  bool isSeniorCitizen = false;
  var lifeInsuranceController = TextEditingController();
  var healthInsuranceController = TextEditingController();
  var preventiveHealthCheckUpController = TextEditingController();
  var parentsHealthInsuranceController = TextEditingController();
  var medicalExpenditureAmountController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool showSubmitBtn = true;
  bool showSubmitBtnLoader = false;

  @override
  void initState() {
    super.initState();
    if (widget.userInsurancePremium != null) {
      lifeInsuranceController.text = widget.userInsurancePremium!.lifeInsurance;
      healthInsuranceController.text =
          widget.userInsurancePremium!.healthInsurance;
      preventiveHealthCheckUpController.text =
          widget.userInsurancePremium!.preventiveHealthCheckup;
      parentsHealthInsuranceController.text =
          widget.userInsurancePremium!.parentsHealthInsurace;
      medicalExpenditureAmountController.text =
          widget.userInsurancePremium!.medicalExpenditureAmount;
      isSeniorCitizen =
          widget.userInsurancePremium!.areParentsSeniorCitizens == "0"
              ? false
              : true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Taxplanning()));
        return Future.value(false);
      },
      child: Scaffold(
        appBar: const CustomAppBar(
          titleTxt: "Insurance Premium",
          bottomtext: false,
          navigateToTaxPlanning: true,
        ),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25, top: 25),
                    child: Text("Annual Life & Health Insurance",
                        style: blackStyle(context).copyWith(
                            color:
                                Get.isDarkMode ? Colors.white : Colors.black)),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Life Insurance",
                              style: TextStyle(
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Color(0xFF6B6B6B),
                                  fontSize: 10),
                            ),
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: lifeInsuranceController,
                              cursorColor: Colors.grey,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter life insurance';
                                }
                                return null;
                              },
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                  helperText: '',
                                  hintText: 'Enter Details',
                                  hintStyle: TextStyle(
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.grey)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Health Insurance",
                              style: TextStyle(
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Color(0xFF6B6B6B),
                                  fontSize: 10),
                            ),
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: healthInsuranceController,
                              cursorColor: Colors.grey,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter health insurance';
                                }
                                return null;
                              },
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                  helperText: '',
                                  hintText: 'Enter Details',
                                  hintStyle: TextStyle(
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.grey)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Preventive Health Check-up",
                              style: TextStyle(
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Color(0xFF6B6B6B),
                                  fontSize: 10),
                            ),
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: preventiveHealthCheckUpController,
                              cursorColor: Colors.grey,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter preventive health check up';
                                }
                                return null;
                              },
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                  helperText: '',
                                  hintText: 'Enter Details',
                                  hintStyle: TextStyle(
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.grey)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Parents Health Insurance",
                              style: TextStyle(
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Color(0xFF6B6B6B),
                                  fontSize: 10),
                            ),
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: parentsHealthInsuranceController,
                              cursorColor: Colors.grey,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter parents health insurance';
                                }
                                return null;
                              },
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                  helperText: '',
                                  hintText: 'Enter Details',
                                  hintStyle: TextStyle(
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.grey)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 30),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("My Parents are Senior Citizen",
                            style: blackStyle(context).copyWith(
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.black)),
                        SizedBox(
                          child: FlutterSwitch(
                            width: 50.0,
                            height: 25.0,
                            toggleColor: Colors.white,
                            activeColor: const Color(0xFF008083),
                            inactiveColor: Colors.grey,
                            value: isSeniorCitizen,
                            onToggle: (val) {
                              setState(() {
                                isSeniorCitizen = val;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Medical Expenditure Amount",
                              style: TextStyle(
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Color(0xFF6B6B6B),
                                  fontSize: 10),
                            ),
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: medicalExpenditureAmountController,
                              cursorColor: Colors.grey,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter medical expenditure amount';
                                }
                                return null;
                              },
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                  helperText: '',
                                  hintText: 'Enter Details',
                                  hintStyle: TextStyle(
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.grey)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  StatefulBuilder(
                    builder: (context, setBtnState) {
                      return Column(
                        children: [
                          Visibility(
                            visible: showSubmitBtn,
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: CustomNextButton(
                                text: "Next Step",
                                ontap: () {
                                  if (formKey.currentState!.validate()) {
                                    setBtnState(
                                      () {
                                        showSubmitBtn = false;
                                        showSubmitBtnLoader = true;
                                      },
                                    );
                                    addInsuranceTaxPlanning(
                                      widget.userId.toString(),
                                      lifeInsuranceController.text,
                                      healthInsuranceController.text,
                                      preventiveHealthCheckUpController.text,
                                      parentsHealthInsuranceController.text,
                                      isSeniorCitizen ? "1" : "0",
                                      medicalExpenditureAmountController.text,
                                    ).then((isAdded) {
                                      setBtnState(
                                        () {
                                          showSubmitBtn = true;
                                          showSubmitBtnLoader = false;
                                        },
                                      );
                                      if (isAdded) {
                                        SystemChannels.textInput
                                            .invokeMethod('TextInput.hide');
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                duration: Duration(seconds: 1),
                                                content: Text("Done")));
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UploadDocuments(
                                                      uploadedDocs: widget
                                                          .userUploadedDocs,
                                                      userId: widget.userId,
                                                    )));
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text("Error")));
                                      }
                                    });
                                    // debugPrint(
                                    //     "Life Insurance: ${lifeInsuranceController.text}");
                                    // debugPrint(
                                    //     "Health Insurance: ${healthInsuranceController.text}");
                                    // debugPrint(
                                    //     "Preventative Health Checkup: ${preventiveHealthCheckUpController.text}");
                                    // debugPrint(
                                    //     "Parents Health Insurance: ${parentsHealthInsuranceController.text}");
                                    // debugPrint(
                                    //     "isParentsSeniorCitizen: $isSeniorCitizen");
                                    // debugPrint(
                                    //     "Medical Expenditure: ${medicalExpenditureAmountController.text}");
                                  }
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => const UploadDocuments()));
                                },
                              ),
                            ),
                          ),
                          Visibility(
                              visible: showSubmitBtnLoader,
                              child:
                                  Center(child: CircularProgressIndicator())),
                        ],
                      );
                    },
                  ),

                  // Container(
                  //   height: 50,
                  //   width: double.infinity,
                  //   padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  //   child: CustomNextButton(
                  //     text: "Next Step",
                  //     ontap: () {
                  //       if (formKey.currentState!.validate()) {
                  //         debugPrint(
                  //             "Life Insurance: ${lifeInsuranceController.text}");
                  //         debugPrint(
                  //             "Health Insurance: ${healthInsuranceController.text}");
                  //         debugPrint(
                  //             "Preventative Health Checkup: ${preventiveHealthCheckUpController.text}");
                  //         debugPrint(
                  //             "Parents Health Insurance: ${parentsHealthInsuranceController.text}");
                  //         debugPrint("isParentsSeniorCitizen: $isSeniorCitizen");
                  //         debugPrint(
                  //             "Medical Expenditure: ${medicalExpenditureAmountController.text}");
                  //       }
                  //       // Navigator.push(
                  //       //     context,
                  //       //     MaterialPageRoute(
                  //       //         builder: (context) => const UploadDocuments()));
                  //     },
                  //   ),
                  // ),

                  SizedBox(height: 82)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
