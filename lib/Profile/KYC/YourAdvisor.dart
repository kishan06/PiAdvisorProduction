//Request advice on button click alertdialog

import '/Common/CustomNextButton.dart';
import '/Common/CustomTextFormFields.dart';
import '/Profile/KYC/KYCMain.dart';
import '/Profile/KYC/SchduleAppointment.dart';
import '/Utils/textStyles.dart';
import 'package:another_flushbar/flushbar.dart';

// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Common/app_bar.dart';

class YourAdvisor extends StatefulWidget {
  const YourAdvisor({Key? key}) : super(key: key);

  @override
  State<YourAdvisor> createState() => _YourAdvisorState();
}

class _YourAdvisorState extends State<YourAdvisor> {
  String suffix = "day";
  bool design = false;

  String? selectedadvisory;

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
        selectedadvisory = data;
      });
    }
  }

  buildAdvisorypopup({required int initialindex}) {
    return showDialog(
      context: context,
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 45,
            width: 45,
            child: FittedBox(
              child: FloatingActionButton(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SchduleAppointment()));
                  },
                  child: Icon(
                    Icons.close,
                    size: 30,
                  )),
            ),
          ),
          AlertDialog(
            insetPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
            contentPadding: EdgeInsets.fromLTRB(24, 30, 24, 24),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            // contentPadding:
            //     EdgeInsets.all(
            //         10),
            //   title: ,
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 45, vertical: 45),
                      child: Text(
                        textAlign: TextAlign.center,
                        "It Will Be Great If You \n Update The KYC",
                        style: blackStyle(context).copyWith(
                            //fontWeight: FontWeight.bold,
                            fontSize: 26.sm),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: CustomNextButton(
                    text: "Upload Your KYC",
                    ontap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const KYCMain()));
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(titleTxt: "Request Advice", bottomtext: false),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const CustomTextFormField(
                        hint: "Enter Your Full Name",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        //  controller: confirmpasscontroller,
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
                              color: Color(0xFF303030).withOpacity(0.3)),
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

                          hintText: selectedadvisory ?? "Select Advisory",
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          hintText: "Message",
                          hintStyle: blackStyle(context).copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF303030).withOpacity(0.3)),
                        ),
                        minLines:
                            13, // any number you need (It works as the rows for the textarea)
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                      ),
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
                    text: "Request Advice",
                    ontap: () {
                      buildAdvisorypopup(initialindex: 1);
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
