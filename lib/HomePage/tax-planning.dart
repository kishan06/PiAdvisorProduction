// ignore_for_file: file_names, use_key_in_widget_constructors, avoid_print, use_full_hex_values_for_flutter_colors

import 'package:flutter/gestures.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:piadvisory/Common/Noscalinganimation.dart';
import 'package:piadvisory/HomePage/UploadDocuments.dart';
import 'package:piadvisory/HomePage/income-details.dart';
import 'package:piadvisory/HomePage/insurance.dart';
import 'package:piadvisory/HomePage/investments.dart';
import 'package:piadvisory/HomePage/personal-info.dart';
import 'package:piadvisory/HomePage/upload-doc.dart';
import 'package:piadvisory/Profile/KYC/SchduleAppointment.dart';
import 'package:piadvisory/SideMenu/Subscribe/Mysubscription.dart';
import 'package:piadvisory/Utils/textStyles.dart';
import 'package:piadvisory/api/tax_planning/methods/documents_upload_tax_planning_api_methods.dart';
import 'package:piadvisory/api/tax_planning/models/documents_upload_tax_planning_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Common/fab_bottom_app_bar.dart';
import '../Portfolio/PortfolioMainUI.dart';
import '../Utils/custom_icons_icons.dart';
import '../api/tax_planning/methods/income_details_tax_planning_api_methods.dart';
import '../api/tax_planning/methods/insurance_premium_tax_planning_api_methods.dart';
import '../api/tax_planning/methods/investments_tax_planning_api_methods.dart';
import '../api/tax_planning/methods/personal_info_tax_planning_api_methods.dart';
import '../api/tax_planning/models/income_details_tax_planning_model.dart';
import '../api/tax_planning/models/insurance_premium_tax_planning_model.dart';
import '../api/tax_planning/models/investments_tax_planning_model.dart';
import '../api/tax_planning/models/personal_info_tax_planning_model.dart';
import '../smallcase_api_methods.dart';
import 'Homepage.dart';
import 'Stock/stock.dart';
import 'package:async/async.dart';

class Taxplanning extends StatefulWidget {
  const Taxplanning({Key? key}) : super(key: key);

  @override
  State<Taxplanning> createState() => _TaxplanningState();
}

