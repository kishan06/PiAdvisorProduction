import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:piadvisory/SideMenu/AdvisorRepository/storeadvisor.dart';
import 'package:piadvisory/Utils/base_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/Common/CustomTextFormFields.dart';
import '/Utils/textStyles.dart';

// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../Common/CustomNextButton.dart';
import '../Common/app_bar.dart';
import '../HomePage/Homepage.dart';
import '/Utils/Dialogs.dart';

class Advisor extends StatefulWidget {
  const Advisor({Key? key}) : super(key: key);

  @override
  State<Advisor> createState() => _AdvisorState();
}

class _AdvisorState extends State<Advisor> {
  String suffix = "day";
  bool design = false;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController fullname = TextEditingController();
  TextEditingController selectedadvisory = TextEditingController();
  TextEditingController referenceid = TextEditingController();
  TextEditingController message = TextEditingController();

  void UploadData() async {
    final isValid = _form.currentState?.validate();
    if (isValid!) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? user_id = await prefs.getInt('user_id');
      Map<String, dynamic> updata = {
        //need to check api call
        "user_id": user_id,
        // "full_name": fullname.text,
        "advisor_id": selectedadvisory.text,
        "reference_id": referenceid.text,
        "message": message.text,
      };
      final data = await Storeadvisordetails().postStoreadvisordetails(updata);
      if (data.status == ResponseStatus.SUCCESS) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        return utils.showToast("You will be contacted shortly");
      } else {
        return utils.showToast(data.message);
      }
    }
  }

  Future showlanguagepicker() async {
    FocusScope.of(context).unfocus();
    final data = await showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: const Languagepicker(),
        );
      },
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Get.isDarkMode ? Colors.grey : Colors.white),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );

    if (data != null) {
      setState(() {
        selectedadvisory.text = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(titleTxt: "Your Advisor", bottomtext: false),
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
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
                      const SizedBox(
                        height: 20,
                      ),
                      AdvisorTextFormField(
                        controller: fullname,
                        keyboardType: TextInputType.text,
                        hint: "Enter Your Full Name*",
                        errortext: "Enter Full Name",
                      ),
                      // const CustomTextFormField(
                      //   hint: "Enter Your Full Name",

                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Select Advisory";
                          }
                          return null;
                        },
                        onTap: (() => showlanguagepicker()),
                        readOnly: true,
                        cursorColor: Colors.grey,
                        style: const TextStyle(
                          //color: Colors.grey,
                          fontFamily: 'Product Sans',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        keyboardType: TextInputType.text,
                        controller: selectedadvisory,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.keyboard_arrow_down),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2.0),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2.0),
                          ),
                          errorMaxLines: 3,
                          hintStyle: blackStyle(context).copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Get.isDarkMode
                                  ? Colors.white
                                  : Color(0xFF303030).withOpacity(0.3)),
                          // fillColor: Colors.white,
                          // filled: true,
                          errorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                BorderSide(color: Colors.red, width: 2.0),
                          ),

                          errorStyle: const TextStyle(
                            fontSize: 16.0,
                          ),

                          hintText: "Select Advisory*",
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AdvisorTextFormField(
                        controller: referenceid,
                        keyboardType: TextInputType.text,
                        hint: "Reference ID*",
                        errortext: "Enter Reference ID",
                      ),
                      // const CustomTextFormField(
                      //   hint: "Reference ID",
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter Message";
                          }
                          return null;
                        },
                        controller: message,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                BorderSide(color: Colors.red, width: 2.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                BorderSide(color: Colors.red, width: 2.0),
                          ),
                          hintText: "Message*",
                          hintStyle: blackStyle(context).copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Get.isDarkMode
                                  ? Colors.white
                                  : Color(0xFF303030).withOpacity(0.3)),
                          errorStyle: const TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp("[a-zA-Z ]")),
                        ],
                        minLines: 13,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                      ),
                      // TextFormField(
                      //   //autovalidateMode: AutovalidateMode.onUserInteraction,
                      //     validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return "Please Enter Message";
                      //     }
                      //     return null;
                      //   },
                      //   controller: message,
                      //   decoration: InputDecoration(
                      //     focusedBorder: OutlineInputBorder(
                      //       borderRadius: BorderRadius.all(Radius.circular(10)),
                      //       borderSide:
                      //           BorderSide(color: Colors.grey, width: 2.0),
                      //     ),
                      //     enabledBorder: OutlineInputBorder(
                      //       borderRadius: BorderRadius.all(Radius.circular(10)),
                      //       borderSide:
                      //           BorderSide(color: Colors.grey, width: 2.0),
                      //     ),
                      //     hintText: "Message",
                      //     hintStyle: blackStyle(context).copyWith(
                      //         fontSize: 16,
                      //         fontWeight: FontWeight.w600,
                      //         color: Color(0xFF303030).withOpacity(0.3)),
                      //   ),
                      //   minLines: 13,
                      //   keyboardType: TextInputType.multiline,
                      //   maxLines: null,

                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: Container(
                  height: 60,
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: CustomNextButton(
                    text: "Send",
                    ontap: () {
                      // if (selectedadvisory == "" ||
                      //     selectedadvisory.text.isEmpty ) {
                      //   return utils.showToast("Please fill all fields");
                      // }
                      UploadData();
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => HomePage()));
                      //     return utils.showToast("You will be contacted shortly");
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ));
  }
}

class Languagepicker extends StatefulWidget {
  const Languagepicker({Key? key}) : super(key: key);

  @override
  State<Languagepicker> createState() => _LanguagepickerState();
}

class _LanguagepickerState extends State<Languagepicker> {
  TextEditingController upiidcontroller = TextEditingController();
  TextEditingController amountcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Text("Select Advisory", style: blackStyle(context)),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Growth");
                  }),
                  title: const Text("Growth"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Growth Plus");
                  }),
                  title: const Text("Growth Plus"),
                ),
                // ListTile(
                //   onTap: (() {
                //     Navigator.pop(context, "Tax Planning");
                //   }),
                //   title: const Text("Tax Planning"),
                // ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class AdvisorTextFormField extends StatelessWidget {
  const AdvisorTextFormField({
    Key? key,
    this.controller,
    this.hint,
    this.ontap,
    this.errortext,
    this.limitlength,
    this.maxlength,
    this.texttype,
    this.maxlines,
    this.keyboardType,
    this.inputFormatters,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? hint;
  final String? errortext;
  final Function(String)? ontap;
  final int? limitlength;
  final int? maxlength;
  final TextInputType? texttype;
  final int? maxlines;
  final TextInputType? keyboardType;
  final FilteringTextInputFormatter? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxlines ?? 1,
      maxLength: maxlength,
      cursorColor: Colors.grey,
      style: const TextStyle(
        //color: Colors.grey,
        fontFamily: 'Productsans',
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        //   contentPadding: EdgeInsets.all(15),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.grey, width: 2.0),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.grey, width: 2.0),
        ),
        errorMaxLines: 3,
        hintText: hint,
        hintStyle: blackStyle(context).copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Get.isDarkMode
                ? Colors.white
                : Color(0xFF303030).withOpacity(0.3)),
        fillColor: Get.isDarkMode ? Colors.grey : Colors.white,
        filled: true,
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
        errorStyle: const TextStyle(
          fontSize: 16.0,
        ),
      ),
      controller: controller,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errortext ?? "Empty value";
        }
        return null;
      },
      inputFormatters: [
        LengthLimitingTextInputFormatter(limitlength ?? 20),
        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
      ],
      onSaved: (value) {
        ontap?.call;
      },
    );
  }
}
