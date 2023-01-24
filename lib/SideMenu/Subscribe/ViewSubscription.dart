import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:piadvisory/SideMenu/Subscribe/Model/SubscriptionFullDetails.dart';
import 'package:piadvisory/SideMenu/Subscribe/Repository/getSubscriptionWithDetails.dart';

import '/Common/app_bar.dart';
import '/Utils/textStyles.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViewSubscription extends StatefulWidget {
  const ViewSubscription({Key? key}) : super(key: key);

  @override
  State<ViewSubscription> createState() => _ViewSubscriptionState();
}

class _ViewSubscriptionState extends State<ViewSubscription> {
  @override
  void initState() {
    setLists();
    super.initState();
  }

  bool showingAdditionalDetails = true;
  bool showingAdditionalDetailsOfPreviousPlans = true;

  List<Data> activePlans = [];
  List<Data> unactivePlans = [];
  setLists() {
    var datalen = subsDetail.data?.length ?? 0;
    for (var i = 0; i < datalen; i++) {
      DateTime planEndDate =
          DateTime.parse('${subsDetail.data![i].planEndDate}');
      DateTime now = DateTime.now();
      DateTime currentDate = DateTime(now.year, now.month, now.day);
      if (planEndDate.day > currentDate.day ||
          planEndDate.month > currentDate.month ||
          planEndDate.year > currentDate.year) {
        activePlans.add(subsDetail.data![i]);
      } else {
        unactivePlans.add(subsDetail.data![i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
            titleTxt: "Subscribe/Request Advice", bottomtext: false),
        body: subsDetail.data!.isNotEmpty
            ? _buildBody(
                context,
              )
            : _buildNoData(context));
  }

  Widget _buildNoData(context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: 0,
          right: 0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Center(
                child: Text(
                  "No Active Subscription ",
                  style: blackStyle(context).copyWith(
                      fontSize: 20,
                      color: Color(0xFF303030),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(context) {
    return SingleChildScrollView(
        child: Padding(
      padding: EdgeInsets.only(
        left: 0,
        right: 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Text(
              "Premium Services",
              style: blackStyle(context).copyWith(
                  fontSize: 20,
                  color: Get.isDarkMode ? Colors.white : Color(0xFF303030),
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          _buildActiveSubs(),
          if (showingAdditionalDetails)
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: activePlans.length,
                itemBuilder: (BuildContext context, int index) {
                  var myFormat =
                      DateTime.parse('${activePlans[index].planEndDate}');
                  var currentDateis = DateTime.now();
                  var purchaseDate =
                      DateTime.parse('${activePlans[index].createdAt}');
                  var planEndsInDays =
                      myFormat.difference(currentDateis).inDays;
                  // var planEndsInDays =
                  //     DateTime(myFormat.year, myFormat.month + 1, 0).day;
                  print("purchase dates are $purchaseDate");
                  print("end in days $planEndsInDays");
                  return _buildActiveSubsContent(
                      index, myFormat, purchaseDate, planEndsInDays);
                }),
          _buildPrevSubsc(),
          if (showingAdditionalDetailsOfPreviousPlans)
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: unactivePlans.length,
                itemBuilder: (BuildContext context, int index) {
                  var myFormat =
                      DateTime.parse('${unactivePlans[index].planEndDate}');
                  var currentDateis = DateTime.now();
                  var purchaseDate =
                      DateTime.parse('${unactivePlans[index].createdAt}');
                  var planEndsInDays = 0;
                  //  myFormat.difference(currentDateis).inDays;
                  // var planEndsInDays =
                  //     DateTime(myFormat.year, myFormat.month + 1, 0).day;
                  print("purchase dates are $purchaseDate");
                  print("end in days $planEndsInDays");
                  return _buildUnActiveSubsContent(
                      index, myFormat, purchaseDate, planEndsInDays);
                }),
          SizedBox(
            height: 20,
          ),

          // Padding(
          //   padding: EdgeInsets.only(
          //     left: 20,
          //     right: 20,
          //   ),
          // child: Card(
          //   shape: RoundedRectangleBorder(
          //     side: const BorderSide(color: Color(0xFFEBEBEB), width: 1),
          //     borderRadius: BorderRadius.circular(10),
          //   ),
          //   child: Row(
          //     children: [
          //       Expanded(
          //         flex: 2,
          //         child: Padding(
          //           padding: const EdgeInsets.symmetric(
          //               vertical: 20, horizontal: 22),
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text(
          //                 "Balance Amount to Advisory",
          //                 style: blackStyle(context).copyWith(fontSize: 14, color:Get.isDarkMode? Colors.white: Colors.black,),
          //               ),
          //               const SizedBox(
          //                 height: 10,
          //               ),
          //               Text(
          //                 "₹ 5,000",
          //                 style: blackStyle(context).copyWith(fontSize: 22, color:Get.isDarkMode? Colors.white: Colors.black,),
          //               ),
          //               Text(
          //                 "Due Date: 12 Mar, 2022",
          //                 style: blackStyle(context).copyWith(
          //                     fontSize: 12, color: Get.isDarkMode? Colors.white:const Color(0xFF878787)),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //       Expanded(
          //         flex: 0,
          //         child: Padding(
          //           padding: const EdgeInsets.only(right: 15),
          //           child: ElevatedButton(
          //             style: ElevatedButton.styleFrom(
          //               elevation: 0,
          //               primary: const Color.fromRGBO(247, 129, 4, 1),
          //               shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(12),
          //               ),
          //             ),
          //             child: const Text(
          //               "Pay Now!",
          //               style: TextStyle(
          //                 color: Color(0xFFFFFFFF),
          //                 fontSize: 14,
          //                 fontFamily: 'Product Sans',
          //               ),
          //             ),
          //             onPressed: () {},
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          //),
        ],
      ),
    ));
  }

  Widget _buildActiveSubs() {
    return Column(
      children: [
        Divider(
          thickness: 2,
          color:
              Get.isDarkMode ? Colors.grey : Color(0xFF707070).withOpacity(0.3),
        ),
        showingAdditionalDetails
            ? SizedBox(
                height: 20,
              )
            : SizedBox(
                height: 5,
              ),
        Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Row(
            children: [
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  setState(() {
                    showingAdditionalDetails = !showingAdditionalDetails;
                  });
                },
                child: Text(
                  "My Plan",
                  style: blackStyle(context).copyWith(
                      fontSize: 22,
                      color: Get.isDarkMode ? Colors.white : Colors.black),
                ),
              )),
              GestureDetector(
                onTap: () {
                  setState(() {
                    showingAdditionalDetails = !showingAdditionalDetails;
                  });
                },
                child: Text(
                  "Order History",
                  style: blackStyle(context).copyWith(
                      fontSize: 14,
                      color: Get.isDarkMode ? Colors.white : Colors.black),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Icon(
                  !showingAdditionalDetails
                      ? Icons.keyboard_arrow_down_rounded
                      : Icons.keyboard_arrow_up_rounded,
                  color: Get.isDarkMode ? Colors.grey : Colors.black,
                ),
              ),
            ],
          ),
        ),
        // showingAdditionalDetails
        //     ? SizedBox(
        //         height: 17,
        //       )
        //     : SizedBox(
        //         height: 5,
        //       ),

        //if (showingAdditionalDetails) _buildActiveSubsContent(),
      ],
    );
  }

  Widget _buildPrevSubsc() {
    return Column(
      children: [
        showingAdditionalDetailsOfPreviousPlans
            ? SizedBox(
                height: 25,
              )
            : SizedBox(
                height: 0,
              ),
        Divider(
          thickness: 2,
          color:
              Get.isDarkMode ? Colors.grey : Color(0xFF707070).withOpacity(0.3),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Row(
            children: [
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  setState(() {
                    showingAdditionalDetailsOfPreviousPlans =
                        !showingAdditionalDetailsOfPreviousPlans;
                  });
                },
                child: Text(
                  "Previous Plan",
                  style: blackStyle(context).copyWith(
                      fontSize: 22,
                      color: Get.isDarkMode ? Colors.white : Colors.black),
                ),
              )),
              GestureDetector(
                onTap: () {
                  setState(() {
                    showingAdditionalDetailsOfPreviousPlans =
                        !showingAdditionalDetailsOfPreviousPlans;
                  });
                },
                child: Text(
                  "Order History",
                  style: blackStyle(context).copyWith(
                      fontSize: 14,
                      color: Get.isDarkMode ? Colors.white : Colors.black),
                ),
              ),
              Icon(
                !showingAdditionalDetailsOfPreviousPlans
                    ? Icons.keyboard_arrow_down_rounded
                    : Icons.keyboard_arrow_up_rounded,
                color: Get.isDarkMode ? Colors.grey : Colors.black,
              ),
            ],
          ),
        ),
        Divider(
          thickness: 2,
          color:
              Get.isDarkMode ? Colors.grey : Color(0xFF707070).withOpacity(0.3),
        ),
      ],
    );
  }

