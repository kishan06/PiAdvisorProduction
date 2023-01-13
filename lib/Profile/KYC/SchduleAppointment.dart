// ignore_for_file: file_names, avoid_print

import 'dart:async';

import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';
import 'package:piadvisory/Common/StreamEnum.dart';
import 'package:piadvisory/HomePage/Stock/stock.dart';
import 'package:piadvisory/Portfolio/PortfolioMainUI.dart';
import 'package:piadvisory/Profile/KYC/Repository/scheduleAppointment.dart';
import 'package:piadvisory/Profile/KYC/SelectTimeAndDate.dart';
import 'package:intl/intl.dart';
import 'package:piadvisory/Utils/Constants.dart';
import 'package:piadvisory/Utils/base_manager.dart';
import 'package:piadvisory/smallcase_api_methods.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/Common/CustomAppbarWithIcons.dart';
import '/Common/CustomNextButton.dart';
import 'package:dio/dio.dart' as prefix;
import '/Profile/equity-stock.dart';
import '/SideMenu/NavDrawer.dart';
import '/Utils/custom_icons_icons.dart';
import '/Utils/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:get/get.dart';
import '../../HomePage/Homepage.dart';
//import '../../HomePage/Stock/stock.dart';
//import '../../Portfolio/PortfolioMainUI.dart';
import '../../SideMenu/Subscribe/Mysubscription.dart';
import 'Model/ScheduleAppointmentModel.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

ScheduleAppointmentModel? fetchedAppointments;

class SchduleAppointment extends StatefulWidget {
  SchduleAppointment({Key? key, this.initialindex = 0}) : super(key: key);
  int initialindex;
  @override
  State<SchduleAppointment> createState() => _SchduleAppointmentState();
}

class _SchduleAppointmentState extends State<SchduleAppointment> {
  String? selectedValue;
  String _lastSelected = 'TAB: 0';
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  CalendarView _view = CalendarView.month;
  final GlobalKey _globalKey = GlobalKey();
  Appointment? _selectedAppointment;
  late List<DateTime> _visibleDates;
  final CalendarController calendarController = CalendarController();
  StreamController<requestResponseState> scheduleAppointmentController =
      StreamController.broadcast();
  //Calendar settings

  void _onViewChanged(ViewChangedDetails visibleDatesChangedDetails) {
    _visibleDates = visibleDatesChangedDetails.visibleDates;
    if (_view == calendarController.view ||
        (_view != CalendarView.month &&
            calendarController.view != CalendarView.month)) {
      return;
    }

    SchedulerBinding.instance.addPostFrameCallback((Duration timeStamp) {
      setState(() {
        _view = calendarController.view!;

        /// Update the current view when the calendar view changed to
        /// month view or from month view.
      });
    });
  }

  final List<CalendarView> _allowedViews = <CalendarView>[
    CalendarView.day,
    CalendarView.week,
    CalendarView.workWeek,
    CalendarView.month,
    CalendarView.schedule
  ];
  void _onCalendarTapped(CalendarTapDetails calendarTapDetails) {
    /// Condition added to open the editor, when the calendar elements tapped
    /// other than the header.
    if (calendarTapDetails.targetElement == CalendarElement.header ||
        calendarTapDetails.targetElement == CalendarElement.resourceHeader) {
      return;
    }

    _selectedAppointment = null;

    /// Navigates the calendar to day view,
    /// when we tap on month cells in mobile.
    if (calendarController.view == CalendarView.month) {
      calendarController.view = CalendarView.day;
    } else {
      if (calendarTapDetails.appointments != null &&
          calendarTapDetails.targetElement == CalendarElement.appointment) {
        final dynamic appointment = calendarTapDetails.appointments![0];
        if (appointment is Appointment) {
          _selectedAppointment = appointment;
        }
      }

      final DateTime selectedDate = calendarTapDetails.date!;
      final CalendarElement targetElement = calendarTapDetails.targetElement;
    }
  }

