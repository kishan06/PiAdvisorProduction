// ignore_for_file: file_names

import 'package:another_flushbar/flushbar.dart';
import 'package:get/get.dart';
import 'package:piadvisory/Common/ThankYouPage.dart';
import 'package:piadvisory/Profile/KYC/KYCthankyou.dart';
import 'package:piadvisory/Profile/KYC/Repository/storebasicaddincome.dart';
import 'package:piadvisory/Utils/base_manager.dart';

import '/Common/CustomNextButton.dart';
import '/Profile/BankDetails.dart';
import '/Profile/KYC/SchduleAppointment.dart';
import '/Profile/KYC/SelectTimeAndDate.dart';
import '/Profile/ProfileMain.dart';
import '/Utils/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/Utils/Dialogs.dart';
import '../../Common/app_bar.dart';

class AddIncomeAndExpenseDetails extends StatefulWidget {
  const AddIncomeAndExpenseDetails({Key? key}) : super(key: key);

  @override
  State<AddIncomeAndExpenseDetails> createState() =>
      _AddIncomeAndExpenseDetailsState();
}

class _AddIncomeAndExpenseDetailsState
    extends State<AddIncomeAndExpenseDetails> {
  bool checkedValue = false;
  bool termplan = false;
  bool ulip = false;
  bool mediclaim = false;
  bool general = false;
  bool guaranteedincome = false;
  bool pensionplan = false;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController income = TextEditingController();
  TextEditingController expense = TextEditingController();
  //TextEditingController assetsliabilities = TextEditingController();
  TextEditingController assets = TextEditingController();
  TextEditingController liabilities = TextEditingController();

  late final Future? myFuture;

  @override
  void initState() {
    super.initState();
    setControllerValues();
  }

  void UploadData() async {
    final isValid = _form.currentState?.validate();
    if (isValid!) {
      Map<String, dynamic> updata = {
        "Income": income.text,
        "Expense": expense.text,
        "Assets": assets.text,
        "Liabilities": liabilities.text,
        "Term_Plan": termplan,
        "UILP": ulip,
        "Mediclaim": mediclaim,
        "General": general,
        "Guaranteed_Income": guaranteedincome,
        "Pension_plan": pensionplan,
      };
      final data = await StorebasicaddincomeDetails()
          .postStorebasicaddincomeDetails(updata);
      if (data.status == ResponseStatus.SUCCESS) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ProfileMain()));
        utils.showToast("Income and Expense added successfully");
      } else {
        return utils.showToast(data.message);
      }
    }
  }

  setControllerValues() {
    income.text = addincomeDetails?.user?.income ?? "";
    expense.text = addincomeDetails?.user?.expense ?? "";
    assets.text = addincomeDetails?.user?.assets ?? "";
    liabilities.text = addincomeDetails?.user?.liabilities ?? "";
    termplan = addincomeDetails?.user?.termPlan == 1 ? true : false;
    ulip = addincomeDetails?.user?.uILP == 1 ? true : false;
    mediclaim = addincomeDetails?.user?.mediclaim == 1 ? true : false;
    general = addincomeDetails?.user?.general == 1 ? true : false;
    guaranteedincome =
        addincomeDetails?.user?.guaranteedIncome == 1 ? true : false;
    pensionplan = addincomeDetails?.user?.pensionPlan == 1 ? true : false;
  }

  @override
  void dispose() {
    // income.dispose();
    // expense.dispose();
    // assets.dispose();
    // liabilities.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
            titleTxt: "Add Income & Expenses Details", bottomtext: false),
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
        );
  }

  Widget _buildBody(context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Form(
              key: _form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 35,
                  ),
                  Text(
                    "Income - Salary, Business, Post office MIS, Pension, Others",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  CustomTextFields(
                    hint: "Enter Details",
                    controller: income,
                    errortext: "Enter Income",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter Income";
                      } else
                        return null;
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Expenses - Rent, Medical, Household exp, Vacations, Parties",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  CustomTextFields(
                    hint: "Enter Details",
                    controller: expense,
                    errortext: "Enter Expenses",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter Expenses";
                      } else
                        return null;
                    },
                  ),
                  //  SizedBox(
                  //   height: 40,
                  // ),
                  // Text(
                  //   "Add Assets & Liabilities",
                  //   style: Theme.of(context).textTheme.headline2,
                  // ),
                  //  CustomTextFields(
                  //   hint: "Enter Details",
                  //   controller: assetsliabilities,
                  // ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Assets - Equity, Debt, Gold, Liquid invest., Real estate (self-occupied/rented)",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  CustomTextFields(
                    hint: "Enter Details",
                    controller: assets,
                    errortext: "Enter Assets",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter Assets";
                      } else
                        return null;
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Liabilities - Housing, Credit card, All types of Loans",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  CustomTextFields(
                    hint: "Enter Details",
                    controller: liabilities,
                    errortext: "Enter Liabilities",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter Liabilities";
                      } else
                        return null;
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Existing Insurance (If any)",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Transform.scale(
                scale: 1,
                child: Theme(
                  data: ThemeData(
                    unselectedWidgetColor: Color(0xFFF78104),
                  ),
                  child: Checkbox(
                    activeColor: Colors.amber,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2))),
                    value: termplan,
                    onChanged: (bool? value) {
                      setState(() {
                        termplan = value!;
                      });
                    },
                  ),
                ),
              ),
              Text(
                "Term Plan",
                style: blackStyle(context).copyWith(
                  fontSize: 14,
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Transform.scale(
                scale: 1,
                child: Theme(
                  data: ThemeData(
                    unselectedWidgetColor: Color(0xFFF78104),
                  ),
                  child: Checkbox(
                    activeColor: Colors.amber,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2))),
                    value: ulip,
                    onChanged: (bool? value) {
                      setState(() {
                        ulip = value!;
                      });
                    },
                  ),
                ),
              ),
              Text(
                "ULIP",
                style: blackStyle(context).copyWith(
                  fontSize: 14,
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Transform.scale(
                scale: 1,
                child: Theme(
                  data: ThemeData(
                    unselectedWidgetColor: Color(0xFFF78104),
                  ),
                  child: Checkbox(
                    activeColor: Colors.amber,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2))),
                    value: mediclaim,
                    onChanged: (bool? value) {
                      setState(() {
                        mediclaim = value!;
                      });
                    },
                  ),
                ),
              ),
              Text(
                "Mediclaim",
                style: blackStyle(context).copyWith(
                  fontSize: 14,
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Transform.scale(
                scale: 1,
                child: Theme(
                  data: ThemeData(
                    unselectedWidgetColor: Color(0xFFF78104),
                  ),
                  child: Checkbox(
                    activeColor: Colors.amber,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2))),
                    value: general,
                    onChanged: (bool? value) {
                      setState(() {
                        general = value!;
                      });
                    },
                  ),
                ),
              ),
              Text(
                "General",
                style: blackStyle(context).copyWith(
                  fontSize: 14,
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Transform.scale(
                scale: 1,
                child: Theme(
                  data: ThemeData(
                    unselectedWidgetColor: Color(0xFFF78104),
                  ),
                  child: Checkbox(
                    activeColor: Colors.amber,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2))),
                    value: guaranteedincome,
                    onChanged: (bool? value) {
                      setState(() {
                        guaranteedincome = value!;
                      });
                    },
                  ),
                ),
              ),
              Text(
                "Guaranteed Income",
                style: blackStyle(context).copyWith(
                  fontSize: 14,
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Transform.scale(
                scale: 1,
                child: Theme(
                  data: ThemeData(
                    unselectedWidgetColor: Color(0xFFF78104),
                  ),
                  child: Checkbox(
                    activeColor: Colors.amber,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2))),
                    value: pensionplan,
                    onChanged: (bool? value) {
                      setState(() {
                        pensionplan = value!;
                      });
                    },
                  ),
                ),
              ),
              Text(
                "Pension Plan",
                style: blackStyle(context).copyWith(
                  fontSize: 14,
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 60,
                    child: CustomNextButton(
                      colorchange: true,
                      text: "Book An Advisor",
                      ontap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => SchduleAppointment())));
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: SizedBox(
                    height: 60,
                    child: CustomNextButton(
                      text: "Save",
                      ontap: () {
                        UploadData();
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: ((context) => const ProfileMain())));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
