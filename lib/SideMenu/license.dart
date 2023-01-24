// ignore_for_file: prefer_const_literals_to_create_immutables, camel_case_types, prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:piadvisory/SideMenu/License%20Repository/licenserepo.dart';

class license extends StatefulWidget {
  const license({Key? key}) : super(key: key);

  @override
  State<license> createState() => _licenseState();
}

class _licenseState extends State<license> {
  late final Future? myFuture;

  @override
  void initState() {
    myFuture = getLicense().License();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(225, 248, 248, 1),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65.0),
        child: AppBar(
          flexibleSpace: Container(
            height: 80,
            // decoration: const BoxDecoration(),
          ),
          backgroundColor: Colors.white,
          elevation: 1,
          automaticallyImplyLeading: true,
          title: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 35, top: 10),
                child: Center(
                  child: Image.asset(
                    'assets/images/Newlogo.png',
                    height: 45.h,
                  ),
                  //  SvgPicture.asset(
                  //   "assets/images/logo4final.svg",
                  //   height: 45,
                  // ),
                ),
              ),
            ],
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            // ignore: prefer_const_constructors
            icon: Icon(
              Icons.arrow_back,
            ),
            iconSize: 22,
            color: Color(0xFF6B6B6B),
          ),
        ),
      ),
      body: FutureBuilder(
        future: myFuture,
        builder: (ctx, snapshot) {
          if (snapshot.data == null) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Lottie.asset(
                    "assets/images/lf30_editor_jc6n8oqe.json",
                    repeat: true,
                    height: 150,
                    width: 150,
                  ),
                ),
              ],
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occured',
                  style: TextStyle(fontSize: 18),
                ),
              );
            }
          }
          return _buildBody(
            context,
          );
        },
      ),
    );
  }

  Widget _buildBody(context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          top: 20,
          bottom: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "License",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Html(
              data: licensepage?.data?.first.licenseContent ?? "",
              // style: {
              //   "h1": Style(
              //    //fontSize: FontSize.,
              //     color: Colors.black,
              //   ),
              // },
              // style: TextStyle(
              //   color: Colors.black,
              //   fontSize: 14,
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
