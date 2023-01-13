// ignore_for_file: file_names

// import 'package:piadvisory/HomePage/equity.dart';
// import 'package:piadvisory/HomePage/MutualFundsDetailed.dart';
import 'package:get/get.dart';
import 'package:piadvisory/HomePage/MutualFundsDetailed.dart';
import 'package:piadvisory/HomePage/equity.dart';
import 'package:piadvisory/Utils/textStyles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:piadvisory/smallcase_api_methods.dart';
import 'holding_model.dart';
import 'indicator.dart';
import './Color_extension.dart';

class PieChartSample1 extends StatefulWidget {
  const PieChartSample1({required this.holdings, Key? key}) : super(key: key);

  final Map<String, dynamic>? holdings;

  @override
  State<StatefulWidget> createState() =>
      PieChartSample1State(holdings: holdings);
}

class PieChartSample1State extends State {
  PieChartSample1State({required this.holdings});
  final Map<String, dynamic>? holdings;

  int touchedIndex = -1;
  double myNetWorth = 0;

  @override
  void initState() {
    super.initState();
    if (holdings != null) {
      List data = holdings!['securities'];
      var mapped = data
          .map<HoldingModel>((json) => HoldingModel.fromJson(json))
          .toList();
      mapped.forEach((holding) {
        myNetWorth += double.parse(holding.averagePrice!) *
            double.parse(holding.quantity!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                      pieTouchData: PieTouchData(touchCallback:
                          (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;
                          debugPrint("Pie Touched Index: $touchedIndex");
                          if (touchedIndex == 0) {
                            //fetch holdings
                            openEquityPage(context, holdings!);
                          }
                        });
                      }),
                      startDegreeOffset: 180,
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 5,
                      centerSpaceRadius: 0,
                      sections: showingSections(myNetWorth: myNetWorth)),
                ),
              ),
            ),
            const SizedBox(
              width: 40,
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      openEquityPage(context, holdings!);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: ((context) => const Equityinner())));
                    },
                    child: Indicator(
                      color: const Color(0xFF008083),
                      text: ' Equity',
                      isSquare: true,
                      size: touchedIndex == 0 ? 18 : 16,
                      textColor: touchedIndex == 0
                          ? Colors.black
                          : Get.isDarkMode
                              ? Colors.white
                              : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 50),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: ((context) => const mutulinner())));
                  //   },
                  //   child: Indicator(
                  //     color: const Color(0xffB2D9D9),
                  //     text: ' Mutual Fund',
                  //     isSquare: true,
                  //     size: touchedIndex == 1 ? 18 : 16,
                  //     textColor: touchedIndex == 1
                  //         ? Colors.black
                  //         : Get.isDarkMode
                  //             ? Colors.white
                  //             : Colors.black,
                  //   ),
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Indicator(
                  //   color: const Color(0xffF78104),
                  //   text: ' Fix Deposit',
                  //   isSquare: true,
                  //   size: touchedIndex == 2 ? 18 : 16,
                  //   textColor: touchedIndex == 2
                  //       ? Colors.black
                  //       : Get.isDarkMode
                  //           ? Colors.white
                  //           : Colors.black,
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Indicator(
                  //   color: const Color(0xFFFDD9B3),
                  //   text: ' Real Estate',
                  //   isSquare: true,
                  //   size: touchedIndex == 3 ? 18 : 16,
                  //   textColor: touchedIndex == 3
                  //       ? Colors.black
                  //       : Get.isDarkMode
                  //           ? Colors.white
                  //           : Colors.black,
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections({double myNetWorth = 0}) {
    return List.generate(
      4,
      (i) {
        final isTouched = i == touchedIndex;

        const color0 = Color(0xFF008083);
        const color1 = Color(0xffB2D9D9);
        const color2 = Color(0xffF78104);
        const color3 = Color(0xFFFDD9B3);

        switch (i) {
          case 0:
            return PieChartSectionData(
              color: color0,
              value: 100,
              title:
                  // "100k",
                  "₹ ${myNetWorth.toStringAsFixed(2)}",
              radius: 65,
              titleStyle: blackStyle(context).copyWith(color: Colors.white),
              titlePositionPercentageOffset: 0.0,
              borderSide: isTouched
                  ? BorderSide(color: color0.darken(40), width: 6)
                  : BorderSide(color: color0.withOpacity(0)),
            );
          case 1:
            return PieChartSectionData(
              color: color1,
              value: 0,
              title: '50K',
              radius: 65,
              titleStyle: blackStyle(context).copyWith(color: Colors.black),
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? BorderSide(color: color1.darken(40), width: 6)
                  : BorderSide(color: color2.withOpacity(0)),
            );
          case 2:
            return PieChartSectionData(
              color: color2,
              value: 0,
              title: '25K',
              radius: 65,
              titleStyle: blackStyle(context).copyWith(color: Colors.white),
              titlePositionPercentageOffset: 0.6,
              borderSide: isTouched
                  ? BorderSide(color: color2.darken(40), width: 6)
                  : BorderSide(color: color2.withOpacity(0)),
            );
          case 3:
            return PieChartSectionData(
              color: color3,
              value: 0,
              title: '5K',
              radius: 65,
              titleStyle: blackStyle(context).copyWith(color: Colors.black),
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? BorderSide(color: color3.darken(40), width: 6)
                  : BorderSide(color: color2.withOpacity(0)),
            );
          default:
            throw Error();
        }
      },
    );
  }
}
