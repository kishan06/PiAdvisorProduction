// ignore_for_file: file_names, depend_on_referenced_packages, avoid_print, prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:piadvisory/Common/CreateBottomBar.dart';
import 'package:piadvisory/Common/Customfloatingbutton.dart';
import 'package:piadvisory/Common/GlobalFuntionsVariables.dart';
import 'package:piadvisory/HomePage/Stock/stock.dart';

import 'package:piadvisory/Login/Repository/UserVerified.dart';
import 'package:piadvisory/Portfolio/PortfolioMainUI.dart';
import 'package:piadvisory/Utils/base_manager.dart';

import 'package:piadvisory/themedata.dart';

import '../smallcase_api_methods.dart';

import '/Common/CustomAppbarWithIcons.dart';
import '/HomePage/Homepage.dart';
import '/Profile/KYC/SchduleAppointment.dart';
import '/SideMenu/NavDrawer.dart';
import '/SideMenu/Subscribe/Mysubscription.dart';
import '/Utils/custom_icons_icons.dart';
import '/Utils/textStyles.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:piadvisory/Utils/Dialogs.dart';
//import 'Stock/stock.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool state = false;
  bool showingAdditionalDetails = false;
  String _lastSelected = 'TAB: 0';
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  // Future<void> UploadData() async {
  //   print("upload data called");
  //   Map<String, dynamic> updata = {
  //     "finger_status": fingerPrintStatus,
  //   };

  //   final data = await UserVerified().postUpdateFingerstatus(updata);

  //   if (data.status == ResponseStatus.SUCCESS) {
  //     return utils.showToast("Finger print enabled");
  //   } else {
  //     return utils.showToast(data.message);
  //   }
  // }

  void _selectedTab(int index) {
    setState(() {
      _lastSelected = 'TAB: $index';
      print(_lastSelected);

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
    return Scaffold(
      key: _key,
      drawer: NavDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 22,
            right: MediaQuery.of(context).size.width * 0.43,
            child: CustomFloatingButton(),
            // FloatingActionButton(
            //   backgroundColor: Color(0xFFF78104),
            //   heroTag: "tag1",
            //   onPressed: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: ((context) => const Mysubscription())));
            //   },
            //   tooltip: 'Subscribe',
            //   elevation: 2.0,
            //   child: SvgPicture.asset(
            //       "assets/images/product sans logo wh new.svg",
            //       color: Colors.white,
            //       fit: BoxFit.contain,
            //       width: 28,
            //       height: 24,
            //     ),
            // ),
          ),
        ],
      ),
      bottomNavigationBar: CreateBottomBar(stateBottomNav, "Bottombar", context),
      appBar: CustomAppBarWithIcons(
        titleTxt: "Settings",
        globalkey: _key,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                "App Preferences",
                style: // Theme.of(context).textTheme.headline6,
                    blackStyle(context).copyWith(
                        color: Get.isDarkMode ? Colors.black : Colors.grey,
                        fontSize: 10),
              ),
              // const SizedBox(
              //   height: 20,
              // ),
              // CustomListTile(
              //   leadingimage: 'assets/images/color-mode-svgrepo-com.svg',
              //   title: "Dark Mode",
              //   statecontroller: state,
              //   sizefactor: MediaQuery.of(context).size.width * 0.4,
              //   isdarkMode: true,
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // Divider(
              //   thickness: 1,
              // ),
              SizedBox(
                height: 10,
              ),
              CustomListTile2(
                title: "Finger Print",
                leadingimage: 'assets/images/Group6056.svg',
                statecontroller: fingerPrintStatus ? true : false,
                sizefactor: MediaQuery.of(context).size.width * 0.39,
                isdarkMode: false,
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 1,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 0,
                      child: SizedBox(
                          width: 15,
                          height: 15,
                          child: SvgPicture.asset(
                            "assets/images/notification-icon.svg",
                            color: Theme.of(context).iconTheme.color,
                          )),
                    ),
                    const Expanded(
                      flex: 1,
                      child: VerticalDivider(
                        color: Color(0xFF878787),
                        indent: 5,
                        endIndent: 5,
                        thickness: 1,
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            showingAdditionalDetails =
                                !showingAdditionalDetails;
                          });
                        },
                        child: Text(
                          "Manage Notification",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            showingAdditionalDetails =
                                !showingAdditionalDetails;
                          });
                        },
                        child: Icon(
                            !showingAdditionalDetails
                                ? Icons.keyboard_arrow_down_rounded
                                : Icons.keyboard_arrow_up_rounded,
                            color: Get.isDarkMode
                                ? ThemeData.dark().iconTheme.color
                                : ThemeData.light().iconTheme.color
                            //Get.isDarkMode ? Colors.white : Colors.black
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              if (showingAdditionalDetails)
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("- Mutual Funds"),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.44,
                                ),
                                //  FlutterSwitch(
                                //   width: 45.0,
                                //   height: 20.0,
                                //   toggleColor: Colors.white,
                                //   activeColor: Color(0xFF008083),
                                //   inactiveColor: Colors.grey,
                                //   value: false,
                                //   //switchit, // value function is switchit to use dark theme
                                //   onToggle: (val) {
                                //     setState(() {
                                //       // fingerPrintStatus = val;
                                //       // widget.statecontroller = val;
                                //       // print("fingerprint status is $fingerPrintStatus");
                                //       // UploadData();
                                //       // widget.statecontroller = val;
                                //     });
                                //   },
                                //  ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text("- Stocks"),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.54,
                                ),
                                //  FlutterSwitch(
                                //   width: 45.0,
                                //   height: 20.0,
                                //   toggleColor: Colors.white,
                                //   activeColor: Color(0xFF008083),
                                //   inactiveColor: Colors.grey,
                                //   value: false,
                                //   //switchit, // value function is switchit to use dark theme
                                //   onToggle: (val) {
                                //     setState(() {
                                //       // fingerPrintStatus = val;
                                //       // widget.statecontroller = val;
                                //       // print("fingerprint status is $fingerPrintStatus");
                                //       // UploadData();
                                //       // widget.statecontroller = val;
                                //     });
                                //   },
                                //  ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text("- Tax Investments"),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.39,
                                ),
                                //  FlutterSwitch(
                                //   width: 45.0,
                                //   height: 20.0,
                                //   toggleColor: Colors.white,
                                //   activeColor: Color(0xFF008083),
                                //   inactiveColor: Colors.grey,
                                //   value: false,
                                //   //switchit, // value function is switchit to use dark theme
                                //   onToggle: (val) {
                                //     setState(() {
                                //       // fingerPrintStatus = val;
                                //       // widget.statecontroller = val;
                                //       // print("fingerprint status is $fingerPrintStatus");
                                //       // UploadData();
                                //       // widget.statecontroller = val;
                                //     });
                                //   },
                                //  ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomListTile2 extends StatefulWidget {
  CustomListTile2({
    Key? key,
    required this.leadingimage,
    required this.title,
    this.statecontroller = false,
    required this.sizefactor,
    required this.isdarkMode,
    this.ontap,
  }) : super(key: key);

  final String? leadingimage;
  final String? title;
  bool statecontroller;
  double sizefactor;
  bool isdarkMode;

  final Function()? ontap;
  @override
  State<CustomListTile2> createState() => _CustomListTile2State();
}

