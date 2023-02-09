import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:piadvisory/Common/CustomNextButton.dart';
import 'package:piadvisory/Common/app_bar.dart';
import 'package:piadvisory/Profile/Liabilities/LiabilitiesRepository/liabilitiesform.dart';
import 'package:piadvisory/Profile/ProfileMain.dart';
import 'package:piadvisory/Utils/base_manager.dart';
import 'package:piadvisory/Utils/textStyles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/Utils/Dialogs.dart';

class CarLoan extends StatefulWidget {
  const CarLoan({super.key});

  @override
  State<CarLoan> createState() => _CarLoanState();
}

class _CarLoanState extends State<CarLoan> {
  TextEditingController Frequency = TextEditingController();
  TextEditingController InstallmentAmount = TextEditingController();
  TextEditingController Interest = TextEditingController();
  TextEditingController LoanAmmount = TextEditingController();
  //TextEditingController datecontroller2 = TextEditingController();
  TextEditingController TenureMonths = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  bool isSaveBtnLoaderVisible = false;
  bool isSaveBtnVisible = true;

  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  DateTime? _selectedDate;

  final args = Get.arguments;
  int carid = 0;

  @override
  void initState() {
    super.initState();
    setValues();
  }

  setValues() {
    if (args != null) {
      carid = Get.arguments["id"];
      LoanAmmount.text = Get.arguments["total_loan"].toString();
      datecontroller.text = Get.arguments["loan_issued_on"].toString();
      TenureMonths.text = Get.arguments["loan_tenure"].toString();
      InstallmentAmount.text = Get.arguments["installment_amount"].toString();
      Frequency.text = Get.arguments["frequency_payment"].toString();
      Interest.text = Get.arguments["rate_of_interest"].toString();
    }
  }

