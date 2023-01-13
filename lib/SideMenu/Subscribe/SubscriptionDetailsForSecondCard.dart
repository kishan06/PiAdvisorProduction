import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import '/Common/app_bar.dart';
import '/Utils/textStyles.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubcriptionDetailsForSecondCard extends StatefulWidget {
  const SubcriptionDetailsForSecondCard({Key? key}) : super(key: key);

  @override
  State<SubcriptionDetailsForSecondCard> createState() =>
      _SubcriptionDetailsForSecondCardState();
}

class _SubcriptionDetailsForSecondCardState
    extends State<SubcriptionDetailsForSecondCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titleTxt: "Subscription",bottomtext: false),
      body: Accordion(
        maxOpenSections: 1,
        scaleWhenAnimating: true,
        openAndCloseAnimation: true,
        headerPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
        sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
        sectionClosingHapticFeedback: SectionHapticFeedback.light,
        children: [
         AccordionSection(
          isOpen: true,
          headerBackgroundColor: Colors.white,
          headerBackgroundColorOpened: const Color(0xFFF2F9F9),
          contentBackgroundColor: Color(0xFFF2F9F9),
          contentBorderColor: Color(0xFFF2F9F9),
          contentBorderRadius: 0,
          headerBorderRadius: 0,
          rightIcon: Icon(Icons.keyboard_arrow_down,
              color: Color(0xFF008083), size: 20),
          header: Text('Fees',
              style: TextStyle(
                  color: Color(
                    0xFF008083,
                  ),
                  fontWeight: FontWeight.bold)),
          content: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check,
                    size: 16.sm,
                    color: const Color(0xFF008083),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text.rich(
                        const TextSpan(children: [
                          TextSpan(
                              text:
                                  "₹ 1,999/- only"),
                          // TextSpan(
                          //     text: "market value",
                          //     style: TextStyle(
                          //       decoration: TextDecoration.underline,
                          //     )),
                          // TextSpan(
                          //     text:
                          //         " of portfolio as on last date of previous quarter/year.")
                        ]),
                        style: blackStyle(context).copyWith(
                            fontSize: 12.sm,
                            color: Colors.black,
                            fontWeight: FontWeight.normal)),
                  ),
                ],
              ),
              // SizedBox(
              //   height: 9.5,
              // ),
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Icon(
              //       Icons.check,
              //       size: 16.sm,
              //       color: const Color(0xFF008083),
              //     ),
              //     SizedBox(
              //       width: 10,
              //     ),
              //     SizedBox(
              //       width: MediaQuery.of(context).size.width * 0.7,
              //       child: Text(
              //         "New investments during the quarter/year to be charged, on the day of investment, pro-rata for the remaining period of the quarter/year at cost of investments.",
              //         style: blackStyle(context).copyWith(
              //             fontSize: 12.sm,
              //             color: Colors.black,
              //             fontWeight: FontWeight.normal),
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: 9.5,
              // ),
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Icon(
              //       Icons.check,
              //       size: 16.sm,
              //       color: const Color(0xFF008083),
              //     ),
              //     SizedBox(
              //       width: 10,
              //     ),
              //     SizedBox(
              //       width: MediaQuery.of(context).size.width * 0.7,
              //       child: Text(
              //         "Redemptions, if any, will not be adjusted during the quarter/year for the purpose of fee calculation. The same will be reflected in the net portfolio value at the end of the quarter/year for the purpose of fee calculations for the next quarter/year",
              //         style: blackStyle(context).copyWith(
              //             fontSize: 12.sm,
              //             color: Colors.black,
              //             fontWeight: FontWeight.normal),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
          contentHorizontalPadding: 20,
          // onOpenSection: () => print('onOpenSection ...'),
          // onCloseSection: () => print('onCloseSection ...'),
        ),
          AccordionSection(
          isOpen: false,
          headerBackgroundColor: Colors.white,
          headerBackgroundColorOpened: const Color(0xFFF2F9F9),
          contentBackgroundColor: Color(0xFFF2F9F9),
          contentBorderColor: Color(0xFFF2F9F9),
          contentBorderRadius: 0,
          headerBorderRadius: 0,
          rightIcon: Icon(Icons.keyboard_arrow_down,
              color: Color(0xFF008083), size: 20),
          header: Text('Frequency of Payment',
              style: TextStyle(
                  color: Color(
                    0xFF008083,
                  ),
                  fontWeight: FontWeight.bold)),
          content:  Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check,
                    size: 16.sm,
                    color: const Color(0xFF008083),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text.rich(
                        const TextSpan(children: [
                          TextSpan(
                              text:"One-time upfront payment"),
                          // TextSpan(
                          //     text: "market value",
                          //     style: TextStyle(
                          //       decoration: TextDecoration.underline,
                          //     )),
                          // TextSpan(
                          //     text:
                          //         " of portfolio as on last date of previous quarter/year.")
                        ]),
                        style: blackStyle(context).copyWith(
                            fontSize: 12.sm,
                            color: Colors.black,
                            fontWeight: FontWeight.normal)),
                  ),
                ],
              ),
            ],
          ),
          //Text("One-time upfront payment "),
          contentHorizontalPadding: 20,
          // onOpenSection: () => print('onOpenSection ...'),
          // onCloseSection: () => print('onCloseSection ...'),
        ),
          AccordionSection(
          isOpen: false,
          headerBackgroundColor: Colors.white,
          headerBackgroundColorOpened: const Color(0xFFF2F9F9),
          contentBackgroundColor: Color(0xFFF2F9F9),
          contentBorderColor: Color(0xFFF2F9F9),
          contentBorderRadius: 0,
          headerBorderRadius: 0,
          rightIcon: Icon(Icons.keyboard_arrow_down,
              color: Color(0xFF008083), size: 20),
          header: Text('Advice Available',
              style: TextStyle(
                  color: Color(
                    0xFF008083,
                  ),
                  fontWeight: FontWeight.bold)),
          content: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check,
                    size: 16.sm,
                    color: const Color(0xFF008083),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text.rich(
                        const TextSpan(children: [
                          TextSpan(
                              text:
                                  "One 30 mins video call slot with expert Tax Advisor "),
                          // TextSpan(
                          //     text: "market value",
                          //     style: TextStyle(
                          //       decoration: TextDecoration.underline,
                          //     )),
                          // TextSpan(
                          //     text:
                          //         " of portfolio as on last date of previous quarter/year.")
                        ]),
                        style: blackStyle(context).copyWith(
                            fontSize: 12.sm,
                            color: Colors.black,
                            fontWeight: FontWeight.normal)),
                  ),
                ],
              ),
              SizedBox(
                height: 9.5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check,
                    size: 16.sm,
                    color: const Color(0xFF008083),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      "Tax planning for one financial year",
                      style: blackStyle(context).copyWith(
                          fontSize: 12.sm,
                          color: Colors.black,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 9.5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check,
                    size: 16.sm,
                    color: const Color(0xFF008083),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      "ITR filing for one financial year",
                      style: blackStyle(context).copyWith(
                          fontSize: 12.sm,
                          color: Colors.black,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Text(
          //     "Lorem ipsum dolor sit amet, consectetuer adipiscing \nelit, sed diam nonummy nibh euismod tincidunt ut \nlaoreet dolore magna aliquam erat volutpat."),
          contentHorizontalPadding: 20,
          // onOpenSection: () => print('onOpenSection ...'),
          // onCloseSection: () => print('onCloseSection ...'),
        ),
        ],
      ),
    );
  }
}

