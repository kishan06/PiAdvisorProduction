import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piadvisory/Common/CreateBottomBar.dart';
import 'package:piadvisory/Common/CustomAppbarWithIcons.dart';
import 'package:piadvisory/Common/Customfloatingbutton.dart';
import 'package:piadvisory/Common/GlobalFuntionsVariables.dart';
import 'package:piadvisory/Common/app_bar.dart';
import 'package:piadvisory/SideMenu/NavDrawer.dart';

class PlaceOrder extends StatefulWidget {
  const PlaceOrder({super.key});

  @override
  State<PlaceOrder> createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  bool _visible = true;
  bool sipVisible = true;
  bool freqVisible = false;
  bool lupVisible = false;
  bool? _checkbox = false;
  bool? until = false;
  bool? _lumpcheck = false;

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: NavDrawer(),
      key: _key,
      appBar: CustomAppBarWithIcons(
        titleTxt: "Place Order",
        isprofile: false,
        globalkey: _key,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: showFab
          ? Stack(
              children: [
                Positioned(
                  bottom: 22,
                  right: MediaQuery.of(context).size.width * 0.43,
                  child: CustomFloatingButton(),
                )
              ],
            )
          : null,
      bottomNavigationBar:
          CreateBottomBar(stateBottomNav, "Bottombar", context),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(context) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height,
        ),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nippon India Multi Cap Fund (G) ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('Equity Multi-Cap-Fund')
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "164.1609",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "-1.96(1.19%)",
                            style: TextStyle(color: Colors.red.shade300),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Invest by",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                sipVisible = true;
                                lupVisible = false;
                                _visible = true;
                              });
                            },
                            child: Text("SIP")),
                        Visibility(
                          visible: _visible,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xFFF78104)),
                              ),
                              onPressed: () {},
                              child: Text("SIP")),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                _visible = false;
                                sipVisible = false;
                                lupVisible = true;
                              });
                            },
                            child: Text("LUMPSUM")),
                        Visibility(
                          visible: !_visible,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xFFF78104)),
                              ),
                              onPressed: () {
                                setState(() {});
                              },
                              child: Text("LUMPSUMP")),
                        ),
                      ],
                    )
                  ],
                ),
                Visibility(
                  visible: sipVisible,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Frequency",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 35,
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  freqVisible = true;
                                });
                              },
                              child: Text("MONTHLY")),
                          Visibility(
                            visible: freqVisible,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color(0xFFF78104)),
                                ),
                                onPressed: () {},
                                child: Text("MONTHLY")),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  freqVisible = false;
                                });
                              },
                              child: Text("QUARTERLY")),
                          Visibility(
                            visible: !freqVisible,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color(0xFFF78104)),
                                ),
                                onPressed: () {},
                                child: Text("QUARTERLY")),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            Visibility(
              visible: sipVisible,
              child: Padding(
                padding: const EdgeInsets.only(top: 90),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          activeColor: Colors.amber,
                          value: _checkbox,
                          onChanged: (bool? value) {
                            setState(() {
                              _checkbox = value!;
                            });
                          },
                        ),
                        Text(
                          "I accept Terms & Conditions & EUIN Declaration",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Center(
                        child: Text(
                      "Amount",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                    Center(
                      child: SizedBox(
                        width: 80,
                        child: TextField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: "1000",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Center(child: Text("Min. SIP Amount: 1000")),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xFFF78104)),
                            ),
                            child: Text("+1000")),
                        ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xFFF78104)),
                            ),
                            child: Text("+2000")),
                        ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xFFF78104)),
                            ),
                            child: Text("+3000")),
                        ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xFFF78104)),
                            ),
                            child: Text("+4000")),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Day of  Investment",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 100,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "14",
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text("(Every Month)")
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "SIP Tenure",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 100,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "1",
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  activeColor: Colors.amber,
                                  value: until,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      until = value!;
                                    });
                                  },
                                ),
                                Text(
                                  "Until Canceled",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xFFF78104)),
                          ),
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text("BUY"),
                              Icon(Icons.arrow_circle_right_outlined)
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: lupVisible,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 260),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          activeColor: Colors.amber,
                          value: _lumpcheck,
                          onChanged: (bool? value) {
                            setState(() {
                              _lumpcheck = value!;
                            });
                          },
                        ),
                        Text(
                          "I accept Terms & Conditions & EUIN Declaration",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Center(
                        child: Text(
                      "Amount",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                    SizedBox(
                      height: 5.h,
                    ),
                    Center(
                      child: SizedBox(
                        width: 80,
                        child: TextField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: "5000",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Center(child: Text("Min. Amount : 5000")),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xFFF78104)),
                            ),
                            child: Text(
                              "+10,000",
                              style: TextStyle(fontSize: 12),
                            )),
                        ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xFFF78104)),
                            ),
                            child: Text("+25,000",
                                style: TextStyle(fontSize: 12))),
                        ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xFFF78104)),
                            ),
                            child: Text("+50,000",
                                style: TextStyle(fontSize: 12))),
                        ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xFFF78104)),
                            ),
                            child: Text("+2,00,000",
                                style: TextStyle(fontSize: 12))),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xFFF78104)),
                          ),
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text("BUY"),
                              Icon(Icons.arrow_circle_right_outlined)
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