  SfCalendar _getAppointmentEditorCalendar(
      [CalendarController? calendarController,
      CalendarDataSource? calendarDataSource,
      dynamic calendarTapCallback,
      ViewChangedCallback? viewChangedCallback,
      dynamic scheduleViewBuilder]) {
    return SfCalendar(
        todayHighlightColor: const Color(0xFF008083),
        backgroundColor: Get.isDarkMode
            ? Color(0xFF303030).withOpacity(0.3)
            : Color(0xFFF8F8F8),
        controller: calendarController,
        showNavigationArrow: false,
        allowedViews: _allowedViews,
        showDatePickerButton: true,
        scheduleViewMonthHeaderBuilder: scheduleViewBuilder,
        dataSource: calendarDataSource,
        onTap: calendarTapCallback,
        onViewChanged: viewChangedCallback,
        initialDisplayDate: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day),
        monthViewSettings: const MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.indicator),
        timeSlotViewSettings: const TimeSlotViewSettings(
            minimumAppointmentDuration: Duration(minutes: 60)));
  }

  void _selectedTab(int index) {
    setState(() {
      _lastSelected = 'TAB: $index';
      print(_lastSelected);

      switch (index) {
        case 0:
          {
            // FirebaseCrashlytics.instance.crash();
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
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: ((context) => SchduleAppointment())));
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
  void initState() {
    calendarController.view = _view;
    //  myfuture = ScheduleAppointment().fetchappointments();
    fetchAppointments();
    super.initState();
  }

  prefix.Dio dio = new prefix.Dio();

  Future<ResponseData> fetchAppointments() async {
    prefix.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token').toString();
    try {
      response = await dio.get(
          "${ApiConstant.base}api/get_users_all_appointments",
          options: prefix.Options(headers: {"authorization": "Bearer $token"}));
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      print("api resp of fetch appointments is ${response.data}");
      fetchedAppointments = ScheduleAppointmentModel.fromJson(response.data);
      scheduleAppointmentController.add(requestResponseState.DataReceived);

      return ResponseData<dynamic>(
        "success",
        ResponseStatus.SUCCESS,
      );
    } else {
      try {
        return ResponseData<dynamic>(
            response.data['message'].toString(), ResponseStatus.FAILED);
      } catch (_) {
        return ResponseData<dynamic>(
            response.statusMessage!, ResponseStatus.FAILED);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: NavDrawer(),
      appBar: CustomAppBarWithIcons(
        globalkey: _key,
        titleTxt: 'Calendar',
      ),
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
                "assets/images/product sans logo wh.svg",
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: TextStyle(color: Color(0xFFF78104)),
        unselectedLabelStyle: TextStyle(color: Colors.grey),
        unselectedIconTheme: IconThemeData(color: Colors.grey),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              CustomIcons.path_3177,
              //  color:
              //         Get.isDarkMode ? Color(0xFFF78104) : Color(0xFFF78104)
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(
                CustomIcons.path_4346,
                //  color:
                //       Get.isDarkMode ? Color(0xFFF78104) : Color(0xFFF78104)
              ),
            ),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CustomIcons.group_2369,
              //  color:
              //         Get.isDarkMode ? Color(0xFFF78104) : Color(0xFFF78104)
            ),
            label: 'Subscribe',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CustomIcons.date_range,
              //  color:
              //           Get.isDarkMode ? Color(0xFFF78104) : Color(0xFFF78104)
            ),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CustomIcons.bottombarbagicon,
              size: 22.5,
              //  color:
              //         Get.isDarkMode ? Color(0xFFF78104) : Color(0xFFF78104)
            ),
            label: 'Dashboard',
          ),
        ],
        currentIndex: 3,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Color(0xFFF78104),
        backgroundColor: Colors.white,
        onTap: (index) {
          print(index);
          _selectedTab(index);
        },
        type: BottomNavigationBarType.fixed,
      ),
      backgroundColor: Get.isDarkMode ? Colors.black : const Color(0xFFF8F8F8),
      body: StreamBuilder<requestResponseState>(
          stream: scheduleAppointmentController.stream,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: Lottie.asset(
                    "assets/images/lf30_editor_jc6n8oqe.json",
                    repeat: true,
                    height: 50,
                    width: 50,
                  ),
                );

              default:
                if (snapshot.hasError) {
                  return Text("Error Occured");
                } else {
                  return _buildBody(context);
                }
            }
          }),
    );
  }

  Widget _buildBody(
    context,
  ) {
    print("reached here");
    final Widget calendar = _getAppointmentEditorCalendar(
      calendarController,
      MeetingDataSource(getAppointments()),
      _onCalendarTapped,
      _onViewChanged,
    );
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Stack(clipBehavior: Clip.none, children: [
                calendar,
              ]),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: CustomNextButton(
                    text: 'Schedule a Session',
                    ontap: () {
                      Get.toNamed('/select_time_and_date');
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              DefaultTabController(
                initialIndex: widget.initialindex,
                length: 3,
                child: Column(
                  children: [
                    TabBar(
                        labelColor:
                            Get.isDarkMode ? Colors.white : Color(0xFF000000),
                        indicatorColor: Get.isDarkMode
                            ? Color(0xFF008082)
                            : Color(0xFF008083),
                        isScrollable: true,
                        unselectedLabelStyle: TextStyle(
                            color: Get.isDarkMode
                                ? Color(0xFF6B6B6B)
                                : Color(0xFF6B6B6B)),
                        labelStyle: TextStyle(
                          color:
                              Get.isDarkMode ? Colors.white : Color(0xFF000000),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        tabs: [
                          Tab(
                            text: "Scheduled Advice",
                          ),
                          Tab(
                            text: "Requested Advice",
                          ),
                          Tab(
                            text: "Past Advice",
                          ),
                        ]),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 300.h,
                      child: TabBarView(children: [
                        fetchedAppointments!.scheduleData!.isEmpty
                            ? MissingOutPage()
                            : ScheduleAdvicePage(),
                        fetchedAppointments!.requestedData!.isEmpty
                            ? MissingOutPage()
                            : RequestedAdvice(),
                        fetchedAppointments!.pastData!.isEmpty
                            ? MissingOutPage()
                            : PastAdvicePage(),
                      ]),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    ));
  }
}

var logger = Logger(
  printer: PrettyPrinter(),
);
List<DateTime> meetingdata = [];
List<DateTime> scheduledAdvice = [];
List<DateTime> requestedAdvice = [];
List<DateTime> pastAdvice = [];

storescheduledAdvice() {
  // DateTime now = DateTime.now();
  // DateTime date = DateTime(now.year, now.month, now.day);
  // scheduledAdvice = meetingdata
  //     .where((element) => element.day > date.day || element.month > date.month)
  //     .toList();
  // logger.d(" data in scheduled advice is ${scheduledAdvice}");
  // pastAdvice = meetingdata
  //     .where((element) => element.day < date.day || element.month < date.month)
  //     .toList();
  // logger.d(" data in past advice is ${pastAdvice}");
  // for (var i = 0 ; i <  fetchedAppointments!.requestedData!.length ; i++) {
  //   requestedAdvice.add(fetchedAppointments!.requestedData![i].);
  // }
}

List<Appointment> getAppointments() {
  List<Appointment> meetings = <Appointment>[];

  // final DateTime startTime =
  //     DateTime.parse(appointData!.status!.last.dateTimeslot!);

  // final DateTime endTime = startTime.add(const Duration(hours: 2));
  if (fetchedAppointments?.requestedData != null &&
      fetchedAppointments!.requestedData!.isNotEmpty) {
    for (var i = 0; i < fetchedAppointments!.requestedData!.length; i++) {
      meetings.add(Appointment(
          startTime: DateTime.parse(
              fetchedAppointments!.requestedData![i].dateTimeslot ?? ""),
          endTime: DateTime.parse(
                  fetchedAppointments!.requestedData![i].dateTimeslot ?? "")
              .add(const Duration(hours: 2)),
          subject: 'Meeting',
          color: Colors.blue,
          isAllDay: false));

      DateTime starttime = DateTime.parse(
          fetchedAppointments!.requestedData![i].dateTimeslot ?? "");
      meetingdata.insert(i, starttime);
    }

    meetingdata = meetingdata.toSet().toList();

    logger.d(" meeting data is ${meetingdata}");
    storescheduledAdvice();
  }

  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}

class MissingOutPage extends StatefulWidget {
  const MissingOutPage({Key? key}) : super(key: key);

  @override
  State<MissingOutPage> createState() => _MissingOutPageState();
}

class _MissingOutPageState extends State<MissingOutPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/images/Group 5339.svg"),
          const SizedBox(
            height: 29.11,
          ),
          Text(
            "You’re missing out \non amazing opportunities.",
            textAlign: TextAlign.center,
            style: blackStyle(context)
                .copyWith(fontSize: 16, color: const Color(0xFF303030)),
          ),
          const SizedBox(
            height: 38,
          ),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: CustomNextButton(
              text: 'Schedule Your Advice Now!',
              ontap: () {
                Get.toNamed('/select_time_and_date');
              },
            ),
          ),
          // const SizedBox(
          //   height: 30,
          // ),
        ],
      ),
    );
  }
}

