// ignore_for_file: unused_import, file_names

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:piadvisory/Profile/BankdetailsRepository/storeBankdetails.dart';
import 'package:piadvisory/Profile/ProfileMain.dart';
import 'package:piadvisory/Utils/base_manager.dart';

import '/Common/CustomNextButton.dart';
import '/Utils/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/Utils/Dialogs.dart';
import '../Common/app_bar.dart';
import 'BankdetailsRepository/Model/BankModel.dart';

class AddBankDetails extends StatefulWidget {
  const AddBankDetails({Key? key}) : super(key: key);

  @override
  State<AddBankDetails> createState() => _AddBankDetailsState();
}

class _AddBankDetailsState extends State<AddBankDetails> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController bankname = TextEditingController();
  TextEditingController accountname = TextEditingController();
  TextEditingController accountnumber = TextEditingController();
  TextEditingController ifsccode = TextEditingController();
  bool _valueExists = false;
  late final Future? myFuture;
  final args = Get.arguments;
  @override
  void initState() {
    super.initState();
    setControllerValues();
  }

  void UploadData() async {
    final isValid = _form.currentState?.validate();
    if (isValid!) {
      Map<String, dynamic> updata1 = {
        "beneficiary_account_no": accountnumber.text,
        "beneficiary_ifsc": ifsccode.text,
      };
      Map<String, dynamic> updata2 = {
        "bankName": bankname.text,
        "accountHolderName": accountname.text,
        "accountNumber": accountnumber.text,
        "IFSC": ifsccode.text,
      };
      final data = await Storebankdetails().verifyBankAccount(updata1);
      if (data.status == ResponseStatus.SUCCESS) {
        final data1 = await Storebankdetails().postStorebankdetails(updata2);
        if (data1.status == ResponseStatus.SUCCESS) {
          utils.showToast("Bank Details Added");
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ProfileMain()));
        } else {
          return utils.showToast(data1.message);
        }
      } else {
        return utils.showToast("Invalid Bank Details");
      }
    }
  }

  void editGoal() async {
    final isValid = _form.currentState?.validate();
    if (isValid!) {
      Map<String, dynamic> updata = {
        "bank_id": Get.arguments["id"],
        "bankName": bankname.text,
        "accountHolderName": accountname.text,
        "accountNumber": accountnumber.text,
        "IFSC": ifsccode.text,
      };
      final data = await Storebankdetails().updateBanks(updata);
      if (data.status == ResponseStatus.SUCCESS) {
        utils.showToast("Bank Details updated");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ProfileMain()));
      } else {
        return utils.showToast(data.message);
      }
    }
  }

  setControllerValues() {
    print("setcontroller called");
    if (args != null) {
      bankname.text = Get.arguments["bank_name"];
      accountname.text = Get.arguments["account_name"].toString();
      accountnumber.text = Get.arguments["account_number"].toString();
      ifsccode.text = Get.arguments["ifscCode"].toString();
    }
  }

  @override
  void dispose() {
    // bankname.dispose();
    // accountname.dispose();
    // accountnumber.dispose();
    // ifsccode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => const ProfileMain())));

        throw new FormatException();
      },
      child: Scaffold(
          appBar:
              const CustomAppBar(titleTxt: "Bank Details", bottomtext: false),
          body: _buildBody(context)),
    );
  }

  Widget _buildBody(context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Form(
        key: _form,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: Text(
                "Bank Accounts",
                style: blackStyle(context).copyWith(
                  fontSize: 18,
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Card(
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFFDCDCDC))),
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 25.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 29,
                    ),
                    Text(
                      "Bank Name*",
                      style: blackStyle(context).copyWith(
                        fontSize: 18,
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    CustomTextFields(
                      readonly: _valueExists,
                      controller: bankname,
                      hint: "Enter Bank Name",
                      // inputFormatters: [
                      //   FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                      // ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Bank Name";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Account Holder Name*",
                      style: blackStyle(context).copyWith(
                        fontSize: 18,
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    CustomTextFields(
                      readonly: _valueExists,
                      controller: accountname,
                      hint: "Enter Account Holder Name",
                      // inputFormatters: [
                      //   FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                      // ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Account Holder Name";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Account Number*",
                      style: blackStyle(context).copyWith(
                        fontSize: 18,
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    CustomTextFieldsNumber(
                      readonly: _valueExists,
                      txtinptype: TextInputType.number,
                      controller: accountnumber,
                      hint: "Enter Account Number",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Account Number";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "IFSC Code*",
                      style: blackStyle(context).copyWith(
                        fontSize: 18,
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    CustomTextFieldsIfsc(
                      readonly: _valueExists,
                      controller: ifsccode,
                      hint: "Enter IFSC Code",
                      // inputFormatters: [
                      //   FilteringTextInputFormatter.allow(
                      //       RegExp('[A-Za-zS0-9]')),
                      // ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter IFSC Code";
                        }
                        return null;
                      },
                    ),
                    //   const SizedBox(
                    //   height: 15,
                    // ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 42,
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color.fromRGBO(247, 129, 4, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  args != null ? editGoal() : UploadData();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 136, right: 136),
                      child: Text(
                        " Save ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 18.sm,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    ));
  }
}

class CustomTextFields extends StatelessWidget {
  const CustomTextFields({
    Key? key,
    this.controller,
    this.hint,
    this.errortext,
    this.ontap,
    this.limitlength,
    this.maxlength,
    this.onchanged,
    this.txtinptype,
    this.sizefactor,
    this.validator,
    this.inputFormatters,
    this.readonly,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? hint;
  final String? errortext;
  final Function(String)? ontap;
  final int? limitlength;
  final int? maxlength;
  final Function(String)? onchanged;
  final TextInputType? txtinptype;
  final double? sizefactor;
  final dynamic validator;
  final dynamic inputFormatters;
  final bool? readonly;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readonly ?? false,
      keyboardType: txtinptype ?? TextInputType.text,
      maxLength: maxlength,
      cursorColor: Colors.grey,
      style: TextStyle(
        //color: Colors.grey,
        fontFamily: 'Product Sans',
        fontSize: sizefactor ?? 16.sm,
        fontWeight: FontWeight.w400,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle:
            //Theme.of(context).textTheme.headline2,
            blackStyle(context).copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Get.isDarkMode
                    ? Colors.white
                    : Color(0xFF303030).withOpacity(0.3)),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(width: 1, color: Color(0xFF303030))),
      ),
      validator: validator,
      inputFormatters: [
        //LengthLimitingTextInputFormatter(limitlength ?? 20),
        FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
      ],
      onSaved: (value) {
        ontap?.call;
      },
      onChanged: (value) {
        onchanged?.call(value);
      },
    );
  }
}

class CustomTextFieldsNumber extends StatelessWidget {
  const CustomTextFieldsNumber({
    Key? key,
    this.controller,
    this.hint,
    this.errortext,
    this.ontap,
    this.limitlength,
    this.maxlength,
    this.onchanged,
    this.txtinptype,
    this.sizefactor,
    this.validator,
    this.inputFormatters,
    this.readonly,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? hint;
  final String? errortext;
  final Function(String)? ontap;
  final int? limitlength;
  final int? maxlength;
  final Function(String)? onchanged;
  final TextInputType? txtinptype;
  final double? sizefactor;
  final dynamic validator;
  final dynamic inputFormatters;
  final bool? readonly;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readonly ?? false,
      keyboardType: txtinptype ?? TextInputType.text,
      maxLength: maxlength,
      cursorColor: Colors.grey,
      style: TextStyle(
        //color: Colors.grey,
        fontFamily: 'Product Sans',
        fontSize: sizefactor ?? 16.sm,
        fontWeight: FontWeight.w400,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle:
            //Theme.of(context).textTheme.headline2,
            blackStyle(context).copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Get.isDarkMode
                    ? Colors.white
                    : Color(0xFF303030).withOpacity(0.3)),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(width: 1, color: Color(0xFF303030))),
      ),
      validator: validator,
      inputFormatters: [
        LengthLimitingTextInputFormatter(limitlength ?? 20),
        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
      ],
      onSaved: (value) {
        ontap?.call;
      },
      onChanged: (value) {
        onchanged?.call(value);
      },
    );
  }
}

class CustomTextFieldsIfsc extends StatelessWidget {
  const CustomTextFieldsIfsc({
    Key? key,
    this.controller,
    this.hint,
    this.errortext,
    this.ontap,
    this.limitlength,
    this.maxlength,
    this.onchanged,
    this.txtinptype,
    this.sizefactor,
    this.validator,
    this.inputFormatters,
    this.readonly,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? hint;
  final String? errortext;
  final Function(String)? ontap;
  final int? limitlength;
  final int? maxlength;
  final Function(String)? onchanged;
  final TextInputType? txtinptype;
  final double? sizefactor;
  final dynamic validator;
  final dynamic inputFormatters;
  final bool? readonly;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.characters,
      readOnly: readonly ?? false,
      keyboardType: txtinptype ?? TextInputType.text,
      maxLength: maxlength,
      cursorColor: Colors.grey,
      style: TextStyle(
        //color: Colors.grey,
        fontFamily: 'Product Sans',
        fontSize: sizefactor ?? 16.sm,
        fontWeight: FontWeight.w400,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle:
            //Theme.of(context).textTheme.headline2,
            blackStyle(context).copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Get.isDarkMode
                    ? Colors.white
                    : Color(0xFF303030).withOpacity(0.3)),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(width: 1, color: Color(0xFF303030))),
      ),
      validator: validator,
      inputFormatters: [
        LengthLimitingTextInputFormatter(limitlength ?? 20),
        FilteringTextInputFormatter.allow(RegExp('[A-ZS0-9]')),
      ],
      onSaved: (value) {
        ontap?.call;
      },
      onChanged: (value) {
        onchanged?.call(value);
      },
    );
  }
}
