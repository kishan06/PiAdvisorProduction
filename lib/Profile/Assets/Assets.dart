import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:piadvisory/Common/CustomNextButton.dart';
import 'package:piadvisory/Common/app_bar.dart';
import 'package:piadvisory/Profile/Assets/AssetsRepository/Model/UserMutualfund.dart';
import 'package:piadvisory/Profile/Assets/AssetsRepository/assetsform.dart';
import 'package:piadvisory/Profile/Assets/Fixdeposit.dart';
import 'package:piadvisory/Profile/Assets/Mutualfund.dart';
import 'package:piadvisory/Profile/Assets/Realestate.dart';
import 'package:piadvisory/SideMenu/Subscribe/AppWidget.dart';
import 'package:async/src/future_group.dart';
import 'package:piadvisory/Utils/base_manager.dart';
import 'package:piadvisory/Utils/textStyles.dart';
import '/Utils/Dialogs.dart';

List<User>? globalMutualfund = [];

class Assets extends StatefulWidget {
  const Assets({super.key});

  @override
  State<Assets> createState() => _AssetsState();
}

class _AssetsState extends State<Assets> {
  List<User>? _Mutualfund = [];

  //FutureGroup futureGroup = FutureGroup();

  @override
  void initState() {
    //futureGroup.add(StoreAssetsform().getAssetsMF());

    Timer(Duration(seconds: 2), () {
      setState(() {});
    });
    super.initState();
  }

  void deleteMutualfunds(int goalId) async { // need to change this code for deleteMutual funds
    Map<String, dynamic> updata = {
      "goal_id": goalId,
    };
    print("updats is $updata");
    final data = await StoreAssetsform().postStoreAssetsformMF(updata);
    if (data.status == ResponseStatus.SUCCESS) {
    } else {
      return utils.showToast(data.message);
    }
  }

