// ignore_for_file: prefer_const_constructors, camel_case_types, file_names, duplicate_ignore

import '/Common/CustomNextButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'Common/app_bar.dart';

class PaymentFailed extends StatefulWidget {
  const PaymentFailed({Key? key}) : super(key: key);

  @override
  State<PaymentFailed> createState() => _PaymentFailedState();
}

class _PaymentFailedState extends State<PaymentFailed> {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(

        appBar: AppBar(
          flexibleSpace: Container(
            height: 50,
            decoration: const BoxDecoration(),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,

          titleSpacing: 0,
          // centerTitle: true,
          title: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              "",
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.close,
            ),
            iconSize: 22,
            color: Color(0xFF6B6B6B),
          ),
        ),

        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 80),
            child: Column(
              children: [
                Center(
                  child: SvgPicture.asset(
                    "assets/images/payment-fail.svg",
                    width: 100,
                    height: 100,
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                SizedBox(
                  child: Text(
                    "Payment Failed!",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetuer adipiscing \nelit, sed diam nonummy nibh euismod tincid ut \nlaoreet dolore magna aliquam erat volutpat.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF6B6B6B),
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(
                  height: 120,
                ),
                // SizedBox(
                //   width: double.infinity,
                //   height: 50,
                //   child: CustomNextButton(
                //     text: 'Try Again',
                //     ontap: () {},
                //   ),
                // )
              ],
            ),
          ),
        ));
  }
}
