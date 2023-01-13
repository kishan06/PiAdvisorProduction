// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Common/app_bar.dart';
import '../Utils/textStyles.dart';

class FinancialOverview extends StatefulWidget {
  const FinancialOverview({Key? key}) : super(key: key);

  @override
  State<FinancialOverview> createState() => _FinancialOverviewState();
}

class _FinancialOverviewState extends State<FinancialOverview> {
  bool showincomestatement = false;
  bool showbalancesheet = false;
  bool showcashflow = false;
  bool showifinancialratio = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titleTxt: "Financial Overview",bottomtext: false,),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 30),
          child: Column(
            children: [
              Card(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFDFDFDF))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                    child: SizedBox(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 10,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        showincomestatement =
                                            !showincomestatement;
                                      });
                                    },
                                    child: Text(
                                      "Income Statement",
                                      style: blackStyle(context).copyWith(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        showincomestatement =
                                            !showincomestatement;
                                      });
                                    },
                                    child: Icon(
                                      !showincomestatement
                                          ? Icons.keyboard_arrow_down_rounded
                                          : Icons.keyboard_arrow_up_rounded,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (showincomestatement)
                            Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    const FirstRow(
                                      firsttitle: "QUARTERLY ",
                                      secondtitle: "Dec 2021",
                                      thirditle: "Sep 2021",
                                    ),
                                    const Divider(
                                      color: const Color(0xFFDFDFDF),
                                      thickness: 1,
                                    ),
                                    const RowWidget(
                                      firsttitle: "Sales ",
                                      secondtitle: "3,637",
                                      thirditle: "3,373",
                                    ),
                                    const Divider(
                                      color: Color(0xFFDFDFDF),
                                      thickness: 1,
                                    ),
                                    const RowWidget(
                                      firsttitle: "Other Income ",
                                      secondtitle: "113",
                                      thirditle: "153",
                                    ),
                                    const Divider(
                                      color: Color(0xFFDFDFDF),
                                      thickness: 1,
                                    ),
                                    const RowWidget(
                                      firsttitle: "Total Income ",
                                      secondtitle: "3,750",
                                      thirditle: "3,526",
                                    ),
                                    const Divider(
                                      color: const Color(0xFFDFDFDF),
                                      thickness: 1,
                                    ),
                                    const RowWidget(
                                      firsttitle: "Total Expenditure ",
                                      secondtitle: "3,057",
                                      thirditle: "2,754",
                                    ),
                                    const Divider(
                                      color: const Color(0xFFDFDFDF),
                                      thickness: 1,
                                    ),
                                    const RowWidget(
                                      firsttitle: "EBIT ",
                                      secondtitle: "673",
                                      thirditle: "785",
                                    ),
                                    const Divider(
                                      color: const Color(0xFFDFDFDF),
                                      thickness: 1,
                                    ),
                                    const RowWidget(
                                      firsttitle: "Interest ",
                                      secondtitle: "53",
                                      thirditle: "55",
                                    ),
                                    const Divider(
                                      color: Color(0xFFDFDFDF),
                                      thickness: 1,
                                    ),
                                    const RowWidget(
                                      firsttitle: "Tax ",
                                      secondtitle: "137",
                                      thirditle: "164",
                                    ),
                                    const Divider(
                                      color:
                                          const Color.fromARGB(255, 95, 95, 95),
                                      thickness: 2,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Net Profit",
                                          style: TextStyle(
                                              fontSize: 15.sm,
                                              color: Color(0xFF444444),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                        ),
                                        Text(
                                          "482",
                                          style: TextStyle(
                                              fontSize: 15.sm,
                                              color: Colors.black),
                                        ),
                                        Spacer(),
                                        Text(
                                          "563",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    )
                                  ],
                                )
                              ],
                            )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Card(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFDFDFDF))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                    child: SizedBox(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 10,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        showbalancesheet = !showbalancesheet;
                                      });
                                    },
                                    child: Text(
                                      "Balance Sheet",
                                      style: blackStyle(context).copyWith(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        //  showbalancesheet = !showbalancesheet;
                                      });
                                    },
                                    child: Icon(
                                      !showbalancesheet
                                          ? Icons.keyboard_arrow_down_rounded
                                          : Icons.keyboard_arrow_up_rounded,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          // if (showbalancesheet)
                          //   Column(
                          //     // mainAxisAlignment: MainAxisAlignment.center,
                          //     // crossAxisAlignment: CrossAxisAlignment.center,
                          //     children: [
                          //       Column(
                          //         children: [
                          //           const FirstRow(
                          //             firsttitle: "QUARTERLY ",
                          //             secondtitle: "Dec 2021",
                          //             thirditle: "Sep 2021",
                          //           ),
                          //           const Divider(
                          //             color: const Color(0xFFDFDFDF),
                          //             thickness: 1,
                          //           ),
                          //           const RowWidget(
                          //             firsttitle: "Sales ",
                          //             secondtitle: "3,637",
                          //             thirditle: "3,373",
                          //           ),
                          //           const Divider(
                          //             color: const Color(0xFFDFDFDF),
                          //             thickness: 1,
                          //           ),
                          //           const RowWidget(
                          //             firsttitle: "Other Income ",
                          //             secondtitle: "113",
                          //             thirditle: "153",
                          //           ),
                          //           const Divider(
                          //             color: const Color(0xFFDFDFDF),
                          //             thickness: 1,
                          //           ),
                          //           const RowWidget(
                          //             firsttitle: "Total Income ",
                          //             secondtitle: "3,750",
                          //             thirditle: "3,526",
                          //           ),
                          //           const Divider(
                          //             color: Color(0xFFDFDFDF),
                          //             thickness: 1,
                          //           ),
                          //           const RowWidget(
                          //             firsttitle: "Total Expenditure ",
                          //             secondtitle: "3,057",
                          //             thirditle: "2,754",
                          //           ),
                          //           const Divider(
                          //             color: Color(0xFFDFDFDF),
                          //             thickness: 1,
                          //           ),
                          //           const RowWidget(
                          //             firsttitle: "EBIT ",
                          //             secondtitle: "673",
                          //             thirditle: "785",
                          //           ),
                          //           const Divider(
                          //             color: const Color(0xFFDFDFDF),
                          //             thickness: 1,
                          //           ),
                          //           const RowWidget(
                          //             firsttitle: "Interest ",
                          //             secondtitle: "53",
                          //             thirditle: "55",
                          //           ),
                          //           const Divider(
                          //             color: Color(0xFFDFDFDF),
                          //             thickness: 1,
                          //           ),
                          //           const RowWidget(
                          //             firsttitle: "Tax ",
                          //             secondtitle: "137",
                          //             thirditle: "164",
                          //           ),
                          //           const Divider(
                          //             color:
                          //                 const Color.fromARGB(255, 95, 95, 95),
                          //             thickness: 2,
                          //           ),
                          //           Row(
                          //             children: const [
                          //               Text(
                          //                 "Net Profit",
                          //                 style: TextStyle(
                          //                     fontSize: 15,
                          //                     color: Color(0xFF444444),
                          //                     fontWeight: FontWeight.bold),
                          //               ),
                          //               SizedBox(
                          //                 width: 90,
                          //               ),
                          //               Text(
                          //                 "482",
                          //                 style: TextStyle(
                          //                     fontSize: 15,
                          //                     color: Colors.black),
                          //               ),
                          //               Spacer(),
                          //               Text(
                          //                 "563",
                          //                 style: TextStyle(
                          //                     fontSize: 15,
                          //                     color: Colors.black),
                          //               ),
                          //             ],
                          //           ),
                          //           const SizedBox(
                          //             height: 10,
                          //           )
                          //         ],
                          //       )
                          //     ],
                          //   )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Card(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFDFDFDF))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                    child: SizedBox(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 10,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        showcashflow = !showcashflow;
                                      });
                                    },
                                    child: Text(
                                      "Cash Flow",
                                      style: blackStyle(context).copyWith(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        showcashflow = !showcashflow;
                                      });
                                    },
                                    child: Icon(
                                      !showcashflow
                                          ? Icons.keyboard_arrow_down_rounded
                                          : Icons.keyboard_arrow_up_rounded,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          // if (showcashflow)
                          //   Column(
                          //     // mainAxisAlignment: MainAxisAlignment.center,
                          //     // crossAxisAlignment: CrossAxisAlignment.center,
                          //     children: [
                          //       Column(
                          //         children: [
                          //           const FirstRow(
                          //             firsttitle: "QUARTERLY ",
                          //             secondtitle: "Dec 2021",
                          //             thirditle: "Sep 2021",
                          //           ),
                          //           const Divider(
                          //             color: Color(0xFFDFDFDF),
                          //             thickness: 1,
                          //           ),
                          //           const RowWidget(
                          //             firsttitle: "Sales ",
                          //             secondtitle: "3,637",
                          //             thirditle: "3,373",
                          //           ),
                          //           const Divider(
                          //             color: const Color(0xFFDFDFDF),
                          //             thickness: 1,
                          //           ),
                          //           const RowWidget(
                          //             firsttitle: "Other Income ",
                          //             secondtitle: "113",
                          //             thirditle: "153",
                          //           ),
                          //           const Divider(
                          //             color: const Color(0xFFDFDFDF),
                          //             thickness: 1,
                          //           ),
                          //           const RowWidget(
                          //             firsttitle: "Total Income ",
                          //             secondtitle: "3,750",
                          //             thirditle: "3,526",
                          //           ),
                          //           const Divider(
                          //             color: const Color(0xFFDFDFDF),
                          //             thickness: 1,
                          //           ),
                          //           const RowWidget(
                          //             firsttitle: "Total Expenditure ",
                          //             secondtitle: "3,057",
                          //             thirditle: "2,754",
                          //           ),
                          //           const Divider(
                          //             color: Color(0xFFDFDFDF),
                          //             thickness: 1,
                          //           ),
                          //           const RowWidget(
                          //             firsttitle: "EBIT ",
                          //             secondtitle: "673",
                          //             thirditle: "785",
                          //           ),
                          //           const Divider(
                          //             color: Color(0xFFDFDFDF),
                          //             thickness: 1,
                          //           ),
                          //           const RowWidget(
                          //             firsttitle: "Interest ",
                          //             secondtitle: "53",
                          //             thirditle: "55",
                          //           ),
                          //           const Divider(
                          //             color: const Color(0xFFDFDFDF),
                          //             thickness: 1,
                          //           ),
                          //           const RowWidget(
                          //             firsttitle: "Tax ",
                          //             secondtitle: "137",
                          //             thirditle: "164",
                          //           ),
                          //           const Divider(
                          //             color:
                          //                 const Color.fromARGB(255, 95, 95, 95),
                          //             thickness: 2,
                          //           ),
                          //           Row(
                          //             children: const [
                          //               Text(
                          //                 "Net Profit",
                          //                 style: TextStyle(
                          //                     fontSize: 15,
                          //                     color: Color(0xFF444444),
                          //                     fontWeight: FontWeight.bold),
                          //               ),
                          //               SizedBox(
                          //                 width: 90,
                          //               ),
                          //               Text(
                          //                 "482",
                          //                 style: TextStyle(
                          //                     fontSize: 15,
                          //                     color: Colors.black),
                          //               ),
                          //               Spacer(),
                          //               Text(
                          //                 "563",
                          //                 style: TextStyle(
                          //                     fontSize: 15,
                          //                     color: Colors.black),
                          //               ),
                          //             ],
                          //           ),
                          //           const SizedBox(
                          //             height: 10,
                          //           )
                          //         ],
                          //       )
                          //     ],
                          //   )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Card(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFDFDFDF))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                    child: SizedBox(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 10,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        showifinancialratio =
                                            !showifinancialratio;
                                      });
                                    },
                                    child: Text(
                                      "Financial Ration",
                                      style: blackStyle(context).copyWith(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        showifinancialratio =
                                            !showifinancialratio;
                                      });
                                    },
                                    child: Icon(
                                      !showifinancialratio
                                          ? Icons.keyboard_arrow_down_rounded
                                          : Icons.keyboard_arrow_up_rounded,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          // if (showifinancialratio)
                          //   Column(
                          //     // mainAxisAlignment: MainAxisAlignment.center,
                          //     // crossAxisAlignment: CrossAxisAlignment.center,
                          //     children: [
                          //       Column(
                          //         children: [
                          //           const FirstRow(
                          //             firsttitle: "QUARTERLY ",
                          //             secondtitle: "Dec 2021",
                          //             thirditle: "Sep 2021",
                          //           ),
                          //           const Divider(
                          //             color: Color(0xFFDFDFDF),
                          //             thickness: 1,
                          //           ),
                          //           const RowWidget(
                          //             firsttitle: "Sales ",
                          //             secondtitle: "3,637",
                          //             thirditle: "3,373",
                          //           ),
                          //           const Divider(
                          //             color: Color(0xFFDFDFDF),
                          //             thickness: 1,
                          //           ),
                          //           const RowWidget(
                          //             firsttitle: "Other Income ",
                          //             secondtitle: "113",
                          //             thirditle: "153",
                          //           ),
                          //           const Divider(
                          //             color: const Color(0xFFDFDFDF),
                          //             thickness: 1,
                          //           ),
                          //           const RowWidget(
                          //             firsttitle: "Total Income ",
                          //             secondtitle: "3,750",
                          //             thirditle: "3,526",
                          //           ),
                          //           const Divider(
                          //             color: Color(0xFFDFDFDF),
                          //             thickness: 1,
                          //           ),
                          //           const RowWidget(
                          //             firsttitle: "Total Expenditure ",
                          //             secondtitle: "3,057",
                          //             thirditle: "2,754",
                          //           ),
                          //           const Divider(
                          //             color: const Color(0xFFDFDFDF),
                          //             thickness: 1,
                          //           ),
                          //           const RowWidget(
                          //             firsttitle: "EBIT ",
                          //             secondtitle: "673",
                          //             thirditle: "785",
                          //           ),
                          //           const Divider(
                          //             color: const Color(0xFFDFDFDF),
                          //             thickness: 1,
                          //           ),
                          //           const RowWidget(
                          //             firsttitle: "Interest ",
                          //             secondtitle: "53",
                          //             thirditle: "55",
                          //           ),
                          //           const Divider(
                          //             color: const Color(0xFFDFDFDF),
                          //             thickness: 1,
                          //           ),
                          //           const RowWidget(
                          //             firsttitle: "Tax ",
                          //             secondtitle: "137",
                          //             thirditle: "164",
                          //           ),
                          //           const Divider(
                          //             color: Color.fromARGB(255, 95, 95, 95),
                          //             thickness: 2,
                          //           ),
                          //           Row(
                          //             children: const [
                          //               Text(
                          //                 "Net Profit",
                          //                 style: TextStyle(
                          //                     fontSize: 15,
                          //                     color: Color(0xFF444444),
                          //                     fontWeight: FontWeight.bold),
                          //               ),
                          //               SizedBox(
                          //                 width: 90,
                          //               ),
                          //               Text(
                          //                 "482",
                          //                 style: TextStyle(
                          //                     fontSize: 15,
                          //                     color: Colors.black),
                          //               ),
                          //               Spacer(),
                          //               Text(
                          //                 "563",
                          //                 style: TextStyle(
                          //                     fontSize: 15,
                          //                     color: Colors.black),
                          //               ),
                          //             ],
                          //           ),
                          //           const SizedBox(
                          //             height: 10,
                          //           )
                          //         ],
                          //       )
                          //     ],
                          //   )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FirstRow extends StatelessWidget {
  const FirstRow({
    Key? key,
    this.firsttitle,
    this.secondtitle,
    this.thirditle,
  }) : super(key: key);

  final String? firsttitle;
  final String? secondtitle;
  final String? thirditle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Text(
                  firsttitle!,
                  style: TextStyle(
                      fontSize: 15.sm,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF444444)),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 19.sm,
                  color: const Color(0xFF4A73FB),
                )
              ],
            ),
          ),
          Expanded(
            child: Text(
              secondtitle!,
              style: TextStyle(fontSize: 15.sm, color: Color(0xFF444444)),
            ),
          ),
          Expanded(
            flex: 0,
            child: Row(
              children: [
                Text(
                  thirditle!,
                  style: TextStyle(fontSize: 15.sm, color: Color(0xFF444444)),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 19.sm,
                  color: const Color(0xFF4A73FB),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RowWidget extends StatelessWidget {
  const RowWidget({
    Key? key,
    this.firsttitle,
    this.secondtitle,
    this.thirditle,
  }) : super(key: key);

  final String? firsttitle;
  final String? secondtitle;
  final String? thirditle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              firsttitle!,
              style: TextStyle(fontSize: 15.sm, color: Color(0xFF444444)),
            ),
          ),
          Expanded(
            child: Text(
              textAlign: TextAlign.left,
              secondtitle!,
              style: TextStyle(
                  fontSize: 15.sm,
                  color: Color(0xFF444444),
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 0,
            child: Text(
              thirditle!,
              style: TextStyle(
                  fontSize: 15.sm,
                  color: Color(0xFF444444),
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
