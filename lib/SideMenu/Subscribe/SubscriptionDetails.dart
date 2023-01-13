import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:get/get.dart';
import '/Common/app_bar.dart';
import '/Utils/textStyles.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubscriptionDetails extends StatefulWidget {
  const SubscriptionDetails({Key? key}) : super(key: key);

  @override
  State<SubscriptionDetails> createState() => _SubscriptionDetailsState();
}

class _SubscriptionDetailsState extends State<SubscriptionDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titleTxt: "Subscription", bottomtext: false),
      body: DefaultTabController(
        length: 2,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                ),
                child: Text(
                  "AUA",
                  style: blackStyle(context).copyWith(
                      fontSize: 20.sm,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF008083)),
                ),
              ),
               TabBar(
                isScrollable: true,
                indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 1,
                      color: Color(0xFF008083),
                    ),
                    insets: EdgeInsets.symmetric(
                      vertical: 10,
                    )),
                //indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Color(0xFF008083),
                padding: EdgeInsets.zero,
                indicatorPadding: EdgeInsets.symmetric(horizontal: 18), 
                labelPadding: EdgeInsets.symmetric(horizontal: 18),
                unselectedLabelStyle:
                    TextStyle(
                      color: Get.isDarkMode ? Color(0xFF6B6B6B) : Color(0xFF6B6B6B),
                      //Get.isDarkMode ? Color(0xFF6B6B6B): Color(0xFF6B6B6B),
                       fontWeight: FontWeight.bold
                       ),
                labelStyle:
                    TextStyle(color: Colors.black,
                      // color: Get.isDarkMode ? Colors.white : Color(0xFF000000),
                      // Get.isDarkMode ? Colors.white: Color(0xFF000000), 
                      fontWeight: FontWeight.bold
                      ),
                      labelColor:  Get.isDarkMode ? Colors.white : Color(0xFF000000),
                      unselectedLabelColor:   Get.isDarkMode ? Color(0xFF6B6B6B) : Color(0xFF6B6B6B),
                tabs: [
                  Tab(
                    text: "Less than ₹ 5,00,000",
                  ),
                  Tab(
                    text: "₹ 5,00,000 and above",
                  ),
                ],
              ),
              Expanded(
                  child:
                      TabBarView(children: <Widget>[LessThan5(), MoreThan5()])),
            ],
          ),
        ),
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
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text.rich(
                        const TextSpan(children: [
                          TextSpan(
                              text:
                                  "1% of Assets Under Advice (AUA) per annum"),
                          // TextSpan(
                          //     text: "market value",
                          //     style: TextStyle(
                          //       decoration: TextDecoration.underline,
                          //     )),
                          // TextSpan(
                          //     text:
                          //         " of portfolio as on last date of previous quarter/year.")
                        ]
                        ),
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
              //       width: MediaQuery.of(context).size.width * 0.6,
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
              //       width: MediaQuery.of(context).size.width * 0.6,
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
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text.rich(
                        const TextSpan(children: [
                          TextSpan(
                              text:"Annual in advance"),
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
              //       width: MediaQuery.of(context).size.width * 0.6,
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
              //       width: MediaQuery.of(context).size.width * 0.6,
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
          // Text(
          //     "Lorem ipsum dolor sit amet, consectetuer adipiscing \nelit, sed diam nonummy nibh euismod tincidunt ut \nlaoreet dolore magna aliquam erat volutpat."),
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
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text.rich(
                        const TextSpan(children: [
                          TextSpan(
                              text:"20 mins video call slots"),
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
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      "2 call slots per quarter",
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
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      "Carry forward of unused calls in next \nquarter till financial year end",
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
          header: Text('Fee Illustration',
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
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text.rich(
                        const TextSpan(children: [
                          TextSpan(
                              text:
                                  "Fees for a quarter/year to be charged, at the beginning of the quarter/year, basis "),
                          TextSpan(
                              text: "market value",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              )),
                          TextSpan(
                              text:
                                  " of portfolio as on last date of previous quarter/year.")
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
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      "New investments during the quarter/year to be charged, on the day of investment, pro-rata for the remaining period of the quarter/year at cost of investments.",
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
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      "Redemptions, if any, will not be adjusted during the quarter/year for the purpose of fee calculation. The same will be reflected in the net portfolio value at the end of the quarter/year for the purpose of fee calculations for the next quarter/year",
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
    );
  }
}

class MoreThan5  extends StatelessWidget {
  const MoreThan5 ({Key? key}) : super(key: key);

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
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text.rich(
                        const TextSpan(children: [
                          TextSpan(
                              text:
                                  "1% of Assets Under Advice (AUA) per annum"),
                          // TextSpan(
                          //     text: "market value",
                          //     style: TextStyle(
                          //       decoration: TextDecoration.underline,
                          //     )),
                          // TextSpan(
                          //     text:
                          //         " of portfolio as on last date of previous quarter/year.")
                        ]
                        ),
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
              //       width: MediaQuery.of(context).size.width * 0.6,
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
              //       width: MediaQuery.of(context).size.width * 0.6,
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
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text.rich(
                        const TextSpan(children: [
                          TextSpan(
                              text:"Annual in advance"),
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
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      "Quarterly in advance ",
                      style: blackStyle(context).copyWith(
                          fontSize: 12.sm,
                          color: Colors.black,
                          fontWeight: FontWeight.normal),
                    ),
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
              //       width: MediaQuery.of(context).size.width * 0.6,
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
          // Text(
          //     "Lorem ipsum dolor sit amet, consectetuer adipiscing \nelit, sed diam nonummy nibh euismod tincidunt ut \nlaoreet dolore magna aliquam erat volutpat."),
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
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text.rich(
                        const TextSpan(children: [
                          TextSpan(
                              text:"20 mins video call slots"),
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
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      "Unlimited calls",
                      style: blackStyle(context).copyWith(
                          fontSize: 12.sm,
                          color: Colors.black,
                          fontWeight: FontWeight.normal),
                    ),
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
              //       width: MediaQuery.of(context).size.width * 0.6,
              //       child: Text(
              //         "Carry forward of unused calls in next \nquarter till financial year end",
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
          // Text(
          //     "Lorem ipsum dolor sit amet, consectetuer adipiscing \nelit, sed diam nonummy nibh euismod tincidunt ut \nlaoreet dolore magna aliquam erat volutpat."),
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
          header: Text('Fee Illustration',
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
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text.rich(
                        const TextSpan(children: [
                          TextSpan(
                              text:
                                  "Fees for a quarter/year to be charged, at the beginning of the quarter/year, basis "),
                          TextSpan(
                              text: "market value",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              )),
                          TextSpan(
                              text:
                                  " of portfolio as on last date of previous quarter/year.")
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
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      "New investments during the quarter/year to be charged, on the day of investment, pro-rata for the remaining period of the quarter/year at cost of investments.",
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
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      "Redemptions, if any, will not be adjusted during the quarter/year for the purpose of fee calculation. The same will be reflected in the net portfolio value at the end of the quarter/year for the purpose of fee calculations for the next quarter/year",
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
    );
  }
}