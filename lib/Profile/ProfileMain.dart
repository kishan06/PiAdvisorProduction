//Profile Uodate implementation static

// ignore_for_file: file_names, avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:piadvisory/Common/CustomAppbarWithIcons.dart';
import 'package:piadvisory/HomePage/Stock/stock.dart';
import 'package:piadvisory/Portfolio/PortfolioMainUI.dart';
import 'package:piadvisory/Profile/Assets.dart';
import 'package:piadvisory/Profile/BankDetails.dart';
import 'package:piadvisory/Profile/BankdetailsRepository/storeBankdetails.dart';
import 'package:piadvisory/Profile/CustomRiskAssessment.dart';
import 'package:piadvisory/Profile/GoalsRepository/storeGoals.dart';
import 'package:piadvisory/Profile/KYC/KYCMain.dart';
import 'package:piadvisory/Profile/KYC/Repository/storebasicaddincome.dart';
import 'package:piadvisory/Profile/KYC/Repository/storebasicfamilydetails.dart';
import 'package:piadvisory/Profile/KYC/Repository/storebasickycuserdetails.dart';
import 'package:piadvisory/Profile/KYC/SchduleAppointment.dart';
import 'package:piadvisory/Profile/Liabilities.dart';
import 'package:piadvisory/Profile/PasswordAndSecurity/PasswordAndSecurity.dart';
import 'package:piadvisory/Profile/PersonalProfile.dart';
import 'package:piadvisory/Profile/Personalprofilerepository/storePersonalprofile.dart';
import 'package:piadvisory/Profile/ProfileRepository/ProfileMethods.dart';
import 'package:piadvisory/Profile/RiskAssestmentRepository/RiskAssestment.dart';
import 'package:piadvisory/Profile/UpdateRiskProfile.dart';
import 'package:piadvisory/Profile/goal.dart';
import 'package:piadvisory/SideMenu/NavDrawer.dart';
import 'package:piadvisory/SideMenu/Subscribe/Mysubscription.dart';
import 'package:piadvisory/Utils/custom_icons_icons.dart';
import 'package:piadvisory/Utils/textStyles.dart';

import '../Common/app_bar.dart';
import '../HomePage/Homepage.dart';
import '../smallcase_api_methods.dart';

class ProfileMain extends StatefulWidget {
  const ProfileMain({Key? key}) : super(key: key);

  @override
  State<ProfileMain> createState() => _ProfileMainState();
}

