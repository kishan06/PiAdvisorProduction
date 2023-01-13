// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../HomePage/tax-planning.dart';

class CustomSignupAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(50);
  const CustomSignupAppBar(
      {Key? key,
      required this.titleTxt,
      this.bottomtext,
      this.customProfileNavigation = false,
      this.navigateToTaxPlanning = false,

      this.showLeading = true})
      : super(key: key);

  final String titleTxt;
  final bool? bottomtext;
  final bool? customProfileNavigation;
  final bool? showLeading;
  final bool navigateToTaxPlanning;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        height: 50,
        decoration: const BoxDecoration(),
      ),
      bottom: bottomtext!
          ? PreferredSize(
              child: Text(
                "Steps to check for Clients other than Resident Individual",
                textAlign: TextAlign.center,
                style:
                    //Theme.of(context).textTheme.headline5,
                    TextStyle(
                        fontWeight: FontWeight.w600,
                        decorationColor: Colors.black,
                        fontSize: 12),
                // selectionColor: Colors.black
              ),
              preferredSize: Size.zero)
          : null,
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,

      titleSpacing: 0,
      // centerTitle: true,
      title: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text(
          titleTxt,
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(
              //  fontFamily: 'Helvetica',
              fontSize: 20.sm,
              fontWeight: FontWeight.w600,
              color: Colors.black),
        ),
      ),
      leading: !navigateToTaxPlanning
          ? showLeading!
              ? IconButton(
                  onPressed: () {
                    !customProfileNavigation!
                        ?  Get.toNamed("/login")
                        : Get.toNamed("/profile");
                  },
                  icon: Icon(
                    Icons.arrow_back,
                  ),
                  iconSize: 22.sm,
                  color: Color(0xFF6B6B6B),
                )
              : null
          : IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Taxplanning(),
                    ));
              },
              icon: Icon(
                Icons.arrow_back,
              ),
              iconSize: 22.sm,
              color: Color(0xFF6B6B6B),
            ),
    );
  }
}
