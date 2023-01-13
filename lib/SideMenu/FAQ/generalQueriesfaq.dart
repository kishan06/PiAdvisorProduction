// ignore_for_file: camel_case_types, unused_field, prefer_const_constructors

import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:piadvisory/SideMenu/FAQ/Model/FaqModel.dart';
import '/Common/app_bar.dart';
import 'package:flutter/material.dart';

class generalQueriesFaq extends StatefulWidget {
  generalQueriesFaq({Key? key, required this.faq}) : super(key: key);

  @override
  State<generalQueriesFaq> createState() => _generalQueriesFaqState();

  List<Cat1> faq = [];
}

class _generalQueriesFaqState extends State<generalQueriesFaq> {
  List<AccordionSection> getList() {
    List<AccordionSection> childs = [];
    for (var i = 0; i < widget.faq.length; i++) {
      childs.add(AccordionSection(
        isOpen: true,
        headerBackgroundColor: Color(0xFFFCFAFA),
        headerBackgroundColorOpened: Color(0xFFF2F9F9),
        contentBackgroundColor: Color(0xFFF2F9F9),
        contentBorderColor: Color(0xFFF2F9F9),
        contentBorderRadius: 0,
        headerBorderRadius: 0,
        rightIcon:
            Icon(Icons.keyboard_arrow_down, color: Color(0xFF008083), size: 20),
        header: Text(widget.faq[i].questions!,
            style: TextStyle(color: Color(0xFF008083))),
        content: Text(widget.faq[i].answers!,
            style: TextStyle(
              color: Colors.black,
            )),
        contentHorizontalPadding: 20,
        // onOpenSection: () => print('onOpenSection ...'),
        // onCloseSection: () => print('onCloseSection ...'),
      ));
    }
    return childs;
  }

  final _headerStyle = const TextStyle(
      color: Color(0xFF008083), fontSize: 15, fontWeight: FontWeight.bold);
  final _contentStyle = const TextStyle(
      color: Color(0xFF000000), fontSize: 14, fontWeight: FontWeight.normal);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            const CustomAppBar(titleTxt: "General Queries", bottomtext: false),
        body: _buildBody(context, widget.faq));
  }

  Widget _buildBody(context, faq) {
    return Accordion(
      maxOpenSections: 1,
      scaleWhenAnimating: true,
      openAndCloseAnimation: true,
      headerPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
      sectionClosingHapticFeedback: SectionHapticFeedback.light,
      children: [for (var i = 0; i < faq.length; i++) getList()[i]],
    );
  }
}
