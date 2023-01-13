// import 'package:advisor/HomePage/Stock/enter_amout.dart';
// import 'package:advisor/HomePage/Stock/hz/sellShare/enter_amout.dart';
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// class TredingChart extends StatefulWidget {
//   const TredingChart({Key? key}) : super(key: key);

//   @override
//   State<TredingChart> createState() => _TredingChartState();
// }

// class _TredingChartState extends State<TredingChart> {
//   late List<SalesData> _chartData;
//   late TooltipBehavior _tooltipBehavior;
//   @override
//   void initState() {
//     _chartData = getChartData();
//     _tooltipBehavior = TooltipBehavior(enable: true);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Container(
//         width: screenSize.width * 1,
//         decoration: const BoxDecoration(
//             // color: Color(0xff000000),
//             ),
//         child: CustomScrollView(
//           // shrinkWrap: true,
//           slivers: [
//             SliverAppBar(
//               automaticallyImplyLeading: false,
//               flexibleSpace: Container(
//                 decoration: const BoxDecoration(),
//               ),
//               pinned: true,
//               centerTitle: true,
//               title: Row(
//                 children: [
//                   IconButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     icon: const Icon(
//                       Icons.arrow_back_ios,
//                     ),
//                     iconSize: 22,
//                     color: const Color(0xffCC9900),
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.only(
//                       left: 0,
//                     ),
//                     child: Text(
//                       'Angelina Jolie',
//                       style: TextStyle(
//                         fontSize: 28,
//                         color: Color(0xffffffff),
//                         fontWeight: FontWeight.w600,
//                         fontFamily: 'Helvetica',
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//               backgroundColor: const Color(0xff000000),
//               elevation: 0,
//             ),
//             SliverToBoxAdapter(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 15),
//                     Container(
//                       decoration: BoxDecoration(
//                         color: const Color(0xffffffff),
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                       width: screenSize.width * 1,
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 18, horizontal: 10),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Image.asset('assets/image/benAffleck.png'),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 const Text(
//                                   'G300',
//                                   style: TextStyle(
//                                     fontSize: 40,
//                                     color: Color(0xffcc9900),
//                                   ),
//                                 ),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: const [
//                                     Icon(
//                                       Icons.keyboard_arrow_down,
//                                       size: 14,
//                                       color: Color(0xff000000),
//                                     ),
//                                     SizedBox(width: 2),
//                                     Text(
//                                       '+3.84%',
//                                       style: TextStyle(
//                                         fontSize: 12,
//                                         color: Color(0xff000000),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                 color: const Color(0xffcc9900),
//                                 borderRadius: BorderRadius.circular(15),
//                               ),
//                               child: const Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: 11, vertical: 6),
//                                 child: Text(
//                                   'Watchlist',
//                                   style: TextStyle(
//                                     fontSize: 10,
//                                     color: Color(0xffffffff),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 45),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: const [
//                             Text(
//                               'Market Value',
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: Color(0xffcc9900),
//                               ),
//                             ),
//                             Text(
//                               '20,351.00',
//                               style: TextStyle(
//                                 fontSize: 18,
//                               ),
//                             ),
//                           ],
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(right: 60),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: const [
//                               Text(
//                                 'Net Value',
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   color: Color(0xffcc9900),
//                                 ),
//                               ),
//                               Text(
//                                 '28,451.00',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 40),
//                     SizedBox(
//                       height: screenSize.width,
//                       width: screenSize.width,
//                       child: SfCartesianChart(
//                         // title: ChartTitle(text: 'Yearly sales analysis'),
//                         // legend: Legend(isVisible: true),
//                         plotAreaBorderWidth: 0,
//                         tooltipBehavior: _tooltipBehavior,
//                         series: <SplineSeries>[
//                           SplineSeries<SalesData, double>(
//                             name: 'Sales',
//                             dataSource: _chartData,
//                             xValueMapper: (SalesData sales, _) => sales.year,
//                             yValueMapper: (SalesData sales, _) => sales.sales,
//                             // dataLabelSettings: const DataLabelSettings(isVisible: true),
//                             enableTooltip: true,
//                             color: Colors.black,
//                             width: 2,
//                             opacity: 1,
//                             // dashArray: const <double>[5, 5],
//                             splineType: SplineType.cardinal,
//                             cardinalSplineTension: 0.8,
//                           )
//                         ],
//                         primaryXAxis: NumericAxis(
//                           // labelFormat: '{value}D',
//                           edgeLabelPlacement: EdgeLabelPlacement.shift,
//                         ),
//                         primaryYAxis: NumericAxis(
//                           labelFormat: '{value}',
//                           // numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 50),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Material(
//                           borderRadius: BorderRadius.circular(28),
//                           color: const Color(0xff5FB670),
//                           child: InkWell(
//                             splashColor:
//                                 const Color(0xffffffff).withOpacity(0.5),
//                             borderRadius: BorderRadius.circular(50),
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => const EnterAmount(),
//                                 ),
//                               );
//                             },
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Container(
//                                   width: screenSize.width * 0.4,
//                                   height: 50,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(28),
//                                     // color: const Color(0xffCC9900),
//                                   ),
//                                   child: const Center(
//                                     child: Text(
//                                       'Buy',
//                                       style: TextStyle(
//                                         fontSize: 20,
//                                         color: Color(0xffffffff),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Material(
//                           borderRadius: BorderRadius.circular(28),
//                           color: const Color(0xffF23030),
//                           child: InkWell(
//                             splashColor:
//                                 const Color(0xffffffff).withOpacity(0.5),
//                             borderRadius: BorderRadius.circular(50),
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) =>
//                                       const EnterAmountForSell(),
//                                 ),
//                               );
//                             },
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Container(
//                                   width: screenSize.width * 0.4,
//                                   height: 50,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(28),
//                                     // color: const Color(0xffCC9900),
//                                   ),
//                                   child: const Center(
//                                     child: Text(
//                                       'Sell',
//                                       style: TextStyle(
//                                         fontSize: 20,
//                                         color: Color(0xffffffff),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 30),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   List<SalesData> getChartData() {
//     final List<SalesData> chartData = [
//       SalesData(2017, 0),
//       SalesData(2018, 28),
//       SalesData(2019, 24),
//       SalesData(2020, 23),
//       SalesData(2021, 22),
//       SalesData(2022, 23),
//       SalesData(2023, 10),
//       SalesData(2024, 23),
//       SalesData(2025, 12),
//       SalesData(2026, 8),
//     ];
//     return chartData;
//   }
// }

// class SalesData {
//   SalesData(this.year, this.sales);
//   final double year;
//   final double sales;
// }
