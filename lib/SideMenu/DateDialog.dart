
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:piadvisory/Utils/textStyles.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DateDialog extends StatefulWidget {
  const DateDialog({Key? key}) : super(key: key);

  @override
  State<DateDialog> createState() => _DateDialogState();
}

class _DateDialogState extends State<DateDialog> {
  String startDate = "select Date";
  String endDate = 'select Date';
  String finalDate = '';
  void setFinalDate() {
    setState(() {
      finalDate = "$startDate - $endDate";
      print("final date is $finalDate");
    });
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      final DateTime rangeStartDate = args.value.startDate;
      final DateTime rangeEndDate = args.value.endDate;
      // print(rangeStartDate);
      // print(rangeEndDate);
      if (rangeStartDate != null && rangeEndDate == null) {
        setState(() {
          startDate =
              "${rangeStartDate.year.toString()}-${rangeStartDate.month.toString().padLeft(2, '0')}-${rangeStartDate.day.toString().padLeft(2, '0')}";
        });
      } else {
        setState(() {
          startDate =
              "${rangeStartDate.year.toString()}-${rangeStartDate.month.toString().padLeft(2, '0')}-${rangeStartDate.day.toString().padLeft(2, '0')}";

          endDate =
              "${rangeEndDate.year.toString()}-${rangeEndDate.month.toString().padLeft(2, '0')}-${rangeEndDate.day.toString().padLeft(2, '0')}";
        });
      }
      // String dateSlug ="${today.year.toString()}-${today.month.toString().padLeft(2,'0')}-${today.day.toString().padLeft(2,'0')}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text("From"),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Container(
                      height: 63.h,
                      width: 157.w,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xFF008083), width: 3),
                          borderRadius: BorderRadius.circular(4)),
                      child: Center(
                        child: Text(
                          startDate,
                          style: blackStyle(context)
                              .copyWith(color: Color(0xFF6B6B6B)),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text("To"),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Container(
                      height: 63.h,
                      width: 157.w,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xFF008083), width: 3),
                          borderRadius: BorderRadius.circular(4)),
                      child: Center(
                        child: Text(
                          endDate,
                          style: blackStyle(context)
                              .copyWith(color: Color(0xFF6B6B6B)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 1,
              color: Get.isDarkMode? Colors.grey: Colors.grey,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: SfDateRangePicker(
                confirmText: "APPLY",
                showNavigationArrow: true,
                startRangeSelectionColor: Color(0xFF008083),
                endRangeSelectionColor: Color(0xFF008083),
                rangeSelectionColor: Color(0xFF008083),
                todayHighlightColor: Color(0xFF008083),
                selectionColor: Color(0xFF008083),
                showActionButtons: true,
                onSelectionChanged: _onSelectionChanged,
                selectionMode: DateRangePickerSelectionMode.range,
                onSubmit: (Object? value) {
                  setFinalDate();
                  // if (value is PickerDateRange) {
                  //   final DateTime rangeStartDate = value.startDate!;
                  //   final DateTime rangeEndDate = value.endDate!;
                  //   print(rangeStartDate);
                  //   print(rangeEndDate);
                  // } else if (value is DateTime) {
                  //   final DateTime selectedDate = value;
                  // } else if (value is List<DateTime>) {
                  //   final List<DateTime> selectedDates = value;
                  // } else if (value is List<PickerDateRange>) {
                  //   final List<PickerDateRange> selectedRanges = value;
                  // }

                  Navigator.pop(
                    context,
                    finalDate,
                  );
                },
                onCancel: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
