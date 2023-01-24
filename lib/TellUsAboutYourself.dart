import 'dart:async';

import 'package:dio/dio.dart' as prefix;
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:piadvisory/Common/StreamEnum.dart';
import 'package:piadvisory/HomePage/Homepage.dart';
import 'package:piadvisory/Tellus_Repository/Model/tellusabout.dart';
import 'package:piadvisory/Tellus_Repository/storeTellusAbout.dart';
import 'package:piadvisory/Utils/Constants.dart';
import 'package:piadvisory/Utils/Dialogs.dart';
import 'package:piadvisory/Utils/base_manager.dart';
import 'package:piadvisory/Utils/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/Common/CustomNextButton.dart';
import '/Common/app_bar.dart';
import '/Profile/KYC/KYCMain.dart';
import '/Profile/KYC/SchduleAppointment.dart';
import '/Utils/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Common/user_id.dart';

class TellUsAboutYourself extends StatefulWidget {
  const TellUsAboutYourself({Key? key}) : super(key: key);

  @override
  State<TellUsAboutYourself> createState() => _TellUsAboutYourselfState();
}

class _TellUsAboutYourselfState extends State<TellUsAboutYourself> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController fullname = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  final selectfamilarity = TextEditingController();
  final selectreason = TextEditingController();
  TextEditingController aannualcontroller = TextEditingController();
  final selectplanperiod = TextEditingController();
  TextEditingController investcontroller = TextEditingController();
  TextEditingController personcontroller = TextEditingController();
  TextEditingController portfoliocontroller = TextEditingController();
  String selectedfamiliarity = "Select";
  String selectedIntrestedInInvesting = "Select";
  String selectedPlanToInvest = "Select";

  bool isContinueBtnVisible = true;
  bool isContinueBtnLoaderVisible = false;

  void replaceTellusAboutBtnWithLoader() {
    setState(() {
      isContinueBtnVisible = false;
      isContinueBtnLoaderVisible = true;
    });
  }

  void replaceLoaderWithTellusAboutBtn() {
    setState(() {
      isContinueBtnVisible = true;
      isContinueBtnLoaderVisible = false;
    });
  }

  StreamController<requestResponseState> tellusmainController =
      StreamController.broadcast();

  @override
  void initState() {
    //_fetchfutures();
    super.initState();
    getTellusAbout();
  }

  prefix.Dio dio = new prefix.Dio();

  Future<ResponseData> getTellusAbout() async {
    prefix.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    int? userid = await getUserId();
    print("userid is $userid");
    try {
      response = await dio.get(ApiConstant.gettellusabout + '/$userid',
          options: Options(headers: {"authorization": "Bearer $token"}));
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }
    print(" resp is $response");
    if (response.statusCode == 200) {
      tellusaboutDetails = tellusaboutyourself.fromJson(response.data);
      if (tellusaboutDetails!.data!.isNotEmpty) {
        setControllerValues();
      }
      print(response);
      tellusmainController.add(requestResponseState.DataReceived);
      return ResponseData<dynamic>(
        "success",
        ResponseStatus.SUCCESS,
      );
    } else {
      try {
        return ResponseData<dynamic>(
            response.data['message'].toString(), ResponseStatus.FAILED);
      } catch (_) {
        return ResponseData<dynamic>(
            response.statusMessage!, ResponseStatus.FAILED);
      }
    }
  }

  // void _fetchfutures() async {
  //   await Future.wait([
  //    StoreTellusAbout().getTellusAbout()
  //   ]);
  //   setState(() {});
  // }

  void UploadData() async {
    final isValid = _form.currentState?.validate();
    if (isValid!) {
      replaceTellusAboutBtnWithLoader();
      Map<String, dynamic> updata = {
        "age": agecontroller.text,
        "level_of_familiarity": selectfamilarity.text,
        "reason_of_investing": selectreason.text,
        "annual_income": aannualcontroller.text,
        "how_long_plan_to_invest": selectplanperiod.text,
        "how_much_you_hope_to_invest": investcontroller.text,
        "no_of_dependent_person": personcontroller.text,
        "portfolio_lost_15ormore": portfoliocontroller.text
      };
      print("updata is $updata");
      final data = await StoreTellusAbout().postStoretellusAbout(updata);
      if (data.status == ResponseStatus.SUCCESS) {
        replaceLoaderWithTellusAboutBtn();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        replaceLoaderWithTellusAboutBtn();
        return utils.showToast(data.message);
      }
    }
  }

  Future _showFamiliarityPicker() async {
    FocusScope.of(context).unfocus();
    final data = await showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: const FamiliarityPicker(),
        );
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );

    if (data != null) {
      setState(() {
        selectedfamiliarity = data;
      });
    }
  }

  Future _showIntrestedInInvestingPicker() async {
    FocusScope.of(context).unfocus();
    final data = await showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: const ReasonOfInvesting(),
        );
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );

    if (data != null) {
      setState(() {
        selectedIntrestedInInvesting = data;
      });
    }
  }

  Future _showPlanToInvestPicker() async {
    FocusScope.of(context).unfocus();
    final data = await showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: const PlanToInvest(),
        );
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );

    if (data != null) {
      setState(() {
        selectedPlanToInvest = data;
      });
    }
  }

  setControllerValues() {
    Map<String, dynamic> userdata = Database().restoreUserDetails();
    fullname.text = userdata['fullname'];
    agecontroller.text = tellusaboutDetails?.data?.first.age ?? "";
    selectfamilarity.text =
        tellusaboutDetails?.data?.first.levelOfFamiliarity ?? "";
    selectreason.text = tellusaboutDetails?.data?.first.reasonOfInvesting ?? "";
    aannualcontroller.text = tellusaboutDetails?.data?.first.annualIncome ?? "";
    selectplanperiod.text =
        tellusaboutDetails?.data?.first.howLongPlanToInvest ?? "";
    investcontroller.text =
        tellusaboutDetails?.data?.first.howMuchYouHopeToInvest ?? "";
    personcontroller.text =
        tellusaboutDetails?.data?.first.noOfDependentPerson ?? "";
    portfoliocontroller.text =
        tellusaboutDetails?.data?.first.portfolioLost15ormore ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomAppBar(titleTxt: "Tell Us About Yourself", bottomtext: false),
      body: StreamBuilder<requestResponseState>(
          stream: tellusmainController.stream,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: Lottie.asset(
                    "assets/images/lf30_editor_jc6n8oqe.json",
                    repeat: true,
                    height: 50,
                    width: 50,
                  ),
                );
              default:
                if (snapshot.hasError) {
                  return Text("Error Occured");
                } else {
                  return _buildBody(context);
                }
            }
          }),
    );
  }

  Widget _buildBody(context) {
    return SingleChildScrollView(
        child: Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Form(
        key: _form,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            Text(
              "Name*",
              style: blackStyle(context).copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            CustomTextFieldsName(
              errortext: "Enter Full Name",
              hint: "Enter Your Full Name",
              txtinptype: TextInputType.text,
              inputFormatters: [
                LengthLimitingTextInputFormatter(20),
                FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
              ],
              controller: fullname,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter Full Name";
                } else
                  return null;
              },
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "Age*",
              style: blackStyle(context).copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            CustomTextFields(
              textCapitalization: TextCapitalization.none,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter age";
                }else if(value != null && value.length >= 3) {
                  return "Please enter correct age";
                }
                 else
                  return null;
              },
              controller: agecontroller,
              inputFormatters: [
                LengthLimitingTextInputFormatter(2),
                FilteringTextInputFormatter.allow(RegExp('[0-9]')),
              ],
              txtinptype: TextInputType.number,
              errortext: "Enter  Age",
              hint: "Enter Age",
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "How would you describe your level of familiarity with investing?*",
              style: blackStyle(context).copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            CustomTextFieldsName(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please select familarity with investing";
                }
                return null;
              },
              inputFormatters: [
                LengthLimitingTextInputFormatter(20),
                FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
              ],
              errortext: "Enter your level of familiarity with investing",
              controller: selectfamilarity,
              hint: "Enter your level of familiarity with investing",
              txtinptype: TextInputType.text,
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "What is the primary reason you're interested in investing?*",
              style: blackStyle(context).copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            CustomTextFieldsName(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter primary reason ";
                }
                return null;
              },
              inputFormatters: [
                LengthLimitingTextInputFormatter(20),
                FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
              ],
              controller: selectreason,
              txtinptype: TextInputType.text,
              errortext: "Enter primary reason you're interested in investing",
              hint: "Enter primary reason you're interested in investing",
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "What is your annual income?*",
              style: blackStyle(context).copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            CustomTextFields(
              textCapitalization: TextCapitalization.none,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter annual income";
                } else
                  return null;
              },
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9]')),
              ],
              controller: aannualcontroller,
              txtinptype: TextInputType.number,
              errortext: "Type Here",
              hint: "Type Here",
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "How long do you plan to invest?*",
              style: blackStyle(context).copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            CustomTextFieldsName(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter how long you plan to invest";
                }
                return null;
              },
              inputFormatters: [
                LengthLimitingTextInputFormatter(20),
                FilteringTextInputFormatter.allow(RegExp('[a-zA-ZS0-9 ]')),
              ],
              errortext: "Enter how long do you plan to invest",
              hint: "Enter How long do you plan to invest",
              controller: selectplanperiod,
              txtinptype: TextInputType.text,
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "How much do you hope to invest on a monthly/yearly basis?*",
              style: blackStyle(context).copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            CustomTextFields(
              textCapitalization: TextCapitalization.none,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter how much you are planning to invest";
                } else
                  return null;
              },
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9]')),
              ],
              controller: investcontroller,
              txtinptype: TextInputType.number,
              errortext: "Type Here",
              hint: "Type Here",
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "What number of persons are dependent on your income?*",
              style: blackStyle(context).copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            CustomTextFields(
              textCapitalization: TextCapitalization.none,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter how many people are dependent on your income ";
                } else
                  return null;
              },
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9]')),
              ],
              controller: personcontroller,
              txtinptype: TextInputType.number,
              errortext: "Type Here",
              hint: "Type Here",
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "How would you react if your portfolio lost 15% or more of its value in a year?*",
              style: blackStyle(context).copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            CustomTextFieldsName(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter how would you react if your portfolio is in loss";
                } else
                  return null;
              },
              inputFormatters: [
                LengthLimitingTextInputFormatter(40),
                FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
              ],
              txtinptype: TextInputType.text,
              controller: portfoliocontroller,
              errortext: "Type here",
              hint: "Type here",
            ),
            const SizedBox(
              height: 40,
            ),
            Visibility(
              visible: isContinueBtnVisible,
              child: SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: CustomNextButton(
                    text: "Continue",
                    ontap: () {
                      UploadData();
                    },
                  )),
            ),
            Visibility(
                visible: isContinueBtnLoaderVisible,
                child: Center(
                  child: CircularProgressIndicator(),
                )),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    ));
  }
}

