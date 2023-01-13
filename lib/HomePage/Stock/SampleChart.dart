// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart' show DateFormat;

class SampleChart extends StatefulWidget {
  SampleChart(
      {Key? key, required this.lastMonthDate, this.dateList, this.priceList})
      : super(key: key);

  String lastMonthDate;
  List<String>? dateList;
  List<String>? priceList;
  @override
  State<SampleChart> createState() => _SampleChartState();
}

class _SampleChartState extends State<SampleChart> {
  late List<SalesData> _chartData;
  late TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
    print("list of date is ${widget.dateList!}");
    // _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        height: screenSize.width,
        width: screenSize.width,
        child: SfCartesianChart(
          // title: ChartTitle(text: 'Yearly sales analysis'),
          // legend: Legend(isVisible: true),
          plotAreaBorderWidth: 0,
          tooltipBehavior: _tooltipBehavior,
          series: _getDefaultDateTimeSeries(),
          primaryXAxis:
              DateTimeAxis(majorGridLines: const MajorGridLines(width: 0)),
          primaryYAxis: NumericAxis(
            // title: AxisTitle(text: "Price"),
            labelFormat: '{value}',
            // numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
          ),
        ),
      ),
    );
  }

  List<LineSeries<ChartSampleData, DateTime>> _getDefaultDateTimeSeries() {
    DateFormat inputFormat = DateFormat('MM/dd/yyyy hh:mm:ss a');

    DateTime kk = inputFormat.parse(widget.dateList!.last);

    List<LineSeries<ChartSampleData, DateTime>> uplist = [];
    List<ChartSampleData> dynamicdata = [];
    List<DateTime> upDate = [];
    for (var i = 0; i < widget.dateList!.length; i++) {
      upDate.add(inputFormat.parse(widget.dateList![i]));
      // uplist.add(LineSeries<ChartSampleData, DateTime>(
      //   dataSource: <ChartSampleData>[
      //     ChartSampleData(
      //         x: upDate[i], yValue: double.parse(widget.priceList![i])),
      //   ],
      //   xValueMapper: (ChartSampleData data, _) => data.x as DateTime,
      //   yValueMapper: (ChartSampleData data, _) => data.yValue,
      //   color: const Color.fromRGBO(242, 117, 7, 1),
      // )
      // );
      dynamicdata.add(
        ChartSampleData(
            x: upDate[i], yValue: double.parse(widget.priceList![i])),
      );
    }
    return <LineSeries<ChartSampleData, DateTime>>[
      LineSeries<ChartSampleData, DateTime>(
        dataSource: dynamicdata,
        xValueMapper: (ChartSampleData data, _) => data.x as DateTime,
        yValueMapper: (ChartSampleData data, _) => data.yValue,
        color: Color(0xFF008083),
      )
    ];
  }

  // List<SalesData> getChartData() {
  //   var currentDate = DateTime.now();
  //   print("current date is ${currentDate.day}");
  //   DateFormat inputFormat = DateFormat('dd/MM/yyyy hh:mm:ss a');
  //   DateTime now = inputFormat.parse(widget.lastMonthDate);

  //   print("last month date is ${now.day}");
  //   for (var i = 0; i < 10; i++) {}
  //   final List<SalesData> chartData = [
  //     SalesData(14, 664.8),
  //     SalesData(15, 655.1),
  //     SalesData(16, 642.85),
  //     SalesData(17, 643.65),
  //     SalesData(18, 638.85),
  //     SalesData(19, 627.15),
  //     SalesData(20, 625.7),
  //     // SalesData(2024, 23),
  //     // SalesData(2025, 12),
  //     // SalesData(2026, 8),
  //   ];
  //   return chartData;
  // }

}

class ChartSampleData {
  ChartSampleData({
    required this.x,
    required this.yValue,
  });
  final DateTime x;
  final double yValue;
}

class _ChartData {
  _ChartData(this.x, this.y, this.y2);
  final double x;
  final double y;
  final double y2;
}

class SalesData {
  SalesData(this.year, this.sales, this.numbers);
  final DateTime year;
  final String sales;
  final double numbers;
}
