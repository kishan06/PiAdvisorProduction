// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'package:another_flushbar/flushbar.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:piadvisory/PaymentSuccess.dart';
import 'package:piadvisory/Profile/KYC/Repository/scheduleAppointment.dart';
import 'package:piadvisory/Utils/base_manager.dart';

import '/Common/CustomNextButton.dart';
import 'package:piadvisory/Utils/Dialogs.dart';
import '/Common/app_bar.dart';
import '/Profile/KYC/KYCMain.dart';
import '/Profile/KYC/SchduleAppointment.dart';
import '/Utils/textStyles.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectTimeAndDate extends StatefulWidget {
  const SelectTimeAndDate({Key? key}) : super(key: key);

  @override
  State<SelectTimeAndDate> createState() => _SelectTimeAndDateState();
}

class _SelectTimeAndDateState extends State<SelectTimeAndDate> {
  var selectedDate;
  bool _buttonclicked = false;
  bool _buttonclicked2 = false;
  bool _buttonclicked3 = false;
  bool _buttonclicked4 = false;
  bool _buttonclicked5 = false;
  bool _buttonclicked6 = false;
  bool _buttonclicked7 = false;
  bool _buttonclicked8 = false;
  bool _buttonclicked9 = false;
  bool _buttonclicked10 = false;
  bool _buttonclicked11 = false;
  bool _buttonclicked12 = false;
  bool _buttonclicked13 = false;
  bool _buttonclicked14 = false;
  bool _buttonclicked15 = false;
  bool _buttonclicked16 = false;
  bool _buttonclicked17 = false;
  bool _buttonclicked18 = false;
  bool _buttonclicked19 = false;
  bool _buttonclicked20 = false;
  bool _buttonclicked21 = false;
  bool _buttonclicked22 = false;
  bool _buttonclicked23 = false;
  bool _buttonclicked24 = false;
  bool _buttonclicked25 = false;
  bool _buttonclicked26 = false;
  bool _buttonclicked27 = false;

  DateTime? _selectedDate = DateTime.now();
  final selectedAdvisory = TextEditingController();
  final datecontroller = TextEditingController();
  Map<String, dynamic> updata = {};
  Map<String, bool> parser = {};
  String _keyis = "";
  bool _slots = true;
  var starttime1;
  var starthr1;
  bool firsttimeval = false;
  bool secondtimeval = false;
  bool thirdtimeval = false;
  bool fourthtimeval = false;
  bool fifthtimeval = false;
  bool sixthtimeval = false;
  bool seventhtimeval = false;
  bool eighttimeval = false;
  bool ninthtimeval = false;
  bool tenthtimeval = false;
  bool eleventhtimeval = false;
  bool twelvethtimeval = false;
  bool thirteenthtimeval = false;
  bool fourteenthtimeval = false;
  bool fifteenthtimeval = false;
  bool sixteenthtimeval = false;
  bool seventeenthtimeval = false;
  bool eighteenthtimeval = false;
  bool nineteenthtimeval = false;
  bool twenteethtimeval = false;
  bool twentyfirsttimeval = false;
  bool twentysecondtimeval = false;
  bool twentythirdtimeval = false;
  bool twentyfourthtimeval = false;
  bool twentyfifthtimeval = false;
  bool twentysixthtimeval = false;
  bool twentyseventhtimeval = false;
  double firstTime = 8.00;
  double secondtime = 8.30;
  double thirdtime = 9.00;
  double fourthtime = 9.30;
  double fifthtime = 10.00;
  double sixthtime = 10.30;
  double seventhtime = 11.00;
  double eighttime = 11.30;
  double ninthtime = 12.00;
  double tenthtime = 12.30;
  double eleventhtime = 13.00;
  double twelvethtime = 13.30;
  double thirteenthtime = 14.00;
  double fourteenthtime = 14.30;
  double fifteenthtime = 15.00;
  double sixteenthtime = 15.30;
  double seventeenthtime = 16.00;
  double eighteenthtime = 16.30;
  double nineteenthtime = 17.00;
  double twenteethtime = 17.30;
  double twentyfirsttime = 18.00;
  double twentysecondtime = 18.30;
  double twentythirdtime = 19.00;
  double twentyfourthtime = 19.30;
  double twentyfifthtime = 20.00;
  double twentysixthtime = 20.30;
  double twentyseventhtime = 21.00;
  DateTime now = new DateTime.now();
  var todaysdate;
  var newstarttime;
  var newstarthr;
  @override
  void initState() {
    DateTime date = new DateTime(now.year, now.month, now.day);
    datecontroller.text = date.toString().replaceAll("00:00:00.000", "");
    updata = {
      'date': datecontroller.text,
      "timeSlot": _keyis,
    };
    super.initState();
  }

  setValues() {
    parser = {
      "8:00 AM": _buttonclicked,
      "8:30 AM": _buttonclicked2,
      "9:00 AM": _buttonclicked3,
      "9:30 AM": _buttonclicked4,
      "10:00 AM": _buttonclicked5,
      "10:30 AM": _buttonclicked6,
      "11:00 AM": _buttonclicked7,
      "11:30 AM": _buttonclicked8,
      "12:00 PM": _buttonclicked9,
      "12:30 PM": _buttonclicked10,
      "1:00 PM": _buttonclicked11,
      "1:30 PM": _buttonclicked12,
      "2:00 PM": _buttonclicked13,
      "2:30 PM": _buttonclicked14,
      "3:00 PM": _buttonclicked15,
      "3:30 PM": _buttonclicked16,
      "4:00 PM": _buttonclicked17,
      "4:30 PM": _buttonclicked18,
      "5:00 PM": _buttonclicked19,
      "5:30 PM": _buttonclicked20,
      "6:00 PM": _buttonclicked21,
      "6:30 PM": _buttonclicked22,
      "7:00 PM": _buttonclicked23,
      "7:30 PM": _buttonclicked24,
      "8:00 PM": _buttonclicked25,
      "8:30 PM": _buttonclicked26,
      "9:00 PM": _buttonclicked27,
    };
    fetchSlotFromMap();
    print(parser);
  }

  void fetchSlotFromMap() {
    print("reached");

    parser.forEach((key, value) {
      if (value == true) {
        print("value is $key");
        setState(() {
          _keyis = key;
        });
      } else {
        setState(() {
          _slots = false;
        });
      }
    });
  }