class TellCustomDropDownOptions extends StatelessWidget {
  const TellCustomDropDownOptions(
      {Key? key,
      required this.hinttext,
      required this.ontap,
      this.controller,
      this.validator})
      : super(key: key);

  final String hinttext;
  final GestureTapCallback ontap;
  final TextEditingController? controller;
  final dynamic validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
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
              Icons.keyboard_arrow_down,
              color: Colors.grey,
            ),
            onPressed: () {
              ontap();
            },
          ),
          hintStyle: blackStyle(context).copyWith(
              fontSize: 16.sm,
              fontWeight: FontWeight.w400,
              color: Get.isDarkMode
                  ? Colors.white
                  : Color(0xFF303030).withOpacity(0.3)),
          //  Color(0xFF303030).withOpacity(0.3)),
          hintText: hinttext),
    );
  }
}

class CustomTextFieldsName extends StatelessWidget {
  const CustomTextFieldsName(
      {Key? key,
      this.controller,
      this.hint,
      this.errortext,
      this.ontap,
      this.limitlength,
      this.maxlength,
      this.onchanged,
      this.txtinptype,
      this.inputFormatters,
      this.validator})
      : super(key: key);

  final TextEditingController? controller;
  final String? hint;
  final String? errortext;
  final Function(String)? ontap;
  final int? limitlength;
  final int? maxlength;
  final Function(String)? onchanged;
  final TextInputType? txtinptype;
  final dynamic inputFormatters;
  final dynamic validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: txtinptype ?? TextInputType.text,
      maxLength: maxlength,
      cursorColor: Colors.grey,
      style: TextStyle(
        fontFamily: 'Product Sans',
        fontSize: 16.sm,
        fontWeight: FontWeight.w500,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: blackStyle(context).copyWith(
          fontSize: 16.sm,
          fontWeight: FontWeight.w400,
          color: Get.isDarkMode
              ? Colors.white
              : Color(0xFF303030).withOpacity(0.3),
        ),
        //Theme.of(context).textTheme.headline3,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(width: 1, color: Color(0xFF303030))),
      ),
      validator: validator,
      // (value) {
      //   if (value == null || value.isEmpty) {
      //     return errortext ?? "Empty value";
      //   }
      //   return null;
      // },
      inputFormatters: inputFormatters,

