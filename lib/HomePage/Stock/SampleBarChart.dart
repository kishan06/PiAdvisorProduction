// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarChart extends StatefulWidget {
  const BarChart({Key? key}) : super(key: key);

  @override
  State<BarChart> createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {
  late TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCartesianChart(
        // title: ChartTitle(text: 'Yearly sales analysis'),
        // legend: Legend(isVisible: true),
        plotAreaBorderWidth: 0,
        tooltipBehavior: _tooltipBehavior,
        series: <ColumnSeries<ChartSampleData, String>>[
          ColumnSeries<ChartSampleData, String>(
            dataSource: <ChartSampleData>[
              ChartSampleData(
                x: '2016',
                y: 0.541,
              ),
              ChartSampleData(x: '2017', y: 0.818),
              ChartSampleData(x: '2018', y: 1.51),
              ChartSampleData(x: '2019', y: 1.302),
              ChartSampleData(x: '2020', y: 2.017),
              ChartSampleData(x: '2022', y: 1.683),
            ],
            xValueMapper: (ChartSampleData sales, _) => sales.x as String,
            yValueMapper: (ChartSampleData sales, _) => sales.y,
            dataLabelSettings: const DataLabelSettings(
                isVisible: true, textStyle: TextStyle(fontSize: 10)),
          )
        ],
        primaryXAxis: CategoryAxis(
          majorGridLines: const MajorGridLines(width: 0),
        ),
        primaryYAxis: NumericAxis(
            axisLine: const AxisLine(width: 0),
            labelFormat: '{value}',
            majorTickLines: const MajorTickLines(size: 0)
            // numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
            ),
      ),
    );
  }

  List<SalesData> getChartData() {
    final List<SalesData> chartData = [
      SalesData(2017, 0),
      SalesData(2018, 15),
      SalesData(2019, 24),
      SalesData(2020, 23),
      SalesData(2021, 22),
      SalesData(2022, 23),
      SalesData(2023, 10),
      SalesData(2024, 23),
      SalesData(2025, 12),
      SalesData(2026, 8),
    ];
    return chartData;
  }
}

class _ChartData {
  _ChartData(this.x, this.y, this.y2);
  final double x;
  final double y;
  final double y2;
}

class SalesData {
  SalesData(this.year, this.sales);
  final double year;
  final double sales;
}

// ignore: empty_constructor_bodies
class ChartSampleData {
  ChartSampleData({
    this.x,
    this.y,
  });

  final dynamic x;
  final num? y;
}