  @override
  Widget build(
    BuildContext context,) {
    return Scaffold(
      appBar: CustomAppBar(
        titleTxt: "My Assets",
        bottomtext: false,
      ),
      body: 
       Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color(0xFFEBEBEB), width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SizedBox(
            //   height: 12.h,
            // ),
            // Text(
            //   "My Total Invstments ₹0.00",
            //   style: TextStyle(
            //       color: Colors.black,
            //       fontSize: 15,
            //       fontWeight: FontWeight.w600),
            // ),
            SizedBox(
              height: 12.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    IconButton(
                      icon: SvgPicture.asset("assets/images/Group 9.svg"),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Mutualfund()));
                      },
                    ),
                    // SizedBox(
                    //   height: 2.h,
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Mutualfund()));
                        },
                        child: Text(
                          "Mutual Fund",
                          style: TextStyle(fontSize: 13, color: Colors.black),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 6.h,
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 12),
                    //   child: Text("₹99.k",
                    //   style: TextStyle(
                    //     fontSize: 13,
                    //     color: Colors.black
                    //   ),
                    //   ),
                    // )
                  ],
                ),
                Column(
                  children: <Widget>[
                    IconButton(
                     icon: SvgPicture.asset("assets/images/Group 10.svg"),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FixDeposit()));
                      },
                    ),
                    // SizedBox(
                    //   height: 2.h,
                    // ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FixDeposit()));
                      },
                      child: Text(
                        "Fix Deposit",
                        style: TextStyle(fontSize: 13, color: Colors.black),
                      ),
                    ),
                    // SizedBox(
                    //   height: 6.h,
                    // ),
                    // Text("₹99.k",
                    // style: TextStyle(
                    //   fontSize: 13,
                    //   color: Colors.black
                    // ),
                    // )
                  ],
                ),
                Column(
                  children: <Widget>[
                    IconButton(
                     icon: SvgPicture.asset("assets/images/Group 8.svg"),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RealEstate()));
                      },
                    ),
                    // SizedBox(
                    //   height: 2.h,
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RealEstate()));
                        },
                        child: Text(
                          "Real Estate",
                          style: TextStyle(fontSize: 13, color: Colors.black),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 6.h,
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(right: 12),
                    //   child: Text("₹99.k",
                    //   style: TextStyle(
                    //     fontSize: 13,
                    //     color: Colors.black
                    //   ),
                    //   ),
                    // )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            // Column(
            //   children: [
            //     Container(
            //       color: Colors.red,
            //     )
            //   ],
            // )
          ],
        ),
        ),
      ),

      // FutureBuilder(
      //   future: StoreAssetsform().getAssetsMF(),
      //   //futureGroup.future,
      //   builder: (ctx, snapshot) {
      //     if (snapshot.data == null) {
      //       return Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         crossAxisAlignment: CrossAxisAlignment.center,
      //         children: [
      //           Center(
      //             child: Lottie.asset(
      //               "assets/images/lf30_editor_jc6n8oqe.json",
      //               repeat: true,
      //               height: 150,
      //               width: 150,
      //             ),
      //           ),
      //         ],
      //       );
      //     }
      //     if (snapshot.connectionState == ConnectionState.done) {
      //       _Mutualfund = userMutualfund.user!;
      //      globalMutualfund = _Mutualfund;
      //       if (snapshot.hasError) {
      //         return Center(
      //           child: Text(
      //             '${snapshot.error} occured',
      //             style: TextStyle(fontSize: 18),
      //           ),
      //         );
      //       }
      //     }
      //    if (_Mutualfund != null && _Mutualfund!.isEmpty) {
      //       return _buildNodataBody(context);
      //     } else {
      //       return _buildBody(context, _Mutualfund);
      //     }
      //   },
      //   ),
    );
  }

  // Widget slideRightBackground() {
  //   return Container(
  //     color: Colors.red,
  //     child: Align(
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.end,
  //         children: <Widget>[
  //           Icon(
  //             Icons.close_outlined,
  //             color: Colors.white,
  //           ),
  //           Text(
  //             "Remove",
  //             style: TextStyle(
  //               color: Colors.white,
  //               fontWeight: FontWeight.w700,
  //             ),
  //             textAlign: TextAlign.left,
  //           ),
  //           SizedBox(
  //             width: 20,
  //           ),
  //         ],
  //       ),
  //       alignment: Alignment.centerLeft,
  //     ),
  //   );
  // }

  //   Widget _buildNodataBody(context) {
  //   return SingleChildScrollView(
  //     child: Padding(
  //       padding: EdgeInsets.only(left: 20, right: 20, top: 30),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           SizedBox(
  //             height: 114.h,
  //           ),
  //           Center(
  //             child: SvgPicture.asset(
  //               "assets/images/Group 5422.svg",
  //               width: 243.82,
  //               height: 248.95,
  //             ),
  //           ),
  //           SizedBox(
  //             height: 80,
  //           ),
  //           SizedBox(
  //             child: Text(
  //               "Set your financial goals to receive \ncustomized investment advice",
  //               textAlign: TextAlign.center,
  //               style: TextStyle(
  //                   color: Colors.black,
  //                   fontSize: 18.sm,
  //                   fontWeight: FontWeight.w600),
  //             ),
  //           ),
  //           SizedBox(
  //             height: 80.h,
  //           ),
  //           SizedBox(
  //             width: double.infinity,
  //             height: 60,
  //             child: CustomNextButton(
  //               text: 'Add Goal',
  //               ontap: () {
  //                 Get.toNamed("/addgoals");
  //               },
  //             ),
  //           ),
  //           SizedBox(
  //             height: 20,
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildBody(context, List<User>? _Mutualfund) {
  //   return 
  //  Column(
  //       children: [
  //         Card(
  //           shape: RoundedRectangleBorder(
  //             side: const BorderSide(color: Color(0xFFEBEBEB), width: 1),
  //             borderRadius: BorderRadius.circular(10),
  //           ),
  //           child: SingleChildScrollView(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 // SizedBox(
  //                 //   height: 12.h,
  //                 // ),
  //                 // Text(
  //                 //   "My Total Invstments ₹0.00",
  //                 //   style: TextStyle(
  //                 //       color: Colors.black,
  //                 //       fontSize: 15,
  //                 //       fontWeight: FontWeight.w600),
  //                 // ),
  //                 SizedBox(
  //                   height: 12.h,
  //                 ),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: <Widget>[
  //                     Column(
  //                       children: <Widget>[
  //                         IconButton(
  //                           icon: SvgPicture.asset("assets/images/Group 9.svg"),
  //                           onPressed: () {
  //                             Navigator.push(
  //                                 context,
  //                                 MaterialPageRoute(
  //                                     builder: (context) => Mutualfund()));
  //                           },
  //                         ),
  //                         // SizedBox(
  //                         //   height: 2.h,
  //                         // ),
  //                         Padding(
  //                           padding: const EdgeInsets.only(left: 12),
  //                           child: GestureDetector(
  //                             onTap: () {
  //                               Navigator.push(
  //                                   context,
  //                                   MaterialPageRoute(
  //                                       builder: (context) => Mutualfund()));
  //                             },
  //                             child: Text(
  //                               "Mutual Fund",
  //                               style: TextStyle(
  //                                   fontSize: 13, color: Colors.black),
  //                             ),
  //                           ),
  //                         ),
  //                         // SizedBox(
  //                         //   height: 6.h,
  //                         // ),
  //                         // Padding(
  //                         //   padding: const EdgeInsets.only(left: 12),
  //                         //   child: Text("₹99.k",
  //                         //   style: TextStyle(
  //                         //     fontSize: 13,
  //                         //     color: Colors.black
  //                         //   ),
  //                         //   ),
  //                         // )
  //                       ],
  //                     ),
  //                     Column(
  //                       children: <Widget>[
  //                         IconButton(
  //                           icon:
  //                               SvgPicture.asset("assets/images/Group 10.svg"),
  //                           onPressed: () {
  //                             Navigator.push(
  //                                 context,
  //                                 MaterialPageRoute(
  //                                     builder: (context) => FixDeposit()));
  //                           },
  //                         ),
  //                         // SizedBox(
  //                         //   height: 2.h,
  //                         // ),
  //                         GestureDetector(
  //                           onTap: () {
  //                             Navigator.push(
  //                                 context,
  //                                 MaterialPageRoute(
  //                                     builder: (context) => FixDeposit()));
  //                           },
  //                           child: Text(
  //                             "Fix Deposit",
  //                             style:
  //                                 TextStyle(fontSize: 13, color: Colors.black),
  //                           ),
  //                         ),
  //                         // SizedBox(
  //                         //   height: 6.h,
  //                         // ),
  //                         // Text("₹99.k",
  //                         // style: TextStyle(
  //                         //   fontSize: 13,
  //                         //   color: Colors.black
  //                         // ),
  //                         // )
  //                       ],
  //                     ),
  //                     Column(
  //                       children: <Widget>[
  //                         IconButton(
  //                           icon: SvgPicture.asset("assets/images/Group 8.svg"),
  //                           onPressed: () {
  //                             Navigator.push(
  //                                 context,
  //                                 MaterialPageRoute(
  //                                     builder: (context) => RealEstate()));
  //                           },
  //                         ),
  //                         // SizedBox(
  //                         //   height: 2.h,
  //                         // ),
  //                         Padding(
  //                           padding: const EdgeInsets.only(right: 12),
  //                           child: GestureDetector(
  //                             onTap: () {
  //                               Navigator.push(
  //                                   context,
  //                                   MaterialPageRoute(
  //                                       builder: (context) => RealEstate()));
  //                             },
  //                             child: Text(
  //                               "Real Estate",
  //                               style: TextStyle(
  //                                   fontSize: 13, color: Colors.black),
  //                             ),
  //                           ),
  //                         ),
  //                         // SizedBox(
  //                         //   height: 6.h,
  //                         // ),
  //                         // Padding(
  //                         //   padding: const EdgeInsets.only(right: 12),
  //                         //   child: Text("₹99.k",
  //                         //   style: TextStyle(
  //                         //     fontSize: 13,
  //                         //     color: Colors.black
  //                         //   ),
  //                         //   ),
  //                         // )
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //                 SizedBox(
  //                   height: 15.h,
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         // SizedBox(
  //         //   height: 20.h,
  //         // ),
  //         // Column(
  //         //   crossAxisAlignment: CrossAxisAlignment.start,
  //         //   children: [
  //         //     Card(
  //         //       shape: RoundedRectangleBorder(
  //         //         side: const BorderSide(color: Color(0xFFEBEBEB), width: 1),
  //         //         borderRadius: BorderRadius.circular(10),
  //         //       ),
  //         //       child: Padding(
  //         //         padding: const EdgeInsets.all(8.0),
  //         //         child: Row(
  //         //           mainAxisAlignment: MainAxisAlignment.start,
  //         //           children: [
  //         //             SizedBox(
  //         //               height: 10,
  //         //             ),
  //         //             Text(
  //         //               "Mutual Funds",
  //         //               style: blackStyle(context).copyWith(
  //         //                 fontWeight: FontWeight.w600,
  //         //                 color: Get.isDarkMode? Colors.white : Colors.black),
  //         //               ),
  //         //             SizedBox(
  //         //               height: 15,
  //         //             ),
  //         //             SizedBox(
  //         //               height: 25,
  //         //             ),
  //         //         SizedBox(
  //         //           height: MediaQuery.of(context).size.height * 0.6,
  //         //           child: ListView.builder(
  //         //             itemCount: _Mutualfund!.length,
  //         //             itemBuilder: (context, index) {
  //         //               return Dismissible(
  //         //                 background: slideRightBackground(),
  //         //                 key: UniqueKey(),
  //         //                 onDismissed: (direction){
  //         //                   setState(() {
  //         //                     deleteMutualfunds(_Mutualfund[index].id!);
  //         //                     _Mutualfund.removeAt(index);
  //         //                   });
  //         //                     Flushbar(
  //         //                       message: "Mutual Funds deleted",
  //         //                       duration: Duration(seconds: 3),
  //         //                     ).show(context);
  //         //                 },
  //         //                 child: Card(
  //         //                   elevation: 2,
  //         //                   child: ListTile(
  //         //                     title: Text('${_Mutualfund[index].schemeName}'),
  //         //                     subtitle: Text(_Mutualfund[index].investmentAmount.toString()),
  //         //                     trailing: PopupMenuButton(
  //         //                       offset: Offset(0,50),
  //         //                       color: Color(0xFF6B6B6B),
  //         //                       tooltip: '',
  //         //                       icon: Icon(Icons.more_vert),
  //         //                       onSelected: (value) {
  //         //                         if (value == '/delete') {
  //         //                           setState(() {
  //         //                             deleteMutualfunds(_Mutualfund[index].id!);
  //         //                             _Mutualfund.removeAt(index);
  //         //                             Flushbar(
  //         //                               message: "Mutual Funds deleted",
  //         //                               duration: Duration(seconds: 3),
  //         //                             ).show(context);
  //         //                           });
  //         //                         } else if (value == "/edit") {
  //         //                           Get.toNamed("/editMutualfund", arguments: {
  //         //                             "id": _Mutualfund[index].id,
  //         //                            "scheme_name": _Mutualfund[index].schemeName,
  //         //                            "investment_amount": _Mutualfund[index].investmentAmount,
  //         //                            "date_of_investment": _Mutualfund[index].dateOfInvestment,
  //         //                           "current_value": _Mutualfund[index].currentValue
  //         //                           });
  //         //                         }
  //         //                       },
  //         //                       itemBuilder: (BuildContext bc) {
  //         //                         return [
  //         //                           PopupMenuItem(
  //         //                             child:  Text(
  //         //                             "Edit",
  //         //                             style: TextStyle(color: Colors.white),
  //         //                          ),
  //         //                          value: '/edit',
  //         //                         ),
  //         //                         PopupMenuItem(
  //         //                           child: Text(
  //         //                             "Delete",
  //         //                             style: TextStyle(color: Colors.white),
  //         //                           ),
  //         //                           value: '/delete',
  //         //                            )
  //         //                         ];
  //         //                        },
  //         //                     ),
  //         //                   ),
  //         //                 )
  //         //                 );
  //         //             },
  //         //             ),
  //         //         ),
  //         //           ],
  //         //         ),
  //         //       ),
  //         //     )
  //         //   ],
  //         // )
  //       ],
  //     );
  // }



//Previous widget for assets do not remove this

  // Card(
  //       shape: RoundedRectangleBorder(
  //         side: const BorderSide(color: Color(0xFFEBEBEB), width: 1),
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //       child: SingleChildScrollView(
  //           child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           // SizedBox(
  //           //   height: 12.h,
  //           // ),
  //           // Text(
  //           //   "My Total Invstments ₹0.00",
  //           //   style: TextStyle(
  //           //       color: Colors.black,
  //           //       fontSize: 15,
  //           //       fontWeight: FontWeight.w600),
  //           // ),
  //           SizedBox(
  //             height: 12.h,
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: <Widget>[
  //               Column(
  //                 children: <Widget>[
  //                   IconButton(
  //                     icon: SvgPicture.asset("assets/images/Group 9.svg"),
  //                     onPressed: () {
  //                       Navigator.push(
  //                           context,
  //                           MaterialPageRoute(
  //                               builder: (context) => Mutualfund()));
  //                     },
  //                   ),
  //                   // SizedBox(
  //                   //   height: 2.h,
  //                   // ),
  //                   Padding(
  //                     padding: const EdgeInsets.only(left: 12),
  //                     child: GestureDetector(
  //                       onTap: () {
  //                         Navigator.push(
  //                             context,
  //                             MaterialPageRoute(
  //                                 builder: (context) => Mutualfund()));
  //                       },
  //                       child: Text(
  //                         "Mutual Fund",
  //                         style: TextStyle(fontSize: 13, color: Colors.black),
  //                       ),
  //                     ),
  //                   ),
  //                   // SizedBox(
  //                   //   height: 6.h,
  //                   // ),
  //                   // Padding(
  //                   //   padding: const EdgeInsets.only(left: 12),
  //                   //   child: Text("₹99.k",
  //                   //   style: TextStyle(
  //                   //     fontSize: 13,
  //                   //     color: Colors.black
  //                   //   ),
  //                   //   ),
  //                   // )
  //                 ],
  //               ),
  //               Column(
  //                 children: <Widget>[
  //                   IconButton(
  //                    icon: SvgPicture.asset("assets/images/Group 10.svg"),
  //                     onPressed: () {
  //                       Navigator.push(
  //                           context,
  //                           MaterialPageRoute(
  //                               builder: (context) => FixDeposit()));
  //                     },
  //                   ),
  //                   // SizedBox(
  //                   //   height: 2.h,
  //                   // ),
  //                   GestureDetector(
  //                     onTap: () {
  //                       Navigator.push(
  //                           context,
  //                           MaterialPageRoute(
  //                               builder: (context) => FixDeposit()));
  //                     },
  //                     child: Text(
  //                       "Fix Deposit",
  //                       style: TextStyle(fontSize: 13, color: Colors.black),
  //                     ),
  //                   ),
  //                   // SizedBox(
  //                   //   height: 6.h,
  //                   // ),
  //                   // Text("₹99.k",
  //                   // style: TextStyle(
  //                   //   fontSize: 13,
  //                   //   color: Colors.black
  //                   // ),
  //                   // )
  //                 ],
  //               ),
  //               Column(
  //                 children: <Widget>[
  //                   IconButton(
  //                    icon: SvgPicture.asset("assets/images/Group 8.svg"),
  //                     onPressed: () {
  //                       Navigator.push(
  //                           context,
  //                           MaterialPageRoute(
  //                               builder: (context) => RealEstate()));
  //                     },
  //                   ),
  //                   // SizedBox(
  //                   //   height: 2.h,
  //                   // ),
  //                   Padding(
  //                     padding: const EdgeInsets.only(right: 12),
  //                     child: GestureDetector(
  //                       onTap: () {
  //                         Navigator.push(
  //                             context,
  //                             MaterialPageRoute(
  //                                 builder: (context) => RealEstate()));
  //                       },
  //                       child: Text(
  //                         "Real Estate",
  //                         style: TextStyle(fontSize: 13, color: Colors.black),
  //                       ),
  //                     ),
  //                   ),
  //                   // SizedBox(
  //                   //   height: 6.h,
  //                   // ),
  //                   // Padding(
  //                   //   padding: const EdgeInsets.only(right: 12),
  //                   //   child: Text("₹99.k",
  //                   //   style: TextStyle(
  //                   //     fontSize: 13,
  //                   //     color: Colors.black
  //                   //   ),
  //                   //   ),
  //                   // )
  //                 ],
  //               ),
  //             ],
  //           ),
  //           SizedBox(
  //             height: 15.h,
  //           ),
  //           Column(
  //             children: [
  //               Container(
  //                 color: Colors.red,
  //               )
  //             ],
  //           )
  //         ],
  //       ),
  //       ),
  //     );
  // }
}
