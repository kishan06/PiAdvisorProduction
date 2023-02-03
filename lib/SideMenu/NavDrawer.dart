// ignore_for_file: file_names, use_key_in_widget_constructors, sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:piadvisory/HomePage/Homepage.dart';
import 'package:piadvisory/HomePage/SettingsPage.dart';
import 'package:piadvisory/HomePage/blog.dart';
import 'package:piadvisory/Login/login.dart';
import 'package:piadvisory/SideMenu/FAQ/faq.dart';
import 'package:piadvisory/SideMenu/PiRecommended.dart';
import 'package:piadvisory/SideMenu/ReportsAndStatement.dart';
import 'package:piadvisory/SideMenu/Subscribe/ViewSubscription.dart';
import 'package:piadvisory/SideMenu/about.dart';
import 'package:piadvisory/SideMenu/contact_us.dart';
import 'package:piadvisory/SideMenu/license.dart';
import 'package:piadvisory/SideMenu/myresources.dart';
import 'package:piadvisory/SideMenu/your-advisor.dart';
import 'package:piadvisory/Utils/database.dart';
import 'package:piadvisory/Utils/textStyles.dart';
import 'package:piadvisory/themedata.dart';
import 'package:scgateway_flutter_plugin/scgateway_flutter_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Common/CustomNextButton.dart';
import 'Brokerage/broker.dart';

class NavDrawer extends StatefulWidget {
  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  Future<void> _logoutstate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('token');
    await preferences.remove('video');
    await preferences.remove('pinenabled');