class _ProfileMainState extends State<ProfileMain> {
  String _lastSelected = 'TAB: 0';
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  void _selectedTab(int index) {
    setState(() {
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
            // debugPrint('DASHBOARD');
          }
          break;
        default:
          {
            throw Error();
          }
      }
    });
  }

  late final Future? myFuture;
  @override
  void initState() {
    // myFuture = ProfileMethods().getUpdateStatus();
    // Storefamilydetails().getBasicfamilyDetails();
    // StorebasicaddincomeDetails().getBasicaddincomeDetails();
    // StorePersonalprofile().getPersonalprofile();
    _fetchfutures();
    super.initState();
  }

  void _fetchfutures() async {
    await Future.wait([
      Storefamilydetails().getBasicfamilyDetails(),
      StorebasicaddincomeDetails().getBasicaddincomeDetails(),
      StorePersonalprofile().getPersonalprofile(),
      getRiskQuestions().getAnswers(),
      Storegoalsdetails().checkGoals(),
      StorebasickycuserDetails().getBasicKycDetails(),
    ]);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (() async {
        Get.offAllNamed('/home');
        return Future.value(false);
      }),
      child: Scaffold(
        drawer: NavDrawer(),
        key: _key,
        appBar: CustomAppBarWithIcons(
          isprofile: true,
          titleTxt: "Profile",
          globalkey: _key,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Stack(
          children: [
            Positioned(
              bottom: 22,
              right: MediaQuery.of(context).size.width * 0.43,
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
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: TextStyle(color: Color(0xFFF78104)),
          unselectedLabelStyle: TextStyle(color: Colors.grey),
          unselectedIconTheme: IconThemeData(color: Colors.grey),
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                CustomIcons.path_3177,
                //  color:
                //         Get.isDarkMode ? Color(0xFFF78104) : Color(0xFFF78104)
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(
                  CustomIcons.path_4346,
                  //  color:
                  //       Get.isDarkMode ? Color(0xFFF78104) : Color(0xFFF78104)
                ),
              ),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CustomIcons.group_2369,
                //  color:
                //         Get.isDarkMode ? Color(0xFFF78104) : Color(0xFFF78104)
              ),
              label: 'Subscribe',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CustomIcons.date_range,
                //  color:
                //           Get.isDarkMode ? Color(0xFFF78104) : Color(0xFFF78104)
              ),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CustomIcons.bottombarbagicon,
                size: 22.5,
                //  color:
                //         Get.isDarkMode ? Color(0xFFF78104) : Color(0xFFF78104)
              ),
              label: 'Dashboard',
            ),
          ],
          currentIndex: 0,
          selectedItemColor: Color(0xFFF78104),
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          onTap: (index) {
            print(index);
            _selectedTab(index);
          },
          type: BottomNavigationBarType.fixed,
        ),
        body: FutureBuilder(
          future: ProfileMethods().getUpdateStatus(),
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
      ),
    );
  }

  Widget _buildBody(context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.only(
        left: 16.5,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 22,
          ),
          CustomListTiles(
            ontap: () {
              //   Get.toNamed('/kycmain');
              if (kycsbool != null && kycsbool!) {
                Get.toNamed('/KYCThankyou');
              } else {
                Get.toNamed('/kycmain');
              }
            },
            sizefactor: 20,
            isimage: false,
            isupdate: kycsbool ?? false ? false : true,
            leadingimage: "assets/images/6062.svg",
            title: "KYC",
            showTrailingText: true,
          ),
          const Divider(
            thickness: 1,
          ),
          CustomListTiles(
            sizefactor: 15,
            isimage: false,
            isupdate: personalProfile ?? false ? false : true,
            leadingimage: "assets/images/Group 6061.svg",
            title: "Personal Profile",
            showTrailingText: true,
            ontap: () {
              Get.toNamed('/personalProfile');
              // if (personalProfile != null && personalProfile!) {
              //   Get.toNamed('/KYCThankyou');
              // } else {
              //   Get.toNamed('/personalProfile');
              // }
            },
          ),
          const Divider(
            thickness: 1,
          ),
          CustomListTiles(
            showTrailingText: false,
            sizefactor: 20,
            isimage: false,
            isupdate: false,
            leadingimage: "assets/images/6060.svg",
            title: "Financial and Risk Profile",
            ontap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CustomAssessment()));
            },
          ),
          const Divider(
            thickness: 1,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomListTiles(
            showTrailingText: true,
            ontap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const goal()));
            },
            sizefactor: 20,
            isimage: false,
            isupdate: goalsupdated ?? false ? false : true,
            leadingimage: "assets/images/6059.svg",
            title: "My Goals",
          ),
          const Divider(
            thickness: 1,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomListTiles(
            showTrailingText: false,
            ontap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const BankDetails()));
            },
            sizefactor: 20,
            isimage: false,
            isupdate: false,
            leadingimage: "assets/images/Group 6058.svg",
            title: "Bank Details",
          ),
          const Divider(
            thickness: 1,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomListTiles(
            showTrailingText: false,
            sizefactor: 20,
            isimage: false,
            isupdate: false,
            leadingimage: "assets/images/Group 6057.svg",
            title: "Password & Security",
            ontap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PasswordAndSecurity()));
            },
          ),
          const Divider(
            thickness: 1,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomListTiles(
            showTrailingText: false,
            sizefactor: 20,
            isimage: false,
            isupdate: false,
            leadingimage: "assets/images/Group 6058.svg",
            title: "My Assets",
            ontap: () {
               Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Assets()));
            },
          ),
          const Divider(
            thickness: 1,
          ),
          const SizedBox(
            height: 10,
          ),
           CustomListTiles(
            showTrailingText: false,
            sizefactor: 20,
            isimage: false,
            isupdate: false,
            leadingimage: "assets/images/Group 6058.svg",
            title: "My Liabilities",
            ontap: () {
               Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Liabilities()));
            },
          ),
          const Divider(
            thickness: 1,
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    ));
  }
}

class CustomListTiles extends StatelessWidget {
  CustomListTiles({
    Key? key,
    required this.leadingimage,
    required this.title,
    required this.isimage,
    required this.isupdate,
    required this.sizefactor,
    required this.showTrailingText,
    this.ontap,
  }) : super(key: key);

  final String leadingimage;
  final String title;
  final double sizefactor;
  bool isimage;
  bool isupdate;
  bool showTrailingText;

  final GestureTapCallback? ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ontap!.call();
      },
      child: SizedBox(
        child: ListTile(
          leading: Padding(
            padding: const EdgeInsets.only(
              top: 5.0,
              left: 5,
            ),
            child: SizedBox(
                height: sizefactor,
                width: sizefactor,
                child: isimage
                    ? Image.asset(leadingimage,
                        color: Get.isDarkMode ? Colors.white : Colors.black)
                    : SvgPicture.asset(leadingimage,
                        color: Get.isDarkMode ? Colors.white : Colors.black)),
          ),
          title: Text(
            title,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          trailing: showTrailingText
              ? Text(
                  !isupdate ? "Completed" : "Update",
                  style: !isupdate
                      ? TextStyle(color: Colors.green, fontSize: 14.sm)
                      : TextStyle(color: Colors.red, fontSize: 14.sm),
                )
              : null,
        ),
      ),
    );
  }
}
