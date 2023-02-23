import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:piadvisory/Common/CustomNextButton.dart';
import 'package:piadvisory/Common/app_bar.dart';
import 'package:piadvisory/Profile/Assets/Assets.dart';
import 'package:piadvisory/Profile/Assets/AssetsRepository/assetsform.dart';
import 'package:piadvisory/Profile/ProfileMain.dart';
import 'package:piadvisory/Utils/base_manager.dart';
import 'package:piadvisory/Utils/textStyles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/Utils/Dialogs.dart';

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
  int FixId = 0;

  bool isValidInvestment(String investment) {
  final RegExp investmentExpression = RegExp(r"^0{3}$");
  
  return !investmentExpression.hasMatch(investment);
}

   bool isValidTenure(String tenure) {
  final RegExp tenureExpression = RegExp(r"^0{2}$");
  
  return !tenureExpression.hasMatch(tenure);
}

  @override
  void initState() {
    super.initState();
      setValues();
  }

    setValues() {
    if (args != null) {
      FixId = Get.arguments["id"];
      BankName.text = Get.arguments["bank_name"].toString();
      Ammount.text = Get.arguments["investment_amount"].toString();
      Annual.text = Get.arguments["annual_rate"].toString();
      datecontroller.text = Get.arguments["start_date"].toString();
      datecontroller2.text = Get.arguments["tenure"].toString();
    }
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

  // void _TenurepresentDatePicker() {
  //  DateTime now = DateTime.now();
  //   DateTime firstDate = now.add(Duration(days: 1));
  //   showDatePicker(
  //           context: context,
  //           initialDate: firstDate,
  //           firstDate: firstDate,
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

  void UploadData() async {
    // final isValid = _form.currentState?.validate();
    // if (isValid!) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? user_id = await prefs.getInt('user_id');
      replaceAssetsBtnWithLoader();
      Map<String, dynamic> updata = {
        "user_id": user_id,
        "bank_name": BankName.text,
        "investment_amount": Ammount.text,
        "annual_rate": Annual.text,
        "start_date": datecontroller.text,
        "tenure": datecontroller2.text
      };
      print(updata);
      final data = await StoreAssetsform().postStoreAssetsformFD(updata);
      if (data.status == ResponseStatus.SUCCESS) {
        utils.showToast("Fixed deposit Added!");
        replaceLoaderWithAssetsBtn();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Assets()));
      } else {
        replaceLoaderWithAssetsBtn();
        return utils.showToast(data.message);
      }
    //}
  }

    void editFixdeposit() async {
    replaceAssetsBtnWithLoader();
    Map<String, dynamic> updata = {
      "id": FixId,
      "bank_name": BankName.text,
      "investment_amount": Ammount.text,
      "annual_rate": Annual.text,
      "start_date": datecontroller.text,
      "tenure": datecontroller2.text
    };
    print("updats is $updata");
    final data = await StoreAssetsform().updateFixdeposit(updata);
    if (data.status == ResponseStatus.SUCCESS) {
      utils.showToast("Fixed deposit Added!");
      replaceLoaderWithAssetsBtn();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Assets()));
    } else {
       replaceLoaderWithAssetsBtn();
      return utils.showToast(data.message);
    }
  }

  bool isSaveBtnVisible = true;
  bool isSaveBtnLoaderVisible = false;

  void replaceAssetsBtnWithLoader() {
    setState(() {
      isSaveBtnVisible = false;
      isSaveBtnLoaderVisible = true;
    });
  }

  void replaceLoaderWithAssetsBtn() {
    setState(() {
      isSaveBtnVisible = true;
      isSaveBtnLoaderVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleTxt: "Fixed Deposit",
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
                          hintText: "Enter Bank/Institution name",
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
                         LengthLimitingTextInputFormatter(25),   
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter bank/institution name";
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
                            return "Please enter amount";
                          }else if (!isValidInvestment(value)) {
                            return 'Investment amount cannot contain zeros';
                          }
                          return null;
                        },
                        inputFormatters: [
                           LengthLimitingTextInputFormatter(12),
                          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                        ],
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
                            return "Please enter annual rate of interest";
                          }
                          return null;
                        },
                        inputFormatters: [
                           LengthLimitingTextInputFormatter(5),
                          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                        ],
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
                              return "Please select start date";
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
                        "Tenure*(In years)",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: datecontroller2,
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
                          hintText: "Enter Tenure in years",
                          helperText: "",
                          hintStyle: blackStyle(context).copyWith(
                              color: Get.isDarkMode
                                  ? Colors.white
                                  : const Color(0xFF6B6B6B),
                              fontSize: 14),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter tenure in years";
                          }else if (!isValidTenure(value)) {
                            return 'Tenure cannot contain zeros';
                          }
                          return null;
                        },
                        inputFormatters: [
                           LengthLimitingTextInputFormatter(3),
                          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                        ],
                      ),
                      // FixDEpositDatePicker(
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return "Please select tenure";
                      //     }
                      //     return null;
                      //   },
                      //   datecontroller: datecontroller2,
                      //   ontap: () => _TenurepresentDatePicker(),
                      //   hintText: "Select tenure",
                      // ),
                      SizedBox(
                        height: 50.h,
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
                              args != null ? editFixdeposit() : UploadData();
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
