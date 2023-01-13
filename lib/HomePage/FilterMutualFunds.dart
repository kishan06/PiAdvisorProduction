// ignore_for_file: file_names


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piadvisory/Utils/textStyles.dart';

class FilterMutualFunds extends StatefulWidget {
  const FilterMutualFunds({Key? key}) : super(key: key);

  @override
  State<FilterMutualFunds> createState() => _FilterMutualFundsState();
}

class _FilterMutualFundsState extends State<FilterMutualFunds> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -80,
              right: MediaQuery.of(context).size.width * 0.4,
              child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 25,
                    child: Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                  )),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Filter",
                      style: blackStyle(context).copyWith(fontSize: 18),
                    ),
                    Text(
                      "CLEAR",
                      style: blackStyle(context).copyWith(
                          color: const Color(0xFFF78104), fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  thickness: 1,
                ),
                Text(
                  "Available to Invest",
                  style: blackStyle(context)
                      .copyWith(fontSize: 18.sp, color: Colors.black),
                ),
                SizedBox(height: 10.h),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.check,
                          size: 15.0,
                          color: Color(0xFF014421),
                        ),
                        label: Text(
                          "SIP",
                          style: blackStyle(context).copyWith(
                              fontSize: 15, color: const Color(0xFF444444)),
                        ),
                      ),
                      const SizedBox(
                        height: 19,
                        child: VerticalDivider(
                          color: Color(0xFF707070),
                          thickness: 1,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.check,
                          size: 15.0,
                          color: Color(0xFF014421),
                        ),
                        label: Text(
                          "ONE TIME",
                          style: blackStyle(context).copyWith(
                              fontSize: 15, color: const Color(0xFF444444)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Divider(),
                Text(
                  "Risk",
                  style: blackStyle(context)
                      .copyWith(fontSize: 18, color: Colors.black),
                ),
                SizedBox(
                  height: 10.h,
                ),
                IntrinsicHeight(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.check,
                          size: 15.0,
                          color: Color(0xFF014421),
                        ),
                        label: Text(
                          "Low",
                          style: blackStyle(context).copyWith(
                              fontSize: 15, color: const Color(0xFF444444)),
                        ),
                      ),
                      const SizedBox(
                        height: 19,
                        child: VerticalDivider(
                          color: Color(0xFF707070),
                          thickness: 1,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.check,
                          size: 15.0,
                          color: Color(0xFF014421),
                        ),
                        label: Text(
                          "Moderately Low",
                          style: blackStyle(context).copyWith(
                              fontSize: 15, color: const Color(0xFF444444)),
                        ),
                      ),
                      const SizedBox(
                        height: 19,
                        child: VerticalDivider(
                          color: Color(0xFF707070),
                          thickness: 1,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.check,
                          size: 15.0,
                          color: Color(0xFF014421),
                        ),
                        label: Text(
                          "Moderate",
                          style: blackStyle(context).copyWith(
                              fontSize: 15, color: const Color(0xFF444444)),
                        ),
                      ),
                      const SizedBox(
                        height: 19,
                        child: VerticalDivider(
                          color: Color(0xFF707070),
                          thickness: 1,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.check,
                          size: 15.0,
                          color: Color(0xFF014421),
                        ),
                        label: Text(
                          "Moderately High",
                          style: blackStyle(context).copyWith(
                              fontSize: 15, color: const Color(0xFF444444)),
                        ),
                      ),
                      const SizedBox(
                        height: 19,
                        child: VerticalDivider(
                          color: Color(0xFF707070),
                          thickness: 1,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.check,
                          size: 15.0,
                          color: Color(0xFF014421),
                        ),
                        label: Text(
                          " High",
                          style: blackStyle(context).copyWith(
                              fontSize: 15, color: const Color(0xFF444444)),
                        ),
                      ),
                      const SizedBox(
                        height: 19,
                        child: VerticalDivider(
                          color: Color(0xFF707070),
                          thickness: 1,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.check,
                          size: 15.0,
                          color: Color(0xFF014421),
                        ),
                        label: Text(
                          "Very High",
                          style: blackStyle(context).copyWith(
                              fontSize: 15, color: const Color(0xFF444444)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Divider(),
                Text(
                  "Sort",
                  style: blackStyle(context)
                      .copyWith(fontSize: 18, color: Colors.black),
                ),
                SizedBox(
                  height: 10.h,
                ),
                IntrinsicHeight(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.check,
                          size: 15.0,
                          color: Color(0xFF014421),
                        ),
                        label: Text(
                          "Popularity",
                          style: blackStyle(context).copyWith(
                              fontSize: 15, color: const Color(0xFF444444)),
                        ),
                      ),
                      const SizedBox(
                        height: 19,
                        child: VerticalDivider(
                          color: Color(0xFF707070),
                          thickness: 1,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.check,
                          size: 15.0,
                          color: Color(0xFF014421),
                        ),
                        label: Text(
                          "Return- High to Low",
                          style: blackStyle(context).copyWith(
                              fontSize: 15, color: const Color(0xFF444444)),
                        ),
                      ),
                      const SizedBox(
                        height: 19,
                        child: VerticalDivider(
                          color: Color(0xFF707070),
                          thickness: 1,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.check,
                          size: 15.0,
                          color: Color(0xFF014421),
                        ),
                        label: Text(
                          "Return- Low to High",
                          style: blackStyle(context).copyWith(
                              fontSize: 15, color: const Color(0xFF444444)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