    //  Database().deleteStorage();
    // setState(() {
    //   Get.isDarkMode ? ThemeServices().switchTheme() : null;
    // });
  }

  @override
  void initState() {
    super.initState();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      //backgroundColor: Colors.amber,
      child: Container(
        color: const Color(0xFF008083),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.end,
              //   children: [
              //     Padding(
              //       padding: EdgeInsets.only(top: 15),
              //       child: IconButton(
              //           onPressed: () {
              //             Navigator.pop(context);
              //           },
              //           icon: const Icon(
              //             Icons.close,
              //             color: Colors.white,
              //           )),
              //     ),
              //   ],
              // ),
              SizedBox(height: 16.h),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  // ListTile(
                  //   leading: const CircleAvatar(
                  //     child: Text("AG"),
                  //     backgroundColor: Color.fromARGB(255, 1, 52, 53),
                  //   ),
                  //   title: Text('Aditya Gupta',
                  //       style: blackStyle(context).copyWith(
                  //         color: Colors.white,
                  //       )),
                  // ),
                  SizedBox(
                    height: 15.h,
                  ),
                  // Divider(
                  //   height: 10,
                  //   color: Colors.white,
                  //   //   indent: MediaQuery.of(context).size.width * 0.24,
                  //   thickness: 0.5,
                  // ),
                ],
              ),
              // SizedBox(
              //   height: 45,
              //   child: ListTile(
              //     trailing: Icon(
              //       Icons.navigate_next,
              //       color: Colors.white,
              //     ),
              //     title: Text(
              //       'Profile',
              //       style: blackStyle(context).copyWith(
              //         color: Colors.white,
              //       ),
              //     ),
              //     onTap: () => {
              //       Navigator.push(context,
              //           MaterialPageRoute(builder: (context) => ProfileMain()))
              //     },
              //   ),
              // ),
              SizedBox(
                height: 45.h,
                child: ListTile(
                  trailing: const Icon(
                    Icons.navigate_next,
                    color: Colors.white,
                  ),
                  title: Text(
                    'PI Recommended',
                    style: blackStyle(context).copyWith(
                      color: Colors.white,
                    ),
                  ),
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PiRecommended()))
                  },
                ),
              ),
              SizedBox(
                height: 45.h,
                child: ListTile(
                  trailing: const Icon(
                    Icons.navigate_next,
                    color: Colors.white,
                  ),
                  title: Text(
                    'My Subscription ',
                    style: blackStyle(context).copyWith(
                      color: Colors.white,
                    ),
                  ),
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewSubscription()))
                  },
                ),
              ),
              SizedBox(
                height: 45.h,
                child: ListTile(
                  trailing: const Icon(
                    Icons.navigate_next,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Brokerage Account',
                    style: blackStyle(context).copyWith(
                      color: Colors.white,
                    ),
                  ),
                  onTap: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Broker()))
                  },
                ),
              ),
              SizedBox(
                height: 45.h,
                child: ListTile(
                  trailing: const Icon(
                    Icons.navigate_next,
                    color: Colors.white,
                  ),
                  title: Text(
                    'News & Insights',
                    style: blackStyle(context).copyWith(
                      color: Colors.white,
                    ),
                  ),
                  onTap: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Blog()))
                  },
                ),
              ),
              SizedBox(
                height: 45.h,
                child: ListTile(
                  trailing: const Icon(
                    Icons.navigate_next,
                    color: Colors.white,
                  ),
                  title: Text(
                    'My Resources',
                    style: blackStyle(context).copyWith(
                      color: Colors.white,
                    ),
                  ),
                  onTap: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => resoures()))
                  },
                ),
              ),
              SizedBox(
                height: 45.h,
                child: ListTile(
                  trailing: const Icon(
                    Icons.navigate_next,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Reports & Statements',
                    style: blackStyle(context).copyWith(
                      color: Colors.white,
                    ),
                  ),
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReportsAndStatement())),
                  },
                ),
              ),
              SizedBox(
                height: 45.h,
                child: ListTile(
                  trailing: const Icon(
                    Icons.navigate_next,
                    color: Colors.white,
                  ),
                  title: Text(
                    'FAQs',
                    style: blackStyle(context).copyWith(
                      color: Colors.white,
                    ),
                  ),
                  onTap: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Faq()))
                  },
                ),
              ),
              SizedBox(
                height: 45.h,
                child: ListTile(
                  trailing: const Icon(
                    Icons.navigate_next,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Contact Us',
                    style: blackStyle(context).copyWith(
                      color: Colors.white,
                    ),
                  ),
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Contact()))
                  },
                ),
              ),
              SizedBox(
                height: 45.h,
                child: ListTile(
                  trailing: const Icon(
                    Icons.navigate_next,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Contact Your Advisor',
                    style: blackStyle(context).copyWith(
                      color: Colors.white,
                    ),
                  ),
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Advisor()))
                  },
                ),
              ),
              SizedBox(
                height: 45.h,
                child: ListTile(
                  trailing: const Icon(
                    Icons.navigate_next,
                    color: Colors.white,
                  ),
                  title: Text(
                    'About Us',
                    style: blackStyle(context).copyWith(
                      color: Colors.white,
                    ),
                  ),
                  onTap: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const about())),
                  },
                ),
              ),
              SizedBox(
                height: 45.h,
                child: ListTile(
                  trailing: const Icon(
                    Icons.navigate_next,
                    color: Colors.white,
                  ),
                  title: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const license()));
                    },
                    child: Text(
                      'Licenses',
                      style: blackStyle(context).copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onTap: () => {Navigator.of(context).pop()},
                ),
              ),
              SizedBox(
                height: 45.h,
                child: ListTile(
                  trailing: const Icon(
                    Icons.navigate_next,
                    color: Colors.white,
                  ),
                  title: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Settings()));
                    },
                    child: Text(
                      'Settings',
                      style: blackStyle(context).copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onTap: () => {Navigator.of(context).pop()},
                ),
              ),
              ListTile(
                title: Text(
                  'Logout',
                  style: blackStyle(context).copyWith(
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    builder: (context) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 50.h,
                            ),
                            Center(
                              child: Text(
                                'Log Out?',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Center(
                              child: Text(
                                'Are you sure you want to log out?',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Color(0xFF444444)),
                              ),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 15,
                                right: 15,
                              ),
                              child: SizedBox(
                                  width: double.infinity,
                                  height: 50.h,
                                  child: CustomNextButton(
                                    text: "Log out",
                                    ontap: () {
                                      _logoutstate();
                                      Get.offAll(Login());
                                    },
                                  )),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 15,
                                right: 15,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()));
                                },
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 50.h,
                                  child: Text(
                                    "Cancel",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Color(0xFF585858),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              SizedBox(
                height: 100.h,
              ),
              ListTile(
                title: Text(
                  "Version 1.0.3",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFFF78104),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
