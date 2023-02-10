import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:piadvisory/Common/CreateBottomBar.dart';
import 'package:piadvisory/Common/CustomAppbarWithIcons.dart';
import 'package:piadvisory/Common/CustomNextButton.dart';
import 'package:piadvisory/Common/GlobalFuntionsVariables.dart';
import 'package:piadvisory/HomePage/Stock/stock.dart';
import 'package:piadvisory/Portfolio/PortfolioMainUI.dart';
import 'package:piadvisory/Profile/KYC/SchduleAppointment.dart';
import 'package:piadvisory/SideMenu/CartPi2.dart';
import 'package:piadvisory/SideMenu/NavDrawer.dart';
import 'package:piadvisory/SideMenu/Subscribe/Mysubscription.dart';
import 'package:piadvisory/Utils/custom_icons_icons.dart';
import 'package:piadvisory/Utils/textStyles.dart';
import '../HomePage/Homepage.dart';
import '../smallcase_api_methods.dart';

class CartPI extends StatefulWidget {
  const CartPI({Key? key}) : super(key: key);

  @override
  State<CartPI> createState() => _CartPIState();
}

class _CartPIState extends State<CartPI> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final frequencyuselected = TextEditingController();
  final datecontroller = TextEditingController();
  final amountselected = TextEditingController();
  final quarterlylected = TextEditingController();
  DateTime? _selectedDate;
  bool _isstartselected = false;
  bool _isoneselected = false;
  bool _is500selected = false;
  bool _is10000selected = false;
  bool _is15000selected = false;

  Future _showFrequencypicker() async {
    FocusScope.of(context).unfocus();
    final data = await showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: const FrequencyPicker(),
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
        frequencyuselected.text = data;
      });
    }
  }

  Future _showQuarterlypicker() async {
    FocusScope.of(context).unfocus();
    final data = await showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: const QuarterlyPicker(),
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
        quarterlylected.text = data;
      });
    }
  }

  void _presentDatePicker() {
    // showDatePicker is a pre-made funtion of Flutter
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      // Check if no date is selected
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
        datecontroller.text =
            "${_selectedDate!.day.toString()}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.year.toString().padLeft(2, '0')}";
      });
    });
  }

  void _selectedTab(int index) {
    setState(() {
      switch (index) {
        case 0:
          {
            Navigator.push(
                context, MaterialPageRoute(builder: ((context) => HomePage())));
          }
          break;

        case 1:
          {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => Stocks(
                          selectedPage: 0,
                        ))));
          }
          break;

        case 2:
          {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => Mysubscription())));
          }
          break;
        case 3:
          {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => SchduleAppointment())));
          }
          break;
        case 4:
          {
            openDashboardPage(context);
            // Navigator.push(context,
            //     MaterialPageRoute(builder: ((context) => PortfolioMainUI())));
          }
          break;
        default:
          {
            throw Error();
          }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return Scaffold(
        drawer: NavDrawer(),
        key: _key,
        appBar: CustomAppBarWithIcons(
          isprofile: false,
          titleTxt: "Cart",
          globalkey: _key,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: showFab
            ? Stack(
                children: [
                  Positioned(
                    bottom: 22,
                    right: MediaQuery.of(context).size.width * 0.43,
                    child: FloatingActionButton(
                      backgroundColor: Color(0xFFF78104),
                      heroTag: "tag1",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    const Mysubscription())));
                      },
                      tooltip: 'Subscribe',
                      elevation: 2.0,
                      child:SvgPicture.asset(
                  "assets/images/product sans logo wh new.svg",
                  color: Colors.white,
                  fit: BoxFit.contain,
                  width: 28,
                  height: 24,
                ),
                    ),
                  ),
                ],
              )
            : null,
        bottomNavigationBar:CreateBottomBar(stateBottomNav, "Bottombar", context),
        body: _buildBody(context));
  }

  Widget _buildBody(context) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 0,
          right: 0,
        ),
        child: Center(
          heightFactor: 1.1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(
                  //   width: 16,
                  //   height: 30,
                  // ),
                  Image.asset(
                    'assets/images/icici.png',
                    width: 50.w,
                    height: 50.h,
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Text("ICICI Prudential Technology \nDirect Plan SM",
                      style: TextStyle(
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                          fontSize: 16.sm,
                          fontWeight: FontWeight.w600)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Equity Sectorial / Thematic",
                    style: TextStyle(
                        color: Get.isDarkMode ? Colors.white : Colors.grey,
                        fontSize: 12.sm),
                  ),
                ],
              ),
              SizedBox(
                height: 48.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35.w,
                    height: 40.h,
                    child: TextButton(
                      onPressed: () {
                        _isstartselected = true;
                        _isoneselected = false;
                      },
                      style: ButtonStyle(
                        backgroundColor: _isstartselected
                            ? MaterialStateProperty.all<Color>(
                                Color(0xFF008083),
                              )
                            : MaterialStateProperty.all<Color>(
                                Color(0xFF008083)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side:  BorderSide(
                              width: 2.w,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      child: Text(
                        "Start SIP",
                        style: blackStyle(context).copyWith(
                            fontSize: 20.sm,
                            color:
                                _isstartselected ? Colors.white : Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35.w,
                    height: 40.h,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _isoneselected = true;
                          _isstartselected = false;
                          Get.off(() => CartPI2());
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: _isoneselected
                            ? MaterialStateProperty.all<Color>(
                                Color(0xFF008083),
                              )
                            : MaterialStateProperty.all<Color>(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side:  BorderSide(
                              width: 2.w,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      // child: GestureDetector(
                      //   onTap: () {
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: ((context) => CartPI2())));
                      //   },
                      child: Text(
                        "One Time",
                        style: blackStyle(context).copyWith(
                            fontSize: 20.sm,
                            color:
                                _isoneselected ? Colors.white : Colors.black),
                      ),
                      //),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "₹ 30000",
                    style: TextStyle(
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                      fontSize: 35.sm,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
              Divider(
                thickness: 2,
                color: Get.isDarkMode ? Colors.grey : Colors.grey,
              ),
              SizedBox(
                height: 12.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25.w,
                    height: 40.h,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _is500selected = true;
                          _is10000selected = false;
                          _is15000selected = false;
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: _is500selected
                            ? MaterialStateProperty.all<Color>(
                                Color(0xFF008083),
                              )
                            : MaterialStateProperty.all<Color>(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side:  BorderSide(
                              width: 2.w,
                              color: Color(0xFF008083),
                            ),
                          ),
                        ),
                      ),
                      child: Text(
                        "+ ₹500",
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: _is500selected
                                ? Colors.white
                                : Color(0xFF008083)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.29.w,
                    height: 40.h,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _is10000selected = true;
                          _is500selected = false;
                          _is15000selected = false;
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: _is10000selected
                            ? MaterialStateProperty.all<Color>(
                                Color(0xFF008083),
                              )
                            : MaterialStateProperty.all<Color>(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side:  BorderSide(
                              width: 2.w,
                              color: Color(0xFF008083),
                            ),
                          ),
                        ),
                      ),
                      child: Text(
                        "+ ₹10000",
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: _is10000selected
                                ? Colors.white
                                : Color(0xFF008083)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.29.w,
                    height: 40.h,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _is15000selected = true;
                          _is500selected = false;
                          _is10000selected = false;
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: _is15000selected
                            ? MaterialStateProperty.all<Color>(
                                Color(0xFF008083),
                              )
                            : MaterialStateProperty.all<Color>(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side:  BorderSide(
                              width: 2.w,
                              color: Color(0xFF008083),
                            ),
                          ),
                        ),
                      ),
                      child: Text(
                        "+ ₹15000",
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: _is15000selected
                                ? Colors.white
                                : Color(0xFF008083)),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 28.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "SIP Frequency",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.sm,
                    ),
                  ),
                  Text(
                    "SIP Date",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.sm,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Cartdropdown(
                        hinttext: "Frequency",
                        controller: frequencyuselected,
                        ontap: () => _showFrequencypicker(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: CartDatePickerWidget(
                        datecontroller: datecontroller,
                        ontap: () => _presentDatePicker(),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      FlutterSwitch(
                        width: 50.0.w,
                        height: 25.0.h,
                        toggleColor: Colors.white,
                        activeColor: Color(0xFF008083),
                        inactiveColor: Colors.grey,
                        value: true,
                        //switchit, // value function is switchit to use dark theme
                        onToggle: (val) {
                          setState(() {
                            // if (widget.isdarkMode) {
                            //   ThemeServices().switchTheme();
                            //   switchit = !switchit;
                            // }
                            //isSwitched = val;
                          });
                        },
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        "Step Up  ⓘ",
                        style: TextStyle(
                            color: Get.isDarkMode ? Colors.grey : Colors.black,
                            fontSize: 16.sm,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Text(
                    "See IND Benefits",
                    style: TextStyle(
                      color: Color(0xFF008083),
                      fontSize: 16.sm,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Step Up Amount",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.sm,
                    ),
                  ),
                  Text(
                    "Step Up Amount",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.sm,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: CartCustomTextFields(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter Amount";
                          } else if (value.isEmpty) {
                            return "Please Enter Amount";
                          }
                          return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                        ],
                        txtinptype: TextInputType.number,
                        hint: "Enter Amount",
                        controller: amountselected,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Cartdropdown(
                        hinttext: "Periods",
                        controller: quarterlylected,
                        ontap: () => _showQuarterlypicker(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 60.h,
              ),
              SizedBox(
                width: 350.w,
                child: CustomNextButton(
                  text: "Continue",
                  ontap: () {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Cartdropdown extends StatelessWidget {
  const Cartdropdown({
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
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      onTap: (() => ontap()),
      readOnly: true,
      cursorColor: Colors.grey,
      style:  TextStyle(
        fontFamily: 'Product Sans',
        fontSize: 16.sm,
        fontWeight: FontWeight.w500,
      ),
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        helperText: "",
        focusedBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.grey, width: 2.0.w),
        ),
        enabledBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.grey, width: 2.0.w),
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
        hintStyle:
            Theme.of(context).textTheme.headline3!.copyWith(color: Colors.grey),
        hintText: hinttext,
      ),
    );
  }
}

class CartDatePickerWidget extends StatelessWidget {
  const CartDatePickerWidget({
    Key? key,
    required this.datecontroller,
    required this.ontap,
  }) : super(key: key);

  final TextEditingController datecontroller;
  final GestureTapCallback ontap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: datecontroller,
      onTap: (() => ontap()),
      readOnly: true,
      cursorColor: Colors.grey,
      style:  TextStyle(
        fontFamily: 'Product Sans',
        fontSize: 16.sm,
        fontWeight: FontWeight.w500,
      ),
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          helperText: "",
          focusedBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.grey, width: 2.0.w),
          ),
          enabledBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.grey, width: 2.0.w),
          ),
          suffixIcon: IconButton(
            icon: const Icon(
              Icons.date_range,
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
          hintText: "Select Date"),
    );
  }
}

class CartCustomTextFields extends StatelessWidget {
  const CartCustomTextFields(
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
        fontSize: 13.sm,
        fontWeight: FontWeight.w500,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      decoration: InputDecoration(
        focusedBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.grey, width: 2.0.w),
        ),
        enabledBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.grey, width: 2.0.w),
        ),
        errorBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.red, width: 2.0.w),
        ),
        focusedErrorBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.red, width: 2.0.w),
        ),
        helperText: "",
        hintText: hint,
        hintStyle:
            Theme.of(context).textTheme.headline3!.copyWith(color: Colors.grey),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: validator,
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

class FrequencyPicker extends StatefulWidget {
  const FrequencyPicker({Key? key}) : super(key: key);

  @override
  State<FrequencyPicker> createState() => _FrequencyPickerState();
}

class _FrequencyPickerState extends State<FrequencyPicker> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Text("Select Frequency", style: blackStyle(context)),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Yearly");
                  }),
                  title: const Text("Yearly"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Monthly");
                  }),
                  title: const Text("Monthly"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Weekly");
                  }),
                  title: const Text("Weekly"),
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

class QuarterlyPicker extends StatefulWidget {
  const QuarterlyPicker({Key? key}) : super(key: key);

  @override
  State<QuarterlyPicker> createState() => _QuarterlyPickerState();
}

class _QuarterlyPickerState extends State<QuarterlyPicker> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Text("Select Period", style: blackStyle(context)),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Quarterly");
                  }),
                  title: const Text("Quarterly"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Weekly");
                  }),
                  title: const Text("Weekly"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Monthly");
                  }),
                  title: const Text("Monthly"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Yearly");
                  }),
                  title: const Text("Yearly"),
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
