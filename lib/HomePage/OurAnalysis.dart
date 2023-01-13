// ignore_for_file: file_names

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:piadvisory/Common/app_bar.dart';
import 'package:piadvisory/Utils/textStyles.dart';

class OurAnalysis extends StatefulWidget {
  const OurAnalysis({Key? key}) : super(key: key);

  @override
  State<OurAnalysis> createState() => _OurAnalysisState();
}

class _OurAnalysisState extends State<OurAnalysis> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titleTxt: "Our Analysis", bottomtext: false),
      body: DefaultTabController(
        length: 4,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: SizedBox(
            height: 400,
            child: Card(
              elevation: 3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            ButtonsTabBar(
                              radius: 150,
                              backgroundColor: const Color(0xFF008083),
                              unselectedBackgroundColor: Colors.grey.shade100,
                              unselectedLabelStyle:
                                  const TextStyle(color: Colors.black),
                              labelStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              // ignore: prefer_const_literals_to_create_immutables
                              tabs: [
                                const Tab(
                                  text: "   S   ",
                                ),
                                const Tab(
                                  text: "   W   ",
                                ),
                                const Tab(
                                  text: "   O   ",
                                ),
                                const Tab(
                                  text: "   T   ",
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.share))
                    ],
                  ),
                  const Expanded(
                    child: TabBarView(
                      children: <Widget>[
                        STab(),
                        WTab(),
                        OTab(),
                        TTab(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class STab extends StatefulWidget {
  const STab({Key? key}) : super(key: key);

  @override
  State<STab> createState() => _STabState();
}

class _STabState extends State<STab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Strength(10)",
              style:
                  blackStyle(context).copyWith(color: const Color(0xFF008083)),
            ),
            const SizedBox(
              height: 100,
            ),
            Wrap(
              children: const [
                Text(
                  "Get full access to SWOt Analysis of stock with SuperMoney Advisory",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
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
                      Text(
                        'Subscribe to Pro',
                        style: blackStyle(context).copyWith(
                            color: const Color(0xFFDA0600), fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}

class WTab extends StatefulWidget {
  const WTab({Key? key}) : super(key: key);

  @override
  State<WTab> createState() => _WTabState();
}

class _WTabState extends State<WTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Weaknesses(6)",
              style:
                  blackStyle(context).copyWith(color: const Color(0xFF008083)),
            ),
            const SizedBox(
              height: 100,
            ),
            Wrap(
              children: const [
                Text(
                  "Get full access to SWOt Analysis of stock with SuperMoney Advisory",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
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
                      Text(
                        'Subscribe to Pro',
                        style: blackStyle(context).copyWith(
                            color: const Color(0xFFDA0600), fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}

class OTab extends StatefulWidget {
  const OTab({Key? key}) : super(key: key);

  @override
  State<OTab> createState() => _OTabState();
}

class _OTabState extends State<OTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Opportunities(0)",
              style:
                  blackStyle(context).copyWith(color: const Color(0xFF008083)),
            ),
            const SizedBox(
              height: 100,
            ),
            Wrap(
              children: const [
                Text(
                  "Get full access to SWOt Analysis of stock with SuperMoney Advisory",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
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
                      Text(
                        'Subscribe to Pro',
                        style: blackStyle(context).copyWith(
                            color: const Color(0xFFDA0600), fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}

class TTab extends StatefulWidget {
  const TTab({Key? key}) : super(key: key);

  @override
  State<TTab> createState() => _TTabState();
}

class _TTabState extends State<TTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Threats(1)",
              style:
                  blackStyle(context).copyWith(color: const Color(0xFF008083)),
            ),
            const SizedBox(
              height: 100,
            ),
            Wrap(
              children: const [
                Text(
                  "Get full access to SWOt Analysis of stock with SuperMoney Advisory",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
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
                      Text(
                        'Subscribe to Pro',
                        style: blackStyle(context).copyWith(
                            color: const Color(0xFFDA0600), fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