class ScheduleAdvicePage extends StatefulWidget {
  const ScheduleAdvicePage({Key? key}) : super(key: key);

  @override
  State<ScheduleAdvicePage> createState() => _ScheduleAdvicePageState();
}

class _ScheduleAdvicePageState extends State<ScheduleAdvicePage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: fetchedAppointments!.scheduleData!.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildBody(index);
        });
  }

  Widget _buildBody(index) {
    DateTime dateAndTimeSlots =
        DateTime.parse(fetchedAppointments!.scheduleData![index].dateTimeslot!);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            "${dateAndTimeSlots.year.toString()}-" +
                "${dateAndTimeSlots.month.toString()}-" +
                "${dateAndTimeSlots.day.toString()}",
            style: blackStyle(context).copyWith(
                fontSize: 12,
                color: Get.isDarkMode
                    ? Colors.white
                    : const Color(
                        0xFF444444,
                      )),
          ),
          const SizedBox(
            height: 9,
          ),
          SizedBox(
            height: 114,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Equitystock(dateis: dateAndTimeSlots)));
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Color(0xFF707070), width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 14),
                  child: ListTile(
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${DateFormat('EEE').format(dateAndTimeSlots)}",
                              style: TextStyle(
                                color: Color(0xFF008083),
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "${dateAndTimeSlots.day.toString()}",
                              style: TextStyle(
                                color: Color(0xFF008083),
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const VerticalDivider(
                          color: Color(0xFF878787),
                          indent: 10,
                          endIndent: 10,
                          thickness: 1,
                        ),
                      ],
                    ),
                    title: Text(
                      fetchedAppointments!.scheduleData![index].advisory ?? "",
                      style: blackStyle(context).copyWith(
                          fontSize: 18,
                          color: Get.isDarkMode ? Colors.white : Colors.black),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          fetchedAppointments!.scheduleData![index].subject ??
                              "",
                          style: blackStyle(context).copyWith(
                              fontSize: 12,
                              color: Get.isDarkMode
                                  ? Colors.white
                                  : const Color(0xFF6B6B6B)),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${DateFormat('h:mm a').format(dateAndTimeSlots)}",
                          style: blackStyle(context).copyWith(
                              fontSize: 10,
                              color: Get.isDarkMode
                                  ? Colors.white
                                  : const Color(0xFF6B6B6B)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RequestedAdvice extends StatefulWidget {
  const RequestedAdvice({Key? key}) : super(key: key);

  @override
  State<RequestedAdvice> createState() => _RequestedAdviceState();
}

class _RequestedAdviceState extends State<RequestedAdvice> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: fetchedAppointments!.requestedData!.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildBody(index);
        });
  }

  Widget _buildBody(index) {
    DateTime dateAndTimeSlots = DateTime.parse(
        fetchedAppointments!.requestedData![index].dateTimeslot!);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            "${dateAndTimeSlots.year.toString()}-" +
                "${dateAndTimeSlots.month.toString()}-" +
                "${dateAndTimeSlots.day.toString()}",
            style: blackStyle(context).copyWith(
                fontSize: 12,
                color: Get.isDarkMode
                    ? Colors.white
                    : const Color(
                        0xFF444444,
                      )),
          ),
          const SizedBox(
            height: 9,
          ),
          SizedBox(
            height: 114,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Equitystock(dateis: dateAndTimeSlots)));
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Color(0xFF707070), width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 14),
                  child: ListTile(
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${DateFormat('EEE').format(dateAndTimeSlots)}",
                              style: TextStyle(
                                color: Color(0xFF008083),
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "${dateAndTimeSlots.day.toString()}",
                              style: TextStyle(
                                color: Color(0xFF008083),
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const VerticalDivider(
                          color: Color(0xFF878787),
                          indent: 10,
                          endIndent: 10,
                          thickness: 1,
                        ),
                      ],
                    ),
                    title: Text(
                      fetchedAppointments!.requestedData![index].advisory ?? "",
                      style: blackStyle(context).copyWith(
                          fontSize: 18,
                          color: Get.isDarkMode ? Colors.white : Colors.black),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          fetchedAppointments!.requestedData![index].subject ??
                              "",
                          style: blackStyle(context).copyWith(
                              fontSize: 12,
                              color: Get.isDarkMode
                                  ? Colors.white
                                  : const Color(0xFF6B6B6B)),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${DateFormat('h:mm a').format(dateAndTimeSlots)}",
                          style: blackStyle(context).copyWith(
                              fontSize: 10,
                              color: Get.isDarkMode
                                  ? Colors.white
                                  : const Color(0xFF6B6B6B)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PastAdvicePage extends StatefulWidget {
  const PastAdvicePage({Key? key}) : super(key: key);

  @override
  State<PastAdvicePage> createState() => _PastAdvicePageState();
}

class _PastAdvicePageState extends State<PastAdvicePage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: fetchedAppointments!.pastData!.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildBody(index);
        });
  }

  Widget _buildBody(index) {
    DateTime dateAndTimeSlots =
        DateTime.parse(fetchedAppointments!.pastData![index].dateTimeslot!);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            "${dateAndTimeSlots.year.toString()}-" +
                "${dateAndTimeSlots.month.toString()}-" +
                "${dateAndTimeSlots.day.toString()}",
            style: blackStyle(context).copyWith(
                fontSize: 12,
                color: Get.isDarkMode
                    ? Colors.white
                    : const Color(
                        0xFF444444,
                      )),
          ),
          const SizedBox(
            height: 9,
          ),
          SizedBox(
            height: 114,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Equitystock(
                              dateis: dateAndTimeSlots,
                            )));
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Color(0xFF707070), width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 14),
                  child: ListTile(
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${DateFormat('EEE').format(dateAndTimeSlots)}",
                              style: TextStyle(
                                color: Color(0xFF008083),
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "${dateAndTimeSlots.day.toString()}",
                              style: TextStyle(
                                color: Color(0xFF008083),
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const VerticalDivider(
                          color: Color(0xFF878787),
                          indent: 10,
                          endIndent: 10,
                          thickness: 1,
                        ),
                      ],
                    ),
                    title: Text(
                      fetchedAppointments!.pastData![index].advisory ?? "",
                      style: blackStyle(context).copyWith(
                          fontSize: 18,
                          color: Get.isDarkMode ? Colors.white : Colors.black),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          fetchedAppointments!.pastData![index].subject ?? "",
                          style: blackStyle(context).copyWith(
                              fontSize: 12,
                              color: Get.isDarkMode
                                  ? Colors.white
                                  : const Color(0xFF6B6B6B)),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${DateFormat('h:mm a').format(dateAndTimeSlots)}",
                          style: blackStyle(context).copyWith(
                              fontSize: 10,
                              color: Get.isDarkMode
                                  ? Colors.white
                                  : const Color(0xFF6B6B6B)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
