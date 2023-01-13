// ignore_for_file: unused_import, file_names

import 'package:another_flushbar/flushbar.dart';
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

class BankDetails extends StatefulWidget {
  const BankDetails({Key? key}) : super(key: key);

  @override
  State<BankDetails> createState() => _BankDetailsState();
}

class _BankDetailsState extends State<BankDetails> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController bankname = TextEditingController();
  TextEditingController accountname = TextEditingController();
  TextEditingController accountnumber = TextEditingController();
  TextEditingController ifsccode = TextEditingController();
  bool _valueExists = false;
  late final Future? myFuture;
  List<BankData>? _banks = [];
  @override
  void initState() {
    super.initState();

    myFuture = Storebankdetails().getBankDetails();
  }

  void UploadData() async {
    final isValid = _form.currentState?.validate();
    if (isValid!) {
      Map<String, dynamic> updata = {
        "bankName": bankname.text,
        "accountHolderName": accountname.text,
        "accountNumber": accountnumber.text,
        "IFSC": ifsccode.text,
      };
      final data = await Storebankdetails().postStorebankdetails(updata);
      if (data.status == ResponseStatus.SUCCESS) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ProfileMain()));
      } else {
        return utils.showToast(data.message);
      }
    }
  }

  @override
  void dispose() {
    bankname.dispose();
    accountname.dispose();
    accountnumber.dispose();
    ifsccode.dispose();
    super.dispose();
  }

  void deleteBank(int bankId) async {
    Map<String, dynamic> updata = {
      "bank_id": bankId,
    };

    final data = await Storebankdetails().deleteBanks(updata);
    if (data.status == ResponseStatus.SUCCESS) {
    } else {
      return utils.showToast(data.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titleTxt: "Bank Details", bottomtext: false),
      body: FutureBuilder(
        future: myFuture,
        builder: (ctx, snapshot) {
          if (snapshot.data == null) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Lottie.asset(
                    "assets/images/lf30_editor_jc6n8oqe.json",
                    repeat: true,
                    height: 150.h,
                    width: 150.w,
                  ),
                ),
              ],
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            _banks = bankDetails!.bankData;

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occured',
                  style: TextStyle(fontSize: 18),
                ),
              );
            }
          }
          if (_banks != null && _banks!.isEmpty) {
            Future.microtask(() => Get.offNamed("/addBankDetails"));
            return Container();
          } else {
            return _buildBodyWithData(context, _banks);
          }
        },
      ),
    );
  }

  Widget _buildAddNewBankAccountButton() {
    return SizedBox(
      width: double.infinity,
      height: 60.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: const Color.fromRGBO(247, 129, 4, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          Get.toNamed("/addBankDetails");
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              " Add Another Bank Account",
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 18.sm,
              ),
            ),
            Icon(
              Icons.add,
              color: Colors.white,
              size: 30.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBodyWithData(context, _banks) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
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
            SizedBox(
              height: 10.h,
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _banks!.length, // _goals!.length,
              itemBuilder: (context, index) {
                return _buildBankCard(_banks, index);
              },
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Center(child: _buildAddNewBankAccountButton()),
            )
          ],
        ),
      ),
    );
  }

  Widget slideRightBackground() {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.close_outlined,
              color: Colors.white,
            ),
            Text(
              "Remove",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget _buildBankCard(List<BankData> _banks, i) {
    return Card(
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFDCDCDC))),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Bank Name",
                  style: blackStyle(context).copyWith(
                      fontSize: 18,
                      color: Get.isDarkMode ? Colors.white : Colors.black),
                ),
                PopupMenuButton(
                  offset: const Offset(0, 50),
                  color: Color(0xFF6b6b6b),
                  tooltip: '',
                  icon: Icon(Icons.more_vert),
                  onSelected: (value) {
                    if (value == '/delete') {
                      setState(() {
                        deleteBank(_banks[i].id!);
                        _banks.removeAt(i);
                        Flushbar(
                          message: "Account deleted",
                          duration: const Duration(seconds: 3),
                        ).show(context);
                      });
                    } else if (value == "/edit") {
                      Get.toNamed("/addBankDetails", arguments: {
                        "id": _banks[i].id,
                        "bank_name": _banks[i].bankName,
                        "account_name": _banks[i].accountHolderName,
                        "account_number": _banks[i].accountNumber,
                        "ifscCode": _banks[i].iFSC,
                      });
                    }
                  },
                  itemBuilder: (BuildContext bc) {
                    return [
                      const PopupMenuItem(
                        child: Text(
                          "Edit",
                          style: TextStyle(color: Colors.white),
                        ),
                        value: '/edit',
                      ),
                      const PopupMenuItem(
                        child: Text(
                          "Delete",
                          style: TextStyle(color: Colors.white),
                        ),
                        value: '/delete',
                      )
                    ];
                  },
                ),
              ],
            ),
            SizedBox(
              height: 1.h,
            ),
            Text(
              _banks[i].bankName!,
              style: Theme.of(context).textTheme.headline3,
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              "Account Holder Name",
              style: blackStyle(context).copyWith(
                  fontSize: 18,
                  color: Get.isDarkMode ? Colors.white : Colors.black),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              _banks[i].accountHolderName!,
              style: Theme.of(context).textTheme.headline3,
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              "Account Number",
              style: blackStyle(context).copyWith(
                  fontSize: 18,
                  color: Get.isDarkMode ? Colors.white : Colors.black),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              _banks[i].accountNumber!,
              style: Theme.of(context).textTheme.headline3,
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              "IFSC Code",
              style: blackStyle(context).copyWith(
                  fontSize: 18,
                  color: Get.isDarkMode ? Colors.white : Colors.black),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              _banks[i].iFSC!,
              style: Theme.of(context).textTheme.headline3,
            ),
            SizedBox(
              height: 15.h,
            ),
          ],
        ),
      ),
    );
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
        LengthLimitingTextInputFormatter(limitlength ?? 20),
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
