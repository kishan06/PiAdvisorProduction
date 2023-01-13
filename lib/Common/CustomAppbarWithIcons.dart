// import 'package:piadvisory/HomePage/Notifications/Notification.dart';
// import 'package:piadvisory/HomePage/SettingsPage.dart';
// import 'package:piadvisory/Portfolio/PortfolioMainUI.dart';
// import 'package:piadvisory/Profile/PersonalProfile.dart';
// import 'package:piadvisory/Profile/ProfileMain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:piadvisory/HomePage/Notifications/Notification.dart';
import 'package:piadvisory/Profile/ProfileMain.dart';

class CustomAppBarWithIcons extends StatelessWidget with PreferredSizeWidget {
  Size get preferredSize => const Size.fromHeight(50);
  CustomAppBarWithIcons({
    Key? key,
    required this.titleTxt,
    required this.globalkey,
    this.bottomWidget,
    this.isnotification =false,
    this.isprofile =false, 
  }) : super(key: key);
  final String titleTxt;
  final GlobalKey<ScaffoldState> globalkey;
  final PreferredSizeWidget? bottomWidget;
  final bool isnotification;
  final bool isprofile;
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: bottomWidget,
      backgroundColor: Colors.white,
      elevation: 2,
      shadowColor: Colors.black,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Text(titleTxt,style: Theme.of(context).appBarTheme.titleTextStyle),
      leading: Row(
        children: [
          IconButton(
            onPressed: () {
              globalkey.currentState!.openDrawer();
            },
            icon: Icon(
              Icons.menu,color:  Get.isDarkMode ? Colors.black : Colors.black,
            ),
            iconSize: 25,
          ),
        ],
      ),
      actions: [
        // IconButton(
        //   onPressed: () {},
        //   icon: SvgPicture.asset(
        //     'assets/images/search-icon.svg',
        //   ),
        //   iconSize: 22,
        //   color: const Color(0xFF6B6B6B),
        // ),
        // IconButton(
        //   onPressed: () { isnotification ? null :
        //      Navigator.push(context,
        //         MaterialPageRoute(builder: ((context) => const Notify())));
        //   },
        //   icon: SvgPicture.asset(
        //     'assets/images/notification-icon.svg',
        //   ),
        //   iconSize: 22,
        //   color: const Color(0xFF6B6B6B),
        // ),
        IconButton(
          onPressed: () { isprofile ? null :
             Navigator.push(context,
                 MaterialPageRoute(builder: ((context) => const ProfileMain())));
          },
          icon: SvgPicture.asset(
            'assets/images/Profile1.svg',
          ),
          iconSize: 22,
          color: const Color(0xFF303030),
        ),
      ],
    );
  }
}
