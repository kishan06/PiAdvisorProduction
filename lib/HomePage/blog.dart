// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new, duplicate_ignore, avoid_print

import 'dart:async';

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:outline_search_bar/outline_search_bar.dart';
import 'package:piadvisory/Common/CreateBottomBar.dart';
import 'package:piadvisory/Common/CustomAppbarWithIcons.dart';
import 'package:piadvisory/Common/Customfloatingbutton.dart';
import 'package:piadvisory/Common/GlobalFuntionsVariables.dart';
import 'package:piadvisory/Common/NoscalingAnimation.dart';
import 'package:piadvisory/HomePage/Blog%20Repository/blogrepo.dart';
import 'package:piadvisory/HomePage/BlogInner.dart';
import 'package:piadvisory/HomePage/BlogInner3.dart';
import 'package:piadvisory/HomePage/BlogInnerFourth.dart';
import 'package:piadvisory/HomePage/BloginnerMutual.dart';
import 'package:piadvisory/HomePage/Homepage.dart';
import 'package:piadvisory/SideMenu/FAQ/faqrepository/feesrepo.dart';
import 'package:piadvisory/SideMenu/NavDrawer.dart';
import 'package:piadvisory/Utils/Constants.dart';
import 'package:piadvisory/smallcase_api_methods.dart';

import '../Common/fab_bottom_app_bar.dart';
import '../Profile/KYC/SchduleAppointment.dart';
import '../SideMenu/Subscribe/Mysubscription.dart';
import '../Utils/custom_icons_icons.dart';
import 'Blog Repository/Model/BlogModel.dart';
import 'Mutual Funds/MutualFundsGraph.dart';
import 'Stock/stock.dart';

//import 'package:html/parser.dart' show parse;
late FocusNode myFocusNode;
var newindex = 0;
//final formKey = GlobalKey<FormState>();

//final riKey2 =  Key('__RIKEY2__');

class Blog extends StatefulWidget {
  const Blog({Key? key}) : super(key: key);

