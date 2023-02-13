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
import 'package:piadvisory/Profile/GoalsRepository/storeGoals.dart';
import 'package:piadvisory/Profile/ProfileMain.dart';
import 'package:piadvisory/Utils/base_manager.dart';
import 'package:piadvisory/Utils/textStyles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/Utils/Dialogs.dart';

class Mutualfund extends StatefulWidget {
  const Mutualfund({super.key});

  @override
  State<Mutualfund> createState() => _MutualfundState();
}

class _MutualfundState extends State<Mutualfund> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController SchemeName = TextEditingController();
  TextEditingController Ammount = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  TextEditingController Current = TextEditingController();
  DateTime? _selectedDate;

  final args = Get.arguments;
  int mutualId = 0;

   bool isValidInvestment(String investment) {
  final RegExp investmentExpression = RegExp(r"^0{3}$");
  
  return !investmentExpression.hasMatch(investment);
}

  bool isValidCurrent(String current) {
  final RegExp currentExpression = RegExp(r"^0{3}$");
  
  return !currentExpression.hasMatch(current);
}

@override
  void initState() {
    super.initState();
     setValues();
  }

    setValues() {
    if (args != null) {
      mutualId = Get.arguments["id"];
      SchemeName.text = Get.arguments["scheme_name"].toString();
      Ammount.text = Get.arguments["investment_amount"].toString();
      datecontroller.text = Get.arguments["date_of_investment"].toString();
      Current.text = Get.arguments["current_value"].toString();
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

  void UploadData() async {
    // final isValid = _form.currentState?.validate();
    // if (isValid!) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? user_id = await prefs.getInt('user_id');
      replaceAssetsBtnWithLoader();
      Map<String, dynamic> updata = {
        "user_id": user_id,
        "scheme_name": SchemeName.text,
        "investment_amount": Ammount.text,
        "date_of_investment": datecontroller.text,
        "current_value": Current.text
      };
      print(updata);
      final data = await StoreAssetsform().postStoreAssetsformMF(updata);
      if (data.status == ResponseStatus.SUCCESS) {
        utils.showToast("Mutual funds Added!");
        replaceLoaderWithAssetsBtn();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Assets()));    
      } else {
        replaceLoaderWithAssetsBtn();
        return utils.showToast(data.message);
      }
   // }
  }

    void editMutualfunds() async {
    replaceAssetsBtnWithLoader();
    Map<String, dynamic> updata = {
      "id": mutualId,
      "scheme_name": SchemeName.text,
      "investment_amount": Ammount.text,
      "date_of_investment": datecontroller.text,
      "current_value": Current.text
    };
    print("updats is $updata");
    final data = await StoreAssetsform().updateMutualfund(updata);
    if (data.status == ResponseStatus.SUCCESS) {
      utils.showToast("Mutual funds Added!");
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
        titleTxt: "Mutual Fund",
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
                        "Scheme Name*",
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
                        controller: SchemeName,
                        decoration: InputDecoration(
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: Color(0xFF303030))),
                          hintText: "Scheme Name",
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
                          LengthLimitingTextInputFormatter(20
                          ),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter scheme name";
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
                            return "Please enter investment amount";
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
                        "Date of Investment*",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      MutualDatePicker(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Select Date of Investment";
                          }
                          return null;
                        },
                        datecontroller: datecontroller,
                        ontap: () => _presentDatePicker(),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Text(
                        "Current Value*",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.grey,
                        controller: Current,
                        decoration: InputDecoration(
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: Color(0xFF303030))),
                          hintText: "Enter Current Value",
                          helperText: "",
                          hintStyle: blackStyle(context).copyWith(
                            color: Get.isDarkMode
                                ? Colors.white
                                : const Color(0xFF6B6B6B),
                            fontSize: 14,
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          LengthLimitingTextInputFormatter(12),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter current value";
                          }else if (!isValidCurrent(value)) {
                            return 'Current value cannot contain zeros';
                          }
                          return null;
                        },
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
                                args != null ? editMutualfunds() : UploadData();
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

class MutualDatePicker extends StatelessWidget {
  const MutualDatePicker(
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
          helperText: "",
          hintStyle:
              // Theme.of(context).textTheme.headline3,
              blackStyle(context).copyWith(
                  fontSize: 14.sm,
                  fontWeight: FontWeight.w400,
                  color: Get.isDarkMode ? Colors.white : Colors.grey),
          hintText: "Select Date of Investment"),
    );
  }
}
