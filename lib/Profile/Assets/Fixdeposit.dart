import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:piadvisory/Common/CustomNextButton.dart';
import 'package:piadvisory/Common/app_bar.dart';
import 'package:piadvisory/Profile/ProfileMain.dart';
import 'package:piadvisory/Utils/textStyles.dart';

class FixDeposit extends StatefulWidget {
  const FixDeposit({super.key});

  @override
  State<FixDeposit> createState() => _FixDepositState();
}

class _FixDepositState extends State<FixDeposit> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController BankName = TextEditingController();
  TextEditingController Ammount = TextEditingController();
  TextEditingController Annual = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  TextEditingController datecontroller2 = TextEditingController();
  DateTime? _selectedDate;
  final args = Get.arguments;

  void _presentDatePicker() {
    // showDatePicker is a pre-made funtion of Flutter
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2099))
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

    void _TenurepresentDatePicker() {
    // showDatePicker is a pre-made funtion of Flutter
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2099))
        .then((pickedDate) {
      // Check if no date is selected
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
        datecontroller2.text =
            "${_selectedDate!.day.toString()}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.year.toString().padLeft(2, '0')}";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleTxt: "Fix Deposit",
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
                        "Enter Bank/Institution Name*",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.grey,
                        controller: BankName,
                        decoration: InputDecoration(
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: Color(0xFF303030))),
                          hintText: "Bank/Institution Name",
                          helperText: "",
                          hintStyle: blackStyle(context).copyWith(
                            color: Get.isDarkMode
                                ? Colors.white
                                : const Color(0xFF6B6B6B),
                            fontSize: 14,
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp('[a-zA-Z ]')),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter Bank/Institution Name";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Text(
                        "Investment Amount*",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: Ammount,
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                          // prefixIcon: Text(
                          //   "₹",
                          //   style: TextStyle(color: Colors.black, fontSize: 18),
                          // ),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: Color(0xFF303030))),
                          hintText: " ₹ Enter Amount",
                          helperText: "",
                          hintStyle: blackStyle(context).copyWith(
                              color: Get.isDarkMode
                                  ? Colors.white
                                  : const Color(0xFF6B6B6B),
                              fontSize: 14),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter Amount";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Text(
                        "Annual Rate of Interest* (In %)",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: Annual,
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                          // prefixIcon: Text(
                          //   "₹",
                          //   style: TextStyle(color: Colors.black, fontSize: 18),
                          // ),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: Color(0xFF303030))),
                          hintText: "Enter Annual Rate of Interest in %",
                          helperText: "",
                          hintStyle: blackStyle(context).copyWith(
                              color: Get.isDarkMode
                                  ? Colors.white
                                  : const Color(0xFF6B6B6B),
                              fontSize: 14),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter Annual Rate of Interest";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Text(
                        "Start Date*",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      FixDEpositDatePicker(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Select Start Date";
                            }
                            return null;
                          },
                          datecontroller: datecontroller,
                          ontap: () => _presentDatePicker(),
                          hintText: "Select Start Date"),
                      SizedBox(
                        height: 30.h,
                      ),
                      Text(
                        "Tenure*",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      FixDEpositDatePicker(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Select Tenure";
                          }
                          return null;
                        },
                        datecontroller: datecontroller2,
                        ontap: () => _TenurepresentDatePicker(),
                        hintText: "Select Tenure",
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 60.h,
                        child: CustomNextButton(
                          text: "Save",
                          ontap: () {
                            final isValid = _form.currentState?.validate();
                            if (isValid!) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfileMain()));
                              //args ! = null ? editGoal() : UploadData();
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}

class FixDEpositDatePicker extends StatelessWidget {
  const FixDEpositDatePicker({
    Key? key,
    required this.datecontroller,
    required this.ontap,
    this.validator,
    this.hintText,
  }) : super(key: key);

  final TextEditingController datecontroller;
  final GestureTapCallback ontap;
  final dynamic validator;
  final String? hintText;

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
