import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:piadvisory/SideMenu/Subscribe/SubscriptionDetailsForThirdCard.dart';
import 'package:piadvisory/Utils/database.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '/SideMenu/Subscribe/PlanModel.dart';
import '/SideMenu/Subscribe/SubscriptionDetails.dart';
import '/SideMenu/Subscribe/SubscriptionDetailsForSecondCard.dart';
import '/SideMenu/Subscribe/SubscriptionPlanModel.dart';
import '/Utils/textStyles.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';

import 'AppWidget.dart';

class SubscriptionPlans extends StatefulWidget {
  @override
  SubscriptionPlansState createState() => SubscriptionPlansState();
}

class SubscriptionPlansState extends State<SubscriptionPlans>
    with SingleTickerProviderStateMixin {
  int selectIndex = 0;
  List<Subscrptionplan> planPageViewList = [];
  List<Subscrptionplan> coloredList = [];
  List<Subscrptionplan> customList = [];
  List<Subscrptionplan> customcoloredList = [];

  Color color = white;
  Color testTextColor = Colors.blue;
  Color doubtsTextColor = Colors.red;

  PageController controller = PageController(
    viewportFraction: 0.76,
  );
  Color containerAdvanced = Color(0xFFEAA954);

  Color selectedContainerColor = Color(0xFFF0C05B);
  int _index = 0;
  late AnimationController _controlleranimation;

  @override
  void initState() {
    super.initState();
    init();
    _controlleranimation =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _controlleranimation.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        _controlleranimation.reset();
      }
    });
  }

  bool selectedTick = false;
  @override
  void dispose() {
    super.dispose();
    _controlleranimation.dispose();
  }

  Future<void> init() async {
    //Free Plan
    planPageViewList.add(
      Subscrptionplan(
        title: "Growth (Free)   ",
        subtitle: "",
        list1: [
          PlanPoints(
            title: 'Current Portfolio Analysis',
          ),
          PlanPoints(title: 'Demat A/c Opening'),
          PlanPoints(title: 'Detailed Risk Profiling'),
          PlanPoints(title: 'Insurance Advisory'),
          PlanPoints(title: 'Real Estate Advisory'),
          PlanPoints(title: 'DIY Stocks Transactions'),
          PlanPoints(title: 'DIY MF Transactions'),
          PlanPoints(title: 'Dashboard Access'),
          PlanPoints(title: 'Tracking Stocks and MF Folios'),
          PlanPoints(
              title:
                  'Tax Planning &  ITR Filing (₹ 749/- only ₹ 1,499/-) (Add-on)'),
        ],
      ),
    );
    coloredList.add(
      Subscrptionplan(
        title: "Growth (Free)   ",
        subtitle: "",
        list1: [
          PlanPoints(
            title: 'Current Portfolio Analysis',
            colorit: true,
          ),
          PlanPoints(
            title: 'Demat A/c Opening',
            colorit: true,
          ),
          PlanPoints(
            title: 'Detailed Risk Profiling',
            colorit: true,
          ),
          PlanPoints(
            title: 'Insurance Advisory',
            colorit: true,
          ),
          PlanPoints(
            title: 'Real Estate Advisory',
            colorit: true,
          ),
          PlanPoints(
            title: 'DIY Stocks Transactions',
            colorit: true,
          ),
          PlanPoints(
            title: 'DIY MF Transactions',
            colorit: true,
          ),
          PlanPoints(
            title: 'Dashboard Access',
            colorit: true,
          ),
          PlanPoints(
            title: 'Tracking Stocks and MF Folios',
            colorit: true,
          ),
          PlanPoints(
            title:
                'Tax Planning &  ITR Filing \n(₹ 749/- only ₹ 1,499/-) (Add-on)',
            colorit: true,
          ),
        ],

        //colorChange: colorchanged0!,
      ),
    );

    //premium

    planPageViewList.add(
      Subscrptionplan(
        title: "Growth Plus ",
        subtitle: "",
        list1: [
          PlanPoints(
            title: 'Fee (incl. taxes) per annum as % of portfolio.',
            showcheckmark: false,
          ),
          PlanPoints(
            title: 'Below ₹ 10 Lakhs: 2.00% 1.50%',
            showcheckmark: false,
          ),
          PlanPoints(
            title: '₹ 10L - ₹ 25L: 1.75% 1.25%',
            showcheckmark: false,
          ),
          PlanPoints(
            title: '₹ 25L - ₹ 50L:  1.50% 1.00%',
            showcheckmark: false,
          ),
          PlanPoints(
            title: 'Above ₹ 50 Lakhs: 1.25% 0.75%',
            showcheckmark: false,
          ),
          PlanPoints(title: 'Everything in the Growth Plan'),
          PlanPoints(title: 'Dedicated Advisor'),
          PlanPoints(title: 'FREE Tax Planning'),
          PlanPoints(title: 'FREE ITR Filing'),
          PlanPoints(title: 'Stocks'),
          PlanPoints(title: 'Mutual Funds'),
          PlanPoints(title: 'Alternative Investments (Real Estate, PMS, AIF)'),
          PlanPoints(title: 'Startup Investing'),
          PlanPoints(title: 'Unlisted/Pre-IPO Investments'),
          PlanPoints(title: 'Liquidity Management'),
          PlanPoints(title: 'Contingency Planning'),
          PlanPoints(title: 'Loans (Home, Personal, etc.)'),
          PlanPoints(title: 'Portfolio Rebalancing'),
          PlanPoints(title: 'Quarterly Reviews'),
          PlanPoints(title: 'Insurance Advisory'),
          PlanPoints(title: 'Real Estate Advisory'),
          PlanPoints(title: 'DIY Stocks Transactions'),
          PlanPoints(title: 'DIY MF Transactions'),
          PlanPoints(title: 'Dashboard Access'),
          PlanPoints(title: 'Tracking Stocks and MF Folios'),
        ],
      ),
    );
    coloredList.add(
      Subscrptionplan(
        title: "Growth Plus ",
        subtitle: "",
        list1: [
          PlanPoints(
            title: 'Fee (incl. taxes) per annum as % of portfolio.',
            showcheckmark: false,
            colorit: true,
          ),
          PlanPoints(
            title: 'Below ₹ 10 Lakhs: 2.00% 1.50%',
            showcheckmark: false,
            colorit: true,
          ),
          PlanPoints(
            title: '₹ 10L - ₹ 25L: 1.75% 1.25%',
            showcheckmark: false,
            colorit: true,
          ),
          PlanPoints(
            title: '₹ 25L - ₹ 50L:  1.50% 1.00%',
            showcheckmark: false,
            colorit: true,
          ),
          PlanPoints(
            title: 'Above ₹ 50 Lakhs: 1.25% 0.75%',
            showcheckmark: false,
            colorit: true,
          ),
          PlanPoints(
            title: 'Everything in the Growth Plan',
            colorit: true,
          ),
          PlanPoints(
            title: 'Dedicated Advisor',
            colorit: true,
          ),
          PlanPoints(
            title: 'FREE Tax Planning',
            colorit: true,
          ),
          PlanPoints(
            title: 'FREE ITR Filing',
            colorit: true,
          ),
          PlanPoints(
            title: 'Stocks',
            colorit: true,
          ),
          PlanPoints(
            title: 'Mutual Funds',
            colorit: true,
          ),
          PlanPoints(
            title: 'Alternative Investments (Real Estate, PMS, AIF)',
            colorit: true,
          ),
          PlanPoints(
            title: 'Startup Investing',
            colorit: true,
          ),
          PlanPoints(
            title: 'Unlisted/Pre-IPO Investments',
            colorit: true,
          ),
          PlanPoints(
            title: 'Liquidity Management',
            colorit: true,
          ),
          PlanPoints(
            title: 'Contingency Planning',
            colorit: true,
          ),
          PlanPoints(
            title: 'Loans (Home, Personal, etc.)',
            colorit: true,
          ),
          PlanPoints(
            title: 'Portfolio Rebalancing',
            colorit: true,
          ),
          PlanPoints(
            title: 'Quarterly Reviews',
            colorit: true,
          ),
          PlanPoints(
            title: 'Insurance Advisory',
            colorit: true,
          ),
          PlanPoints(
            title: 'Real Estate Advisory',
            colorit: true,
          ),
          PlanPoints(
            title: 'DIY Stocks Transactions',
            colorit: true,
          ),
          PlanPoints(
            title: 'DIY MF Transactions',
            colorit: true,
          ),
          PlanPoints(
            title: 'Dashboard Access',
            colorit: true,
          ),
          PlanPoints(
            title: 'Tracking Stocks and MF Folios',
            colorit: true,
          ),
        ],
      ),
    );
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PageView.builder(
          controller: controller,
          itemCount: planPageViewList.length,
          onPageChanged: (i) {
            _index = i;
            print("current page index in view is $i");
            setState(() {});
          },
          itemBuilder: (
            BuildContext context,
            int index1,
          ) {
            bool isMyPageIndex = selectIndex == index1;
            if (index1 == 0)
              //1st plan
              return GestureDetector(
                onTap: () {
                  setState(() {});
                  selectIndex = index1;
                  if (!isMyPageIndex) {
                    _controlleranimation.forward();
                  }

                  Get.find<Database>().storePriceModel(selectIndex);
                },
                child: AnimatedContainer(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  height: _index == index1
                      ? context.height() * 0.55
                      : context.height() * 0.50,
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 10),
                  decoration: boxDecorationDefault(
                    color: selectIndex == index1
                        ? Color(
                            0xFF008083) //appStore.appColorPrimary.withOpacity(0.3)
                        : Get.isDarkMode
                            ?
                            // Colors.grey.withOpacity(0.9),
                            Color(0xFF303030).withOpacity(0.3)
                            : context.cardColor,
                    boxShadow: defaultBoxShadow(),
                    borderRadius: radius(defaultRadius),
                  ),
                  duration: 1000.milliseconds,
                  curve: Curves.linearToEaseOut,
                  child: Column(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 15.h,
                          ),
                          Stack(clipBehavior: Clip.none, children: [
                            Text.rich(
                                const TextSpan(children: [
                                  TextSpan(text: "Growth ("),
                                  TextSpan(
                                      text: "Rs. 1999/- ",
                                      style: TextStyle(
                                        decorationColor: Colors.red,
                                        decoration: TextDecoration.lineThrough,
                                      )),
                                  TextSpan(text: " FREE )")
                                ]),
                                style: blackStyle(context).copyWith(
                                    fontSize: 15.sm,
                                    color: selectIndex == index1
                                        ? Colors.white
                                        : Get.isDarkMode
                                            ? Colors.white
                                            : const Color(0xFF444444),
                                    fontWeight: FontWeight.bold)),
                            // Text(
                            //   textAlign: TextAlign.center,
                            //   planPageViewList[index1].title!.validate(),
                            //   style: TextStyle(
                            //     fontSize: 16.sm,
                            //     fontWeight: FontWeight.bold,
                            //     color: selectIndex == index1
                            //         ? Colors.white
                            //         : Get.isDarkMode
                            //             ? Colors.white
                            //             : const Color(0xFF444444),
                            //   ),
                            // ),
                            Positioned(
                              top: -40,
                              //left: -50,
                              right: -70,
                              child: Lottie.asset(
                                "assets/images/lf30_editor_30qhvaxh.json",
                                repeat: false,
                                controller: _controlleranimation,
                                height: 100,
                                width: 100,
                              ),
                            ),
                          ]),

                          // const Divider(
                          //   color: Color(0xFFF78104),
                          //   indent: 100,
                          //   endIndent: 100,
                          //   thickness: 2,
                          // ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  planPageViewList[index1].subtitle.validate(),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 15.sm,
                                    color: selectIndex == index1
                                        ? Colors.white
                                        : Get.isDarkMode
                                            ? Colors.white
                                            : const Color(0xFF444444),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // index1 == 1
                          //     ? SizedBox(
                          //         height: 10,
                          //       )
                          //     :
                          //      SizedBox(
                          //         height: 38,
                          //       ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                      selectIndex != index1
                          ? SizedBox(
                              height: 310.h,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    PlanPoints(
                                      title: 'Current Portfolio Analysis',
                                    ),
                                    PlanPoints(title: 'Demat A/c Opening'),
                                    PlanPoints(
                                        title: 'Detailed Risk Profiling'),
                                    PlanPoints(title: 'Insurance Advisory'),
                                    PlanPoints(title: 'Real Estate Advisory'),
                                    PlanPoints(
                                        title: 'DIY Stocks Transactions'),
                                    PlanPoints(title: 'DIY MF Transactions'),
                                    PlanPoints(title: 'Dashboard Access'),
                                    PlanPoints(
                                        title: 'Tracking Stocks and MF Folios'),

                                    LineThroughPointsGrowth(
                                      firstPart: "Tax Planning &  ITR Filing\n",
                                      LineThroughPart: "₹ 1,499/-",
                                      EndPart: "₹ 749/- only) (Add-on)",
                                      showcheckmark: true,
                                      colorit: false,
                                    )
                                    // LineThroughPoints(
                                    //   firstPart: "Tax Planning &  ITR Filing (₹ 749/- only",
                                    //   LineThroughPart: "₹ 1,499/-",
                                    //   EndPart: ") (Add-on)",
                                    //   showcheckmark: false,
                                    // )
                                    // PlanPoints(
                                    //     title:
                                    //         'Tax Planning &  ITR Filing (₹ 749/- only ₹ 1,499/-) (Add-on)'),
                                  ],
                                ),
                              ),
                            )
                          :
                          //colored list
                          SizedBox(
                              height: 310.h,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    PlanPoints(
                                      title: 'Current Portfolio Analysis',
                                      colorit: true,
                                    ),
                                    PlanPoints(
                                      title: 'Demat A/c Opening',
                                      colorit: true,
                                    ),
                                    PlanPoints(
                                      title: 'Detailed Risk Profiling',
                                      colorit: true,
                                    ),
                                    PlanPoints(
                                      title: 'Insurance Advisory',
                                      colorit: true,
                                    ),
                                    PlanPoints(
                                      title: 'Real Estate Advisory',
                                      colorit: true,
                                    ),
                                    PlanPoints(
                                      title: 'DIY Stocks Transactions',
                                      colorit: true,
                                    ),
                                    PlanPoints(
                                      title: 'DIY MF Transactions',
                                      colorit: true,
                                    ),
                                    PlanPoints(
                                      title: 'Dashboard Access',
                                      colorit: true,
                                    ),
                                    PlanPoints(
                                      title: 'Tracking Stocks and MF Folios',
                                      colorit: true,
                                    ),
                                    LineThroughPointsGrowth(
                                      firstPart: "Tax Planning &  ITR Filing\n",
                                      LineThroughPart: "₹ 1,499/-",
                                      EndPart: "₹ 749/- only) (Add-on)",
                                      showcheckmark: true,
                                      colorit: true,
                                    )
                                    // LineThroughPoints(
                                    //    firstPart: "Tax Planning &  ITR Filing (₹ 749/- only" ,
                                    //   LineThroughPart: "\n ₹ 1,499/-",
                                    //   EndPart: ") (Add-on)",
                                    //   showcheckmark: false,
                                    //   colorit: true,
                                    // )
                                    // PlanPoints(
                                    //   title:
                                    //       'Tax Planning &  ITR Filing (₹ 749/- only ₹ 1,499/-) (Add-on)',
                                    //   colorit: true,
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                      // ListView.builder(
                      //     physics: ClampingScrollPhysics(),
                      //     itemCount: planPageViewList[index1].list1.length,
                      //     itemBuilder: (context, index) {
                      //       if (selectIndex == index1) {
                      //         return coloredList[index1].list1[index];
                      //       } else {
                      //         return planPageViewList[index1].list1[index];
                      //       }
                      //     }).expand(),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              );
            //2nd plan
            return GestureDetector(
              onTap: () {
                setState(() {});
                selectIndex = index1;
                if (!isMyPageIndex) {
                  _controlleranimation.forward();
                }

                Get.find<Database>().storePriceModel(selectIndex);
              },
              child: AnimatedContainer(
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                height: _index == index1
                    ? context.height() * 0.55
                    : context.height() * 0.50,
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 10),
                decoration: boxDecorationDefault(
                  color: selectIndex == index1
                      ? Color(
                          0xFF008083) //appStore.appColorPrimary.withOpacity(0.3)
                      : Get.isDarkMode
                          ?
                          // Colors.grey.withOpacity(0.9),
                          Color(0xFF303030).withOpacity(0.3)
                          : context.cardColor,
                  boxShadow: defaultBoxShadow(),
                  borderRadius: radius(defaultRadius),
                ),
                duration: 1000.milliseconds,
                curve: Curves.linearToEaseOut,
                child: Column(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 15.h,
                        ),
                        Stack(clipBehavior: Clip.none, children: [
                          Text(
                            textAlign: TextAlign.center,
                            planPageViewList[index1].title!.validate(),
                            style: TextStyle(
                              fontSize: 16.sm,
                              fontWeight: FontWeight.bold,
                              color: selectIndex == index1
                                  ? Colors.white
                                  : Get.isDarkMode
                                      ? Colors.white
                                      : const Color(0xFF444444),
                            ),
                          ),
                          Positioned(
                            top: -40,
                            //left: -50,
                            right: -100,
                            child: Lottie.asset(
                              "assets/images/lf30_editor_30qhvaxh.json",
                              repeat: false,
                              controller: _controlleranimation,
                              height: 100,
                              width: 100,
                            ),
                          ),
                        ]),

                        // const Divider(
                        //   color: Color(0xFFF78104),
                        //   indent: 100,
                        //   endIndent: 100,
                        //   thickness: 2,
                        // ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                planPageViewList[index1].subtitle.validate(),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 15.sm,
                                  color: selectIndex == index1
                                      ? Colors.white
                                      : Get.isDarkMode
                                          ? Colors.white
                                          : const Color(0xFF444444),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // index1 == 1
                        //     ? SizedBox(
                        //         height: 10,
                        //       )
                        //     :
                        //      SizedBox(
                        //         height: 38,
                        //       ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                    selectIndex != index1
                        ? SizedBox(
                            height: 310.h,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  PlanPoints(
                                    title:
                                        'Fee (incl. taxes) per annum as % of portfolio.',
                                    showcheckmark: false,
                                  ),
                                  LineThroughPoints(
                                    firstPart: "Below ₹ 10 Lakhs:",
                                    LineThroughPart: " 2.00%",
                                    EndPart: " 1.50%",
                                    showcheckmark: false,
                                  ),
                                  LineThroughPoints(
                                    firstPart: "₹ 10L - ₹ 25L:",
                                    LineThroughPart: " 1.75%",
                                    EndPart: " 1.25%",
                                    showcheckmark: false,
                                  ),
                                  LineThroughPoints(
                                    firstPart: "₹ 25L - ₹ 50L:",
                                    LineThroughPart: "  1.50%",
                                    EndPart: "1.00%",
                                    showcheckmark: false,
                                  ),
                                  LineThroughPoints(
                                    firstPart: "Above ₹ 50 Lakhs:",
                                    LineThroughPart: " 1.25%",
                                    EndPart: " 0.75%",
                                    showcheckmark: false,
                                  ),
                                  PlanPoints(
                                      title: 'Everything in the Growth Plan'),
                                  PlanPoints(title: 'Dedicated Advisor'),
                                  PlanPoints(title: 'FREE Tax Planning'),
                                  PlanPoints(title: 'FREE ITR Filing'),
                                  PlanPoints(title: 'Stocks'),
                                  PlanPoints(title: 'Mutual Funds'),
                                  PlanPoints(
                                      title:
                                          'Alternative Investments (Real Estate, PMS, AIF)'),
                                  PlanPoints(title: 'Startup Investing'),
                                ],
                              ),
                            ),
                          )
                        : SizedBox(
                            height: 310.h,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  PlanPoints(
                                    title:
                                        'Fee (incl. taxes) per annum as % of portfolio.',
                                    colorit: true,
                                    showcheckmark: false,
                                  ),
                                  LineThroughPoints(
                                    firstPart: "Below ₹ 10 Lakhs:",
                                    LineThroughPart: " 2.00%",
                                    EndPart: " 1.50%",
                                    showcheckmark: false,
                                    colorit: true,
                                  ),
                                  LineThroughPoints(
                                    firstPart: "₹ 10L - ₹ 25L:",
                                    LineThroughPart: " 1.75%",
                                    EndPart: " 1.25%",
                                    showcheckmark: false,
                                    colorit: true,
                                  ),
                                  LineThroughPoints(
                                    firstPart: "₹ 25L - ₹ 50L:",
                                    LineThroughPart: "  1.50%",
                                    EndPart: "1.00%",
                                    showcheckmark: false,
                                    colorit: true,
                                  ),
                                  LineThroughPoints(
                                    firstPart: "Above ₹ 50 Lakhs:",
                                    LineThroughPart: " 1.25%",
                                    EndPart: " 0.75%",
                                    showcheckmark: false,
                                    colorit: true,
                                  ),
                                  PlanPoints(
                                    title: 'Everything in the Growth Plan',
                                    colorit: true,
                                  ),
                                  PlanPoints(
                                    title: 'Dedicated Advisor',
                                    colorit: true,
                                  ),
                                  PlanPoints(
                                    title: 'FREE Tax Planning',
                                    colorit: true,
                                  ),
                                  PlanPoints(
                                    title: 'FREE ITR Filing',
                                    colorit: true,
                                  ),
                                  PlanPoints(
                                    title: 'Stocks',
                                    colorit: true,
                                  ),
                                  PlanPoints(
                                    title: 'Mutual Funds',
                                    colorit: true,
                                  ),
                                  PlanPoints(
                                    title:
                                        'Alternative Investments (Real Estate, PMS, AIF)',
                                    colorit: true,
                                  ),
                                  PlanPoints(
                                    title: 'Startup Investing',
                                    colorit: true,
                                  ),
                                ],
                              ),
                            ),
                          ),

                    // ListView.builder(
                    //     physics: ClampingScrollPhysics(),
                    //     itemCount: planPageViewList[index1].list1.length,
                    //     itemBuilder: (context, index) {
                    //       if (selectIndex == index1) {
                    //         return coloredList[index1].list1[index];
                    //       } else {
                    //         return planPageViewList[index1].list1[index];
                    //       }
                    //     }).expand(),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            );
          },
        ).expand(),
        SmoothPageIndicator(
            controller: controller,
            count: 2,
            effect: ExpandingDotsEffect(
                dotHeight: 10, dotWidth: 10, activeDotColor: Color(0xFF008083)))
      ],
    );
  }
}

