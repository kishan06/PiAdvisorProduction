// ignore_for_file: prefer_const_constructors

import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';

import '../../Common/app_bar.dart';

class BrokingFaq extends StatefulWidget {
  const BrokingFaq({Key? key}) : super(key: key);

  @override
  State<BrokingFaq> createState() => _BrokingFaqState();
}

class _BrokingFaqState extends State<BrokingFaq> {
  // final _contentStyleHeader = const TextStyle(
  //     color: Color(0xFF000000),
  //     fontSize: 14,
  //     fontWeight: FontWeight.w700);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleTxt: "Broking & Execution", bottomtext: false),
      body: SingleChildScrollView(
        child: Accordion(
          maxOpenSections: 1,
          scaleWhenAnimating: true,
          openAndCloseAnimation: true,
          headerPadding:
              const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
          sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
          sectionClosingHapticFeedback: SectionHapticFeedback.light,
          children: [
            AccordionSection(
              isOpen: true,
              headerBackgroundColor: Color(0xFFFCFAFA),
              headerBackgroundColorOpened: Color(0xFFF2F9F9),
              contentBackgroundColor: Color(0xFFF2F9F9),
              contentBorderColor: Color(0xFFF2F9F9),
              contentBorderRadius: 0,
              headerBorderRadius: 0,
              rightIcon: Icon(Icons.keyboard_arrow_down,
                  color: Color(0xFF008083), size: 20),
              header: Text('Lorem ipsum dolor sit amet, elit, sed diam nonummy',
                  style: TextStyle(color: Color(0xFF008083))),
              content: Text(
                  "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.",
                  style: TextStyle(
                    color: Colors.black,
                  )),
              contentHorizontalPadding: 20,
              // onOpenSection: () => print('onOpenSection ...'),
              // onCloseSection: () => print('onCloseSection ...'),
            ),
            AccordionSection(
              isOpen: false,
              headerBackgroundColor: Color(0xFFFCFAFA),
              headerBackgroundColorOpened: Color(0xFFF2F9F9),
              contentBackgroundColor: Color(0xFFF2F9F9),
              contentBorderColor: Color(0xFFF2F9F9),
              contentBorderRadius: 0,
              headerBorderRadius: 0,
              rightIcon: Icon(Icons.keyboard_arrow_down,
                  color: Color(0xFF008083), size: 20),
              header: Text('Lorem ipsum dolor sit amet, elit, sed diam nonummy',
                  style: TextStyle(color: Color(0xFF008083))),
              content: Text(
                  "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.",
                  style: TextStyle(
                    color: Colors.black,
                  )),
              contentHorizontalPadding: 20,
              // onOpenSection: () => print('onOpenSection ...'),
              // onCloseSection: () => print('onCloseSection ...'),
            ),
            AccordionSection(
              isOpen: false,
              headerBackgroundColor: Color(0xFFFCFAFA),
              headerBackgroundColorOpened: Color(0xFFF2F9F9),
              contentBackgroundColor: Color(0xFFF2F9F9),
              contentBorderColor: Color(0xFFF2F9F9),
              contentBorderRadius: 0,
              headerBorderRadius: 0,
              rightIcon: Icon(Icons.keyboard_arrow_down,
                  color: Color(0xFF008083), size: 20),
              header: Text('Lorem ipsum dolor sit amet, elit, sed diam nonummy',
                  style: TextStyle(color: Color(0xFF008083))),
              content: Text(
                  "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.",
                  style: TextStyle(
                    color: Colors.black,
                  )),
              contentHorizontalPadding: 20,
              // onOpenSection: () => print('onOpenSection ...'),
              // onCloseSection: () => print('onCloseSection ...'),
            ),
            AccordionSection(
              isOpen: false,
              headerBackgroundColor: Color(0xFFFCFAFA),
              headerBackgroundColorOpened: Color(0xFFF2F9F9),
              contentBackgroundColor: Color(0xFFF2F9F9),
              contentBorderColor: Color(0xFFF2F9F9),
              contentBorderRadius: 0,
              headerBorderRadius: 0,
              rightIcon: Icon(Icons.keyboard_arrow_down,
                  color: Color(0xFF008083), size: 20),
              header: Text('Lorem ipsum dolor sit amet, elit, sed diam nonummy',
                  style: TextStyle(color: Color(0xFF008083))),
              content: Text(
                  "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.",
                  style: TextStyle(
                    color: Colors.black,
                  )),
              contentHorizontalPadding: 20,
              // onOpenSection: () => print('onOpenSection ...'),
              // onCloseSection: () => print('onCloseSection ...'),
            ),
            AccordionSection(
              isOpen: false,
              headerBackgroundColor: Color(0xFFFCFAFA),
              headerBackgroundColorOpened: Color(0xFFF2F9F9),
              contentBackgroundColor: Color(0xFFF2F9F9),
              contentBorderColor: Color(0xFFF2F9F9),
              contentBorderRadius: 0,
              headerBorderRadius: 0,
              rightIcon: Icon(Icons.keyboard_arrow_down,
                  color: Color(0xFF008083), size: 20),
              header: Text('Lorem ipsum dolor sit amet, elit, sed diam nonummy',
                  style: TextStyle(color: Color(0xFF008083))),
              content: Text(
                  "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.",
                  style: TextStyle(
                    color: Colors.black,
                  )),
              contentHorizontalPadding: 20,
              // onOpenSection: () => print('onOpenSection ...'),
              // onCloseSection: () => print('onCloseSection ...'),
            ),
            AccordionSection(
              isOpen: false,
              headerBackgroundColor: Color(0xFFFCFAFA),
              headerBackgroundColorOpened: Color(0xFFF2F9F9),
              contentBackgroundColor: Color(0xFFF2F9F9),
              contentBorderColor: Color(0xFFF2F9F9),
              contentBorderRadius: 0,
              headerBorderRadius: 0,
              rightIcon: Icon(Icons.keyboard_arrow_down,
                  color: Color(0xFF008083), size: 20),
              header: Text('Lorem ipsum dolor sit amet, elit, sed diam nonummy',
                  style: TextStyle(color: Color(0xFF008083))),
              content: Text(
                  "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.",
                  style: TextStyle(
                    color: Colors.black,
                  )),
              contentHorizontalPadding: 20,
              // onOpenSection: () => print('onOpenSection ...'),
              // onCloseSection: () => print('onCloseSection ...'),
            ),
            AccordionSection(
              isOpen: false,
              headerBackgroundColor: Color(0xFFFCFAFA),
              headerBackgroundColorOpened: Color(0xFFF2F9F9),
              contentBackgroundColor: Color(0xFFF2F9F9),
              contentBorderColor: Color(0xFFF2F9F9),
              contentBorderRadius: 0,
              headerBorderRadius: 0,
              rightIcon: Icon(Icons.keyboard_arrow_down,
                  color: Color(0xFF008083), size: 20),
              header: Text('Lorem ipsum dolor sit amet, elit, sed diam nonummy',
                  style: TextStyle(color: Color(0xFF008083))),
              content: Text(
                  "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.",
                  style: TextStyle(
                    color: Colors.black,
                  )),
              contentHorizontalPadding: 20,
              // onOpenSection: () => print('onOpenSection ...'),
              // onCloseSection: () => print('onCloseSection ...'),
            ),
            AccordionSection(
              isOpen: false,
              headerBackgroundColor: Color(0xFFFCFAFA),
              headerBackgroundColorOpened: Color(0xFFF2F9F9),
              contentBackgroundColor: Color(0xFFF2F9F9),
              contentBorderColor: Color(0xFFF2F9F9),
              contentBorderRadius: 0,
              headerBorderRadius: 0,
              rightIcon: Icon(Icons.keyboard_arrow_down,
                  color: Color(0xFF008083), size: 20),
              header: Text('Lorem ipsum dolor sit amet, elit, sed diam nonummy',
                  style: TextStyle(color: Color(0xFF008083))),
              content: Text(
                  "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.",
                  style: TextStyle(
                    color: Colors.black,
                  )),
              contentHorizontalPadding: 20,
              // onOpenSection: () => print('onOpenSection ...'),
              // onCloseSection: () => print('onCloseSection ...'),
            ),
            AccordionSection(
              isOpen: false,
              headerBackgroundColor: Color(0xFFFCFAFA),
              headerBackgroundColorOpened: Color(0xFFF2F9F9),
              contentBackgroundColor: Color(0xFFF2F9F9),
              contentBorderColor: Color(0xFFF2F9F9),
              contentBorderRadius: 0,
              headerBorderRadius: 0,
              rightIcon: Icon(Icons.keyboard_arrow_down,
                  color: Color(0xFF008083), size: 20),
              header: Text('Lorem ipsum dolor sit amet, elit, sed diam nonummy',
                  style: TextStyle(color: Color(0xFF008083))),
              content: Text(
                  "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.",
                  style: TextStyle(
                    color: Colors.black,
                  )),
              contentHorizontalPadding: 20,
              // onOpenSection: () => print('onOpenSection ...'),
              // onCloseSection: () => print('onCloseSection ...'),
            ),
          ],
        ),
      ),
    );
  }
}