  void UploadData() async {
    //final isValid = _form.currentState?.validate();
    // if (isValid!) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? user_id = await prefs.getInt('user_id');
    replaceLiabilitiesBtnWithLoader();
    Map<String, dynamic> updata = {
      "user_id": user_id,
      "total_loan": LoanAmmount.text,
      "loan_issued_on": datecontroller.text,
      "loan_tenure": TenureMonths.text,
      "installment_amount": InstallmentAmount.text,
      "frequency_payment": Frequency.text,
      "rate_of_interest": Interest.text
    };

    final data =
        await StoreLiabilitiesform().postStoreLiabilitiesformCL(updata);
    if (data.status == ResponseStatus.SUCCESS) {
      replaceLoaderWithLiabilitiesBtn();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ProfileMain()));
    } else {
      replaceLoaderWithLiabilitiesBtn();
      return utils.showToast(data.message);
    }
    // }
  }

  void editCarloan() async {
    replaceLiabilitiesBtnWithLoader();
    Map<String, dynamic> updata = {
      "id": carid,
      "total_loan": LoanAmmount.text,
      "loan_issued_on": datecontroller.text,
      "loan_tenure": TenureMonths.text,
      "installment_amount": InstallmentAmount.text,
      "frequency_payment": Frequency.text,
      "rate_of_interest": Interest.text
    };
    print("updats is $updata");
    final data = await StoreLiabilitiesform().updateCarloan(updata);
    if (data.status == ResponseStatus.SUCCESS) {
      utils.showToast("Personal loan Added!");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ProfileMain()));
    } else {
      replaceLoaderWithLiabilitiesBtn();
      return utils.showToast(data.message);
    }
  }

  void replaceLiabilitiesBtnWithLoader() {
    setState(() {
      isSaveBtnVisible = false;
      isSaveBtnLoaderVisible = true;
    });
  }

  void replaceLoaderWithLiabilitiesBtn() {
    setState(() {
      isSaveBtnVisible = true;
      isSaveBtnLoaderVisible = false;
    });
  }

  void _presentpastDatePicker() {
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

  //   void _tenureDatePicker() {
  //   // showDatePicker is a pre-made funtion of Flutter
  //   showDatePicker(
  //           context: context,
  //           initialDate: DateTime.now(),
  //           firstDate: DateTime(1922),
  //           lastDate: DateTime(2099))
  //       .then((pickedDate) {
  //     // Check if no date is selected
  //     if (pickedDate == null) {
  //       return;
  //     }
  //     setState(() {
  //       _selectedDate = pickedDate;
  //       datecontroller2.text =
  //           "${_selectedDate!.day.toString()}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.year.toString().padLeft(2, '0')}";
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleTxt: "Car Loan",
        bottomtext: false,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _form,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 49.h,
                    ),
                    Text(
                      "Total Loan Amount*",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: LoanAmmount,
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        // prefixIcon: Text(
                        //   "₹",
                        //   style: TextStyle(color: Colors.black, fontSize: 18),
                        // ),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Color(0xFF303030))),
                        hintText: " ₹ Enter loan amount",
                        helperText: "",
                        hintStyle: blackStyle(context).copyWith(
                            color: Get.isDarkMode
                                ? Colors.white
                                : const Color(0xFF6B6B6B),
                            fontSize: 14),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter loan amount";
                        }
                        return null;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      "Loan Issued on*",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    CarLoanDatePicker(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please select loan issued on";
                        }
                        return null;
                      },
                      datecontroller: datecontroller,
                      ontap: () => _presentpastDatePicker(),
                      hintText: "Select loan Issued on",
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      "Loan Tenure in months*",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: TenureMonths,
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        // prefixIcon: Text(
                        //   "₹",
                        //   style: TextStyle(color: Colors.black, fontSize: 18),
                        // ),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Color(0xFF303030))),
                        hintText: "Enter Tenure in months",
                        helperText: "",
                        hintStyle: blackStyle(context).copyWith(
                            color: Get.isDarkMode
                                ? Colors.white
                                : const Color(0xFF6B6B6B),
                            fontSize: 14),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter tenure in months";
                        }
                        return null;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      ],
                    ),
                    // HomeLoanDatePicker(
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return "Please Select Loan Issued on";
                    //     }
                    //     return null;
                    //   },
                    //   datecontroller: datecontroller2,
                    //   ontap: () => _tenureDatePicker(),
                    //   hintText: "Select Loan Issued on",
                    // ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      "Installment Amount*",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: InstallmentAmount,
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        // prefixIcon: Text(
                        //   "₹",
                        //   style: TextStyle(color: Colors.black, fontSize: 18),
                        // ),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Color(0xFF303030))),
                        hintText: " ₹ Enter Installment amount",
                        helperText: "",
                        hintStyle: blackStyle(context).copyWith(
                            color: Get.isDarkMode
                                ? Colors.white
                                : const Color(0xFF6B6B6B),
                            fontSize: 14),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter installment amount";
                        }
                        return null;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      "Frequency of payment* (In %)",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: Frequency,
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Color(0xFF303030))),
                        hintText: "Enter Frequency of payment in %",
                        helperText: "",
                        hintStyle: blackStyle(context).copyWith(
                            color: Get.isDarkMode
                                ? Colors.white
                                : const Color(0xFF6B6B6B),
                            fontSize: 14),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter frequency of payment";
                        }
                        return null;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      "Rate of Interest*",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: Interest,
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Color(0xFF303030))),
                        hintText: "Enter Rate of interest",
                        helperText: "",
                        hintStyle: blackStyle(context).copyWith(
                            color: Get.isDarkMode
                                ? Colors.white
                                : const Color(0xFF6B6B6B),
                            fontSize: 14),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter rate of interest";
                        }
                        return null;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      ],
                    ),
                    SizedBox(
                      height: 70.h,
                    ),
                    Visibility(
                      visible: isSaveBtnVisible,
                      child: SizedBox(
                        width: double.infinity,
                        height: 60.h,
                        child: CustomNextButton(
                          text: "Save",
                          ontap: () {
                            //UploadData();
                            final isValid = _form.currentState?.validate();
                            if (isValid!) {
                              args != null ? editCarloan() : UploadData();
                            }
                          },
                        ),
                      ),
                    ),
                    Visibility(
                        visible: isSaveBtnLoaderVisible,
                        child: Center(child: CircularProgressIndicator())),
                    SizedBox(
                      height: 30.h,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CarLoanDatePicker extends StatelessWidget {
  const CarLoanDatePicker({
    Key? key,
    required this.datecontroller,
    required this.ontap,
    this.validator,
    this.hintText,
  }) : super(key: key);

  final TextEditingController datecontroller;
  final String? hintText;
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
        helperText: "",
        hintStyle:
            // Theme.of(context).textTheme.headline3,
            blackStyle(context).copyWith(
                fontSize: 14.sm,
                fontWeight: FontWeight.w400,
                color: Get.isDarkMode ? Colors.white : Colors.grey),
        hintText: hintText,
      ),
    );
  }
}