class PlanPoints extends StatelessWidget {
  PlanPoints({
    Key? key,
    required this.title,
    this.colorit = false,
    this.showcheckmark = true,
    this.firstPart,
    // required TextStyle style
    //this.style = false
  }) : super(key: key);
  final String title;
  final bool? colorit;
  final bool? showcheckmark;
  //final TextStyle style;
  String? firstPart;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          showcheckmark!
              ? Icon(
                  Icons.check,
                  size: 16.sm,
                  color: colorit! ? Color(0xFFF78104) : const Color(0xFF008083),
                )
              : SizedBox(
                  width: 5,
                ),
          const SizedBox(
            width: 5,
          ),
          SizedBox(
            width: 150.w,
            child: Text(
              title,
              style: TextStyle(
                overflow: TextOverflow.visible,
                color: colorit!
                    ? Colors.white
                    : Get.isDarkMode
                        ? Colors.white
                        : Color(0xFF6B6B6B),
                fontSize: 14.sm,
              ),
            ),
          ),
          // SizedBox(
          //   height: 20,
          // )
        ],
      ),
    );
  }
}

class LineThroughPoints extends StatelessWidget {
  LineThroughPoints(
      {Key? key,
      this.colorit = false,
      this.showcheckmark = true,
      this.firstPart,
      this.EndPart,
      this.LineThroughPart})
      : super(key: key);

