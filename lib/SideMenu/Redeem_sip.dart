import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:piadvisory/Common/CreateBottomBar.dart';
import 'package:piadvisory/Common/CustomAppbarWithIcons.dart';
import 'package:piadvisory/Common/Customfloatingbutton.dart';
import 'package:piadvisory/Common/GlobalFuntionsVariables.dart';
import 'package:piadvisory/HomePage/Stock/MutualFundsTab.dart';
import 'package:piadvisory/SideMenu/NavDrawer.dart';
import 'package:piadvisory/Utils/textStyles.dart';

class ReedeemSip extends StatefulWidget {
  const ReedeemSip({super.key});

  @override
  State<ReedeemSip> createState() => _ReedeemSipState();
}

class _ReedeemSipState extends State<ReedeemSip> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  DateTime? _selectedDate;

  TextEditingController holding = TextEditingController();
  TextEditingController folio = TextEditingController();
  TextEditingController sipdatecontroller = TextEditingController();
  bool? accept = false;
  bool? until = false;

  Future _showHoldingpicker() async {
    FocusScope.of(context).unfocus();
    final data = await showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: const Holding(),
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
        holding.text = data;
      });
    }
  }

  Future _showDematicker() async {
    FocusScope.of(context).unfocus();
    final data = await showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: const Folio(),
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
        folio.text = data;
      });
    }
  }

  void _pastDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1922),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
        sipdatecontroller.text =
            "${_selectedDate!.day.toString()}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.year.toString().padLeft(2, '0')}";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool showfab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: NavDrawer(),
      key: _key,
      appBar: CustomAppBarWithIcons(
        titleTxt: "Redeem Order",
        globalkey: _key,
        isprofile: false,
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: showfab
      //     ? Stack(
      //         children: [
      //           Positioned(
      //               bottom: 22,
      //               right: MediaQuery.of(context).size.width * 0.43,
      //               child: CustomFloatingButton())
      //         ],
      //       )
      //     : null,
      // bottomNavigationBar:
      //     CreateBottomBar(stateBottomNav, "Bottombar", context),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  //vertical: 20
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "AXIS Focussed 25 Fund (G)",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        Text("Equity Focused-fund")
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "37.2700",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        Text(
                          "0.30 (0.80%)",
                          style: TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Invest by",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.redAccent.shade700),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(2),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      onPressed: null,
                      child: Text(
                        "SIP",
                        style: TextStyle(color: Colors.black),
                      ))
                ],
              ),
              Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Frequency",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.redAccent.shade700),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(2),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      onPressed: null,
                      child: Text(
                        "Monthly",
                        style: TextStyle(color: Colors.black),
                      ))
                ],
              ),
              Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Holding Mode",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 140),
                    child: Text(
                      "Demat ID",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 4.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      child: RedeemDropdown(
                        hinttext: "Holding  ",
                        controller: holding,
                        ontap: () => _showHoldingpicker(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: 10,
                      ),
                      child: RedeemDropdown(
                        hinttext: "Demat  ",
                        controller: folio,
                        ontap: () => _showDematicker(),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          activeColor: Colors.amber,
                          value: accept,
                          onChanged: (bool? value) {
                            setState(() {
                              accept = value!;
                            });
                          },
                        ),
                        Text(
                          "I accept Terms & Conditions & EUIN Declaration",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Center(
                        child: Text(
                      "Amount",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.redAccent),
                    )),
                    Center(
                      child: SizedBox(
                        width: 80,
                        child: TextField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: "500",
                            border: InputBorder.none,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                    ),
                    Center(
                        child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 2,
                        shadowColor: Colors.grey.shade700,
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {},
                      child: Text(
                        "Min.SIP AMount: \n 500",
                        style: TextStyle(color: Colors.black),
                      ),
                    )),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                            ),
                            child: Text(
                              "+1000",
                              style: TextStyle(fontSize: 12),
                            )),
                        ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                            ),
                            child:
                                Text("+2000", style: TextStyle(fontSize: 12))),
                        ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                            ),
                            child:
                                Text("+5000", style: TextStyle(fontSize: 12))),
                        ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                            ),
                            child: Text("+10,000",
                                style: TextStyle(fontSize: 12))),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 23),
                              child: Text(
                                "Day of Investment",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: 130,
                              child: SipdatePickerWidget(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please Select Day of Investment";
                                  }
                                },
                                datecontroller: sipdatecontroller,
                                ontap: () => _pastDatePicker(),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 43),
                              child: Text("(Every Month)"),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 63),
                              child: Text(
                                "SIP Tenure",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: 130,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "1",
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  activeColor: Colors.amber,
                                  value: until,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      until = value!;
                                    });
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 33),
                                  child: Text(
                                    "Until Canceled",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.redAccent),
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.greenAccent.shade700),
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text("BUY"),
                              Icon(Icons.arrow_circle_right_outlined)
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 100.h,
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class RedeemDropdown extends StatelessWidget {
  const RedeemDropdown({
    Key? key,
    required this.hinttext,
    required this.ontap,
    this.controller,
  }) : super(key: key);

  final String hinttext;
  final GestureTapCallback ontap;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        onTap: (() => ontap()),
        readOnly: true,
        cursorColor: Colors.grey,
        style: TextStyle(
          fontFamily: 'Product Sans',
          fontSize: 16.sm,
          fontWeight: FontWeight.w500,
        ),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          helperText: "",
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(1)),
            borderSide: BorderSide(
              color: Colors.grey.shade200,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(1)),
            borderSide: BorderSide(
              color: Colors.grey.shade200,
            ),
          ),
          suffixIcon: IconButton(
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.grey,
            ),
            onPressed: () {
              ontap();
            },
          ),
          hintStyle: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(color: Colors.grey),
          hintText: hinttext,
        ),
      ),
    );
  }
}

class Holding extends StatefulWidget {
  const Holding({Key? key}) : super(key: key);

  @override
  State<Holding> createState() => _HoldingState();
}

class _HoldingState extends State<Holding> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Text("Select Holding",
                style: Theme.of(context).textTheme.headline2),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Demat");
                  }),
                  title: const Text("Demat"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Folio");
                  }),
                  title: const Text("Folio"),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}

class Folio extends StatefulWidget {
  const Folio({Key? key}) : super(key: key);

  @override
  State<Folio> createState() => _FolioState();
}

class _FolioState extends State<Folio> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Text("Select Folio",
                style: Theme.of(context).textTheme.headline2),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "456464");
                  }),
                  title: const Text("456464"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "14447");
                  }),
                  title: const Text("14447"),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}

class SipdatePickerWidget extends StatelessWidget {
  const SipdatePickerWidget(
      {Key? key,
      required this.datecontroller,
      required this.ontap,
      this.validator})
      : super(key: key);

  final TextEditingController datecontroller;
  final GestureTapCallback ontap;
  final dynamic validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: datecontroller,
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
              Icons.date_range,
              color: Color(0xFF008083),
            ),
            onPressed: () {
              ontap();
            },
          ),
          hintStyle:
              // Theme.of(context).textTheme.headline3,
              blackStyle(context).copyWith(
                  fontSize: 16.sm,
                  fontWeight: FontWeight.w400,
                  color: Get.isDarkMode
                      ? Colors.white
                      : Color(0xFF303030).withOpacity(0.3)),
          hintText: "Day"),
    );
  }
}