  Future _showAdvisoryPicker() async {
    FocusScope.of(context).unfocus();
    final data = await showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: const AdvisoryOptions(),
        );
      },
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Get.isDarkMode ? Colors.grey : Colors.white),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      backgroundColor: Get.isDarkMode
          ? Colors.black
          : Theme.of(context).scaffoldBackgroundColor,
    );

    if (data != null) {
      setState(() {
        selectedAdvisory.text = data;
      });
    }
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(3000))
        .then((pickedDate) {
      // Check if no date is selected
      if (pickedDate == null) {
        return;
      } else
        setState(() {
          firsttimeval = false;
          secondtimeval = false;
          thirdtimeval = false;
          fourthtimeval = false;
          fifthtimeval = false;
          sixthtimeval = false;
          seventhtimeval = false;
          eighttimeval = false;
          ninthtimeval = false;
          tenthtimeval = false;
          eleventhtimeval = false;
          twelvethtimeval = false;
          thirteenthtimeval = false;
          fourteenthtimeval = false;
          fifteenthtimeval = false;
          sixteenthtimeval = false;
          seventeenthtimeval = false;
          eighteenthtimeval = false;
          nineteenthtimeval = false;
          twenteethtimeval = false;
          twentyfirsttimeval = false;
          twentysecondtimeval = false;
          twentythirdtimeval = false;
          twentyfourthtimeval = false;
          twentyfifthtimeval = false;
          twentysixthtimeval = false;
          twentyseventhtimeval = false;

          _selectedDate = pickedDate;
          datecontroller.text =
              "${_selectedDate!.year.toString().padLeft(2, '0')}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString()}";
          updata = {"date": datecontroller.text};
          print(updata);
        });
    });
  }

  buildAdvisorypopup({required int initialindex}) {
    return showDialog(
      context: context,
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SizedBox(
          //   height: 45,
          //   width: 45,
          //   child: FittedBox(
          //     child: FloatingActionButton(
          //         elevation: 0,
          //         backgroundColor: Colors.white,
          //         onPressed: () {
          //           Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                   builder: (context) => SchduleAppointment()));
          //         },
          //         child: Icon(
          //           Icons.close,
          //           size: 30,
          //         )),
          //   ),
          // ),
          AlertDialog(
            insetPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
            backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
            contentPadding: EdgeInsets.fromLTRB(24, 30, 24, 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              side: BorderSide(
                  color: Get.isDarkMode ? Colors.grey : Colors.white),
            ),
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
                        "Booking Successful",
                        style: blackStyle(context).copyWith(
                            color: Get.isDarkMode ? Colors.white : Colors.black,
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
                    text: "Continue",
                    ontap: () {
                      Navigator.pushAndRemoveUntil<void>(
                        context,
                        MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const PaymentSuccess()),
                        ModalRoute.withName('/select_time_and_date'),
                      );
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => SchduleAppointment()));
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

  Future<void> apiCallMethod() async {
    if (selectedAdvisory.text.isNotEmpty && !_slots) {
      updata = {
        "Date": datecontroller.text,
        "timeSlot": _keyis,
        "advisory": selectedAdvisory.text
      };
      final data = await ScheduleAppointment().postAppointmentDetails(updata);

      if (data.status == ResponseStatus.SUCCESS) {
        buildAdvisorypopup(initialindex: 1);
      } else {
        return utils.showToast(data.message);
      }
    } else {
      Flushbar(
        message: "Please Select Advisory & Slots",
        duration: const Duration(seconds: 3),
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(now.hour);
    print(now.minute);
    starttime1 = now.hour;
    starthr1 = now.minute;

    todaysdate = now.day;
    if (_selectedDate?.hour == null) {
      newstarttime = "";
    } else {
      newstarttime = _selectedDate?.hour;
    }
    if (_selectedDate?.minute == null) {
      newstarthr = "";
    } else {
      newstarthr = _selectedDate?.minute;
    }
    String finalnewtime = "$newstarttime.$newstarthr";

    String finaltime = "$starttime1.$starthr1";
    double finaltimefirst = double.parse(finaltime);
    print(finaltimefirst);
    double finalnewtimefirst = 16.22;
    try {
      finalnewtimefirst = double.parse(finalnewtime);
    } catch (e) {}

    if (todaysdate == _selectedDate!.day) {
      if (finaltimefirst <= firstTime) {
        firsttimeval = true;
      }
      if (finaltimefirst <= secondtime) {
        secondtimeval = true;
      }
      if (finaltimefirst <= thirdtime) {
        thirdtimeval = true;
      }
      if (finaltimefirst <= fourthtime) {
        fourthtimeval = true;
      }
      if (finaltimefirst <= fifthtime) {
        fifthtimeval = true;
      }
      if (finaltimefirst <= sixthtime) {
        sixthtimeval = true;
      }
      if (finaltimefirst <= seventhtime) {
        seventhtimeval = true;
      }
      if (finaltimefirst <= eighttime) {
        eighttimeval = true;
      }
      if (finaltimefirst <= ninthtime) {
        ninthtimeval = true;
      }
      if (finaltimefirst <= tenthtime) {
        tenthtimeval = true;
      }
      if (finaltimefirst <= eleventhtime) {
        eleventhtimeval = true;
      }
      if (finaltimefirst <= twelvethtime) {
        twelvethtimeval = true;
      }
      if (finaltimefirst <= thirteenthtime) {
        thirteenthtimeval = true;
      }
      if (finaltimefirst <= fourteenthtime) {
        fourteenthtimeval = true;
      }
      if (finaltimefirst <= fifteenthtime) {
        fifteenthtimeval = true;
      }
      if (finaltimefirst <= sixteenthtime) {
        sixteenthtimeval = true;
      }
      if (finaltimefirst <= seventeenthtime) {
        seventeenthtimeval = true;
      }
      if (finaltimefirst <= eighteenthtime) {
        eighteenthtimeval = true;
      }
      if (finaltimefirst <= nineteenthtime) {
        nineteenthtimeval = true;
      }
      if (finaltimefirst <= twenteethtime) {
        twenteethtimeval = true;
      }
      if (finaltimefirst <= twentyfirsttime) {
        twentyfirsttimeval = true;
      }
      if (finaltimefirst <= twentysecondtime) {
        twentysecondtimeval = true;
      }
      if (finaltimefirst <= twentythirdtime) {
        twentythirdtimeval = true;
      }
      if (finaltimefirst <= twentyfourthtime) {
        twentyfourthtimeval = true;
      }
      if (finaltimefirst <= twentyfifthtime) {
        twentyfifthtimeval = true;
      }
      if (finaltimefirst <= twentysixthtime) {
        twentysixthtimeval = true;
      }
      if (finaltimefirst <= twentyseventhtime) {
        twentyseventhtimeval = true;
      }
    } else {
      if (finalnewtimefirst <= firstTime) {
        firsttimeval = true;
      }
      if (finalnewtimefirst <= secondtime) {
        secondtimeval = true;
      }
      if (finalnewtimefirst <= thirdtime) {
        thirdtimeval = true;
      }
      if (finalnewtimefirst <= fourthtime) {
        fourthtimeval = true;
      }
      if (finalnewtimefirst <= fifthtime) {
        fifthtimeval = true;
      }
      if (finalnewtimefirst <= sixthtime) {
        sixthtimeval = true;
      }
      if (finalnewtimefirst <= seventhtime) {
        seventhtimeval = true;
      }
      if (finalnewtimefirst <= eighttime) {
        eighttimeval = true;
      }
      if (finalnewtimefirst <= ninthtime) {
        ninthtimeval = true;
      }
      if (finalnewtimefirst <= tenthtime) {
        tenthtimeval = true;
      }
      if (finalnewtimefirst <= eleventhtime) {
        eleventhtimeval = true;
      }
      if (finalnewtimefirst <= twelvethtime) {
        twelvethtimeval = true;
      }
      if (finalnewtimefirst <= thirteenthtime) {
        thirteenthtimeval = true;
      }
      if (finalnewtimefirst <= fourteenthtime) {
        fourteenthtimeval = true;
      }
      if (finalnewtimefirst <= fifteenthtime) {
        fifteenthtimeval = true;
      }
      if (finalnewtimefirst <= sixteenthtime) {
        sixteenthtimeval = true;
      }
      if (finalnewtimefirst <= seventeenthtime) {
        seventeenthtimeval = true;
      }
      if (finalnewtimefirst <= eighteenthtime) {
        eighteenthtimeval = true;
      }
      if (finalnewtimefirst <= nineteenthtime) {
        nineteenthtimeval = true;
      }
      if (finalnewtimefirst <= twenteethtime) {
        twenteethtimeval = true;
      }
      if (finalnewtimefirst <= twentyfirsttime) {
        twentyfirsttimeval = true;
      }
      if (finalnewtimefirst <= twentysecondtime) {
        twentysecondtimeval = true;
      }
      if (finalnewtimefirst <= twentythirdtime) {
        twentythirdtimeval = true;
      }
      if (finalnewtimefirst <= twentyfourthtime) {
        twentyfourthtimeval = true;
      }
      if (finalnewtimefirst <= twentyfifthtime) {
        twentyfifthtimeval = true;
      }
      if (finalnewtimefirst <= twentysixthtime) {
        twentysixthtimeval = true;
      }
      if (finalnewtimefirst <= twentyseventhtime) {
        twentyseventhtimeval = true;
      }
    }
    return Scaffold(
      appBar: const CustomAppBar(
          titleTxt: "Select Date And Time", bottomtext: false),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40.h,
                ),
                Text("Select Advisory",
                    style: blackStyle(context).copyWith(
                        fontWeight: FontWeight.w600,
                        color: Get.isDarkMode ? Colors.white : Colors.black)),
                CustomDropDownOptions(
                    controller: selectedAdvisory,
                    hinttext: "-Select-",
                    ontap: () {
                      _showAdvisoryPicker();
                    }),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SizedBox(
              //   width: 350,
              //   // padding: EdgeInsets.all(10),
              //   height: 138.09,
              //   child: Card(
              //     elevation: 2,
              //     child: Padding(
              //       padding: const EdgeInsets.all(15),
              //       child: AnimatedHorizontalCalendar(
              //           tableCalenderButtonColor: const Color(0xFF008083),
              //           unSelectedBoxShadow:
              //               const BoxShadow(color: Colors.white),
              //           selectedBoxShadow: const BoxShadow(color: Colors.white),
              //           // curve: Curves.easeInOutCirc,
              //           tableCalenderIcon: const Icon(
              //             Icons.calendar_today,
              //             color: Colors.white,
              //           ),
              //           date: DateTime.now(),
              //           textColor: Colors.black45,
              //           backgroundColor: Colors.white,
              //           tableCalenderThemeData: ThemeData.light().copyWith(
              //             primaryColor: const Color(0xFF008083),
              //             buttonTheme: const ButtonThemeData(
              //                 textTheme: ButtonTextTheme.primary),
              //             colorScheme: const ColorScheme.light(
              //               primary: Color(0xFF008083),
              //             ),
              //           ),
              //           selectedColor: const Color(0xFF008083),
              //           onDateSelected: (date) {
              //             selectedDate = date;
              //           }),
              //     ),
              //   ),
              // ),
            ],
          ), // here
          // SizedBox(
          //   height: 50.h,
          // ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40.h,
                ),
                Text("Select Date",
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                        color: Get.isDarkMode ? Colors.white : Colors.black)),
                DatePickerWidget(
                  datecontroller: datecontroller,
                  ontap: () => _presentDatePicker(),
                ),
                const SizedBox(
                  height: 40,
                ),
                FutureBuilder(
                  future: ScheduleAppointment().fetchSlotDetails(updata),
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
                              height: 150,
                              width: 150,
                            ),
                          ),
                        ],
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      // setValues();
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            '${snapshot.error} occured',
                            style: TextStyle(fontSize: 18),
                          ),
                        );
                      }
                    }
                    return _buildBody(
                      context,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }

  Widget _buildBody(context) {
    return Column(
      children: [
        Text(
          "Morning Slot",
          style: blackStyle(context).copyWith(
              fontSize: 18.sm,
              fontWeight: FontWeight.bold,
              color: Get.isDarkMode ? Colors.white : Colors.black),
        ),
        const SizedBox(
          height: 20,
        ),
        Wrap(
          alignment: WrapAlignment.start,
          spacing: 22,
          runSpacing: 10,
          children: [
            firsttimeval
                ? CustomTimeButton(
                    isactive: (slotsData?.status?.slot1 == 0) ? false : true,
                    timeslot: "8:00",
                    isbuttonclicked: _buttonclicked,
                    ontap: () {
                      setState(() {
                        _buttonclicked = true;
                        _buttonclicked2 = false;
                        _buttonclicked3 = false;
                        _buttonclicked4 = false;
                        _buttonclicked5 = false;
                        _buttonclicked6 = false;
                        _buttonclicked7 = false;
                        _buttonclicked8 = false;
                        _buttonclicked9 = false;
                        _buttonclicked10 = false;
                        _buttonclicked11 = false;
                        _buttonclicked12 = false;
                        _buttonclicked13 = false;
                        _buttonclicked14 = false;
                        _buttonclicked15 = false;
                        _buttonclicked16 = false;
                        _buttonclicked17 = false;
                        _buttonclicked18 = false;
                        _buttonclicked19 = false;
                        _buttonclicked20 = false;
                        _buttonclicked21 = false;
                        _buttonclicked22 = false;
                        _buttonclicked23 = false;
                        _buttonclicked24 = false;
                        _buttonclicked25 = false;
                        _buttonclicked26 = false;
                        _buttonclicked27 = false;

                        setValues();
                      });
                    },
                  )
                : SizedBox(
                    width: 104,
                    height: 38.86,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(2),
                          shadowColor:
                              MaterialStateProperty.all(Color(0XFF000028)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey)),
                      onPressed: null,
                      child: Text(
                        "8:00",
                        style:
                            blackStyle(context).copyWith(color: Colors.black),
                      ),
                    ),
                  ),
            secondtimeval
                ? CustomTimeButton(
                    isactive: (slotsData?.status?.slot2 == 0) ? false : true,
                    timeslot: "8:30",
                    isbuttonclicked: _buttonclicked2,
                    ontap: () {
                      setState(() {
                        _buttonclicked2 = true;

                        _buttonclicked = false;
                        _buttonclicked3 = false;
                        _buttonclicked4 = false;
                        _buttonclicked5 = false;
                        _buttonclicked6 = false;
                        _buttonclicked7 = false;
                        _buttonclicked8 = false;
                        _buttonclicked9 = false;
                        _buttonclicked10 = false;
                        _buttonclicked11 = false;
                        _buttonclicked12 = false;
                        _buttonclicked13 = false;
                        _buttonclicked14 = false;
                        _buttonclicked15 = false;
                        _buttonclicked16 = false;
                        _buttonclicked17 = false;
                        _buttonclicked18 = false;
                        _buttonclicked19 = false;
                        _buttonclicked20 = false;
                        _buttonclicked21 = false;
                        _buttonclicked22 = false;
                        _buttonclicked23 = false;
                        _buttonclicked24 = false;
                        _buttonclicked25 = false;
                        _buttonclicked26 = false;
                        _buttonclicked27 = false;
                        setValues();
                      });
                    },
                  )
                : SizedBox(
                    width: 104,
                    height: 38.86,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(2),
                          shadowColor:
                              MaterialStateProperty.all(Color(0XFF000028)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey)),
                      onPressed: null,
                      child: Text(
                        "8:30",
                        style:
                            blackStyle(context).copyWith(color: Colors.black),
                      ),
                    ),
                  ),
            thirdtimeval
                ? CustomTimeButton(
                    isactive: (slotsData?.status?.slot3 == 0) ? false : true,
                    timeslot: "9:00",
                    isbuttonclicked: _buttonclicked3,
                    ontap: () {
                      setState(() {
                        _buttonclicked3 = true;
                        _buttonclicked = false;

                        _buttonclicked2 = false;
                        _buttonclicked4 = false;
                        _buttonclicked5 = false;
                        _buttonclicked6 = false;
                        _buttonclicked7 = false;
                        _buttonclicked8 = false;
                        _buttonclicked9 = false;
                        _buttonclicked10 = false;
                        _buttonclicked11 = false;
                        _buttonclicked12 = false;
                        _buttonclicked13 = false;
                        _buttonclicked14 = false;
                        _buttonclicked15 = false;
                        _buttonclicked16 = false;
                        _buttonclicked17 = false;
                        _buttonclicked18 = false;
                        _buttonclicked19 = false;
                        _buttonclicked20 = false;
                        _buttonclicked21 = false;
                        _buttonclicked22 = false;
                        _buttonclicked23 = false;
                        _buttonclicked24 = false;
                        _buttonclicked25 = false;
                        _buttonclicked26 = false;
                        _buttonclicked27 = false;
                        setValues();
                      });
                    },
                  )
                : SizedBox(
                    width: 104,
                    height: 38.86,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(2),
                          shadowColor:
                              MaterialStateProperty.all(Color(0XFF000028)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey)),
                      onPressed: null,
                      child: Text(
                        "9:00",
                        style:
                            blackStyle(context).copyWith(color: Colors.black),
                      ),
                    ),
                  ),
            fourthtimeval
                ? CustomTimeButton(
                    isactive: (slotsData?.status?.slot4 == 0) ? false : true,
                    timeslot: "9:30",
                    isbuttonclicked: _buttonclicked4,
                    ontap: () {
                      setState(() {
                        _buttonclicked4 = true;
                        _buttonclicked = false;
                        _buttonclicked2 = false;

                        _buttonclicked3 = false;
                        _buttonclicked5 = false;
                        _buttonclicked6 = false;
                        _buttonclicked7 = false;
                        _buttonclicked8 = false;
                        _buttonclicked9 = false;
                        _buttonclicked10 = false;
                        _buttonclicked11 = false;
                        _buttonclicked12 = false;
                        _buttonclicked13 = false;
                        _buttonclicked14 = false;
                        _buttonclicked15 = false;
                        _buttonclicked16 = false;
                        _buttonclicked17 = false;
                        _buttonclicked18 = false;
                        _buttonclicked19 = false;
                        _buttonclicked20 = false;
                        _buttonclicked21 = false;
                        _buttonclicked22 = false;
                        _buttonclicked23 = false;
                        _buttonclicked24 = false;
                        _buttonclicked25 = false;
                        _buttonclicked26 = false;
                        _buttonclicked27 = false;
                        setValues();
                      });
                    },
                  )
                : SizedBox(
                    width: 104,
                    height: 38.86,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(2),
                          shadowColor:
                              MaterialStateProperty.all(Color(0XFF000028)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey)),
                      onPressed: null,
                      child: Text(
                        "9:30",
                        style:
                            blackStyle(context).copyWith(color: Colors.black),
                      ),
                    ),
                  ),
            fifthtimeval
                ? CustomTimeButton(
                    isactive: (slotsData?.status?.slot5 == 0) ? false : true,
                    timeslot: "10:00",
                    isbuttonclicked: _buttonclicked5,
                    ontap: () {
                      setState(() {
                        _buttonclicked5 = true;
                        _buttonclicked = false;
                        _buttonclicked2 = false;
                        _buttonclicked3 = false;
                        _buttonclicked4 = false;

                        _buttonclicked6 = false;
                        _buttonclicked7 = false;
                        _buttonclicked8 = false;
                        _buttonclicked9 = false;
                        _buttonclicked10 = false;
                        _buttonclicked11 = false;
                        _buttonclicked12 = false;
                        _buttonclicked13 = false;
                        _buttonclicked14 = false;
                        _buttonclicked15 = false;
                        _buttonclicked16 = false;
                        _buttonclicked17 = false;
                        _buttonclicked18 = false;
                        _buttonclicked19 = false;
                        _buttonclicked20 = false;
                        _buttonclicked21 = false;
                        _buttonclicked22 = false;
                        _buttonclicked23 = false;
                        _buttonclicked24 = false;
                        _buttonclicked25 = false;
                        _buttonclicked26 = false;
                        _buttonclicked27 = false;
                        setValues();
                      });
                    },
                  )
                : SizedBox(
                    width: 104,
                    height: 38.86,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(2),
                          shadowColor:
                              MaterialStateProperty.all(Color(0XFF000028)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey)),
                      onPressed: null,
                      child: Text(
                        "10:00",
                        style:
                            blackStyle(context).copyWith(color: Colors.black),
                      ),
                    ),
                  ),
            sixthtimeval
                ? CustomTimeButton(
                    isactive: (slotsData?.status?.slot6 == 0) ? false : true,
                    timeslot: "10:30",
                    isbuttonclicked: _buttonclicked6,
                    ontap: () {
                      setState(() {
                        _buttonclicked6 = true;
                        _buttonclicked = false;
                        _buttonclicked2 = false;
                        _buttonclicked3 = false;
                        _buttonclicked4 = false;
                        _buttonclicked5 = false;

                        _buttonclicked7 = false;
                        _buttonclicked8 = false;
                        _buttonclicked9 = false;
                        _buttonclicked10 = false;
                        _buttonclicked11 = false;
                        _buttonclicked12 = false;
                        _buttonclicked13 = false;
                        _buttonclicked14 = false;
                        _buttonclicked15 = false;
                        _buttonclicked16 = false;
                        _buttonclicked17 = false;
                        _buttonclicked18 = false;
                        _buttonclicked19 = false;
                        _buttonclicked20 = false;
                        _buttonclicked21 = false;
                        _buttonclicked22 = false;
                        _buttonclicked23 = false;
                        _buttonclicked24 = false;
                        _buttonclicked25 = false;
                        _buttonclicked26 = false;
                        _buttonclicked27 = false;
                        setValues();
                      });
                    },
                  )
                : SizedBox(
                    width: 104,
                    height: 38.86,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(2),
                          shadowColor:
                              MaterialStateProperty.all(Color(0XFF000028)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey)),
                      onPressed: null,
                      child: Text(
                        "10:30",
                        style:
                            blackStyle(context).copyWith(color: Colors.black),
                      ),
                    ),
                  ),
            seventhtimeval
                ? CustomTimeButton(
                    isactive: (slotsData?.status?.slot7 == 0) ? false : true,
                    timeslot: "11:00",
                    isbuttonclicked: _buttonclicked7,
                    ontap: () {
                      setState(() {
                        _buttonclicked7 = true;
                        _buttonclicked = false;
                        _buttonclicked2 = false;
                        _buttonclicked3 = false;
                        _buttonclicked4 = false;
                        _buttonclicked5 = false;
                        _buttonclicked6 = false;

                        _buttonclicked8 = false;
                        _buttonclicked9 = false;
                        _buttonclicked10 = false;
                        _buttonclicked11 = false;
                        _buttonclicked12 = false;
                        _buttonclicked13 = false;
                        _buttonclicked14 = false;
                        _buttonclicked15 = false;
                        _buttonclicked16 = false;
                        _buttonclicked17 = false;
                        _buttonclicked18 = false;
                        _buttonclicked19 = false;
                        _buttonclicked20 = false;
                        _buttonclicked21 = false;
                        _buttonclicked22 = false;
                        _buttonclicked23 = false;
                        _buttonclicked24 = false;
                        _buttonclicked25 = false;
                        _buttonclicked26 = false;
                        _buttonclicked27 = false;
                        setValues();
                      });
                    },
                  )
                : SizedBox(
                    width: 104,
                    height: 38.86,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(2),
                          shadowColor:
                              MaterialStateProperty.all(Color(0XFF000028)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey)),
                      onPressed: null,
                      child: Text(
                        "11:00",
                        style:
                            blackStyle(context).copyWith(color: Colors.black),
                      ),
                    ),
                  ),
            eighttimeval
                ? CustomTimeButton(
                    isactive: (slotsData?.status?.slot8 == 0) ? false : true,
                    timeslot: "11:30",
                    isbuttonclicked: _buttonclicked8,
                    ontap: () {
                      setState(() {
                        _buttonclicked8 = true;
                        _buttonclicked = false;
                        _buttonclicked2 = false;
                        _buttonclicked3 = false;
                        _buttonclicked4 = false;
                        _buttonclicked5 = false;
                        _buttonclicked6 = false;
                        _buttonclicked7 = false;

                        _buttonclicked9 = false;
                        _buttonclicked10 = false;
                        _buttonclicked11 = false;
                        _buttonclicked12 = false;
                        _buttonclicked13 = false;
                        _buttonclicked14 = false;
                        _buttonclicked15 = false;
                        _buttonclicked16 = false;
                        _buttonclicked17 = false;
                        _buttonclicked18 = false;
                        _buttonclicked19 = false;
                        _buttonclicked20 = false;
                        _buttonclicked21 = false;
                        _buttonclicked22 = false;
                        _buttonclicked23 = false;
                        _buttonclicked24 = false;
                        _buttonclicked25 = false;
                        _buttonclicked26 = false;
                        _buttonclicked27 = false;
                        setValues();
                      });
                    },
                  )
                : SizedBox(
                    width: 104,
                    height: 38.86,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(2),
                          shadowColor:
                              MaterialStateProperty.all(Color(0XFF000028)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey)),
                      onPressed: null,
                      child: Text(
                        "11:30",
                        style:
                            blackStyle(context).copyWith(color: Colors.black),
                      ),
                    ),
                  ),
            ninthtimeval
                ? CustomTimeButton(
                    isactive: (slotsData?.status?.slot9 == 0) ? false : true,
                    timeslot: "12:00",
                    isbuttonclicked: _buttonclicked9,
                    ontap: () {
                      setState(() {
                        _buttonclicked9 = true;
                        _buttonclicked = false;
                        _buttonclicked2 = false;
                        _buttonclicked3 = false;
                        _buttonclicked4 = false;
                        _buttonclicked5 = false;
                        _buttonclicked6 = false;
                        _buttonclicked7 = false;
                        _buttonclicked8 = false;

                        _buttonclicked10 = false;
                        _buttonclicked11 = false;
                        _buttonclicked12 = false;
                        _buttonclicked13 = false;
                        _buttonclicked14 = false;
                        _buttonclicked15 = false;
                        _buttonclicked16 = false;
                        _buttonclicked17 = false;
                        _buttonclicked18 = false;
                        _buttonclicked19 = false;
                        _buttonclicked20 = false;
                        _buttonclicked21 = false;
                        _buttonclicked22 = false;
                        _buttonclicked23 = false;
                        _buttonclicked24 = false;
                        _buttonclicked25 = false;
                        _buttonclicked26 = false;
                        _buttonclicked27 = false;
                        setValues();
                      });
                    },
                  )
                : SizedBox(
                    width: 104,
                    height: 38.86,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(2),
                          shadowColor:
                              MaterialStateProperty.all(Color(0XFF000028)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey)),
                      onPressed: null,
                      child: Text(
                        "12:00",
                        style:
                            blackStyle(context).copyWith(color: Colors.black),
                      ),
                    ),
                  ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "Afternoon Slot",
          style: blackStyle(context)
              .copyWith(fontSize: 18.sm, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        Wrap(
          spacing: 22,
          runSpacing: 10,
          children: [
            tenthtimeval
                ? CustomTimeButton(
                    isactive: (slotsData?.status?.slot10 == 0) ? false : true,
                    timeslot: "12:30",
                    isbuttonclicked: _buttonclicked10,
                    ontap: () {
                      setState(() {
                        _buttonclicked10 = true;
                        _buttonclicked = false;
                        _buttonclicked2 = false;
                        _buttonclicked3 = false;
                        _buttonclicked4 = false;
                        _buttonclicked5 = false;
                        _buttonclicked6 = false;
                        _buttonclicked7 = false;
                        _buttonclicked8 = false;
                        _buttonclicked9 = false;

                        _buttonclicked11 = false;
                        _buttonclicked12 = false;
                        _buttonclicked13 = false;
                        _buttonclicked14 = false;
                        _buttonclicked15 = false;
                        _buttonclicked16 = false;
                        _buttonclicked17 = false;
                        _buttonclicked18 = false;
                        _buttonclicked19 = false;
                        _buttonclicked20 = false;
                        _buttonclicked21 = false;
                        _buttonclicked22 = false;
                        _buttonclicked23 = false;
                        _buttonclicked24 = false;
                        _buttonclicked25 = false;
                        _buttonclicked26 = false;
                        _buttonclicked27 = false;
                        setValues();
                      });
                    },
                  )
                : SizedBox(
                    width: 104,
                    height: 38.86,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(2),
                          shadowColor:
                              MaterialStateProperty.all(Color(0XFF000028)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey)),
                      onPressed: null,
                      child: Text(
                        "12:30",
                        style:
                            blackStyle(context).copyWith(color: Colors.black),
                      ),
                    ),
                  ),
            eleventhtimeval
                ? CustomTimeButton(
                    isactive: (slotsData?.status?.slot11 == 0) ? false : true,
                    timeslot: "1:00",
                    isbuttonclicked: _buttonclicked11,
                    ontap: () {
                      setState(() {
                        _buttonclicked11 = true;

                        _buttonclicked = false;
                        _buttonclicked2 = false;
                        _buttonclicked3 = false;
                        _buttonclicked4 = false;
                        _buttonclicked5 = false;
                        _buttonclicked6 = false;
                        _buttonclicked7 = false;
                        _buttonclicked8 = false;
                        _buttonclicked9 = false;
                        _buttonclicked10 = false;

                        _buttonclicked12 = false;
                        _buttonclicked13 = false;
                        _buttonclicked14 = false;
                        _buttonclicked15 = false;
                        _buttonclicked16 = false;
                        _buttonclicked17 = false;
                        _buttonclicked18 = false;
                        _buttonclicked19 = false;
                        _buttonclicked20 = false;
                        _buttonclicked21 = false;
                        _buttonclicked22 = false;
                        _buttonclicked23 = false;
                        _buttonclicked24 = false;
                        _buttonclicked25 = false;
                        _buttonclicked26 = false;
                        _buttonclicked27 = false;
                        setValues();
                      });
                    },
                  )
                : SizedBox(
                    width: 104,
                    height: 38.86,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(2),
                          shadowColor:
                              MaterialStateProperty.all(Color(0XFF000028)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey)),
                      onPressed: null,
                      child: Text(
                        "1:00",
                        style:
                            blackStyle(context).copyWith(color: Colors.black),
                      ),
                    ),
                  ),
            twelvethtimeval
                ? CustomTimeButton(
                    isactive: (slotsData?.status?.slot12 == 0) ? false : true,
                    timeslot: "01:30",
                    isbuttonclicked: _buttonclicked12,
                    ontap: () {
                      setState(() {
                        _buttonclicked12 = true;

                        _buttonclicked = false;
                        _buttonclicked2 = false;
                        _buttonclicked3 = false;
                        _buttonclicked4 = false;
                        _buttonclicked5 = false;
                        _buttonclicked6 = false;
                        _buttonclicked7 = false;
                        _buttonclicked8 = false;
                        _buttonclicked9 = false;
                        _buttonclicked10 = false;
                        _buttonclicked11 = false;

                        _buttonclicked13 = false;
                        _buttonclicked14 = false;
                        _buttonclicked15 = false;
                        _buttonclicked16 = false;
                        _buttonclicked17 = false;
                        _buttonclicked18 = false;
                        _buttonclicked19 = false;
                        _buttonclicked20 = false;
                        _buttonclicked21 = false;
                        _buttonclicked22 = false;
                        _buttonclicked23 = false;
                        _buttonclicked24 = false;
                        _buttonclicked25 = false;
                        _buttonclicked26 = false;
                        _buttonclicked27 = false;
                        setValues();
                      });
                    },
                  )
                : SizedBox(
                    width: 104,
                    height: 38.86,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(2),
                          shadowColor:
                              MaterialStateProperty.all(Color(0XFF000028)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey)),
                      onPressed: null,
                      child: Text(
                        "01:30",
                        style:
                            blackStyle(context).copyWith(color: Colors.black),
                      ),
                    ),
                  ),
            thirteenthtimeval
                ? CustomTimeButton(
                    isactive: (slotsData?.status?.slot13 == 0) ? false : true,
                    timeslot: "02:00",
                    isbuttonclicked: _buttonclicked13,
                    ontap: () {
                      setState(() {
                        _buttonclicked13 = true;

                        _buttonclicked = false;
                        _buttonclicked2 = false;
                        _buttonclicked3 = false;
                        _buttonclicked4 = false;
                        _buttonclicked5 = false;
                        _buttonclicked6 = false;
                        _buttonclicked7 = false;
                        _buttonclicked8 = false;
                        _buttonclicked9 = false;
                        _buttonclicked10 = false;
                        _buttonclicked11 = false;
                        _buttonclicked12 = false;

                        _buttonclicked14 = false;
                        _buttonclicked15 = false;
                        _buttonclicked16 = false;
                        _buttonclicked17 = false;
                        _buttonclicked18 = false;
                        _buttonclicked19 = false;
                        _buttonclicked20 = false;
                        _buttonclicked21 = false;
                        _buttonclicked22 = false;
                        _buttonclicked23 = false;
                        _buttonclicked24 = false;
                        _buttonclicked25 = false;
                        _buttonclicked26 = false;
                        _buttonclicked27 = false;
                        setValues();
                      });
                    },
                  )
                : SizedBox(
                    width: 104,
                    height: 38.86,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(2),
                          shadowColor:
                              MaterialStateProperty.all(Color(0XFF000028)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey)),
                      onPressed: null,
                      child: Text(
                        "02:00",
                        style:
                            blackStyle(context).copyWith(color: Colors.black),
                      ),
                    ),
                  ),
            fourteenthtimeval
                ? CustomTimeButton(
                    isactive: (slotsData?.status?.slot14 == 0) ? false : true,
                    timeslot: "02:30",
                    isbuttonclicked: _buttonclicked14,
                    ontap: () {
                      setState(() {
                        _buttonclicked14 = true;

                        _buttonclicked = false;
                        _buttonclicked2 = false;
                        _buttonclicked3 = false;
                        _buttonclicked4 = false;
                        _buttonclicked5 = false;
                        _buttonclicked6 = false;
                        _buttonclicked7 = false;
                        _buttonclicked8 = false;
                        _buttonclicked9 = false;
                        _buttonclicked10 = false;
                        _buttonclicked11 = false;
                        _buttonclicked12 = false;
                        _buttonclicked13 = false;

                        _buttonclicked15 = false;
                        _buttonclicked16 = false;
                        _buttonclicked17 = false;
                        _buttonclicked18 = false;
                        _buttonclicked19 = false;
                        _buttonclicked20 = false;
                        _buttonclicked21 = false;
                        _buttonclicked22 = false;
                        _buttonclicked23 = false;
                        _buttonclicked24 = false;
                        _buttonclicked25 = false;
                        _buttonclicked26 = false;
                        _buttonclicked27 = false;
                        setValues();
                      });
                    },
                  )
                : SizedBox(
                    width: 104,
                    height: 38.86,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(2),
                          shadowColor:
                              MaterialStateProperty.all(Color(0XFF000028)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey)),
                      onPressed: null,
                      child: Text(
                        "02:30",
                        style:
                            blackStyle(context).copyWith(color: Colors.black),
                      ),
                    ),
                  ),
            fifteenthtimeval
                ? CustomTimeButton(
                    isactive: (slotsData?.status?.slot15 == 0) ? false : true,
                    timeslot: "03:00",
                    isbuttonclicked: _buttonclicked15,
                    ontap: () {
                      setState(() {
                        _buttonclicked15 = true;

                        _buttonclicked = false;
                        _buttonclicked2 = false;
                        _buttonclicked3 = false;
                        _buttonclicked4 = false;
                        _buttonclicked5 = false;
                        _buttonclicked6 = false;
                        _buttonclicked7 = false;
                        _buttonclicked8 = false;
                        _buttonclicked9 = false;
                        _buttonclicked10 = false;
                        _buttonclicked11 = false;
                        _buttonclicked12 = false;
                        _buttonclicked13 = false;
                        _buttonclicked14 = false;

                        _buttonclicked16 = false;
                        _buttonclicked17 = false;
                        _buttonclicked18 = false;
                        _buttonclicked19 = false;
                        _buttonclicked20 = false;
                        _buttonclicked21 = false;
                        _buttonclicked22 = false;
                        _buttonclicked23 = false;
                        _buttonclicked24 = false;
                        _buttonclicked25 = false;
                        _buttonclicked26 = false;
                        _buttonclicked27 = false;
                        setValues();
                      });
                    },
                  )
                : SizedBox(
                    width: 104,
                    height: 38.86,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(2),
                          shadowColor:
                              MaterialStateProperty.all(Color(0XFF000028)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey)),
                      onPressed: null,
                      child: Text(
                        "03:00",
                        style:
                            blackStyle(context).copyWith(color: Colors.black),
                      ),
                    ),
                  ),
            sixteenthtimeval
                ? CustomTimeButton(
                    isactive: (slotsData?.status?.slot16 == 0) ? false : true,
                    timeslot: "03:30",
                    isbuttonclicked: _buttonclicked16,
                    ontap: () {
                      setState(() {
                        _buttonclicked16 = true;

                        _buttonclicked = false;
                        _buttonclicked2 = false;
                        _buttonclicked3 = false;
                        _buttonclicked4 = false;
                        _buttonclicked5 = false;
                        _buttonclicked6 = false;
                        _buttonclicked7 = false;
                        _buttonclicked8 = false;
                        _buttonclicked9 = false;
                        _buttonclicked10 = false;
                        _buttonclicked11 = false;
                        _buttonclicked12 = false;
                        _buttonclicked13 = false;
                        _buttonclicked14 = false;
                        _buttonclicked15 = false;

                        _buttonclicked17 = false;
                        _buttonclicked18 = false;
                        _buttonclicked19 = false;
                        _buttonclicked20 = false;
                        _buttonclicked21 = false;
                        _buttonclicked22 = false;
                        _buttonclicked23 = false;
                        _buttonclicked24 = false;
                        _buttonclicked25 = false;
                        _buttonclicked26 = false;
                        _buttonclicked27 = false;
                        setValues();
                      });
                    },
                  )
                : SizedBox(
                    width: 104,
                    height: 38.86,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(2),
                          shadowColor:
                              MaterialStateProperty.all(Color(0XFF000028)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey)),
                      onPressed: null,
                      child: Text(
                        "03:30",
                        style:
                            blackStyle(context).copyWith(color: Colors.black),
                      ),
                    ),
                  ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "Evening Slot",
          style: blackStyle(context)
              .copyWith(fontSize: 18.sm, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        Wrap(
          spacing: 22,
          runSpacing: 10,
          children: [
            seventeenthtimeval
                ? CustomTimeButton(
                    isactive: (slotsData?.status?.slot17 == 0) ? false : true,
                    timeslot: "04:00",
                    isbuttonclicked: _buttonclicked17,
                    ontap: () {
                      setState(() {
                        _buttonclicked17 = true;

                        _buttonclicked = false;
                        _buttonclicked2 = false;
                        _buttonclicked3 = false;
                        _buttonclicked4 = false;
                        _buttonclicked5 = false;
                        _buttonclicked6 = false;
                        _buttonclicked7 = false;
                        _buttonclicked8 = false;
                        _buttonclicked9 = false;
                        _buttonclicked10 = false;
                        _buttonclicked11 = false;
                        _buttonclicked12 = false;
                        _buttonclicked13 = false;
                        _buttonclicked14 = false;
                        _buttonclicked15 = false;
                        _buttonclicked16 = false;

                        _buttonclicked18 = false;
                        _buttonclicked19 = false;
                        _buttonclicked20 = false;
                        _buttonclicked21 = false;
                        _buttonclicked22 = false;
                        _buttonclicked23 = false;
                        _buttonclicked24 = false;
                        _buttonclicked25 = false;
                        _buttonclicked26 = false;
                        _buttonclicked27 = false;
                        setValues();
                      });
                    },
                  )
                : SizedBox(
                    width: 104,
                    height: 38.86,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(2),
                          shadowColor:
                              MaterialStateProperty.all(Color(0XFF000028)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey)),
                      onPressed: null,
                      child: Text(
                        "04:00",
                        style:
                            blackStyle(context).copyWith(color: Colors.black),
                      ),
                    ),
                  ),
            eighteenthtimeval
                ? CustomTimeButton(
                    isactive: (slotsData?.status?.slot18 == 0) ? false : true,
                    timeslot: "04:30",
                    isbuttonclicked: _buttonclicked18,
                    ontap: () {
                      setState(() {
                        _buttonclicked18 = true;

                        _buttonclicked = false;
                        _buttonclicked2 = false;
                        _buttonclicked3 = false;
                        _buttonclicked4 = false;
                        _buttonclicked5 = false;
                        _buttonclicked6 = false;
                        _buttonclicked7 = false;
                        _buttonclicked8 = false;
                        _buttonclicked9 = false;
                        _buttonclicked10 = false;
                        _buttonclicked11 = false;
                        _buttonclicked12 = false;
                        _buttonclicked13 = false;
                        _buttonclicked14 = false;
                        _buttonclicked15 = false;
                        _buttonclicked16 = false;
                        _buttonclicked17 = false;

                        _buttonclicked19 = false;
                        _buttonclicked20 = false;
                        _buttonclicked21 = false;
                        _buttonclicked22 = false;
                        _buttonclicked23 = false;
                        _buttonclicked24 = false;
                        _buttonclicked25 = false;
                        _buttonclicked26 = false;
                        _buttonclicked27 = false;
                        setValues();
                      });
                    },
                  )
                : SizedBox(
                    width: 104,
                    height: 38.86,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(2),
                          shadowColor:
                              MaterialStateProperty.all(Color(0XFF000028)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey)),
                      onPressed: null,
                      child: Text(
                        "04:30",
                        style:
                            blackStyle(context).copyWith(color: Colors.black),
                      ),
                    ),
                  ),
            nineteenthtimeval
                ? CustomTimeButton(
                    isactive: (slotsData?.status?.slot19 == 0) ? false : true,
                    timeslot: "05:00",
                    isbuttonclicked: _buttonclicked19,
                    ontap: () {
                      setState(() {
                        _buttonclicked19 = true;

                        _buttonclicked = false;
                        _buttonclicked2 = false;
                        _buttonclicked3 = false;
                        _buttonclicked4 = false;
                        _buttonclicked5 = false;
                        _buttonclicked6 = false;
                        _buttonclicked7 = false;
                        _buttonclicked8 = false;
                        _buttonclicked9 = false;
                        _buttonclicked10 = false;
                        _buttonclicked11 = false;
                        _buttonclicked12 = false;
                        _buttonclicked13 = false;
                        _buttonclicked14 = false;
                        _buttonclicked15 = false;
                        _buttonclicked16 = false;
                        _buttonclicked17 = false;
                        _buttonclicked18 = false;

                        _buttonclicked20 = false;
                        _buttonclicked21 = false;
                        _buttonclicked22 = false;
                        _buttonclicked23 = false;
                        _buttonclicked24 = false;
                        _buttonclicked25 = false;
                        _buttonclicked26 = false;
                        _buttonclicked27 = false;
                        setValues();
                      });
                    },
                  )
                : SizedBox(
                    width: 104,
                    height: 38.86,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(2),
                          shadowColor:
                              MaterialStateProperty.all(Color(0XFF000028)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey)),
                      onPressed: null,
                      child: Text(
                        "05:00",
                        style:
                            blackStyle(context).copyWith(color: Colors.black),
                      ),
                    ),
                  ),
            twenteethtimeval
                ? CustomTimeButton(
                    isactive: (slotsData?.status?.slot20 == 0) ? false : true,
                    timeslot: "05:30",
                    isbuttonclicked: _buttonclicked20,
                    ontap: () {
                      setState(() {
                        _buttonclicked20 = true;

                        _buttonclicked = false;
                        _buttonclicked2 = false;
                        _buttonclicked3 = false;
                        _buttonclicked4 = false;
                        _buttonclicked5 = false;
                        _buttonclicked6 = false;
                        _buttonclicked7 = false;
                        _buttonclicked8 = false;
                        _buttonclicked9 = false;
                        _buttonclicked10 = false;
                        _buttonclicked11 = false;
                        _buttonclicked12 = false;
                        _buttonclicked13 = false;
                        _buttonclicked14 = false;
                        _buttonclicked15 = false;
                        _buttonclicked16 = false;
                        _buttonclicked17 = false;
                        _buttonclicked18 = false;
                        _buttonclicked19 = false;

                        _buttonclicked21 = false;
                        _buttonclicked22 = false;
                        _buttonclicked23 = false;
                        _buttonclicked24 = false;
                        _buttonclicked25 = false;
                        _buttonclicked26 = false;
                        _buttonclicked27 = false;
                        setValues();
                      });
                    },
                  )
                : SizedBox(
                    width: 104,
                    height: 38.86,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(2),
                          shadowColor:
                              MaterialStateProperty.all(Color(0XFF000028)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey)),
                      onPressed: null,
                      child: Text(
                        "05:30",
                        style:
                            blackStyle(context).copyWith(color: Colors.black),
                      ),
                    ),
                  ),
            twentyfirsttimeval
                ? CustomTimeButton(
                    isactive: (slotsData?.status?.slot21 == 0) ? false : true,
                    timeslot: "06:00",
                    isbuttonclicked: _buttonclicked21,
                    ontap: () {
                      setState(() {
                        _buttonclicked21 = true;

                        _buttonclicked = false;
                        _buttonclicked2 = false;
                        _buttonclicked3 = false;
                        _buttonclicked4 = false;
                        _buttonclicked5 = false;
                        _buttonclicked6 = false;
                        _buttonclicked7 = false;
                        _buttonclicked8 = false;
                        _buttonclicked9 = false;
                        _buttonclicked10 = false;
                        _buttonclicked11 = false;
                        _buttonclicked12 = false;
                        _buttonclicked13 = false;
                        _buttonclicked14 = false;
                        _buttonclicked15 = false;
                        _buttonclicked16 = false;
                        _buttonclicked17 = false;
                        _buttonclicked18 = false;
                        _buttonclicked19 = false;
                        _buttonclicked20 = false;

                        _buttonclicked22 = false;
                        _buttonclicked23 = false;
                        _buttonclicked24 = false;
                        _buttonclicked25 = false;
                        _buttonclicked26 = false;
                        _buttonclicked27 = false;
                        setValues();
                      });
                    },
                  )
                : SizedBox(
                    width: 104,
                    height: 38.86,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(2),
                          shadowColor:
                              MaterialStateProperty.all(Color(0XFF000028)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey)),
                      onPressed: null,
                      child: Text(
                        "06:00",
                        style:
                            blackStyle(context).copyWith(color: Colors.black),
                      ),
                    ),
                  ),
            twentysecondtimeval
                ? CustomTimeButton(
                    isactive: (slotsData?.status?.slot22 == 0) ? false : true,
                    timeslot: "06:30",
                    isbuttonclicked: _buttonclicked22,
                    ontap: () {
                      setState(() {
                        _buttonclicked22 = true;

                        _buttonclicked = false;
                        _buttonclicked2 = false;
                        _buttonclicked3 = false;
                        _buttonclicked4 = false;
                        _buttonclicked5 = false;
                        _buttonclicked6 = false;
                        _buttonclicked7 = false;
                        _buttonclicked8 = false;
                        _buttonclicked9 = false;
                        _buttonclicked10 = false;
                        _buttonclicked11 = false;
                        _buttonclicked12 = false;
                        _buttonclicked13 = false;
                        _buttonclicked14 = false;
                        _buttonclicked15 = false;
                        _buttonclicked16 = false;
                        _buttonclicked17 = false;
                        _buttonclicked18 = false;
                        _buttonclicked19 = false;
                        _buttonclicked20 = false;
                        _buttonclicked21 = false;

                        _buttonclicked23 = false;
                        _buttonclicked24 = false;
                        _buttonclicked25 = false;
                        _buttonclicked26 = false;
                        _buttonclicked27 = false;
                        setValues();
                      });
                    },
                  )
                : SizedBox(
                    width: 104,
                    height: 38.86,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(2),
                          shadowColor:
                              MaterialStateProperty.all(Color(0XFF000028)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey)),
                      onPressed: null,
                      child: Text(
                        "06:30",
                        style:
                            blackStyle(context).copyWith(color: Colors.black),
                      ),
                    ),
                  ),
            twentythirdtimeval
                ? CustomTimeButton(
                    isactive: (slotsData?.status?.slot23 == 0) ? false : true,
                    timeslot: "07:00",
                    isbuttonclicked: _buttonclicked23,
                    ontap: () {
                      setState(() {
                        _buttonclicked23 = true;

                        _buttonclicked = false;
                        _buttonclicked2 = false;
                        _buttonclicked3 = false;
                        _buttonclicked4 = false;
                        _buttonclicked5 = false;
                        _buttonclicked6 = false;
                        _buttonclicked7 = false;
                        _buttonclicked8 = false;
                        _buttonclicked9 = false;
                        _buttonclicked10 = false;
                        _buttonclicked11 = false;
                        _buttonclicked12 = false;
                        _buttonclicked13 = false;
                        _buttonclicked14 = false;
                        _buttonclicked15 = false;
                        _buttonclicked16 = false;
                        _buttonclicked17 = false;
                        _buttonclicked18 = false;
                        _buttonclicked19 = false;
                        _buttonclicked20 = false;
                        _buttonclicked21 = false;
                        _buttonclicked22 = false;

                        _buttonclicked24 = false;
                        _buttonclicked25 = false;
                        _buttonclicked26 = false;
                        _buttonclicked27 = false;
                        setValues();
                      });
                    },
                  )
                : SizedBox(
                    width: 104,
                    height: 38.86,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(2),
                          shadowColor:
                              MaterialStateProperty.all(Color(0XFF000028)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey)),
                      onPressed: null,
                      child: Text(
                        "07:00",
                        style:
                            blackStyle(context).copyWith(color: Colors.black),
                      ),
                    ),
                  ),
            twentyfourthtimeval
                ? CustomTimeButton(
                    isactive: (slotsData?.status?.slot24 == 0) ? false : true,
                    timeslot: "07:30",
                    isbuttonclicked: _buttonclicked24,
                    ontap: () {
                      setState(() {
                        _buttonclicked24 = true;

                        _buttonclicked = false;
                        _buttonclicked2 = false;
                        _buttonclicked3 = false;
                        _buttonclicked4 = false;
                        _buttonclicked5 = false;
                        _buttonclicked6 = false;
                        _buttonclicked7 = false;
                        _buttonclicked8 = false;
                        _buttonclicked9 = false;
                        _buttonclicked10 = false;
                        _buttonclicked11 = false;
                        _buttonclicked12 = false;
                        _buttonclicked13 = false;
                        _buttonclicked14 = false;
                        _buttonclicked15 = false;
                        _buttonclicked16 = false;
                        _buttonclicked17 = false;
                        _buttonclicked18 = false;
                        _buttonclicked19 = false;
                        _buttonclicked20 = false;
                        _buttonclicked21 = false;
                        _buttonclicked22 = false;
                        _buttonclicked23 = false;

                        _buttonclicked25 = false;
                        _buttonclicked26 = false;
                        _buttonclicked27 = false;
                        setValues();
                      });
                    },
                  )
                : SizedBox(
                    width: 104,
                    height: 38.86,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(2),
                          shadowColor:
                              MaterialStateProperty.all(Color(0XFF000028)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey)),
                      onPressed: null,
                      child: Text(
                        "07:30",
                        style:
                            blackStyle(context).copyWith(color: Colors.black),
                      ),
                    ),
                  ),
            twentyfifthtimeval
                ? CustomTimeButton(
                    isactive: (slotsData?.status?.slot25 == 0) ? false : true,
                    timeslot: "08:00",
                    isbuttonclicked: _buttonclicked25,
                    ontap: () {
                      setState(() {
                        _buttonclicked25 = true;

                        _buttonclicked = false;
                        _buttonclicked2 = false;
                        _buttonclicked3 = false;
                        _buttonclicked4 = false;
                        _buttonclicked5 = false;
                        _buttonclicked6 = false;
                        _buttonclicked7 = false;
                        _buttonclicked8 = false;
                        _buttonclicked9 = false;
                        _buttonclicked10 = false;
                        _buttonclicked11 = false;
                        _buttonclicked12 = false;
                        _buttonclicked13 = false;
                        _buttonclicked14 = false;
                        _buttonclicked15 = false;
                        _buttonclicked16 = false;
                        _buttonclicked17 = false;
                        _buttonclicked18 = false;
                        _buttonclicked19 = false;
                        _buttonclicked20 = false;
                        _buttonclicked21 = false;
                        _buttonclicked22 = false;
                        _buttonclicked23 = false;
                        _buttonclicked24 = false;

                        _buttonclicked26 = false;
                        _buttonclicked27 = false;
                        setValues();
                      });
                    },
                  )
                : SizedBox(
                    width: 104,
                    height: 38.86,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(2),
                          shadowColor:
                              MaterialStateProperty.all(Color(0XFF000028)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey)),
                      onPressed: null,
                      child: Text(
                        "08:00",
                        style:
                            blackStyle(context).copyWith(color: Colors.black),
                      ),
                    ),
                  ),
            twentysixthtimeval
                ? CustomTimeButton(
                    isactive: (slotsData?.status?.slot26 == 0) ? false : true,
                    timeslot: "08:30",
                    isbuttonclicked: _buttonclicked26,
                    ontap: () {
                      setState(() {
                        _buttonclicked26 = true;

                        _buttonclicked = false;
                        _buttonclicked2 = false;
                        _buttonclicked3 = false;
                        _buttonclicked4 = false;
                        _buttonclicked5 = false;
                        _buttonclicked6 = false;
                        _buttonclicked7 = false;
                        _buttonclicked8 = false;
                        _buttonclicked9 = false;
                        _buttonclicked10 = false;
                        _buttonclicked11 = false;
                        _buttonclicked12 = false;
                        _buttonclicked13 = false;
                        _buttonclicked14 = false;
                        _buttonclicked15 = false;
                        _buttonclicked16 = false;
                        _buttonclicked17 = false;
                        _buttonclicked18 = false;
                        _buttonclicked19 = false;
                        _buttonclicked20 = false;
                        _buttonclicked21 = false;
                        _buttonclicked22 = false;
                        _buttonclicked23 = false;
                        _buttonclicked24 = false;
                        _buttonclicked25 = false;

                        _buttonclicked27 = false;
                        setValues();
                      });
                    },
                  )
                : SizedBox(
                    width: 104,
                    height: 38.86,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(2),
                          shadowColor:
                              MaterialStateProperty.all(Color(0XFF000028)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey)),
                      onPressed: null,
                      child: Text(
                        "08:30",
                        style:
                            blackStyle(context).copyWith(color: Colors.black),
                      ),
                    ),
                  ),
            twentyseventhtimeval
                ? CustomTimeButton(
                    isactive: (slotsData?.status?.slot27 == 0) ? false : true,
                    timeslot: "09:00",
                    isbuttonclicked: _buttonclicked27,
                    ontap: () {
                      setState(() {
                        _buttonclicked27 = true;

                        _buttonclicked = false;
                        _buttonclicked2 = false;
                        _buttonclicked3 = false;
                        _buttonclicked4 = false;
                        _buttonclicked5 = false;
                        _buttonclicked6 = false;
                        _buttonclicked7 = false;
                        _buttonclicked8 = false;
                        _buttonclicked9 = false;
                        _buttonclicked10 = false;
                        _buttonclicked11 = false;
                        _buttonclicked12 = false;
                        _buttonclicked13 = false;
                        _buttonclicked14 = false;
                        _buttonclicked15 = false;
                        _buttonclicked16 = false;
                        _buttonclicked17 = false;
                        _buttonclicked18 = false;
                        _buttonclicked19 = false;
                        _buttonclicked20 = false;
                        _buttonclicked21 = false;
                        _buttonclicked22 = false;
                        _buttonclicked23 = false;
                        _buttonclicked24 = false;
                        _buttonclicked25 = false;
                        _buttonclicked26 = false;

                        setValues();
                      });
                    },
                  )
                : SizedBox(
                    width: 104,
                    height: 38.86,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(2),
                          shadowColor:
                              MaterialStateProperty.all(Color(0XFF000028)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey)),
                      onPressed: null,
                      child: Text(
                        "09:00",
                        style:
                            blackStyle(context).copyWith(color: Colors.black),
                      ),
                    ),
                  ),
          ],
        ),
        SizedBox(
          height: 50.h,
        ),
        SizedBox(
            width: double.infinity,
            height: 60,
            child: CustomNextButton(
              text: "Confirm Booking",
              ontap: () {
                apiCallMethod();
                //  buildAdvisorypopup(initialindex: 1);
              },
            )),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}

