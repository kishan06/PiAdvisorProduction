import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:piadvisory/SideMenu/ContactusRepository/storecontactus.dart';
import 'package:piadvisory/Utils/base_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/HomePage/Homepage.dart';
import '/Utils/textStyles.dart';
import '/Utils/Dialogs.dart';
import 'package:flutter/material.dart';

import '../Common/CustomNextButton.dart';
import '../Common/app_bar.dart';

class Contact extends StatefulWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController fullname = TextEditingController();
  TextEditingController emailid = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController message = TextEditingController();

  void UploadData() async {
    final isValid = _form.currentState?.validate();
    if (isValid!) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? user_id = await prefs.getInt('user_id');
      Map<String, dynamic> updata = {
        "user_id": user_id,
        "Name": fullname.text,
        "Email": emailid.text,
        "Mob_number": mobilecontroller.text,
        "Subject": subject.text,
        "Message": message.text,
      };
      final data =
          await Storecontactusdetails().postStorecontactusdetails(updata);
      if (data.status == ResponseStatus.SUCCESS) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        return utils.showToast("You will be contacted shortly");
      } else {
        return utils.showToast(data.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(titleTxt: "Contact Us", bottomtext: false),
        body: SingleChildScrollView(
          child: Form(
            key: _form,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 25,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text("Name*",
                          style: blackStyle(context).copyWith(
                            color: Get.isDarkMode ? Colors.white : Colors.black,
                          )),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter Full Name";
                          }
                          return null;
                        },
                        controller: fullname,
                        cursorColor: Colors.grey,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                            hintText: 'Enter Full Name',
                            hintStyle: blackStyle(context).copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Color(0xFF303030).withOpacity(0.3))),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(50),
                          FilteringTextInputFormatter.allow(
                              RegExp('[a-zA-Z ]')),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text("Email*",
                          style: blackStyle(context).copyWith(
                            color: Get.isDarkMode ? Colors.white : Colors.black,
                          )),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: emailid,
                        cursorColor: Colors.grey,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                            hintText: 'Email Address',
                            hintStyle: blackStyle(context).copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Color(0xFF303030).withOpacity(0.3))),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !value.contains('@') ||
                              !value.contains('.')) {
                            return "Please Enter Valid Email Address";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text("Mobile*",
                          style: blackStyle(context).copyWith(
                            color: Get.isDarkMode ? Colors.white : Colors.black,
                          )),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: mobilecontroller,
                        cursorColor: Colors.grey,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                            hintText: 'Mobile Phone Number',
                            hintStyle: blackStyle(context).copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Color(0xFF303030).withOpacity(0.3))),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter Phone Number";
                          } else if (value.length != 10) {
                            return "Please Enter Valid Phone Number";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter Subject";
                          }
                          return null;
                        },
                        controller: subject,
                        cursorColor: Colors.grey,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                            hintText: 'Subject*',
                            hintStyle: blackStyle(context).copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Color(0xFF303030).withOpacity(0.3))),
                      ),
                      const SizedBox(
                        height: 30,
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
                        ),
                        minLines: 8,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 12,
                    right: 12,
                  ),
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: CustomNextButton(
                      text: "Send Now!",
                      ontap: () {
                        UploadData();
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) => HomePage()));
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text("*Required Field",
                      style: TextStyle(
                        color:
                            Get.isDarkMode ? Colors.white : Color(0xFF6B6B6B),
                        fontSize: 12,
                      )),
                ),
              ],
            ),
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