  final bool? colorit;
  final bool? showcheckmark;

  String? firstPart;
  String? LineThroughPart;
  String? EndPart;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          showcheckmark!
              ? Icon(
                  Icons.check,
                  size: 16.sm,
                  color: colorit! ? Color(0xFFF78104) : const Color(0xFF008083),
                )
              : SizedBox(
                  width: 5,
                ),
          const SizedBox(
            width: 5,
          ),
          Text.rich(
            TextSpan(children: [
              TextSpan(
                text: firstPart,
              ),
              TextSpan(
                  text: LineThroughPart,
                  style: TextStyle(
                    decorationColor: Colors.red,
                    decoration: TextDecoration.lineThrough,
                  )),
              TextSpan(text: EndPart, style: TextStyle(color: Colors.red)),
            ]),
            style: TextStyle(
              color: colorit!
                  ? Colors.white
                  : Get.isDarkMode
                      ? Colors.white
                      : Color(0xFF6B6B6B),
              fontSize: 14.sm,
            ),
          ),
          // SizedBox(
          //   width: 220.w,
          //   child: Text(
          //     title,
          //     style: TextStyle(
          //       color: colorit!
          //           ? Colors.white
          //           : Get.isDarkMode
          //               ? Colors.white
          //               : Color(0xFF6B6B6B),
          //       fontSize: 14.sm,
          //     ),
          //   ),
          // ),

