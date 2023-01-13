// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:piadvisory/Utils/textStyles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'indicator.dart';
import './Color_extension.dart';

class PieChartMutualFunds extends StatefulWidget {
  const PieChartMutualFunds({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PieChartMutualFundsState();
}

class PieChartMutualFundsState extends State {
  int touchedIndex = -1;

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
                        });
                      }),
                      startDegreeOffset: 180,
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 5,
                      centerSpaceRadius: 0,
                      sections: showingSections()),
                ),
              ),
            ),
            // const SizedBox(
            //   width: 25,
            // ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Indicator(
                    color: const Color(0xFF008083),
                    text: ' Motilal Oswal S&P',
                    isSquare: true,
                    size: touchedIndex == 0 ? 18 : 16,
                    textColor: touchedIndex == 0 ? Colors.black :Get.isDarkMode? Colors.white:Colors.black,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Indicator(
                    color: const Color(0xffB2D9D9),
                    text: ' ICICI Prudential',
                    isSquare: true,
                    size: touchedIndex == 1 ? 18 : 16,
                    textColor: touchedIndex == 1 ? Colors.black : Get.isDarkMode? Colors.white:Colors.black,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Indicator(
                    color: const Color(0xffF78104),
                    text: ' Axis Short Term',
                    isSquare: true,
                    size: touchedIndex == 2 ? 18 : 16,
                    textColor: touchedIndex == 2 ? Colors.black : Get.isDarkMode? Colors.white:Colors.black,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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

  List<PieChartSectionData> showingSections() {
    return List.generate(
      3,
      (i) {
        final isTouched = i == touchedIndex;

        const color0 = Color(0xFF008083);
        const color1 = Color(0xffB2D9D9);
        const color2 = Color(0xffF78104);

        switch (i) {
          case 0:
            return PieChartSectionData(
              color: color0,
              value: 20,
              title: '10K',
              radius: 65,
              titleStyle: blackStyle(context).copyWith(color: Colors.white),
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? BorderSide(color: color0.darken(40), width: 6)
                  : BorderSide(color: color0.withOpacity(0)),
            );
          case 1:
            return PieChartSectionData(
              color: color1,
              value: 30,
              title: '10K',
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
              value: 60,
              title: '20K',
              radius: 65,
              titleStyle: blackStyle(context).copyWith(color: Colors.white),
              titlePositionPercentageOffset: 0.6,
              borderSide: isTouched
                  ? BorderSide(color: color2.darken(40), width: 6)
                  : BorderSide(color: color2.withOpacity(0)),
            );

          default:
            throw Error();
        }
      },
    );
  }
}
