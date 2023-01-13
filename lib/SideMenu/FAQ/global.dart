// ignore_for_file: prefer_const_constructors, duplicate_ignore

import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';

import '../../Common/app_bar.dart';

class GlobalFaq extends StatefulWidget {
  const GlobalFaq({Key? key}) : super(key: key);

  @override
  State<GlobalFaq> createState() => _GlobalFaqState();
}

class _GlobalFaqState extends State<GlobalFaq> {
  // final _contentStyleHeader = const TextStyle(
  //     color: Color(0xFF000000),
  //     fontSize: 14,
  //     fontWeight: FontWeight.w700);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titleTxt: "Global Investing", bottomtext: false),
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
              headerBackgroundColor: const Color(0xFFFCFAFA),
              headerBackgroundColorOpened: const Color(0xFFF2F9F9),
              contentBackgroundColor: const Color(0xFFF2F9F9),
              contentBorderColor: const Color(0xFFF2F9F9),
              contentBorderRadius: 0,
              headerBorderRadius: 0,
              // ignore: prefer_const_constructors
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
