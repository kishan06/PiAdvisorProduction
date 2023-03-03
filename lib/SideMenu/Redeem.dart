import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piadvisory/Common/CreateBottomBar.dart';
import 'package:piadvisory/Common/CustomAppbarWithIcons.dart';
import 'package:piadvisory/Common/Customfloatingbutton.dart';
import 'package:piadvisory/Common/GlobalFuntionsVariables.dart';
import 'package:piadvisory/SideMenu/NavDrawer.dart';
import 'package:piadvisory/Utils/textStyles.dart';

class ReedeemOrder extends StatefulWidget {
  const ReedeemOrder({super.key});

  @override
  State<ReedeemOrder> createState() => _ReedeemOrderState();
}

class _ReedeemOrderState extends State<ReedeemOrder> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  TextEditingController holding = TextEditingController();
  TextEditingController folio = TextEditingController();
  bool? accept = false;
  bool? until = false;

  Future _showHoldingpicker() async {
    FocusScope.of(context).unfocus();
    final data = await showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: const Holding(),
        );
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );

    if (data != null) {
      setState(() {
        holding.text = data;
      });
    }
  }

  Future _showFoliopicker() async {
    FocusScope.of(context).unfocus();
    final data = await showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: const Folio(),
        );
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );

    if (data != null) {
      setState(() {
        folio.text = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool showfab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: NavDrawer(),
      key: _key,
      appBar: CustomAppBarWithIcons(
        titleTxt: "Redeem Order",
        globalkey: _key,
        isprofile: false,
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: showfab
      //     ? Stack(
      //         children: [
      //           Positioned(
      //               bottom: 22,
      //               right: MediaQuery.of(context).size.width * 0.43,
      //               child: CustomFloatingButton())
      //         ],
      //       )
      //     : null,
      // bottomNavigationBar:
      //     CreateBottomBar(stateBottomNav, "Bottombar", context),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  //vertical: 20
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Canara Robeco Small cap Fund- \n Regular (G)",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        Text("Equity Small-Cap-fund")
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "23.7700",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        Text(
                          "0.27 (1.14%)",
                          style: TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Invest by",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.redAccent.shade700),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(2),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      onPressed: null,
                      child: Text(
                        "LUMPSUM",
                        style: TextStyle(color: Colors.black),
                      ))
                ],
              ),
              Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Holding Mode",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 140),
                    child: Text(
                      "Folio ID",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 4.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      child: RedeemDropdown(
                        hinttext: "Holding  ",
                        controller: holding,
                        ontap: () => _showHoldingpicker(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 10, left: 10),
                      child: RedeemDropdown(
                        hinttext: "New Folio",
                        controller: folio,
                        ontap: () => _showFoliopicker(),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 90, left: 10, right: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          activeColor: Colors.amber,
                          value: accept,
                          onChanged: (bool? value) {
                            setState(() {
                              accept = value!;
                            });
                          },
                        ),
                        Text(
                          "I accept Terms & Conditions & EUIN Declaration",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Center(
                        child: Text(
                      "Amount",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.redAccent),
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
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                    ),
                    Center(
                        child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 2,
                        shadowColor: Colors.grey.shade700,
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {},
                      child: Text(
                        "Additional Inv: \n 1000",
                        style: TextStyle(color: Colors.black),
                      ),
                    )),
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
                                  MaterialStateProperty.all(Colors.white),
                            ),
                            child: Text(
                              "+10,000",
                              style: TextStyle(fontSize: 12),
                            )),
                        ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                            ),
                            child: Text("+25,000",
                                style: TextStyle(fontSize: 12))),
                        ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                            ),
                            child: Text("+50,000",
                                style: TextStyle(fontSize: 12))),
                        ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
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
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.greenAccent.shade700),
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
            ],
          )
        ],
      ),
    );
  }
}

class RedeemDropdown extends StatelessWidget {
  const RedeemDropdown({
    Key? key,
    required this.hinttext,
    required this.ontap,
    this.controller,
  }) : super(key: key);

  final String hinttext;
  final GestureTapCallback ontap;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        onTap: (() => ontap()),
        readOnly: true,
        cursorColor: Colors.grey,
        style: TextStyle(
          fontFamily: 'Product Sans',
          fontSize: 16.sm,
          fontWeight: FontWeight.w500,
        ),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          helperText: "",
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(1)),
            borderSide: BorderSide(
              color: Colors.grey.shade200,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(1)),
            borderSide: BorderSide(
              color: Colors.grey.shade200,
            ),
          ),
          suffixIcon: IconButton(
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.black,
            ),
            onPressed: () {
              ontap();
            },
          ),
          hintStyle: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(color: Colors.grey),
          hintText: hinttext,
        ),
      ),
    );
  }
}

class Holding extends StatefulWidget {
  const Holding({Key? key}) : super(key: key);

  @override
  State<Holding> createState() => _HoldingState();
}

class _HoldingState extends State<Holding> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Text("Select Holding",
                style: Theme.of(context).textTheme.headline2),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Folio");
                  }),
                  title: const Text("Folio"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Debit");
                  }),
                  title: const Text("Debit"),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}

class Folio extends StatefulWidget {
  const Folio({Key? key}) : super(key: key);

  @override
  State<Folio> createState() => _FolioState();
}

class _FolioState extends State<Folio> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Text("Select Folio",
                style: Theme.of(context).textTheme.headline2),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "New Holding");
                  }),
                  title: const Text("New Holding"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Old Holding");
                  }),
                  title: const Text("Old Holding"),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
