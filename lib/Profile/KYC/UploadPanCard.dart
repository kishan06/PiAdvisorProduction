import '/Common/app_bar.dart';
import '/Utils/textStyles.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UploadPanCard extends StatefulWidget {
  const UploadPanCard({Key? key}) : super(key: key);

  @override
  State<UploadPanCard> createState() => _UploadPanCardState();
}

class _UploadPanCardState extends State<UploadPanCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleTxt: "Personal Profile", bottomtext: false),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              "Upload your PAN Card",
              style: blackStyle(context)
                  .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            DottedBorder(
              color: Color(0xFF6B6B6B),
              strokeWidth: 3,
              dashPattern: const [10, 5, 10, 5, 10, 5],
              borderType: BorderType.RRect,
              radius: const Radius.circular(20),
              child: Container(
                width: double.infinity,
                height: 254,
                decoration: BoxDecoration(
                    color: const Color(0xFFF2F5FA),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/images/Path 4171.svg"),
                    const SizedBox(height: 23),
                    const Text(
                      "Upload your file here",
                      style: TextStyle(
                        color: Color(0xFF444444),
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      "Browse",
                      style: blackStyle(context)
                          .copyWith(fontSize: 12, color: Color(0xFF008083)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SvgPicture.asset(
                  "assets/images/lock_black_24dp.svg",
                  color: Color(0xFFF78104),
                ),
                Flexible(
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut",
                    style: blackStyle(
                      context,
                    ).copyWith(fontSize: 10),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 17,
            ),
            Text(
                "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut"),
            SizedBox(
              height: 30,
            ),
            Image.asset("assets/images/pancard.png"),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      )),
    );
  }
}
