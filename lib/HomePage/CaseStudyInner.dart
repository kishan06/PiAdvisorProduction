// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Common/app_bar.dart';

class CaseStudyInner extends StatefulWidget {
  const CaseStudyInner({Key? key}) : super(key: key);

  @override
  State<CaseStudyInner> createState() => _CaseStudyInnerState();
}

class _CaseStudyInnerState extends State<CaseStudyInner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titleTxt: "", bottomtext: false,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 15,
            bottom: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Cap on short-term power price to hurt generation as coal prices remain high: JSW Energy CEO",
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.sm,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "May 03, 2022 11:33 AM IST",
                style: TextStyle(
                  color: Color(0xFF444444),
                  fontSize: 11.sm,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                color: Color(0xFFF6FFFF),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, cons ectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad",
                    style: TextStyle(
                      color: Color(0xFF6B6B6B),
                      fontSize: 14.sm,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Image.asset("assets/images/imgpsh_fullsize_anim.png"),
              SizedBox(
                height: 20,
              ),
              Text(
                "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sipiscing elit, sed diam nont ut laoreetadipiscing elit, sed diam nonummy nibh euismod tincidunt ut adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreetadipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in",
                style: TextStyle(
                  color: Color(0xFF6B6B6B),
                  fontSize: 14.sm,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
