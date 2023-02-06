import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:piadvisory/Common/CustomNextButton.dart';
import 'package:piadvisory/Common/app_bar.dart';
import 'package:piadvisory/Profile/Assets/AssetsRepository/assetsform.dart';
import 'package:piadvisory/Profile/ProfileMain.dart';
import 'package:piadvisory/Utils/base_manager.dart';
import 'package:piadvisory/Utils/textStyles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/Utils/Dialogs.dart';

class RealEstate extends StatefulWidget {
  const RealEstate({super.key});

  @override
  State<RealEstate> createState() => _RealEstateState();
}

class _RealEstateState extends State<RealEstate> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController PropertyName = TextEditingController();
  TextEditingController Invested = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  TextEditingController Current = TextEditingController();
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

  void UploadData() async {
    final isValid = _form.currentState?.validate();
    if (isValid!) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? user_id = await prefs.getInt('user_id');
      replaceAssetsBtnWithLoader();
      Map<String, dynamic> updata = {
        "user_id": user_id,
        "property_name": PropertyName.text,
        "invested_value": Invested.text,
        "date_of_investment": datecontroller.text,
        "current_value": Current.text
      };
      print(updata);
      final data = await StoreAssetsform().postStoreAssetsformRE(updata);
      if (data.status == ResponseStatus.SUCCESS) {
        replaceLoaderWithAssetsBtn();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProfileMain()));
      } else {
        replaceLoaderWithAssetsBtn();
        return utils.showToast(data.message);
      }
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
        titleTxt: "Real Estate",
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
                        "Property Name*",
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
                        controller: PropertyName,
                        decoration: InputDecoration(
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: Color(0xFF303030))),
                          hintText: "Enter Property Name",
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
                              RegExp('[a-zA-ZS0-9 ]')),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter property name";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Text(
                        "Invested Value*",
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
                        controller: Invested,
                        decoration: InputDecoration(
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: Color(0xFF303030))),
                          hintText: "Enter Invested Value",
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
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter invested value";
                          }
                          return null;
                        },
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
                      RealestateDatePicker(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please select date of investment";
                            }
                            return null;
                          },
                          datecontroller: datecontroller,
                          ontap: () => _presentDatePicker(),
                          hintText: "Select Date of Investment"),
                      SizedBox(
                        height: 30.h,
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
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter current value";
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
                              UploadData();
                              // final isValid = _form.currentState?.validate();
                              // if (isValid!) {
                              //   Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //           builder: (context) => ProfileMain()));
                              //   //args ! = null ? editGoal() : UploadData();
                              // }
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

class RealestateDatePicker extends StatelessWidget {
  const RealestateDatePicker({
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
