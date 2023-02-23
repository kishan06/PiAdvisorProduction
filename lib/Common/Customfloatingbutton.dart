import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piadvisory/SideMenu/Subscribe/Mysubscription.dart';
import 'package:piadvisory/SideMenu/Subscribe/Repository/getSubscriptionWithDetails.dart';
import 'package:piadvisory/main.dart';

class CustomFloatingButton extends StatefulWidget {
  CustomFloatingButton({super.key});

  @override
  State<CustomFloatingButton> createState() => _CustomFloatingButtonState();
}

class _CustomFloatingButtonState extends State<CustomFloatingButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Color(0xFFF78104),
      heroTag: "tag1",
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => const Mysubscription())));
        bottomIndex = 2;
      },
      tooltip: 'Subscribe',
      elevation: 2.0,
      child: SvgPicture.asset(
        "assets/images/product sans logo wh new.svg",
        color: Colors.white,
        fit: BoxFit.contain,
        width: 28,
        height: 24,
      ),
    );
  }
}
