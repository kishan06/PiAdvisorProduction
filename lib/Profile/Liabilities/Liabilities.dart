import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:piadvisory/Common/app_bar.dart';
import 'package:piadvisory/Profile/Assets/AssetsRepository/assetsform.dart';
import 'package:piadvisory/Profile/Liabilities/CarLoan.dart';
import 'package:piadvisory/Profile/Liabilities/Homeloan.dart';
import 'package:piadvisory/Profile/Liabilities/LiabilitiesRepository/Model/UserLiabilitiesCL.dart';
import 'package:piadvisory/Profile/Liabilities/LiabilitiesRepository/Model/UserLiabilitiesHL.dart';
import 'package:piadvisory/Profile/Liabilities/LiabilitiesRepository/Model/UserLiabilitiesPL.dart';
import 'package:piadvisory/Profile/Liabilities/LiabilitiesRepository/liabilitiesform.dart';
import 'package:piadvisory/Profile/Liabilities/PersonalLoan.dart';
import 'package:piadvisory/Utils/base_manager.dart';
import 'package:piadvisory/Utils/textStyles.dart';
import '/Utils/Dialogs.dart';
import 'package:async/src/future_group.dart';

List<User>? globalHomeLoan = [];
List<Userpl>? globalPersonalLoan = [];
List<Usercl>? globalCarLoan = [];


class Liabilities extends StatefulWidget {
  const Liabilities({super.key});

  @override
  State<Liabilities> createState() => _LiabilitiesState();
}

class _LiabilitiesState extends State<Liabilities> {
  List<User>? _HomeLoan = [];
  List<Userpl>? _PersonalLoan = [];
  List<Usercl>? _CarLoan = [];

  FutureGroup futureGroup = FutureGroup();

   @override
  void initState() {
    futureGroup.add(StoreLiabilitiesform().getLiabilitiesHL());
    futureGroup.add(StoreLiabilitiesform().getLiabilitiesPL());
    futureGroup.add(StoreLiabilitiesform().getLiabilitiesCL());
    futureGroup.close();
    super.initState();
  }

  void deleteHomeLoans(int goalId) async {
    Map<String, dynamic> updata = {
      "goal_id": goalId,
    };
    print("updats is $updata");
    final data = await StoreLiabilitiesform().deleteLiabilitiesHL(updata);
    if (data.status == ResponseStatus.SUCCESS) {
    } else {
      return utils.showToast(data.message);
    }
  }

    void deletePersonalLoans(int goalId) async {
    Map<String, dynamic> updata = {
      "goal_id": goalId,
    };
    print("updats is $updata");
    final data = await StoreLiabilitiesform().deleteLiabilitiesPL(updata);
    if (data.status == ResponseStatus.SUCCESS) {
    } else {
      return utils.showToast(data.message);
    }
  }