  Widget _buildActiveSubsContent(
      index, myFormat, purchaseDate, planEndsInDays) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                activePlans[index].plan!.planValidity == 1 ? "1 Year" : "",
                style: blackStyle(context)
                    .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 12,
              ),
              Text("Expiring on  ${DateFormat('d-MM-yyyy').format(myFormat)}"),
              SizedBox(
                height: 14,
              ),
              Card(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Color(0xFFEBEBEB), width: 1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Product",
                                style: blackStyle(context).copyWith(
                                    fontSize: 16,
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Color(0xFF6B6B6B)),
                              ),
                              SizedBox(height: 14),
                              Text(
                                "Order Id",
                                style: blackStyle(context).copyWith(
                                    fontSize: 16,
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Color(0xFF6B6B6B)),
                              ),
                              SizedBox(height: 14),
                              Text(
                                "Invoice Id",
                                style: blackStyle(context).copyWith(
                                    fontSize: 16,
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Color(0xFF6B6B6B)),
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                // width: 100,
                                child: Text(
                                  activePlans[index].plan!.planName!,
                                  style: blackStyle(context).copyWith(
                                      fontSize: 16, color: Color(0xFF008083)),
                                ),
                              ),
                              SizedBox(height: 14),
                              Text(
                                activePlans[index].transaction?.orderId ?? "NA",
                                style: blackStyle(context).copyWith(
                                  fontSize: 16,
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              SizedBox(height: 14),
                              Text(
                                activePlans[index].transaction?.invoiceId ??
                                    "NA",
                                style: blackStyle(context).copyWith(
                                  fontSize: 16,
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        thickness: 2,
                        color: Get.isDarkMode
                            ? Colors.grey
                            : Color(0xFF707070).withOpacity(0.3),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Duration",
                                  style: blackStyle(context).copyWith(
                                      fontSize: 16,
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Color(0xFF6B6B6B)),
                                ),
                                SizedBox(height: 14),
                                Text(
                                  "Purchase Date",
                                  style: blackStyle(context).copyWith(
                                      fontSize: 16,
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Color(0xFF6B6B6B)),
                                ),
                                SizedBox(height: 14),
                                Text(
                                  "Amount",
                                  style: blackStyle(context).copyWith(
                                      fontSize: 16,
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Color(0xFF6B6B6B)),
                                ),
                                SizedBox(height: 14),
                                Text(
                                  "Expiry Date",
                                  style: blackStyle(context).copyWith(
                                      fontSize: 16,
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Color(0xFF6B6B6B)),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  activePlans[index].plan!.planValidity == 1
                                      ? "1 Year"
                                      : "6 Months",
                                  style: blackStyle(context).copyWith(
                                    fontSize: 16,
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                                SizedBox(height: 14),
                                Text(
                                  " ${DateFormat('d-MM-yyyy').format(purchaseDate)}",
                                  style: blackStyle(context).copyWith(
                                    fontSize: 16,
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                                SizedBox(height: 14),
                                Text(
                                  "Free",
                                  //" ₹ ${activePlans[index].plan!.amount!.toString()}",
                                  style: blackStyle(context).copyWith(
                                    fontSize: 16,
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                                SizedBox(height: 14),
                                Text(
                                  "in $planEndsInDays days",
                                  style: blackStyle(context).copyWith(
                                    fontSize: 16,
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                                SizedBox(height: 12),
                                // Text(
                                //   "Cancel Auto Renewal",
                                //   style: blackStyle(context).copyWith(
                                //       fontSize: 14, color: Color(0xFF008083)),
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUnActiveSubsContent(
      index, myFormat, purchaseDate, planEndsInDays) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                unactivePlans[index].plan!.planValidity == 1 ? "1 Year" : "",
                style: blackStyle(context)
                    .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 12,
              ),
              Text("Expiring on  ${DateFormat('d-MM-yyyy').format(myFormat)}"),
              SizedBox(
                height: 14,
              ),
              Card(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Color(0xFFEBEBEB), width: 1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Product",
                                style: blackStyle(context).copyWith(
                                    fontSize: 16,
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Color(0xFF6B6B6B)),
                              ),
                              SizedBox(height: 14),
                              Text(
                                "Order Id",
                                style: blackStyle(context).copyWith(
                                    fontSize: 16,
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Color(0xFF6B6B6B)),
                              ),
                              SizedBox(height: 14),
                              Text(
                                "Invoice Id",
                                style: blackStyle(context).copyWith(
                                    fontSize: 16,
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Color(0xFF6B6B6B)),
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                // width: 100,
                                child: Text(
                                  unactivePlans[index].plan!.planName!,
                                  style: blackStyle(context).copyWith(
                                      fontSize: 16, color: Color(0xFF008083)),
                                ),
                              ),
                              SizedBox(height: 14),
                              Text(
                                unactivePlans[index].transaction?.orderId ??
                                    "NA",
                                style: blackStyle(context).copyWith(
                                  fontSize: 16,
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              SizedBox(height: 14),
                              Text(
                                subsDetail
                                        .data![index].transaction?.invoiceId ??
                                    "NA",
                                style: blackStyle(context).copyWith(
                                  fontSize: 16,
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        thickness: 2,
                        color: Get.isDarkMode
                            ? Colors.grey
                            : Color(0xFF707070).withOpacity(0.3),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Duration",
                                  style: blackStyle(context).copyWith(
                                      fontSize: 16,
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Color(0xFF6B6B6B)),
                                ),
                                SizedBox(height: 14),
                                Text(
                                  "Purchase Date",
                                  style: blackStyle(context).copyWith(
                                      fontSize: 16,
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Color(0xFF6B6B6B)),
                                ),
                                SizedBox(height: 14),
                                Text(
                                  "Amount",
                                  style: blackStyle(context).copyWith(
                                      fontSize: 16,
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Color(0xFF6B6B6B)),
                                ),
                                SizedBox(height: 14),
                                Text(
                                  "Expiry Date",
                                  style: blackStyle(context).copyWith(
                                      fontSize: 16,
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Color(0xFF6B6B6B)),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  unactivePlans[index].plan!.planValidity == 1
                                      ? "1 Year"
                                      : "6 Months",
                                  style: blackStyle(context).copyWith(
                                    fontSize: 16,
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                                SizedBox(height: 14),
                                Text(
                                  " ${DateFormat('d-MM-yyyy').format(purchaseDate)}",
                                  style: blackStyle(context).copyWith(
                                    fontSize: 16,
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                                SizedBox(height: 14),
                                Text(
                                  " ₹ ${unactivePlans[index].plan!.amount!.toString()}",
                                  style: blackStyle(context).copyWith(
                                    fontSize: 16,
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                                SizedBox(height: 14),
                                Text(
                                  "Expired",
                                  //   "in $planEndsInDays days",
                                  style: blackStyle(context).copyWith(
                                    fontSize: 16,
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                                SizedBox(height: 12),
                                // Text(
                                //   "Cancel Auto Renewal",
                                //   style: blackStyle(context).copyWith(
                                //       fontSize: 14, color: Color(0xFF008083)),
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
