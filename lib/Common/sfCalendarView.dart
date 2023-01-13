import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:piadvisory/Common/app_bar.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class SFcalend extends StatefulWidget {
  SFcalend({Key? key}) : super(key: key);

  @override
  State<SFcalend> createState() => _SFcalendState();
}

class _SFcalendState extends State<SFcalend> {
  CalendarView _view = CalendarView.month;
  final GlobalKey _globalKey = GlobalKey();
  Appointment? _selectedAppointment;
  late List<DateTime> _visibleDates;
  @override
  void initState() {
    calendarController.view = _view;

    super.initState();
  }

  final CalendarController calendarController = CalendarController();

  final ScrollController controller = ScrollController();
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
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
        timeSlotViewSettings: const TimeSlotViewSettings(
            minimumAppointmentDuration: Duration(minutes: 60)));
  }

  @override
  Widget build(BuildContext context) {
    final Widget calendar = _getAppointmentEditorCalendar(
      calendarController,
      MeetingDataSource(getAppointments()),
      _onCalendarTapped,
      _onViewChanged,
    );
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: calendarController.view == CalendarView.month && screenHeight < 800
          ? Scrollbar(
              thumbVisibility: true,
              controller: controller,
              child: ListView(
                controller: controller,
                children: <Widget>[
                  Container(
                    //  color: model.cardThemeColor,
                    height: 600,
                    child: calendar,
                  )
                ],
              ))
          : Container(child: calendar),
    );

    // return
    // Scaffold(
    //   appBar: CustomAppBar(titleTxt: "testing"),
    //   body: SfCalendar( key: _globalKey,
    //     showNavigationArrow: true,
    //     todayHighlightColor: Color(0xFF008083),
    //     allowViewNavigation: true,
    //     viewNavigationMode: ViewNavigationMode.none,
    //     showDatePickerButton: true,
    //     view: CalendarView.month,
    //     firstDayOfWeek: 6,
    //     monthViewSettings: const MonthViewSettings(
    //         appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
    //     //initialDisplayDate: DateTime(2021, 03, 01, 08, 30),
    //     //initialSelectedDate: DateTime(2021, 03, 01, 08, 30),
    //     dataSource: MeetingDataSource(getAppointments()),
    //     onTap: (onSelectionChanged) {
    //       //Get.toNamed('/select_time_and_date');
    //     },
    //   ),
    // );
  }
}

List<Appointment> getAppointments() {
  List<Appointment> meetings = <Appointment>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
      DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));

  meetings.add(Appointment(
      startTime: startTime,
      endTime: endTime,
      subject: 'Board Meeting',
      color: Colors.blue,
      recurrenceRule: 'FREQ=DAILY;COUNT=10',
      isAllDay: false));

  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
