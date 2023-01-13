// ignore_for_file: file_names


import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piadvisory/SideMenu/Subscribe/Mysubscription.dart';
import '../Common/CustomNextButton.dart';
import '../Common/app_bar.dart';
import 'package:dotted_border/dotted_border.dart';

class Uploaddoc extends StatefulWidget {
  const Uploaddoc({Key? key}) : super(key: key);

  @override
  State<Uploaddoc> createState() => _UploaddocState();
}

class _UploaddocState extends State<Uploaddoc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titleTxt: "Upload Documents",bottomtext: false),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: double.infinity,
                height: 200,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: Color(0xFFC5C4C4)),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    children: [
                      const Text(
                        "Form 16",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DottedBorder(
                        color: const Color(0xFF008083),
                        strokeWidth: 3,
                        dashPattern: const [10, 5, 10, 5, 10, 5],
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(20),
                        child: Container(
                          width: 250,
                          height: 100,
                          decoration: BoxDecoration(
                              color: const Color(0xFFF2F5FA),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset("assets/images/Path 4171.svg"),
                              const SizedBox(width: 10),
                              const Text(
                                "Upload your file here",
                                style: TextStyle(
                                  color: Color(0xFF444444),
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )),
            Container(
                width: double.infinity,
                height: 200,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: Color(0xFFC5C4C4)),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    children: [
                      const Text(
                        "Last year ITR",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DottedBorder(
                        color: const Color(0xFF008083),
                        strokeWidth: 3,
                        dashPattern: const [10, 5, 10, 5, 10, 5],
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(20),
                        child: Container(
                          width: 250,
                          height: 100,
                          decoration: BoxDecoration(
                              color: const Color(0xFFF2F5FA),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset("assets/images/Path 4171.svg"),
                              const SizedBox(width: 10),
                              const Text(
                                "Upload your file here",
                                style: TextStyle(
                                  color: Color(0xFF444444),
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )),
            Container(
                width: double.infinity,
                height: 200,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    children: [
                      const Text(
                        "Other Documents",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DottedBorder(
                        color: const Color(0xFF008083),
                        strokeWidth: 3,
                        dashPattern: const [10, 5, 10, 5, 10, 5],
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(20),
                        child: Container(
                          width: 250,
                          height: 100,
                          decoration: BoxDecoration(
                              color: const Color(0xFFF2F5FA),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset("assets/images/Path 4171.svg"),
                              const SizedBox(width: 10),
                              const Text(
                                "Upload your file here",
                                style: TextStyle(
                                  color: Color(0xFF444444),
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )),
            SizedBox(
              height: 40,
            ),
            Container(
              height: 60,
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: CustomNextButton(
                text: "Contact Tax Advisor",
                ontap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Mysubscription()));
                },
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
