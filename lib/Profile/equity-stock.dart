// ignore_for_file: file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:piadvisory/Common/CreateBottomBar.dart';
import 'package:piadvisory/Common/GlobalFuntionsVariables.dart';
import 'package:piadvisory/HomePage/Homepage.dart';
import 'package:piadvisory/HomePage/Stock/stock.dart';
import 'package:piadvisory/Portfolio/PortfolioMainUI.dart';
import 'package:piadvisory/Profile/KYC/Repository/scheduleAppointment.dart';
import 'package:piadvisory/Profile/KYC/SchduleAppointment.dart';
import 'package:piadvisory/SideMenu/Subscribe/Mysubscription.dart';
import 'package:piadvisory/Utils/textStyles.dart';
import '../Common/app_bar.dart';
import '../Common/fab_bottom_app_bar.dart';
import 'package:intl/intl.dart';
import '../Utils/custom_icons_icons.dart';
import '../smallcase_api_methods.dart';

// ignore: must_be_immutable
class Equitystock extends StatefulWidget {
  Equitystock({Key? key, this.dateis}) : super(key: key);

  @override
  State<Equitystock> createState() => _EquitystockState();
  DateTime? dateis;
}

class _EquitystockState extends State<Equitystock> {
  String _lastSelected = 'TAB: 0';
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

  Map<String, dynamic> updata = {};

  @override
  void initState() {
    super.initState();
    updata = {
      "date": "${widget.dateis!.year.toString()}-" +
          "${widget.dateis!.month.toString()}-" +
          "${widget.dateis!.day.toString()}",
    };
    print("date received is $updata");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: ScheduleAppointment().fetchAppointmentDetailsByDate(updata),
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
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occured',
                  style: TextStyle(fontSize: 18),
                ),
              );
            }
          }
          return _buildScaffoldBody();
        },
      ),
    );
  }

  Widget _buildScaffoldBody() {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Stack(
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
                          builder: ((context) => const Mysubscription())));
                },
                tooltip: 'Subscribe',
                elevation: 2.0,
                child: SvgPicture.asset(
                  "assets/images/product sans logo wh new.svg",
                  color: Colors.white,
                  fit: BoxFit.contain,
                  width: 28,
                  height: 24,
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar:CreateBottomBar(stateBottomNav, "Bottombar", context),
        appBar: CustomAppBar(
            titleTxt: appointmentbyDates?.status?.advisory ?? "",
            bottomtext: false),
        body: _buildBody(context));
  }

  Widget _buildBody(context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              DateFormat('EEEE, d MMM, yyyy').format(widget.dateis!),
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),
            SizedBox(
              height: 5,
            ),
            Text("${DateFormat('h:mm a').format(widget.dateis!)}",
                style: TextStyle(fontSize: 12, color: Colors.black)),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: Column(
                children: [
                  appointmentbyDates?.status?.link == null
                      ? Container()
                      : Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(255, 212, 209, 208),
                                blurRadius: 10.0,
                                spreadRadius: 0,
                                offset: Offset(
                                  4.0,
                                  4.0,
                                ),
                              )
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Image.asset(
                                  'assets/images/images.png',
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                flex: 10,
                                child: SizedBox(
                                  width: 270,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Join with Zoom Meet",
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontSize: 16.sm,
                                          color: Color(0xFF008083),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        appointmentbyDates?.status?.link ?? "",
                                        style: TextStyle(
                                          color: Color(0xFF444444),
                                          fontSize: 10.sm,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: SizedBox(
                                    child: SvgPicture.asset(
                                        'assets/images/share_black_24dp.svg')),
                              ),
                            ],
                          ),
                        ),
                  const SizedBox(
                    height: 30,
                  ),
                  appointmentbyDates?.status?.link == null
                      ? Container()
                      : Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(255, 212, 209, 208),
                                blurRadius: 10.0,
                                spreadRadius: 0,
                                offset: Offset(
                                  4.0,
                                  4.0,
                                ),
                              )
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                  width: 15,
                                  height: 15,
                                  child: Icon(
                                    FontAwesomeIcons.bell,
                                    size: 20,
                                    color: Color(0xFF008083),
                                  )),
                              const SizedBox(
                                width: 20,
                              ),
                              SizedBox(
                                child: Text(
                                  "30 minutes before",
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 16.sm,
                                    color: Color(0xFF000000),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                  const SizedBox(
                    height: 30,
                  ),
                  if (appointmentbyDates?.status?.guests != null)
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      height: 160,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 212, 209, 208),
                            blurRadius: 10.0,
                            spreadRadius: 0,
                            offset: Offset(
                              4.0,
                              4.0,
                            ),
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 0,
                            child: Column(
                              children: [
                                const SizedBox(
                                    width: 15,
                                    height: 15,
                                    child: Icon(
                                      FontAwesomeIcons.users,
                                      size: 20,
                                      color: Color(0xFF008083),
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  " Guests",
                                  style: blackStyle(context).copyWith(
                                      fontSize: 16.sm, color: Colors.black),
                                ),
                                // Text(
                                //   "1 yes, 1 awaiting",
                                //   style: blackStyle(context).copyWith(
                                //       fontSize: 10.sm, color: Color(0xFF6B6B6B)),
                                // ),
                                SizedBox(
                                  height: 18,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 25,
                                      height: 25,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.24),
                                        child: Image.asset(
                                          "assets/images/profile.png",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          appointmentbyDates
                                                  ?.status?.guests?.guestName ??
                                              "",
                                          style: blackStyle(context).copyWith(
                                              fontSize: 13,
                                              color: Color(0xFF444444)),
                                        ),
                                        Text(
                                          appointmentbyDates
                                                  ?.status?.guests?.guestName ??
                                              "",
                                          style: blackStyle(context).copyWith(
                                              fontSize: 10,
                                              color: Color(0xFF6B6B6B)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 25,
                                      height: 25,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.24),
                                        child: Image.asset(
                                          "assets/images/profile.png",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          appointmentbyDates?.status?.guests
                                                  ?.guestEmail ??
                                              "",
                                          style: blackStyle(context).copyWith(
                                              fontSize: 13,
                                              color: Color(0xFF444444)),
                                        ),
                                        Text(
                                          appointmentbyDates?.status?.guests
                                                  ?.guestEmail ??
                                              "",
                                          style: blackStyle(context).copyWith(
                                              fontSize: 10,
                                              color: Color(0xFF6B6B6B)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 0,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  FontAwesomeIcons.envelope,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(
                    height: 30,
                  ),
                  appointmentbyDates?.status?.link == null
                      ? Container()
                      : SizedBox(
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                  width: 20,
                                  height: 15,
                                  child: SvgPicture.asset(
                                      "assets/images/Group 4429.svg")),
                              const SizedBox(
                                width: 20,
                              ),
                              SizedBox(
                                width: 270,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      appointmentbyDates?.status?.advisory ??
                                          "NA",
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF000000),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // SizedBox(
                        //     child:
                        //         SvgPicture.asset("assets/images/calendar.svg")),
                        // const SizedBox(
                        //   width: 20,
                        // ),
                        // SizedBox(
                        //   width: 270,
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     mainAxisAlignment: MainAxisAlignment.start,
                        //     children: const [
                        //       Text(
                        //         "Events",
                        //         maxLines: 2,
                        //         style: TextStyle(
                        //           fontSize: 16,
                        //           color: Color(0xFF000000),
                        //         ),
                        //       ),
                        //       Text(
                        //         "aditya@gmail.com",
                        //         maxLines: 2,
                        //         style: TextStyle(
                        //           fontSize: 10,
                        //           color: Color(0xFF6B6B6B),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