class CustomTimeButton extends StatelessWidget {
  const CustomTimeButton(
      {Key? key,
      required this.ontap,
      this.isbuttonclicked = false,
      this.timeslot,
      this.isactive})
      : super(key: key);

  final GestureTapCallback ontap;
  final bool? isbuttonclicked;
  final String? timeslot;
  final bool? isactive;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 104,
      height: 38.86,
      child: ElevatedButton(
        onPressed: () {
          isactive! ? ontap() : null;
        },
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(2),
            shadowColor: MaterialStateProperty.all(const Color(0xFF000028)),
            backgroundColor: isactive ?? false
                ? isbuttonclicked!
                    ? MaterialStateProperty.all(
                        const Color(0xFF008083),
                      )
                    : MaterialStateProperty.all(Colors.white)
                : MaterialStateProperty.all(
                    Color.fromARGB(255, 138, 139, 139),
                  )),
        child: Text(
          timeslot ?? "",
          style: blackStyle(context).copyWith(
              color: isbuttonclicked! ? Colors.white : const Color(0xFF303030)),
        ),
      ),
    );
  }
}

class AdvisoryOptions extends StatefulWidget {
  const AdvisoryOptions({Key? key}) : super(key: key);

  @override
  State<AdvisoryOptions> createState() => _AdvisoryOptionsState();
}

class _AdvisoryOptionsState extends State<AdvisoryOptions> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Text("Select Advisory",
                style: blackStyle(context).copyWith(
                    color: Get.isDarkMode ? Colors.white : Colors.black)),
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
