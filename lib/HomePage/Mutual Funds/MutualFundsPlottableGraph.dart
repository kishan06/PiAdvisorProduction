// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart' show DateFormat;

class MutualFundsPlottableGraph extends StatefulWidget {
  MutualFundsPlottableGraph({Key? key, this.dateList, this.priceList})
      : super(key: key);

  List<String>? dateList;
  List<String>? priceList;
  @override
  State<MutualFundsPlottableGraph> createState() =>
      _MutualFundsPlottableGraphState();
}

class _MutualFundsPlottableGraphState extends State<MutualFundsPlottableGraph> {
  late List<SalesData> _chartData;
  late TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
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
    List<LineSeries<ChartSampleData, DateTime>> uplist = [];
    List<ChartSampleData> dynamicdata = [];
    List<DateTime> upDate = [];
    for (var i = 0; i < widget.dateList!.length; i++) {
      upDate.add(inputFormat.parse(widget.dateList![i]));
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
