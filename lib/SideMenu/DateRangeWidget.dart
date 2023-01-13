
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piadvisory/Common/CustomNextButton.dart';
import 'package:piadvisory/SideMenu/DateDialog.dart';
import 'package:piadvisory/Utils/textStyles.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DateRangeWidget extends StatefulWidget {
  const DateRangeWidget({Key? key}) : super(key: key);

  @override
  State<DateRangeWidget> createState() => _DateRangeWidgetState();
}

String selectedCat = "Select Category";
String? selecteddate = "";

class _DateRangeWidgetState extends State<DateRangeWidget> {
  Future _showEquityPicker() async {
    FocusScope.of(context).unfocus();
    final data = await showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: EquityCat(),
        );
      },
      shape:  RoundedRectangleBorder(
       side: BorderSide(color: Get.isDarkMode? Colors.grey: Colors.white),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );

    if (data != null) {
      setState(() {
        selectedCat = data;
      });
    }
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    print(args.value);
  }

  Future _showDateDialog() async {
    FocusScope.of(context).unfocus();
    final data = await showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: const DateDialog(),
        );
      },
      shape:  RoundedRectangleBorder(
         side: BorderSide(color: Get.isDarkMode? Colors.grey: Colors.white),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
          
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
    setState(() {
      selecteddate = data;
    });
    print(data);
  }

  Future _showMultiDatePicker() async {
    FocusScope.of(context).unfocus();
    final data = await showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Scaffold(
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: SfDateRangePicker(
              showActionButtons: true,
              onSelectionChanged: _onSelectionChanged,
              selectionMode: DateRangePickerSelectionMode.range,
              onSubmit: (Object? value) {
                print(value);
                Navigator.pop(context);
              },
              onCancel: () {
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
      shape:  RoundedRectangleBorder(
         side: BorderSide(color: Get.isDarkMode? Colors.grey: Colors.white),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );

    if (data != null) {
      setState(() {
        selectedCat = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -80,
            right: MediaQuery.of(context).size.width * 0.35,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                "Search & Filter",
                style:
                    blackStyle(context).copyWith(fontWeight: FontWeight.bold,color: Get.isDarkMode? Colors.white: Colors.black,)
              ),
              const SizedBox(
                height: 40,
              ),
              TextFormField(
                onTap: (() => _showEquityPicker()),
                readOnly: true,
                cursorColor: Colors.grey,
                style: const TextStyle(
                  fontFamily: 'Product Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    // enabledBorder: const OutlineInputBorder(
                    //     borderSide: BorderSide(color: Color(0xFF008083), width: 2)),
                    disabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF008083), width: 2)),
                    focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF008083), width: 2)),
                    border: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF008083), width: 2)),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        _showEquityPicker();
                      },
                    ),
                    hintStyle:  TextStyle(
                      fontSize: 16,
                      fontFamily: 'Product Sans',
                      color: Get.isDarkMode? Colors.white: Colors.grey
                    ),
                    hintText: selectedCat,
                    labelText: "  Category   ",
                    labelStyle: blackStyle(context)
                        .copyWith(color:Get.isDarkMode? Colors.white: const Color(0xFF444444))),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                onTap: (() => _showDateDialog()),
                readOnly: true,
                cursorColor: Colors.grey,
                style: const TextStyle(
                  fontFamily: 'Product Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    // enabledBorder: const OutlineInputBorder(
                    //     borderSide: BorderSide(color: Color(0xFF008083), width: 2)),
                    disabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF008083), width: 2)),
                    focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF008083), width: 2)),
                    border: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF008083), width: 2)),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        // _showEquityPicker();
                      },
                    ),
                    hintStyle: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Product Sans',
                    ),
                    hintText: selecteddate,
                    labelText: "  Date Range  ",
                    labelStyle: blackStyle(context)
                        .copyWith(color:Get.isDarkMode? Colors.white: const Color(0xFF444444))),
              ),
              const SizedBox(
                height: 46,
              ),
              SizedBox(
                  width: double.infinity,
                  child: CustomNextButton(
                    text: "Search",
                    ontap: () {
                      Navigator.pop(context, selecteddate);
                    },
                  )),
            ],
          ),
        ],
      ),
    ));
  }
}

class EquityCat extends StatefulWidget {
  EquityCat({Key? key}) : super(key: key);

  @override
  State<EquityCat> createState() => _EquityCatState();
}

class _EquityCatState extends State<EquityCat> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Text("Select Category", style: blackStyle(context)),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Equity");
                  }),
                  title: const Text("Equity"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Stocks");
                  }),
                  title: const Text("Stocks"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Mutual Funds");
                  }),
                  title: const Text("Mutual Funds"),
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
