import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piadvisory/HomePage/insurance.dart';
import 'package:piadvisory/HomePage/tax-planning.dart';
import 'package:piadvisory/api/tax_planning/methods/investments_tax_planning_api_methods.dart';
import 'package:piadvisory/api/tax_planning/models/insurance_premium_tax_planning_model.dart';
import '../Common/CustomNextButton.dart';
import '../Common/app_bar.dart';
import '../Utils/textStyles.dart';
import '../api/tax_planning/models/documents_upload_tax_planning_model.dart';
import '../api/tax_planning/models/investments_tax_planning_model.dart';

class Invest extends StatefulWidget {
  const Invest({
    required this.userId,
    required this.userInvestments,
    required this.userInsurancePremium,
    required this.userUploadedDocs,
    Key? key,
  }) : super(key: key);

  final InvestmentsTaxPlanningModel? userInvestments;
  final InsurancePremiumTaxPlanningModel? userInsurancePremium;
  final DocumentsUploadTaxPlanningModel? userUploadedDocs;
  final int userId;

  @override
  State<Invest> createState() => _InvestState();
}

class _InvestState extends State<Invest> {
  var epfController = TextEditingController();
  var tutionFeesController = TextEditingController();
  var elssController = TextEditingController();
  var npsController = TextEditingController();
  var otherInvestmentsController = TextEditingController();

  var employersController = TextEditingController();
  var ownController = TextEditingController();

  var principalController = TextEditingController();
  var interestAmountController = TextEditingController();

  var educationController = TextEditingController();
  var depostInterestController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool showSubmitBtn = true;
  bool showSubmitBtnLoader = false;