   void deleteCarLoans(int goalId) async {
    Map<String, dynamic> updata = {
      "goal_id": goalId,
    };
    print("updats is $updata");
    final data = await StoreLiabilitiesform().deleteLiabilitiesCL(updata);
    if (data.status == ResponseStatus.SUCCESS) {
    } else {
      return utils.showToast(data.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleTxt: "My Liabilities",
        bottomtext: false,
      ),
      body: FutureBuilder(
        future: 
        //StoreLiabilitiesform().getLiabilitiesHL(),
        futureGroup.future,
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
            _HomeLoan = userHomeLoan.user!;
            globalHomeLoan = _HomeLoan;

            _PersonalLoan = userPersonalLoan.userpl!;
            globalPersonalLoan = _PersonalLoan;

            _CarLoan = userCarLoan.usercl!;
            globalCarLoan = _CarLoan;
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occured',
                  style: TextStyle(fontSize: 18),
                ),
              );
            }
          }
          //if (_Mutualfund != null && _Mutualfund!.isEmpty) {
          //  return _buildNodataBody(context);
          //  } else {
          return _buildBody(context, _HomeLoan, _PersonalLoan, _CarLoan
          //_Fixdeposit, _Realestate
          );
          // }
        },
      ),

    );
  }

    Widget slideRightBackground() {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.close_outlined,
              color: Colors.white,
            ),
            Text(
              "Remove",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

   Widget _buildBody(context, List<User>? _HomeLoan, List<Userpl>? _PersonalLoan, List<Usercl>? _CarLoan) {
        return 
        Column(
          children: [
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
                          icon: SvgPicture.asset("assets/images/Group 7.svg"),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Homeloan()));
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
                                      builder: (context) => Homeloan()));
                            },
                            child: Text(
                              "Home Loan",
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
                          icon: SvgPicture.asset("assets/images/Group 6.svg"),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PersonalLoan()));
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
                                    builder: (context) => PersonalLoan()));
                          },
                          child: Text(
                            "Personal Loan",
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
                         icon: SvgPicture.asset("assets/images/Group 5.svg"),
                          onPressed: () {
                            Navigator.push(context,
                            
                                MaterialPageRoute(builder: (context) => CarLoan()));
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
                                      builder: (context) => CarLoan()));
                            },
                            child: Text(
                              "Car Loan",
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
              ],
            )),
      ),
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Color(0xFFEBEBEB), width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Home Loan",
                          style: blackStyle(context).copyWith(
                              fontWeight: FontWeight.w600,
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: _HomeLoan!.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            background: slideRightBackground(),
                            key: UniqueKey(),
                            onDismissed: (direction) {
                              setState(() {
                                deleteHomeLoans(_HomeLoan[index].id!);
                                _HomeLoan.removeAt(index);
                              });
                              Flushbar(
                                message: "Home Loan deleted",
                                duration: Duration(seconds: 3),
                              ).show(context);
                            },
                            child: Card(
                              elevation: 2,
                              child: ListTile(
                                title: Text('${_HomeLoan[index].totalLoan}'),
                                subtitle: Text(
                                    '${_HomeLoan[index].loanIssuedOn.toString()}'),
                                trailing: PopupMenuButton(
                                    offset: Offset(0, 50),
                                    color: Color(0xFF6B6B6B),
                                    tooltip: '',
                                    icon: Icon(Icons.more_vert),
                                    onSelected: (value) {
                                      if (value == '/delete') {
                                        setState(() {
                                          deleteHomeLoans(
                                              _HomeLoan[index].id!);
                                          _HomeLoan.removeAt(index);
                                          Flushbar(
                                            message: "Home Loan deleted",
                                            duration: Duration(seconds: 3),
                                          ).show(context);
                                        });
                                      } else if (value == "/edit") {
                                        Get.toNamed("/editHomeloan",
                                            arguments: {
                                              "id": _HomeLoan[index].id,
                                              "total_loan":
                                                  _HomeLoan[index].totalLoan,
                                              "loan_issued_on":
                                                  _HomeLoan[index]
                                                      .loanIssuedOn,
                                              "loan_tenure":
                                                  _HomeLoan[index]
                                                      .loanTenure,
                                              "installment_amount":
                                                  _HomeLoan[index]
                                                      .installmentAmount,
                                              "frequency_payment":
                                                  _HomeLoan[index]
                                                      .frequencyPayment,  
                                               "rate_of_interest":
                                                  _HomeLoan[index]
                                                      .rateOfInterest,                
                                            });
                                      }
                                    },
                                    itemBuilder: (BuildContext bc) {
                                      return [
                                        PopupMenuItem(
                                          child: Text(
                                            "Edit",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          value: '/edit',
                                        ),
                                        PopupMenuItem(
                                          child: Text(
                                            "Delete",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          value: '/delete',
                                        )
                                      ];
                                    }),
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      Card(
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Color(0xFFEBEBEB), width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Personal Loan",
                      style: blackStyle(context).copyWith(
                          fontWeight: FontWeight.w600,
                          color:
                              Get.isDarkMode ? Colors.white : Colors.black),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                  ],
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: _PersonalLoan!.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        background: slideRightBackground(),
                        key: UniqueKey(),
                        onDismissed: (direction) {
                          setState(() {
                            deletePersonalLoans(_PersonalLoan[index].id!);
                            _PersonalLoan.removeAt(index);
                          });
                          Flushbar(
                            message: "Personal Loan deleted",
                            duration: Duration(seconds: 3),
                          ).show(context);
                        },
                        child: Card(
                          elevation: 2,
                          child: ListTile(
                            title: Text('${_PersonalLoan[index].totalLoan}'),
                            subtitle: Text(
                                '${_PersonalLoan[index].loanIssuedOn.toString()}'),
                            trailing: PopupMenuButton(
                                offset: Offset(0, 50),
                                color: Color(0xFF6B6B6B),
                                tooltip: '',
                                icon: Icon(Icons.more_vert),
                                onSelected: (value) {
                                  if (value == '/delete') {
                                    setState(() {
                                      deletePersonalLoans(
                                          _PersonalLoan[index].id!);
                                      _PersonalLoan.removeAt(index);
                                      Flushbar(
                                        message: "Personal Loan deleted",
                                        duration: Duration(seconds: 3),
                                      ).show(context);
                                    });
                                  } else if (value == "/edit") {
                                    Get.toNamed("/editPersonalloan",
                                        arguments: {
                                          "id": _PersonalLoan[index].id,
                                              "total_loan":
                                                  _PersonalLoan[index].totalLoan,
                                              "loan_issued_on":
                                                  _PersonalLoan[index]
                                                      .loanIssuedOn,
                                              "loan_tenure":
                                                  _PersonalLoan[index]
                                                      .loanTenure,
                                              "installment_amount":
                                                  _PersonalLoan[index]
                                                      .installmentAmount,
                                              "frequency_payment":
                                                  _PersonalLoan[index]
                                                      .frequencyPayment,  
                                               "rate_of_interest":
                                                  _PersonalLoan[index]
                                                      .rateOfInterest,
                                        });
                                  }
                                },
                                itemBuilder: (BuildContext bc) {
                                  return [
                                    PopupMenuItem(
                                      child: Text(
                                        "Edit",
                                        style:
                                            TextStyle(color: Colors.white),
                                      ),
                                      value: '/edit',
                                    ),
                                    PopupMenuItem(
                                      child: Text(
                                        "Delete",
                                        style:
                                            TextStyle(color: Colors.white),
                                      ),
                                      value: '/delete',
                                    )
                                  ];
                                }),
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Color(0xFFEBEBEB), width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Car Loan",
                          style: blackStyle(context).copyWith(
                              fontWeight: FontWeight.w600,
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: _CarLoan!.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            background: slideRightBackground(),
                            key: UniqueKey(),
                            onDismissed: (direction) {
                              setState(() {
                                deleteCarLoans(_CarLoan[index].id!);
                                _CarLoan.removeAt(index);
                              });
                              Flushbar(
                                message: "Car Loan deleted",
                                duration: Duration(seconds: 3),
                              ).show(context);
                            },
                            child: Card(
                              elevation: 2,
                              child: ListTile(
                                title: Text('${_CarLoan[index].totalLoan}'),
                                subtitle: Text(
                                    '${_CarLoan[index].loanIssuedOn.toString()}'),
                                trailing: PopupMenuButton(
                                    offset: Offset(0, 50),
                                    color: Color(0xFF6B6B6B),
                                    tooltip: '',
                                    icon: Icon(Icons.more_vert),
                                    onSelected: (value) {
                                      if (value == '/delete') {
                                        setState(() {
                                          deleteCarLoans(
                                              _CarLoan[index].id!);
                                          _CarLoan.removeAt(index);
                                          Flushbar(
                                            message: "Car Loan deleted",
                                            duration: Duration(seconds: 3),
                                          ).show(context);
                                        });
                                      } else if (value == "/edit") {
                                        Get.toNamed("/editCarloan",
                                            arguments: {
                                              "id": _CarLoan[index].id,
                                              "total_loan":
                                                  _CarLoan[index].totalLoan,
                                              "loan_issued_on":
                                                  _CarLoan[index]
                                                      .loanIssuedOn,
                                              "loan_tenure":
                                                  _CarLoan[index]
                                                      .loanTenure,
                                              "installment_amount":
                                                  _CarLoan[index]
                                                      .installmentAmount,
                                              "frequency_payment":
                                                  _CarLoan[index]
                                                      .frequencyPayment,  
                                               "rate_of_interest":
                                                  _CarLoan[index]
                                                      .rateOfInterest,                
                                            });
                                      }
                                    },
                                    itemBuilder: (BuildContext bc) {
                                      return [
                                        PopupMenuItem(
                                          child: Text(
                                            "Edit",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          value: '/edit',
                                        ),
                                        PopupMenuItem(
                                          child: Text(
                                            "Delete",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          value: '/delete',
                                        )
                                      ];
                                    }),
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
          ],
        );
   }

}