          // SizedBox(
          //   height: 20,
          // )
        ],
      ),
    );
  }
}

class LineThroughPointsGrowth extends StatelessWidget {
  LineThroughPointsGrowth(
      {Key? key,
      this.colorit = false,
      this.showcheckmark = true,
      this.firstPart,
      this.EndPart,
      this.LineThroughPart})
      : super(key: key);

  final bool? colorit;
  final bool? showcheckmark;

  String? firstPart;
  String? LineThroughPart;
  String? EndPart;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          showcheckmark!
              ? Icon(
                  Icons.check,
                  size: 16.sm,
                  color: colorit! ? Color(0xFFF78104) : const Color(0xFF008083),
                )
              : SizedBox(
                  width: 5,
                ),
          const SizedBox(
            width: 5,
          ),
          Flexible(
            child: Text.rich(
              TextSpan(children: [
                TextSpan(
                  text: firstPart,
                ),
                TextSpan(
                    text: LineThroughPart,
                    style: TextStyle(
                      decorationColor: Colors.red,
                      decoration: TextDecoration.lineThrough,
                    )),
                TextSpan(
                    text: EndPart,
                    style: TextStyle(
                        color: colorit! ? Colors.white : Color(0xFF6B6B6B))),
              ]),
              style: TextStyle(
                color: colorit!
                    ? Colors.white
                    : Get.isDarkMode
                        ? Colors.white
                        : Color(0xFF6B6B6B),
                fontSize: 14.sm,
              ),
            ),
          ),
          // SizedBox(
          //   width: 220.w,
          //   child: Text(
          //     title,
          //     style: TextStyle(
          //       color: colorit!
          //           ? Colors.white
          //           : Get.isDarkMode
          //               ? Colors.white
          //               : Color(0xFF6B6B6B),
          //       fontSize: 14.sm,
          //     ),
          //   ),
          // ),

          // SizedBox(
          //   height: 20,
          // )
        ],
      ),
    );
  }
}