  @override
  void initState() {
    super.initState();
    if (widget.userInvestments != null) {
      epfController.text = widget.userInvestments!.epfPpf;
      tutionFeesController.text = widget.userInvestments!.tutionFees;
      elssController.text = widget.userInvestments!.elss;
      npsController.text = widget.userInvestments!.nps;
      otherInvestmentsController.text =
          widget.userInvestments!.otherInvestments;
      employersController.text = widget.userInvestments!.employers;
      ownController.text = widget.userInvestments!.own;
      principalController.text = widget.userInvestments!.principalAmount;
      interestAmountController.text = widget.userInvestments!.interestAmount;
      educationController.text = widget.userInvestments!.educationLoanInterest;
      depostInterestController.text = widget.userInvestments!.depositsInterest;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Taxplanning()));
        return Future.value(false);
      },
      child: Scaffold(
        appBar: const CustomAppBar(
          titleTxt: "Investments",
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
                    padding: const EdgeInsets.only(bottom: 25, top: 15),
                    child: Text("Your Annual Tax Saving Investments",
                        style: blackStyle(context).copyWith(color: Get.isDarkMode? Colors.white: Colors.black)),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "EPF/PPF",
                              style: TextStyle(
                                color:Get.isDarkMode? Colors.white: Color(0xFF6B6B6B),
                                fontSize: 10,
                              ),
                            ),
                            TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: epfController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter EPF/PPF';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              cursorColor: Colors.grey,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                helperText: '',
                                hintText: 'Enter Amount',
                                hintStyle: TextStyle(
                                  color: Get.isDarkMode? Colors.white: Colors.grey
                                )
                              ),
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
                              "Tution Fees",
                              style: TextStyle(
                                  color:Get.isDarkMode? Colors.white: Color(0xFF6B6B6B), fontSize: 10),
                            ),
                            TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: tutionFeesController,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter tution fees';
                                }
                                return null;
                              },
                              cursorColor: Colors.grey,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                helperText: '',
                                hintText: 'Enter Amount',
                                hintStyle: TextStyle(
                                  color: Get.isDarkMode? Colors.white: Colors.grey
                                )
                              ),
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
                              "ELSS",
                              style: TextStyle(
                                  color:Get.isDarkMode? Colors.white: Color(0xFF6B6B6B), fontSize: 10),
                            ),
                            TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: elssController,
                              keyboardType: TextInputType.number,
                              cursorColor: Colors.grey,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter ELSS';
                                }
                                return null;
                              },
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                helperText: '',
                                hintText: 'Enter Amount',
                                 hintStyle: TextStyle(
                                  color: Get.isDarkMode? Colors.white: Colors.grey
                                )
                              ),
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
                              "NPS",
                              style: TextStyle(
                                  color:Get.isDarkMode? Colors.white: Color(0xFF6B6B6B), fontSize: 10),
                            ),
                            TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: npsController,
                              keyboardType: TextInputType.number,
                              cursorColor: Colors.grey,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter NPS';
                                }
                                return null;
                              },
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                helperText: '',
                                hintText: 'Enter Amount',
                                 hintStyle: TextStyle(
                                  color: Get.isDarkMode? Colors.white: Colors.grey
                                )
                              ),
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
                              "Other Investments",
                              style: TextStyle(
                                  color:Get.isDarkMode? Colors.white: Color(0xFF6B6B6B), fontSize: 10),
                            ),
                            TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: otherInvestmentsController,
                              keyboardType: TextInputType.number,
                              cursorColor: Colors.grey,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter other investments';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                helperText: '',
                                hintText: 'Enter Amount',
                                 hintStyle: TextStyle(
                                  color: Get.isDarkMode? Colors.white: Colors.grey
                                )
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25, top: 15),
                    child: Text("Pension Contributions: (if Applicable)",
                        style: blackStyle(context).copyWith(color: Get.isDarkMode? Colors.white: Colors.black)),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Employer's",
                              style: TextStyle(
                                  color:Get.isDarkMode? Colors.white: Color(0xFF6B6B6B), fontSize: 10),
                            ),
                            TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: employersController,
                              keyboardType: TextInputType.number,
                              cursorColor: Colors.grey,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter Employers';
                                }
                                return null;
                              },
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                helperText: '',
                                hintText: 'Enter Amount',
                                hintStyle: TextStyle(
                                  color: Get.isDarkMode? Colors.white: Colors.grey
                                )
                              ),
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
                              "Own",
                              style: TextStyle(
                                  color:Get.isDarkMode? Colors.white: Color(0xFF6B6B6B), fontSize: 10),
                            ),
                            TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: ownController,
                              keyboardType: TextInputType.number,
                              cursorColor: Colors.grey,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter own';
                                }
                                return null;
                              },
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                helperText: '',
                                hintText: 'Enter Amount',
                                hintStyle: TextStyle(
                                  color: Get.isDarkMode? Colors.white: Colors.grey
                                )
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25, top: 15),
                    child:
                        Text("Have Taken Home Loan?", style: blackStyle(context).copyWith(color: Get.isDarkMode? Colors.white: Colors.black)),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Principle Amount",
                              style: TextStyle(
                                  color:Get.isDarkMode? Colors.white: Color(0xFF6B6B6B), fontSize: 10),
                            ),
                            TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: principalController,
                              keyboardType: TextInputType.number,
                              cursorColor: Colors.grey,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter principal amount';
                                }
                                return null;
                              },
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                helperText: '',
                                hintText: 'Enter Amount',
                                hintStyle: TextStyle(
                                  color: Get.isDarkMode? Colors.white: Colors.grey
                                )
                              ),
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
                              "Interest Amount",
                              style: TextStyle(
                                  color:Get.isDarkMode? Colors.white: Color(0xFF6B6B6B), fontSize: 10),
                            ),
                            TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: interestAmountController,
                              keyboardType: TextInputType.number,
                              cursorColor: Colors.grey,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter interest amount';
                                }
                                return null;
                              },
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                helperText: '',
                                hintText: 'Enter Amount',
                                hintStyle: TextStyle(
                                  color: Get.isDarkMode? Colors.white: Colors.grey
                                )
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25, top: 15),
                    child: Text("All Interest", style: blackStyle(context).copyWith(color: Get.isDarkMode? Colors.white: Colors.black)),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Education loan Interest",
                              style: TextStyle(
                                  color:Get.isDarkMode? Colors.white: Color(0xFF6B6B6B), fontSize: 10),
                            ),
                            TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: educationController,
                              keyboardType: TextInputType.number,
                              cursorColor: Colors.grey,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter loan interest';
                                }
                                return null;
                              },
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                helperText: '',
                                hintText: 'Enter Amount',
                                hintStyle: TextStyle(
                                  color: Get.isDarkMode? Colors.white: Colors.grey
                                )
                              ),
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
                              "Interest from Deposits",
                              style: TextStyle(
                                  color:Get.isDarkMode? Colors.white: Color(0xFF6B6B6B), fontSize: 10),
                            ),
                            TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: depostInterestController,
                              keyboardType: TextInputType.number,
                              cursorColor: Colors.grey,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter deposits interest';
                                }
                                return null;
                              },
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                helperText: '',
                                hintText: 'Enter Amount',
                                hintStyle: TextStyle(
                                  color: Get.isDarkMode? Colors.white: Colors.grey
                                )
                              ),
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
                                    addInvestmentsTaxPlanning(
                                      widget.userId.toString(),
                                      epfController.text,
                                      tutionFeesController.text,
                                      elssController.text,
                                      npsController.text,
                                      otherInvestmentsController.text,
                                      employersController.text,
                                      ownController.text,
                                      principalController.text,
                                      interestAmountController.text,
                                      educationController.text,
                                      depostInterestController.text,
                                    ).then((isAdded) {
                                      setBtnState(
                                        () {
                                          showSubmitBtn = true;
                                          showSubmitBtnLoader = false;
                                        },
                                      );
                                      if (isAdded) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                                SnackBar(
                                                  duration : Duration(seconds: 1),
                                                  content: Text("Done")));
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    InsurancePremium(
                                                      userId: widget.userId,
                                                      userInsurancePremium: widget
                                                          .userInsurancePremium,
                                                      userUploadedDocs:
                                                          widget.userUploadedDocs,
                                                    )));
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                                SnackBar(content: Text("Error")));
                                      }
                                    });
                                    // debugPrint("EPF/PPF: ${epfController.text}");
                                    // debugPrint(
                                    //     "Tution Fees: ${tutionFeesController.text}");
                                    // debugPrint(
                                    //     "ELSS Fees: ${elssController.text}");
                                    // debugPrint("NPS Fees: ${npsController.text}");
                                    // debugPrint(
                                    //     "Other Investments Fees: ${otherInvestmentsController.text}");
                                    // debugPrint(
                                    //     "Employers: ${employersController.text}");
                                    // debugPrint("Own: ${ownController.text}");
                                    // debugPrint(
                                    //     "Principal: ${principalController.text}");
                                    // debugPrint(
                                    //     "Interest: ${interestAmountController.text}");
                                    // debugPrint(
                                    //     "Education: ${educationController.text}");
                                    // debugPrint(
                                    //     "Deposit: ${depostInterestController.text}");
                                  }
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => const InsurancePremium()));
                                },
                              ),
                            ),
                          ),
                          Visibility(
                              visible: showSubmitBtnLoader,
                              child: Center(child: CircularProgressIndicator())),
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
                  //         debugPrint("EPF/PPF: ${epfController.text}");
                  //         debugPrint("Tution Fees: ${tutionFeesController.text}");
                  //         debugPrint("ELSS Fees: ${elssController.text}");
                  //         debugPrint("NPS Fees: ${npsController.text}");
                  //         debugPrint(
                  //             "Other Investments Fees: ${otherInvestmentsController.text}");
                  //         debugPrint("Employers: ${employersController.text}");
                  //         debugPrint("Own: ${ownController.text}");
                  //         debugPrint("Principal: ${principalController.text}");
                  //         debugPrint(
                  //             "Interest: ${interestAmountController.text}");
                  //         debugPrint("Education: ${educationController.text}");
                  //         debugPrint("Deposit: ${depostInterestController.text}");
                  //       }
                  //       // Navigator.push(
                  //       //     context,
                  //       //     MaterialPageRoute(
                  //       //         builder: (context) => const InsurancePremium()));
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