class _CustomListTile2State extends State<CustomListTile2> {
  Settings obj = Settings();
  //bool switchit = ThemeServices().loadThemeFromBox();
  //bool isSwitched = false;
  Future<void> UploadData() async {
    print("upload data called");
    Map<String, dynamic> updata = {
      "finger_status": fingerPrintStatus,
    };

    final data = await UserVerified().postUpdateFingerstatus(updata);

    if (data.status == ResponseStatus.SUCCESS) {
      return utils.showToast(data.message);
    } else {
      return utils.showToast(data.message);
    }
  }

  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: SvgPicture.asset(
              widget.leadingimage!,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          Expanded(
            child: const VerticalDivider(
              color: Color(0xFF878787),
              indent: 10,
              endIndent: 10,
              thickness: 1,
            ),
          ),
          Expanded(
            flex: 13,
            child: Text(
              widget.title!,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Expanded(
            flex: 3,
            child: FlutterSwitch(
              width: 50.0,
              height: 25.0,
              toggleColor: Colors.white,
              activeColor: Color(0xFF008083),
              inactiveColor: Colors.grey,
              value: widget.statecontroller,
              //switchit, // value function is switchit to use dark theme
              onToggle: (val) {
                setState(() {
                  fingerPrintStatus = val;
                  widget.statecontroller = val;
                  print("fingerprint status is $fingerPrintStatus");
                  UploadData();
                  // widget.statecontroller = val;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CustomListTile extends StatefulWidget {
  CustomListTile(
      {Key? key,
      required this.leadingimage,
      required this.title,
      this.statecontroller = false,
      required this.sizefactor,
      required this.isdarkMode})
      : super(key: key);

  final String? leadingimage;
  final String? title;
  bool statecontroller;
  double sizefactor;
  bool isdarkMode;

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  bool switchit = ThemeServices().loadThemeFromBox();
  //bool isSwitched = false;
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: SvgPicture.asset(
              widget.leadingimage!,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          Expanded(
            child: const VerticalDivider(
              color: Color(0xFF878787),
              indent: 10,
              endIndent: 10,
              thickness: 1,
            ),
          ),
          Expanded(
            flex: 13,
            child: Text(
              widget.title!,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          // Expanded(
          //   flex: 3,
          //   child: FlutterSwitch(
          //     width: 50.0,
          //     height: 25.0,
          //     toggleColor: Colors.white,
          //     activeColor: Color(0xFF008083),
          //     inactiveColor: Colors.grey,
          //     value: switchit,
          //     //switchit, // value function is switchit to use dark theme
          //     onToggle: (val) {
          //       setState(() {

          //         ThemeServices().switchTheme();
          //         // switchit = !switchit;

          //         switchit = val;
          //       });
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