class LessThan5 extends StatelessWidget {
  const LessThan5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Accordion(
      maxOpenSections: 1,
      scaleWhenAnimating: true,
      openAndCloseAnimation: true,
      headerPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
      sectionClosingHapticFeedback: SectionHapticFeedback.light,
      children: [
       
       
        
        // AccordionSection(
        //   isOpen: false,
        //   headerBackgroundColor: Colors.white,
        //   headerBackgroundColorOpened: const Color(0xFFF2F9F9),
        //   contentBackgroundColor: Color(0xFFF2F9F9),
        //   contentBorderColor: Color(0xFFF2F9F9),
        //   contentBorderRadius: 0,
        //   headerBorderRadius: 0,
        //   rightIcon: Icon(Icons.keyboard_arrow_down,
        //       color: Color(0xFF008083), size: 20),
        //   header: Text('Fee Illustration',
        //       style: TextStyle(
        //           color: Color(
        //             0xFF008083,
        //           ),
        //           fontWeight: FontWeight.bold)),
        //   content: Text(
        //       "Lorem ipsum dolor sit amet, consectetuer adipiscing \nelit, sed diam nonummy nibh euismod tincidunt ut \nlaoreet dolore magna aliquam erat volutpat."),
        //   contentHorizontalPadding: 20,
        //   // onOpenSection: () => print('onOpenSection ...'),
        //   // onCloseSection: () => print('onCloseSection ...'),
        // ),
      ],
    );
  }
}
