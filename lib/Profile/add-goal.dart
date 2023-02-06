// ignore_for_file: file_names

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:month_picker_dialog_2/month_picker_dialog_2.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:piadvisory/Profile/GoalsRepository/storeGoals.dart';
import 'package:piadvisory/Profile/goal.dart';
import 'package:piadvisory/SideMenu/Subscribe/Mysubscription.dart';
import 'package:piadvisory/Utils/base_manager.dart';
import '/Common/CustomNextButton.dart';
import '/Profile/ProfileMain.dart';
import '/Utils/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Common/app_bar.dart';
import '/Utils/Dialogs.dart';

class AddGoals extends StatefulWidget {
  const AddGoals({Key? key}) : super(key: key);

  @override
  State<AddGoals> createState() => _AddGoalsState();
}

class _AddGoalsState extends State<AddGoals> {
  DateTime? _selected;
  TextEditingController datecontroller = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController GoalName = TextEditingController();
  TextEditingController Ammount = TextEditingController();
  final args = Get.arguments;
  int goalId = 0;
  bool addGoalbtnvisible = true;
   bool progressindicatorvisible = false;
  
  @override
  void initState() {
    super.initState();
    setValues();
  }
 void replaceAddGoalBtnWithLoader() {
    setState(() {
      addGoalbtnvisible = false;
      progressindicatorvisible = true;
    });
  }

  void replaceLoaderWithAddGoalBtn() {
    setState(() {
      addGoalbtnvisible = true;
      progressindicatorvisible = false;
    });
  }
  setValues() {
    //var _idExists = Get.arguments["id"];

    if (args != null) {
      goalId = Get.arguments["id"];
      GoalName.text = Get.arguments["goalName"].toString();
      Ammount.text = Get.arguments["targetAmt"].toString();
      datecontroller.text = Get.arguments["duration"].toString();
    }
  }

  void _yearMonthPicker() async {
    showMonthPicker(
      context: context,
      initialDate: _selected ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate:  DateTime(2075)
    ).then((date) {
      if (date != null) {
        setState(() {
          _selected = date;
          datecontroller.text = '${_selected?.month}/${_selected?.year}';
        });
      }
    });
  }

  void UploadData() async {
    print("upload goals method called");
      Map<String, dynamic> updata = {
        "type": GoalName.text,
        "amount": Ammount.text,
        "duration": datecontroller.text,
      };
      final data = await Storegoalsdetails().postStoregoalsdetails(updata);
      if (data.status == ResponseStatus.SUCCESS) {
        utils.showToast("Goal Added!");
        showGoalsDialog();
        replaceLoaderWithAddGoalBtn();
      } else { replaceLoaderWithAddGoalBtn();
        return utils.showToast(data.message);
      }
   
  }

  void editGoal() async {
    Map<String, dynamic> updata = {
      "goal_id": goalId,
      "type": GoalName.text,
      "amount": Ammount.text,
      "duration": datecontroller.text,
    };
    print("updats is $updata");
    final data = await Storegoalsdetails().updateGoalsdetails(updata);
    if (data.status == ResponseStatus.SUCCESS) {
      utils.showToast("Goal Added!");
      showGoalsDialog();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ProfileMain()));
    } else {
      return utils.showToast(data.message);
    }
  }

  Future showGoalsDialog() async {
    FocusScope.of(context).unfocus();
    final data = await showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: GoalsDialog(
            ontap: () {
              Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProfileMain()));
            }
         
          ),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titleTxt: "Add Goal", bottomtext: false),
      body: SingleChildScrollView(
        child: Form(
          key: _form,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 49.h,
                    ),
                    Text(
                      "Goal Name*",
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
                      controller: GoalName,
                      decoration: InputDecoration(
                        focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Color(0xFF303030))),
                        hintText: "Goal Name",
                        hintStyle: blackStyle(context).copyWith(
                          color: Get.isDarkMode
                              ? Colors.white
                              : const Color(0xFF6B6B6B),
                          fontSize: 14,
                        ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[a-zA-ZS0-9 ]')),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Goal name";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
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
                            borderSide:
                                BorderSide(width: 1, color: Color(0xFF303030))),
                        hintText: " ₹ Enter Amount",
                        hintStyle: blackStyle(context).copyWith(
                            color: Get.isDarkMode
                                ? Colors.white
                                : const Color(0xFF6B6B6B),
                            fontSize: 14),
                      ),
                      inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Amount";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Duration: Years and Months*",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: datecontroller,
                      onTap: (() => _yearMonthPicker()),
                      readOnly: true,
                      cursorColor: Colors.grey,
                      style: const TextStyle(
                        fontFamily: 'Product Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Color(0xFF878787),
                          ),
                          onPressed: () {
                            _yearMonthPicker();
                          },
                        ),
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Product Sans',
                          color: Get.isDarkMode
                              ? Colors.white
                              : const Color(0xFF6B6B6B),
                        ),
                        hintText: "Select Years and Months",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Select Years and Months";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 106.h,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: CustomNextButton(
                        text: "Add Goal",
                        ontap: () {
                          //  print(Get.arguments["id"].toString());

                          final isValid = _form.currentState?.validate();
                          if (isValid!) {
                           // replaceAddGoalBtnWithLoader();
                           // showGoalsDialog();
                            args != null ? editGoal() : UploadData();
                          }
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class GoalsDialog extends StatefulWidget {
  GoalsDialog({Key? key, this.ontap, }) : super(key: key);

  @override
  State<GoalsDialog> createState() => _GoalsDialogState();
  final void Function()? ontap;

}

class _GoalsDialogState extends State<GoalsDialog> {
  TextEditingController upiidcontroller = TextEditingController();
  TextEditingController amountcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -80,
          right: MediaQuery.of(context).size.width * 0.4,
          child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 25,
                child: Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              )),
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 50.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45),
                child: Text(
                  textAlign: TextAlign.center,
                  "We have just the right Investment Lined up for you to Achieve your Goal ",
                  style: blackStyle(context).copyWith(
                      fontSize: 18.sm,
                      color: Get.isDarkMode ? Colors.white : Colors.black),
                ),
              ),
              SizedBox(height: 38.h),
              SizedBox(
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: const Color.fromRGBO(247, 129, 4, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Let us Help build you portfolio Today",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 18.sm,
                      fontFamily: 'Product Sans',
                    ),
                  ),
                  onPressed: () {
                    widget.ontap!();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Mysubscription()));
                  },
                ),
              ),
              SizedBox(
                height: 23.h,
              ),
              // Visibility( visible: widget.addgoalbtnvisible,
              //   child: GestureDetector(
              //     onTap: () {
              //       widget.ontap!();
              
              //       // Navigator.push(context,
              //       //     MaterialPageRoute(builder: (context) => ProfileMain()));
              //     },
              //     child: Text(
              //       "Save the Goal",
              //       style: blackStyle(context).copyWith(
              //         fontSize: 14,
              //         color: Get.isDarkMode ? Colors.white : Color(0xFF303030),
              //         decoration: TextDecoration.underline,
              //       ),
              //     ),
              //   ),
              // ),
              //  Visibility(
              //     visible: widget.loadervisible,
              //     child: const Center(
              //       child: CircularProgressIndicator(),
              //     ),
              //   ),
            ],
          ),
        ),
      ],
    );
  }
}