  @override
  State<Blog> createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  String _lastSelected = 'TAB: 0';
  void _selectedTab(int index) {
    setState(() {
      _lastSelected = 'TAB: $index';
      print(_lastSelected);

      switch (index) {
        case 0:
          {
            Navigator.push(
                context, MaterialPageRoute(builder: ((context) => HomePage())));
          }
          break;

        case 1:
          {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => Stocks(
                          selectedPage: 0,
                        ))));
          }
          break;

        case 2:
          {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => SchduleAppointment())));
          }
          break;
        case 3:
          {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => const Mysubscription())));
          }
          break;
        case 4:
          {
            openDashboardPage(context);
          }
          break;

        default:
          {
            throw Error();
          }
      }
    });
  }

  late final Future myFuture;
  @override
  void initState() {
    myFuture = getBlogs().getBlogsandNews();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _key,
      drawer: NavDrawer(),
      floatingActionButtonAnimator: NoScalingAnimation(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: showFab
          ? Padding(
              padding: const EdgeInsets.only(top: 10),
              child: CustomFloatingButton(),
              //  FloatingActionButton(
              //   backgroundColor: Color(0xFFF78104),
              //   heroTag: "tag1",
              //   onPressed: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: ((context) => const Mysubscription())));
              //   },
              //   tooltip: 'Subscribe',
              //   elevation: 2.0,
              //   child: SvgPicture.asset(
              //     "assets/images/product sans logo wh new.svg",
              //     color: Colors.white,
              //     fit: BoxFit.contain,
              //     width: 28,
              //     height: 24,
              //   ),
              // ),
            )
          : null,
      bottomNavigationBar:CreateBottomBar(stateBottomNav, "Bottombar", context),
      appBar: CustomAppBarWithIcons(
        titleTxt: "Blog",
        globalkey: _key,
      ),
      body: FutureBuilder(
        future: myFuture,
        builder: (ctx, snapshot) {
          if (snapshot.data == null) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Lottie.asset(
                    "assets/images/lf30_editor_jc6n8oqe.json",
                    repeat: true,
                    height: 150,
                    width: 150,
                  ),
                ),
              ],
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occured',
                  style: TextStyle(fontSize: 18),
                ),
              );
            }
          }
          return _buildBody(
            context,
          );
        },
      ),
    );
  }

  Widget _buildBody(context) {
    return DefaultTabController(
      length: 4,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            ButtonsTabBar(
              contentPadding: EdgeInsets.only(left: 25, right: 25),
              radius: 4,
              backgroundColor: Color(0xFF008083),
              unselectedBorderColor: Color(0xFF008083),
              borderWidth: 2,
              borderColor: Color(0xFF008083),
              unselectedBackgroundColor: Colors.white,
              unselectedLabelStyle: TextStyle(color: Color(0xFF6B6B6B)),
              labelStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              tabs: [
                Tab(
                  text: "All",
                ),
                Tab(
                  text: "Mutual Fund",
                ),
                Tab(
                  text: "Stocks",
                ),
                Tab(
                  text: "Insights",
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  FirstTab(),
                  SecondTab(),
                  ThirdTab(),
                  FourthTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FirstTab extends StatefulWidget {
  const FirstTab({super.key});

  @override
  State<FirstTab> createState() => _FirstTabState();
}

class _FirstTabState extends State<FirstTab> {
  final GlobalKey<_FirstTabState> riKey2 = GlobalKey<_FirstTabState>();

  //    var document = parse(
  //     blogs.blogAll![i].discription!);
  // print(document.outerHtml);
  TextEditingController searchController = TextEditingController();
  bool searchingStarted = false;
  //List<Blogs> filteredList = [];
  List<BlogAll> filteredList = [];

  @override
  void dispose() {
    super.dispose();
    myFocusNode.dispose();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    myFocusNode = FocusNode();
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 15,
      ),
      child: Center(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      // clipBehavior: Clip.none,
                      children: [
                        OutlineSearchBar(
                          focusNode: myFocusNode,
                          key: riKey2,
                          borderColor: Color(0xFF6E6E6E),
                          onKeywordChanged: (value) {
                            setState(() {
                              searchController.text.isNotEmpty
                                  ? searchingStarted = true
                                  : searchingStarted = false;

                              filteredList = blogs.blogAll!
                                  .where(
                                    (element) =>
                                        element.title!.toLowerCase().contains(
                                              value.toLowerCase(),
                                            ),
                                  )
                                  .toList();
                            });
                          },
                          textEditingController: searchController,
                          hintText: "Search & Add",
                        ),
                        searchingStarted
                            ? Center(
                                child: Container(
                                  height: 150.h,
                                  //width: 280.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                    border: Border.all(
                                      width: 1,
                                      color: Color(0xFF6B6B6B),
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: SizedBox(
                                      height: 50,
                                      child: ListView.separated(
                                        itemCount: filteredList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return SingleChildScrollView(
                                            child: ListTile(
                                              title: Text(
                                                  filteredList[index].title!),
                                              onTap: () {
                                                SystemChannels.textInput
                                                    .invokeMethod(
                                                        'TextInput.hide');
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: ((context) =>
                                                            BlogInner(
                                                              allBlogIndex:
                                                                  index!,
                                                            ))));
                                              },
                                            ),
                                          );
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return Divider(
                                            thickness: 1.5,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Top News",
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Get.isDarkMode ? Colors.white : Color(0xFF444444)),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        for (var i = 0; i < 3; i++)
                          SizedBox(
                            width: 350.w,
                            child: ScrollableCards(
                              image: ApiConstant.piImages +
                                  blogs.blogAll![i].blogImage!,

                              //"assets/images/BSE-5.png",
                              title: blogs.blogAll![i].title!,
                              subtitle: blogs.blogAll![i].discription!,
                              megatitle: blogs.blogAll![i].publishDate!,
                              index: i,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 2,
              color: Get.isDarkMode ? Colors.grey : Colors.grey,
            ),
            for (var i = 0; i < blogs.blogAll!.length; i++)
              commonBlog(
                image: ApiConstant.piImages + blogs.blogAll![i].blogImage!,
                title: blogs.blogAll![i].title!,
                subtitle: blogs.blogAll![i].publishDate!,
                index: i,
              ),
          ],
        ),
      ),
    );
  }
}

class commonBlog extends StatelessWidget {
  commonBlog({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.image,
    this.index,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String image;
  int? index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: GestureDetector(
        onTap: () {
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BlogInner(
                        allBlogIndex: index!,
                      )));
        },
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.24),
                      child: Image.network(
                        image,
                        width: 86,
                        height: 83,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 15.sm,
                              fontWeight: FontWeight.w600,
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            subtitle,
                            style: TextStyle(
                              color: Get.isDarkMode
                                  ? Colors.white
                                  : Color(0xFF444444),
                              fontSize: 12.sm,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Expanded(
                  //   flex: 0,
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(right: 8.0),
                  //     child: SizedBox(
                  //       width: 5,
                  //       child: Icon(
                  //         FontAwesomeIcons.bookmark,
                  //         size: 15,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScrollableCards extends StatelessWidget {
  ScrollableCards(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.image,
      required this.megatitle,
      this.index})
      : super(key: key);

  final String title;
  final String subtitle;
  final String megatitle;
  final String image;
  int? index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BlogInner(allBlogIndex: index!)));
      },
      child: SizedBox(
        width: 390,
        height: 160,
        child: Card(
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.24),
                  child: Image.network(
                    image,
                    width: 132,
                    height: 153,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 15.sm,
                          fontWeight: FontWeight.w600,
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Flexible(
                        child: Html(
                          data: subtitle,
                          //  style: TextStyle(
                          //   color: Get.isDarkMode
                          //       ? Colors.white
                          //       : Color(0xFF444444),
                          //   fontSize: 14.sm,
                          // ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        megatitle,
                        style: TextStyle(
                          color:
                              Get.isDarkMode ? Colors.white : Color(0xFF444444),
                          fontSize: 10.sm,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SecondTab extends StatefulWidget {
  const SecondTab({super.key});

  @override
  State<SecondTab> createState() => _SecondTabState();
}

class _SecondTabState extends State<SecondTab> {
  @override
  Widget build(BuildContext context) {
    return blogs.blog1 == null || blogs.blog1!.isEmpty
        ? _buildNoDataBody()
        : _buildWithDataBody();
  }

  Widget _buildNoDataBody() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 170,
              padding: EdgeInsets.all(35),
              // decoration: BoxDecoration(
              //   color: themeColor,
              //  // shape: BoxShape.circle,
              // ),
              child: Center(
                child: Image.asset(
                  "assets/images/Nodata.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 1
                // screenHeight * 0.1
                ),
            Center(
              child: Text(
                "No Data Available",
                style: TextStyle(
                  color: Colors.black,
                  //Color(0xFF008083),
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWithDataBody() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 50,
      ),
      child: Center(
        child: ListView(
          children: [
            for (var i = 0; i < blogs.blog1!.length; i++)
              CommonMutual(
                image: ApiConstant.piImages + blogs.blog1![i].blogImage!,
                title: blogs.blog1![i].title!,
                subtitle: blogs.blog1![i].publishDate!,
                index: i,
              ),
          ],
        ),
      ),
    );
  }

  // Padding(
  //   padding: const EdgeInsets.only(
  //     bottom: 50,
  //   ),
  //   child: Center(
  //     child: ListView(
  //       children: [
  //         for (var i = 0; i < blogs.blog1!.length; i++)
  //           CommonMutual(
  //             image: ApiConstant.piImages + blogs.blog1![i].blogImage!,
  //             title: blogs.blog1![i].title!,
  //             subtitle: blogs.blog1![i].publishDate!,
  //             index: i,
  //           ),
  //       ],
  //     ),
  //   ),
  // );

}

class CommonMutual extends StatelessWidget {
  CommonMutual({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.image,
    this.index,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String image;
  int? index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: GestureDetector(
        onTap: () {
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BlogInnerMutual(
                        allBlogIndex: index!,
                      )));
        },
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.24),
                      child: Image.network(
                        image,
                        width: 86,
                        height: 83,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 15.sm,
                              fontWeight: FontWeight.w600,
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            subtitle,
                            style: TextStyle(
                              color: Get.isDarkMode
                                  ? Colors.white
                                  : Color(0xFF444444),
                              fontSize: 12.sm,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Expanded(
                  //   flex: 0,
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(right: 8.0),
                  //     child: SizedBox(
                  //       width: 5,
                  //       child: Icon(
                  //         FontAwesomeIcons.bookmark,
                  //         size: 15,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ThirdTab extends StatefulWidget {
  const ThirdTab({super.key});

  @override
  State<ThirdTab> createState() => _ThirdTabState();
}

class _ThirdTabState extends State<ThirdTab> {
  @override
  Widget build(BuildContext context) {
    return blogs.blog2 == null || blogs.blog2!.isEmpty
        ? _buildNoDataBody()
        : _buildWithDataBody();
  }

  Widget _buildNoDataBody() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 170,
              padding: EdgeInsets.all(35),
              // decoration: BoxDecoration(
              //   color: themeColor,
              //  // shape: BoxShape.circle,
              // ),
              child: Center(
                child: Image.asset(
                  "assets/images/Nodata.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 1
                // screenHeight * 0.1
                ),
            Center(
              child: Text(
                "No Data Available",
                style: TextStyle(
                  color: Colors.black,
                  //Color(0xFF008083),
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWithDataBody() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 50,
      ),
      child: Center(
        child: ListView(
          children: [
            for (var i = 0; i < blogs.blog2!.length; i++)
              commonBlog(
                image: ApiConstant.piImages + blogs.blog2![i].blogImage!,
                title: blogs.blog2![i].title!,
                subtitle: blogs.blog2![i].publishDate!,
                index: i,
              ),
          ],
        ),
      ),
    );
  }
  // Scaffold(
  //   body: Center(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: <Widget>[
  //         Container(
  //           height: 170,
  //           padding: EdgeInsets.all(35),
  //           // decoration: BoxDecoration(
  //           //   color: themeColor,
  //           //  // shape: BoxShape.circle,
  //           // ),
  //           child: Center(
  //             child: Image.asset(
  //               "assets/images/Nodata.png",
  //               fit: BoxFit.contain,
  //             ),
  //           ),
  //         ),
  //         SizedBox(height: 1
  //             // screenHeight * 0.1
  //             ),
  //         Center(
  //           child: Text(
  //             "No Data Available",
  //             style: TextStyle(
  //               color: Colors.black,
  //               //Color(0xFF008083),
  //               fontWeight: FontWeight.w600,
  //               fontSize: 20,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   ),
  // );
  // Padding(
  //   padding: const EdgeInsets.only(
  //     bottom: 50,
  //   ),
  //   child: Center(
  //     child: ListView(
  //       children: [
  //         for (var i = 0; i < blogs.blog2!.length; i++)
  //           commonBlog(
  //             image: ApiConstant.piImages + blogs.blog2![i].blogImage!,
  //             title: blogs.blog2![i].title!,
  //             subtitle: blogs.blog2![i].publishDate!,
  //             index: i,
  //           ),
  //       ],
  //     ),
  //   ),
  // );

}

class CommonThird extends StatelessWidget {
  CommonThird({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.image,
    this.index,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String image;
  int? index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: GestureDetector(
        onTap: () {
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BlogInner3(
                        allBlogIndex: index!,
                      )));
        },
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.24),
                      child: Image.network(
                        image,
                        width: 86,
                        height: 83,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 15.sm,
                              fontWeight: FontWeight.w600,
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            subtitle,
                            style: TextStyle(
                              color: Get.isDarkMode
                                  ? Colors.white
                                  : Color(0xFF444444),
                              fontSize: 12.sm,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Expanded(
                  //   flex: 0,
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(right: 8.0),
                  //     child: SizedBox(
                  //       width: 5,
                  //       child: Icon(
                  //         FontAwesomeIcons.bookmark,
                  //         size: 15,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FourthTab extends StatefulWidget {
  const FourthTab({super.key});

  @override
  State<FourthTab> createState() => _FourthTabState();
}

class _FourthTabState extends State<FourthTab> {
  @override
  Widget build(BuildContext context) {
    return blogs.blog3 == null || blogs.blog3!.isEmpty
        ? _buildNoDataBody()
        : _buildWithDataBody();
  }

  Widget _buildNoDataBody() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 170,
              padding: EdgeInsets.all(35),
              // decoration: BoxDecoration(
              //   color: themeColor,
              //  // shape: BoxShape.circle,
              // ),
              child: Center(
                child: Image.asset(
                  "assets/images/Nodata.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 1
                // screenHeight * 0.1
                ),
            Center(
              child: Text(
                "No Data Available",
                style: TextStyle(
                  color: Colors.black,
                  //Color(0xFF008083),
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWithDataBody() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 50,
      ),
      child: Center(
        child: ListView(
          children: [
            for (var i = 0; i < blogs.blog3!.length; i++)
              commonBlog(
                image: ApiConstant.piImages + blogs.blog3![i].blogImage!,
                title: blogs.blog3![i].title!,
                subtitle: blogs.blog3![i].publishDate!,
                index: i,
              ),
          ],
        ),
      ),
    );
  }
}

class CommonFourth extends StatelessWidget {
  CommonFourth({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.image,
    this.index,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String image;
  int? index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: GestureDetector(
        onTap: () {
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BlogInnerFourth(
                        allBlogIndex: index!,
                      )));
        },
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.24),
                      child: Image.network(
                        image,
                        width: 86,
                        height: 83,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 15.sm,
                              fontWeight: FontWeight.w600,
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            subtitle,
                            style: TextStyle(
                              color: Get.isDarkMode
                                  ? Colors.white
                                  : Color(0xFF444444),
                              fontSize: 12.sm,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Expanded(
                  //   flex: 0,
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(right: 8.0),
                  //     child: SizedBox(
                  //       width: 5,
                  //       child: Icon(
                  //         FontAwesomeIcons.bookmark,
                  //         size: 15,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
