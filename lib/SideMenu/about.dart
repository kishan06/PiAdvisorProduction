// ignore_for_file: prefer_const_literals_to_create_immutables, camel_case_types, prefer_const_constructors, duplicate_ignore, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:piadvisory/SideMenu/About%20Repository/aboutrepo.dart';

class about extends StatefulWidget {
  const about({Key? key}) : super(key: key);

  @override
  State<about> createState() => _aboutState();
}

class _aboutState extends State<about> {
  late final Future? myFuture;

  @override
  void initState() {
    myFuture = getAbout().getAboutus();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 225, 248, 248),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65.0),
        child: AppBar(
          flexibleSpace: Container(
            height: 80,
            decoration: const BoxDecoration(),
          ),
          backgroundColor: Colors.white,
          elevation: 1,
          automaticallyImplyLeading: true,
          title: Padding(
            padding: const EdgeInsets.only(right: 35, top: 10),
            child: Center(
              child: SvgPicture.asset(
                "assets/images/logo4final.svg",
                height: 45,
              ),
            ),
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
              "About PI Advisors",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Text(
                aboutuspage!.data!.first.content!,
                style: TextStyle(
                  color: Color(0xFF6B6B6B),
                  fontSize: 14,
                ),
              ),
            ),
            // SizedBox(
            //   height: 20,
            // ),
            // Container(
            //   child: Text(
            //     "PI stands for Personalised Investments. While there are numerous money management platforms in the market, a majority of them are either Robo advisors or provide you only a standard investment basket to invest, which might not match your specific needs. We at PI focus on YOU.",
            //     style: TextStyle(
            //       color: Color(0xFF6B6B6B),
            //       fontSize: 14,
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            // Container(
            //   child: Text(
            //     "We analyse your investment profile to understand your goals and risk appetite and curate customised, well-balanced portfolios spread across different investment avenues, including stocks, mutual funds, fixed deposits, real estate, and more. Additionally, we also provide you with suitable insurance options with low premiums and services on tax planning and filing. We are a one-stop destination for all your financial needs.",
            //     style: TextStyle(
            //       color: Color(0xFF6B6B6B),
            //       fontSize: 14,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