class _TaxplanningState extends State<Taxplanning> {
  String _lastSelected = 'TAB: 0';
  void _selectedTab(int index) {
    setState(() {
      _lastSelected = 'TAB: $index';
      print(_lastSelected);

      switch (index) {
        case 0:
          {
            Navigator.push(
                context, MaterialPageRoute(builder: ((context) => HomePage())));
          }
          break;

        case 1:
          {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => Stocks(
                          selectedPage: 0,
                        ))));
          }
          break;

        case 2:
          {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => Mysubscription())));
          }
          break;
        case 3:
          {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => SchduleAppointment())));
          }
          break;
        case 4:
          {
            openDashboardPage(context);
            // Navigator.push(context,
            //     MaterialPageRoute(builder: ((context) => PortfolioMainUI())));
          }
          break;
        default:
          {
            throw Error();
          }
      }
    });
  }

  FutureGroup futureGroup = FutureGroup();

  Future<int?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? user_id = await prefs.getInt('user_id');
    return user_id;
  }

  @override
  void initState() {
    super.initState();
    futureGroup.add(getUserId());
    futureGroup.add(fetchIncomeDetailsTaxPlanning());
    futureGroup.add(fetchInsurancePremiumTaxPlanning());
    futureGroup.add(fetchInvestmentsTaxPlanning());
    futureGroup.add(fetchPersonalInfoTaxPlanning());
    futureGroup.add(fetchDocumentsTaxPlanning());
    futureGroup.close();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  @override
  Widget build(BuildContext context) {
    final bool showfab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return FutureBuilder(
      future: futureGroup.future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          List data = snapshot.data! as List;
          debugPrint("snapshot data: ${snapshot.data}");
          int? userId = data[0];
          List<IncomeDetailsTaxPlanningModel> incomeDetailsList = data[1];
          List<InsurancePremiumTaxPlanningModel> insurancePremiumsList =
              data[2];
          List<InvestmentsTaxPlanningModel> investmentsList = data[3];
          List<PersonalInfoTaxPlanningModel> personalInfoList = data[4];
          List<DocumentsUploadTaxPlanningModel> documentsUploadList = data[5];

          //user tax planning details
          PersonalInfoTaxPlanningModel? userPersonalInfo;
          IncomeDetailsTaxPlanningModel? userIncomeDetails;
          InvestmentsTaxPlanningModel? userInvestments;
          InsurancePremiumTaxPlanningModel? userInsurancePremium;
          DocumentsUploadTaxPlanningModel? userDocuments;

          //user personal info
          try {
            userPersonalInfo = personalInfoList
                .singleWhere((personalInfo) => personalInfo.userId == userId);
          } catch (e) {
            userPersonalInfo = null;
          }

          //user income details
          try {
            userIncomeDetails = incomeDetailsList
                .singleWhere((incomeDetails) => incomeDetails.userId == userId);
          } catch (e) {
            userIncomeDetails = null;
          }

          try {
            userInvestments = investmentsList
                .singleWhere((investments) => investments.userId == userId);
          } catch (e) {
            userInvestments = null;
          }

          try {
            userInsurancePremium = insurancePremiumsList.singleWhere(
                (insurancePremium) => insurancePremium.userId == userId);
          } catch (e) {
            userInsurancePremium = null;
          }

          try {
            userDocuments = documentsUploadList
                .singleWhere((documents) => documents.userId == userId);
          } catch (e) {
            userDocuments = null;
          }

          debugPrint("userPersonalInfo $userPersonalInfo");
          debugPrint("userIncomeDetails $userIncomeDetails");
          debugPrint("userInvestments $userInvestments");
          debugPrint("userInsurancePremium $userInsurancePremium");
          debugPrint("userDocuments $userDocuments");

          return WillPopScope(
            onWillPop: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ));
              return Future.value(false);
            },
            child: Scaffold(
              //resizeToAvoidBottomInset: false,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButtonAnimator: NoScalingAnimation(),
              floatingActionButton:
                  //showfab
                  //? Stack(
                  //children: [
                  //  Positioned(
                  // bottom: 22,
                  // right: MediaQuery.of(context).size.width * 0.43,
                  // child:
                  //button changes
                  // RawMaterialButton(
                  //     padding: EdgeInsets.all(15.0),
                  //     shape: CircleBorder(),
                  //     child: SvgPicture.asset(
                  //       "assets/images/product sans logo wh.svg",
                  //     ),
                  //     elevation: 2.0,
                  //     fillColor: Color(0xFFF78104),
                  //     onPressed: () {
                  //       Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: ((context) =>
                  //                   const Mysubscription())));
                  //     })
                  Padding(
                padding: const EdgeInsets.only(top: 10),
                child: FloatingActionButton(
                  backgroundColor: Color(0xFFF78104),
                  heroTag: "tag1",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const Mysubscription())));
                  },
                  tooltip: 'Subscribe',
                  elevation: 2.0,
                  child: SvgPicture.asset(
                    "assets/images/product sans logo wh.svg",
                  ),
                ),
              ),
              //  ),
              //  ],
              // )
              //: null,
              bottomNavigationBar: BottomNavigationBar(
                selectedLabelStyle: TextStyle(color: Color(0xFFF78104)),
                unselectedLabelStyle: TextStyle(color: Colors.grey),
                unselectedIconTheme: IconThemeData(color: Colors.grey),
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      CustomIcons.path_3177,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Icon(
                        CustomIcons.path_4346,
                      ),
                    ),
                    label: 'Explore',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      CustomIcons.group_2369,
                    ),
                    label: 'Subscribe',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CustomIcons.date_range),
                    label: 'Calendar',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      CustomIcons.bottombarbagicon,
                      size: 22.5,
                    ),
                    label: 'Dashboard',
                  ),
                ],
                currentIndex: 0,
                unselectedItemColor: Colors.grey,
                selectedItemColor: Color(0xFFF78104),
                backgroundColor: Colors.white,
                onTap: (index) {
                  print(index);
                  _selectedTab(index);
                },
                type: BottomNavigationBarType.fixed,
              ),
              appBar: AppBar(
                backgroundColor: const Color(0xFFE7F3F3),
                elevation: 0,
                automaticallyImplyLeading: false,
                titleSpacing: 0,
                title: const Text(
                  "Tax Planning",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Product Sans',
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                  iconSize: 22,
                  color: const Color(0xFF6B6B6B),
                ),
              ),
              body: ListView(
                children: [
                  SvgPicture.asset(
                    fit: BoxFit.cover,
                    "assets/images/Group 6055.svg",
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Personalinfo(
                                    userUploadedDocs: userDocuments,
                                    userInvestments: userInvestments,
                                    userInsurancePremium: userInsurancePremium,
                                    userIncomeDetails: userIncomeDetails,
                                    userPersonalInfo: userPersonalInfo,
                                    userId: userId!,
                                  )));
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: 55,
                          margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                          padding: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color(0xFF82828229), width: 1),
                            borderRadius: BorderRadius.circular(10),
                            shape: BoxShape.rectangle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 12, left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Personal Information",
                                    style: TextStyle(
                                      fontSize: 18,
                                    )),
                                userPersonalInfo == null
                                    ? Text(
                                        "Update",
                                        style: blackStyle(context).copyWith(
                                            fontSize: 14,
                                            color: Color(0xFFDA0600)),
                                      )
                                    : AnimatedContainer(
                                        duration: const Duration(
                                          milliseconds: 500,
                                        ),
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF12B784),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                            color: Color(0xFF12B784),
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                            left: 30,
                            top: 12,
                            child: Container(
                              padding: const EdgeInsets.only(
                                  bottom: 10, left: 10, right: 10),
                              color: Get.isDarkMode
                                  ? Color(0xFF303030).withOpacity(0.8)
                                  : Colors.white,
                              child: const Text(
                                'Step 1',
                                style: TextStyle(
                                    color: Color(0xFF008083), fontSize: 12),
                              ),
                            )),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Incomedetails(
                                    userId: userId!,
                                    userInvestments: userInvestments,
                                    userInsurancePremium: userInsurancePremium,
                                    incomeDetails: userIncomeDetails,
                                    userUploadedDocs: userDocuments,
                                  )));
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: 55,
                          margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                          padding: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color(0xFF82828229), width: 1),
                            borderRadius: BorderRadius.circular(10),
                            shape: BoxShape.rectangle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 12, left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Income Details",
                                  style: TextStyle(fontSize: 18),
                                ),
                                userIncomeDetails == null
                                    ? Text(
                                        "Update",
                                        style: blackStyle(context).copyWith(
                                            fontSize: 14,
                                            color: Color(0xFFDA0600)),
                                      )
                                    : AnimatedContainer(
                                        duration: const Duration(
                                          milliseconds: 500,
                                        ),
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF12B784),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                            color: Color(0xFF12B784),
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                            left: 30,
                            top: 12,
                            child: Container(
                              padding: const EdgeInsets.only(
                                  bottom: 10, left: 10, right: 10),
                              color: Get.isDarkMode
                                  ? Color(0xFF303030).withOpacity(0.8)
                                  : Colors.white,
                              child: const Text(
                                'Step 2',
                                style: TextStyle(
                                    color: Color(0xFF008083), fontSize: 12),
                              ),
                            )),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Invest(
                                    userId: userId!,
                                    userInvestments: userInvestments,
                                    userInsurancePremium: userInsurancePremium,
                                    userUploadedDocs: userDocuments,
                                  )));
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: 55,
                          margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                          padding: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color(0xFF82828229), width: 1),
                            borderRadius: BorderRadius.circular(10),
                            shape: BoxShape.rectangle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 12, left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Investments",
                                  style: TextStyle(fontSize: 18),
                                ),
                                userInvestments == null
                                    ? Text(
                                        "Update",
                                        style: blackStyle(context).copyWith(
                                            fontSize: 14,
                                            color: Color(0xFFDA0600)),
                                      )
                                    : AnimatedContainer(
                                        duration: const Duration(
                                          milliseconds: 500,
                                        ),
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF12B784),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                            color: Color(0xFF12B784),
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                            left: 30,
                            top: 12,
                            child: Container(
                              padding: const EdgeInsets.only(
                                  bottom: 10, left: 10, right: 10),
                              color: Get.isDarkMode
                                  ? Color(0xFF303030).withOpacity(0.8)
                                  : Colors.white,
                              child: const Text(
                                'Step 3',
                                style: TextStyle(
                                    color: Color(0xFF008083), fontSize: 12),
                              ),
                            )),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InsurancePremium(
                                    userId: userId!,
                                    userInsurancePremium: userInsurancePremium,
                                    userUploadedDocs: userDocuments,
                                  )));
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: 55,
                          margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                          padding: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color(0xFF82828229), width: 1),
                            borderRadius: BorderRadius.circular(10),
                            shape: BoxShape.rectangle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 12, left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Insurance Premium",
                                  style: TextStyle(fontSize: 18),
                                ),
                                userInsurancePremium == null
                                    ? Text(
                                        "Update",
                                        style: blackStyle(context).copyWith(
                                            fontSize: 14,
                                            color: Color(0xFFDA0600)),
                                      )
                                    : AnimatedContainer(
                                        duration: const Duration(
                                          milliseconds: 500,
                                        ),
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF12B784),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                            color: Color(0xFF12B784),
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                            left: 30,
                            top: 12,
                            child: Container(
                              padding: const EdgeInsets.only(
                                  bottom: 10, left: 10, right: 10),
                              color: Get.isDarkMode
                                  ? Color(0xFF303030).withOpacity(0.8)
                                  : Colors.white,
                              child: const Text(
                                'Step 4',
                                style: TextStyle(
                                    color: Color(0xFF008083), fontSize: 12),
                              ),
                            )),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UploadDocuments(
                            userId: userId!,
                            uploadedDocs: userDocuments,
                          ),
                        ),
                      );
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: 55,
                          margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                          padding: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color(0xFF82828229), width: 1),
                            borderRadius: BorderRadius.circular(10),
                            shape: BoxShape.rectangle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 12, left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Upload Documents",
                                  style: TextStyle(fontSize: 18),
                                ),
                                userDocuments == null
                                    ? Text(
                                        "Update",
                                        style: blackStyle(context).copyWith(
                                            fontSize: 14,
                                            color: Color(0xFFDA0600)),
                                      )
                                    : AnimatedContainer(
                                        duration: const Duration(
                                          milliseconds: 500,
                                        ),
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF12B784),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                            color: Color(0xFF12B784),
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                            left: 30,
                            top: 12,
                            child: Container(
                              padding: const EdgeInsets.only(
                                  bottom: 10, left: 10, right: 10),
                              color: Get.isDarkMode
                                  ? Color(0xFF303030).withOpacity(0.8)
                                  : Colors.white,
                              child: const Text(
                                'Step 5',
                                style: TextStyle(
                                    color: Color(0xFF008083), fontSize: 12),
                              ),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          );
        }
        return Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