      onSaved: (value) {
        ontap?.call;
      },
      onChanged: (value) {
        onchanged?.call(value);
      },
    );
  }
}

class FamiliarityPicker extends StatefulWidget {
  const FamiliarityPicker({Key? key}) : super(key: key);

  @override
  State<FamiliarityPicker> createState() => _FamiliarityPickerState();
}

class _FamiliarityPickerState extends State<FamiliarityPicker> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child:
                Text("Select level of familiarity", style: blackStyle(context)),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Option1");
                  }),
                  title: const Text("Option1"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Option2");
                  }),
                  title: const Text("Option2"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Option3");
                  }),
                  title: const Text("Option3"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class ReasonOfInvesting extends StatefulWidget {
  const ReasonOfInvesting({Key? key}) : super(key: key);

  @override
  State<ReasonOfInvesting> createState() => _ReasonOfInvestingState();
}

class _ReasonOfInvestingState extends State<ReasonOfInvesting> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child:
                Text("Select Reason Of Investing", style: blackStyle(context)),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Option1");
                  }),
                  title: const Text("Option1"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Option2");
                  }),
                  title: const Text("Option2"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Option3");
                  }),
                  title: const Text("Option3"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class PlanToInvest extends StatefulWidget {
  const PlanToInvest({Key? key}) : super(key: key);

  @override
  State<PlanToInvest> createState() => _PlanToInvestState();
}

class _PlanToInvestState extends State<PlanToInvest> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Text("Select how long you plan to invest",
                style: blackStyle(context)),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Option1");
                  }),
                  title: const Text("Option1"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Option2");
                  }),
                  title: const Text("Option2"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Option3");
                  }),
                  title: const Text("Option3"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
