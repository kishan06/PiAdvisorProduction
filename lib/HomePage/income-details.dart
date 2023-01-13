// ignore_for_file: file_names, depend_on_referenced_packages

import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piadvisory/HomePage/investments.dart';
import 'package:piadvisory/HomePage/tax-planning.dart';
import 'package:piadvisory/Utils/textStyles.dart';
import 'package:piadvisory/api/tax_planning/methods/income_details_tax_planning_api_methods.dart';
import 'package:piadvisory/api/tax_planning/models/income_details_tax_planning_model.dart';

import '../Common/CustomNextButton.dart';
import '../Common/app_bar.dart';
import '../api/tax_planning/models/documents_upload_tax_planning_model.dart';
import '../api/tax_planning/models/insurance_premium_tax_planning_model.dart';
import '../api/tax_planning/models/investments_tax_planning_model.dart';

class Incomedetails extends StatefulWidget {
  const Incomedetails(
      {required this.userId,
      required this.incomeDetails,
      required this.userInvestments,
      required this.userInsurancePremium,
      required this.userUploadedDocs,
      Key? key})
      : super(key: key);

  final IncomeDetailsTaxPlanningModel? incomeDetails;
  final InvestmentsTaxPlanningModel? userInvestments;
  final InsurancePremiumTaxPlanningModel? userInsurancePremium;
  final DocumentsUploadTaxPlanningModel? userUploadedDocs;

  final int userId;

  @override
  State<Incomedetails> createState() => _IncomedetailsState();
}

class _IncomedetailsState extends State<Incomedetails> {
  bool isSalaried = false;
  var incomeController = TextEditingController();
  var rentController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool showSubmitBtn = true;
  bool showSubmitBtnLoader = false;

  @override
  void initState() {
    super.initState();
    if (widget.incomeDetails != null) {
      debugPrint("Income details: ${widget.incomeDetails}");
      isSalaried = widget.incomeDetails!.isSalaried == 0 ? false : true;
      incomeController.text = widget.incomeDetails!.allSourceIncome;
      rentController.text = widget.incomeDetails!.houseRentPayable;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Taxplanning()));
        return Future.value(false);
      },
      child: Scaffold(
        appBar: const CustomAppBar(
          titleTxt: "Income Details",
          bottomtext: false,
          navigateToTaxPlanning: true,
        ),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                       Text(
                        "Income from All Sources?*",
                        style: TextStyle(color:Get.isDarkMode?Colors.white: Colors.black, fontSize: 11),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.number,
                        controller: incomeController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter income from all sources';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          helperText: '',
                          hintText: "Enter Details",
                          hintStyle: blackStyle(context).copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color:Get.isDarkMode? Colors.white: Color(0xFF303030).withOpacity(0.3),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: TextButton(
                                onPressed: () {},
                                child:  Text(
                                  'F.Y. 2021 - 2022',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color:Get.isDarkMode? Colors.white: Color(0xFF444444),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Text(
                          "Are You Salaried?",
                          style: TextStyle(fontSize: 18, color:Get.isDarkMode? Colors.white: Colors.black),
                        ),
                        SizedBox(
                          child: FlutterSwitch(
                            width: 50.0,
                            height: 25.0,
                            toggleColor: Colors.white,
                            activeColor: const Color(0xFF008083),
                            inactiveColor: Colors.grey,
                            value: isSalaried,
                            onToggle: (val) {
                              setState(() {
                                isSalaried = val;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                       Text(
                        "House Rent Payable",
                        style: TextStyle(color:Get.isDarkMode? Colors.white: Colors.black, fontSize: 11),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: rentController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter house rent payable';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          helperText: '',
                          hintText: "Enter Details",
                          hintStyle: blackStyle(context).copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color:Get.isDarkMode? Colors.white: Color(0xFF303030).withOpacity(0.3),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 80,
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
                              child: CustomNextButton(
                                text: "Next Step",
                                ontap: () {
                                  if (formKey.currentState!.validate()) {
                                    debugPrint("widget.userId ${widget.userId}");
                                    debugPrint("isSalaried ${isSalaried}");
                                    debugPrint(
                                        "incomeController.text ${incomeController.text}");
                                    debugPrint(
                                        "rentController.text ${rentController.text}");
                                    setBtnState(
                                      () {
                                        showSubmitBtn = false;
                                        showSubmitBtnLoader = true;
                                      },
                                    );
                                    addIncomeDetailsTaxPlanning(
                                      widget.userId.toString(),
                                      incomeController.text,
                                      isSalaried ? "1" : "0",
                                      rentController.text,
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
                                            content: Text("Done"),
                                          ),
                                        );
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Invest(
                                              userId: widget.userId,
                                              userInvestments:
                                                  widget.userInvestments,
                                              userInsurancePremium:
                                                  widget.userInsurancePremium,
                                              userUploadedDocs:
                                                  widget.userUploadedDocs,
                                            ),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text("Error"),
                                          ),
                                        );
                                      }
                                    });
                                    // debugPrint(
                                    //     'INCOME: ${incomeController.text}');
                                    // debugPrint('IS SALARIED: $isSalaried');
                                    // debugPrint('RENT: ${rentController.text}');
                                  }
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => const Invest()));
                                },
                              ),
                            ),
                          ),
                          Visibility(
                            visible: showSubmitBtnLoader,
                            child: Center(child: CircularProgressIndicator()),
                          ),
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
