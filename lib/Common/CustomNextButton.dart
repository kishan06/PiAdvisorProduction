// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomNextButton extends StatelessWidget {
  const CustomNextButton({
    Key? key,
    GlobalKey<FormState>? form,
    this.ontap,
    required this.text,
    this.colorchange = false,
  }) : super(key: key);

  final String text;
  final GestureTapCallback? ontap;
  final bool colorchange;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          // ignore: deprecated_member_use
          primary:
              colorchange ? Colors.white : const Color.fromRGBO(247, 129, 4, 1),
          shape: RoundedRectangleBorder(
            side: colorchange
                ? BorderSide(color: Color(0xFF707070))
                : BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: colorchange ? Color(0xFF303030) : Colors.white,
            fontSize: 16.sm,
            fontFamily: 'Productsans',
          ),
        ),
        onPressed: () {
          ontap!();
        },
      ),
    );
  }
}
