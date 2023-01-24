// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piadvisory/HomePage/income-details.dart';
import 'package:piadvisory/api/tax_planning/methods/personal_info_tax_planning_api_methods.dart';
import 'package:piadvisory/api/tax_planning/models/personal_info_tax_planning_model.dart';

import '../Common/CustomNextButton.dart';
import '../Common/app_bar.dart';
import '../Utils/textStyles.dart';
import '../api/tax_planning/models/documents_upload_tax_planning_model.dart';
import '../api/tax_planning/models/income_details_tax_planning_model.dart';
import '../api/tax_planning/models/insurance_premium_tax_planning_model.dart';
import '../api/tax_planning/models/investments_tax_planning_model.dart';
import 'tax-planning.dart';

class Personalinfo extends StatefulWidget {
  const Personalinfo({
    required this.userId,
    required this.userPersonalInfo,
    required this.userIncomeDetails,
    required this.userInvestments,
    required this.userInsurancePremium,
    required this.userUploadedDocs,
    Key? key,
  }) : super(key: key);

  final int userId;
  final PersonalInfoTaxPlanningModel? userPersonalInfo;
  final IncomeDetailsTaxPlanningModel? userIncomeDetails;
  final InvestmentsTaxPlanningModel? userInvestments;
  final InsurancePremiumTaxPlanningModel? userInsurancePremium;
  final DocumentsUploadTaxPlanningModel? userUploadedDocs;

  @override
  State<Personalinfo> createState() => _PersonalinfoState();
}

class _PersonalinfoState extends State<Personalinfo> {
  final ageTextFieldController = TextEditingController();
  final maritialStatusController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool showSubmitBtn = true;
  bool showSubmitBtnLoader = false;

  @override
  void initState() {
    super.initState();
    if (widget.userPersonalInfo != null) {
      ageTextFieldController.text = widget.userPersonalInfo!.age.toString();
      maritialStatusController.text = widget.userPersonalInfo!.maritalStatus;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Taxplanning(),
            ));
        return Future.value(false);
      },
      child: Scaffold(
        appBar: const CustomAppBar(
          titleTxt: "Personal Information",
          bottomtext: false,
          navigateToTaxPlanning: true,
        ),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("What's your age?"),
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.number,
                              controller: ageTextFieldController,
                              cursorColor: Colors.grey,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                helperText: '',
                                hintText: 'Enter Details',
                                hintStyle: blackStyle(context).copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Color(0xFF303030).withOpacity(0.3),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter age';
                                } else if (value != null && value.length >= 3) {
                                  return "Please Enter Correct Age";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Maritial Status"),
                            StatefulBuilder(
                              builder: (context, setFieldState) {
                                return TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  onTap: () async {
                                    FocusScope.of(context).unfocus();
                                    final data =
                                        await showModalBottomSheet<dynamic>(
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 24),
                                          child: const Languagepicker(),
                                        );
                                      },
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Get.isDarkMode
                                                ? Colors.grey
                                                : Colors.white),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30),
                                        ),
                                      ),
                                      backgroundColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                    );

                                    if (data != null) {
                                      setFieldState(() {
                                        maritialStatusController.text = data;
                                      });
                                    }
                                  },
                                  readOnly: true,
                                  cursorColor: Colors.grey,
                                  style: const TextStyle(
                                    //color: Colors.grey,
                                    fontFamily: 'Product Sans',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  keyboardType: TextInputType.text,
                                  controller: maritialStatusController,
                                  decoration: InputDecoration(
                                    suffixIcon: Icon(
                                      Icons.keyboard_arrow_down,
                                    ),
                                    helperText: '',
                                    hintStyle: blackStyle(context).copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Get.isDarkMode
                                            ? Colors.white
                                            : Color(0xFF303030)
                                                .withOpacity(0.3)),
                                    // errorStyle: const TextStyle(
                                    //   fontSize: 16.0,
                                    // ),
                                    hintText: "Select Status",
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Select maritial status';
                                    }
                                    return null;
                                  },
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  StatefulBuilder(
                    builder: (context, setSubmitBtnState) {
                      return Column(
                        children: [
                          Visibility(
                            visible: showSubmitBtn,
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              child: CustomNextButton(
                                text: "Next Step",
                                ontap: () {
                                  if (formKey.currentState!.validate()) {
                                    setSubmitBtnState(
                                      () {
                                        showSubmitBtn = false;
                                        showSubmitBtnLoader = true;
                                      },
                                    );
                                    debugPrint(
                                        'AGE: ${ageTextFieldController.text}');
                                    debugPrint(
                                        'Maritial Status: ${maritialStatusController.text}');

                                    addPersonalInfoTaxPlanning(
                                            widget.userId,
                                            ageTextFieldController.text,
                                            maritialStatusController.text)
                                        .then((isAdded) {
                                      setSubmitBtnState(
                                        () {
                                          showSubmitBtn = true;
                                          showSubmitBtnLoader = false;
                                        },
                                      );
                                      if (isAdded) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                duration: Duration(seconds: 1),
                                                content: Text("Done")));
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Incomedetails(
                                                  userUploadedDocs:
                                                      widget.userUploadedDocs,
                                                  userId: widget.userId,
                                                  userInvestments:
                                                      widget.userInvestments,
                                                  userInsurancePremium: widget
                                                      .userInsurancePremium,
                                                  incomeDetails:
                                                      widget.userIncomeDetails),
                                            ));
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text("Error")));
                                      }
                                    });
                                  }
                                  /*
                                              Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Incomedetails()));
                                            */
                                },
                              ),
                            ),
                          ),
                          Visibility(
                            visible: showSubmitBtnLoader,
                            child: Center(child: CircularProgressIndicator()),
                          )
                        ],
                      );
                    },
                  ),
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
            child: Text("Select Status", style: blackStyle(context)),
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
                    Navigator.pop(context, "Widowed");
                  }),
                  title: const Text("Widowed"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Separated");
                  }),
                  title: const Text("Separated"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Divorced");
                  }),
                  title: const Text("Divorced"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Single");
                  }),
                  title: const Text("Single"),
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
