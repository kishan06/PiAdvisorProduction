// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:piadvisory/Utils/textStyles.dart';

class FilterStocksData extends StatefulWidget {
  const FilterStocksData({Key? key}) : super(key: key);

  @override
  State<FilterStocksData> createState() => _FilterStocksDataState();
}

class _FilterStocksDataState extends State<FilterStocksData> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: IntrinsicWidth(
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
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    side: BorderSide(
                                        color: Color(0xFF008083), width: 2)))),
                        onPressed: () {},
                        child: Text(
                          "INDICES",
                          style: blackStyle(context).copyWith(
                              color: const Color(0xFF6B6B6B),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      TextButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    side: BorderSide(
                                        color: Color(0xFF008083), width: 2)))),
                        onPressed: () {},
                        child: Row(
                          children: [
                            Text(
                              "NSE",
                              style: blackStyle(context).copyWith(
                                  color: const Color(0xFF6B6B6B),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      TextButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    side: BorderSide(
                                        color: Color(0xFF008083), width: 2)))),
                        onPressed: () {},
                        child: Row(
                          children: [
                            Text(
                              "BSE",
                              style: blackStyle(context).copyWith(
                                  color: const Color(0xFF6B6B6B),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Sort",
                    style: blackStyle(context),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        "A-Z",
                        style: blackStyle(context).copyWith(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "Alphabetically",
                        style: blackStyle(context).copyWith(
                            color: const Color(0xFF585858), fontSize: 15),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Text(
                        "%",
                        style: blackStyle(context).copyWith(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "Change",
                        style: blackStyle(context).copyWith(
                            color: const Color(0xFF585858), fontSize: 15),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Text(
                        "LTP",
                        style: blackStyle(context).copyWith(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "Last Trade Price",
                        style: blackStyle(context).copyWith(
                            color: const Color(0xFF585858), fontSize: 15),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Divider(
                    thickness: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
