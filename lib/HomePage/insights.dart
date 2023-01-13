// ignore_for_file: sort_child_properties_last


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:piadvisory/SideMenu/Subscribe/Mysubscription.dart';
import 'package:piadvisory/Utils/textStyles.dart';

import '../Common/app_bar.dart';

class Insights extends StatefulWidget {
  const Insights({Key? key}) : super(key: key);

  @override
  State<Insights> createState() => _InsightsState();
}

class _InsightsState extends State<Insights> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titleTxt: "Insights",bottomtext: false,),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Stack(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 169.w,
                        height: 196,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: const Color(0xFFFFFFFF),
                          border: Border.all(color: const Color(0xFFAFADAD)),
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromARGB(255, 221, 221, 221),
                                blurRadius: 4,
                                spreadRadius: 0,
                                offset: Offset(0, 0)),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: const [
                                  Text(
                                    "Insights",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                    FontAwesomeIcons.angleRight,
                                    size: 15,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              const Text(
                                "PROS",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ), //BoxDecoration
                      ), //Container
                      const SizedBox(
                        width: 20,
                      ), //SizedBox
                      Container(
                        width: 140.w,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: const Color(0xFFFFFFFF),
                          border: Border.all(color: const Color(0xFFAFADAD)),
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromARGB(255, 221, 221, 221),
                                blurRadius: 4,
                                spreadRadius: 0,
                                offset: Offset(0, 0)),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Text(
                                  "CONS",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    top: 50,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        border: Border.all(
                            color: const Color.fromARGB(255, 230, 227, 227)),
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromARGB(255, 185, 183, 183),
                              blurRadius: 4,
                              spreadRadius: 0,
                              offset: Offset(5, 8)),
                        ],
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const Mysubscription()));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: SizedBox(
                                height: 41,
                                width: 214,
                                child: OutlinedButton(
                                  onPressed: () {},
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                      color: Colors.red,
                                    ),
                                    shape: const StadiumBorder(),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.lock,
                                        size: 20,
                                        color: Color(0xFFDA0600),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Mysubscription()));
                                        },
                                        child: Text(
                                          'Subscribe to Pro',
                                          style: blackStyle(context).copyWith(
                                              color: const Color(0xFFDA0600),
                                              fontSize: 14),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 40,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      //BoxDecoration
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 230,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: const Color(0xFFFFFFFF),
                      border: Border.all(color: const Color(0xFFAFADAD)),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromARGB(255, 221, 221, 221),
                            blurRadius: 4,
                            spreadRadius: 0,
                            offset: Offset(0, 0)),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Text(
                                "Prices",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                FontAwesomeIcons.angleRight,
                                size: 15,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          const Text(
                            "22.64% away from 52 week high",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ), //BoxDecoration
                  ),
                  Positioned(
                    top: 50,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: double.infinity,
                      height: 180,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        border: Border.all(
                            color: const Color.fromARGB(255, 230, 227, 227)),
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromARGB(255, 185, 183, 183),
                              blurRadius: 4,
                              spreadRadius: 0,
                              offset: Offset(5, 8)),
                        ],
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const Mysubscription()));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "Get details analysis with \nSuperMoney Stocks Insights.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18, color: Color(0xFF585858)),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Mysubscription()));
                                },
                                child: Center(
                                  child: SizedBox(
                                    height: 41,
                                    width: 214,
                                    child: OutlinedButton(
                                      onPressed: () {},
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                          color: Colors.red,
                                        ),
                                        shape: const StadiumBorder(),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.lock,
                                            size: 20,
                                            color: Color(0xFFDA0600),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Mysubscription()));
                                            },
                                            child: Text(
                                              'Subscribe to Pro',
                                              style: blackStyle(context)
                                                  .copyWith(
                                                      color: const Color(
                                                          0xFFDA0600),
                                                      fontSize: 14),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 40,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                      //BoxDecoration
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: const Color(0xFFFFFFFF),
                      border: Border.all(color: const Color(0xFFAFADAD)),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromARGB(255, 221, 221, 221),
                            blurRadius: 4,
                            spreadRadius: 0,
                            offset: Offset(0, 0)),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Text(
                                "Industry Comparison",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                FontAwesomeIcons.angleRight,
                                size: 15,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          // const Text(
                          //   "Market Cap - High in Industry",
                          //   style: TextStyle(color: Colors.black, fontSize: 14),
                          // )
                        ],
                      ),
                    ), //BoxDecoration
                  ),
                  Positioned(
                    top: 50,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        border: Border.all(
                            color: const Color.fromARGB(255, 230, 227, 227)),
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromARGB(255, 185, 183, 183),
                              blurRadius: 4,
                              spreadRadius: 0,
                              offset: Offset(5, 8)),
                        ],
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const Mysubscription()));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: SizedBox(
                                height: 41,
                                width: 214,
                                child: OutlinedButton(
                                  onPressed: () {},
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                      color: Colors.red,
                                    ),
                                    shape: const StadiumBorder(),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.lock,
                                        size: 20,
                                        color: Color(0xFFDA0600),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Mysubscription()));
                                        },
                                        child: Text(
                                          'Subscribe to Pro',
                                          style: blackStyle(context).copyWith(
                                              color: const Color(0xFFDA0600),
                                              fontSize: 14),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 40,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      //BoxDecoration
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ), //Container,
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: const Color(0xFFFFFFFF),
                      border: Border.all(color: const Color(0xFFAFADAD)),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromARGB(255, 221, 221, 221),
                            blurRadius: 4,
                            spreadRadius: 0,
                            offset: Offset(0, 0)),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Text(
                                "Shareholding",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                FontAwesomeIcons.angleRight,
                                size: 15,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          // const Text(
                          //   "Market Cap - High in Industry",
                          //   style: TextStyle(color: Colors.black, fontSize: 14),
                          // )
                        ],
                      ),
                    ), //BoxDecoration
                  ),
                  Positioned(
                    top: 50,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        border: Border.all(
                            color: const Color.fromARGB(255, 230, 227, 227)),
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromARGB(255, 185, 183, 183),
                              blurRadius: 4,
                              spreadRadius: 0,
                              offset: Offset(5, 8)),
                        ],
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const Mysubscription()));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: SizedBox(
                                height: 41,
                                width: 214,
                                child: OutlinedButton(
                                  onPressed: () {},
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                      color: Colors.red,
                                    ),
                                    shape: const StadiumBorder(),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.lock,
                                        size: 20,
                                        color: Color(0xFFDA0600),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Mysubscription()));
                                        },
                                        child: Text(
                                          'Subscribe to Pro',
                                          style: blackStyle(context).copyWith(
                                              color: const Color(0xFFDA0600),
                                              fontSize: 14),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 40,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      //BoxDecoration
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
