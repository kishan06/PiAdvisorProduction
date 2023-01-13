
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:piadvisory/Common/CustomAppbarWithIcons.dart';
import 'package:piadvisory/Common/CustomNextButton.dart';
import 'package:piadvisory/HomePage/Stock/stock.dart';
import 'package:piadvisory/Portfolio/PortfolioMainUI.dart';
import 'package:piadvisory/Profile/KYC/SchduleAppointment.dart';
import 'package:piadvisory/SideMenu/CartPi.dart';
import 'package:piadvisory/SideMenu/NavDrawer.dart';
import 'package:piadvisory/SideMenu/Subscribe/Mysubscription.dart';
import 'package:piadvisory/Utils/custom_icons_icons.dart';
import 'package:piadvisory/Utils/textStyles.dart';
import '../HomePage/Homepage.dart';
import '../smallcase_api_methods.dart';

class CartPI2 extends StatefulWidget {
  const CartPI2({Key? key}) : super(key: key);

  @override
  State<CartPI2> createState() => _CartPI2State();
}

class _CartPI2State extends State<CartPI2> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  bool _isstartselected = false;
  bool _isoneselected = false;
  bool _is500selected = false;
  bool _is10000selected = false;
  bool _is15000selected = false;
  void _selectedTab(int index) {
    setState(() {
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
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => Mysubscription())));
          }
          break;
        case 3:
          {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => SchduleAppointment())));
          }
          break;
        case 4:
          {
            openDashboardPage(context);
            // Navigator.push(context,
            //     MaterialPageRoute(builder: ((context) => PortfolioMainUI())));
          }
          break;
        default:
          {
            throw Error();
          }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        key: _key,
        appBar: CustomAppBarWithIcons(
          isprofile: false,
          titleTxt: "Cart",
          globalkey: _key,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Stack(
          children: [
            Positioned(
              bottom: 22,
              right: MediaQuery.of(context).size.width * 0.43,
              child: FloatingActionButton(
                backgroundColor: Color(0xFFF78104),
                heroTag: "tag1",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const Mysubscription())));
                },
                tooltip: 'Subscribe',
                elevation: 2.0,
                child: SvgPicture.asset(
                  "assets/images/product sans logo wh.svg",
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
             selectedLabelStyle: TextStyle(color: Color(0xFFF78104)),
          unselectedLabelStyle: TextStyle(color: Colors.grey),
          unselectedIconTheme: IconThemeData(color: Colors.grey),
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                CustomIcons.path_3177,
                //  color:
                //       Get.isDarkMode ? Color(0xFFF78104) : Color(0xFFF78104)
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(
                  CustomIcons.path_4346,
                  //  color:
                  //     Get.isDarkMode ? Color(0xFFF78104) : Color(0xFFF78104)
                ),
              ),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CustomIcons.group_2369,
                //  color:
                //       Get.isDarkMode ? Color(0xFFF78104) : Color(0xFFF78104)
              ),
              label: 'Subscribe',
            ),
            BottomNavigationBarItem(
              icon: Icon(CustomIcons.date_range,
              //  color:
              //         Get.isDarkMode ? Color(0xFFF78104) : Color(0xFFF78104)
              ),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CustomIcons.bottombarbagicon,
                size: 22.5,
                //  color:
                //       Get.isDarkMode ? Color(0xFFF78104) : Color(0xFFF78104)
              ),
              label: 'Dashboard',
            ),
          ],
          currentIndex: 0,
          unselectedItemColor: Colors.grey,
           selectedItemColor: Color(0xFFF78104),
          backgroundColor: Colors.white,
          onTap: (index) {
            print(index);
            _selectedTab(index);
          },
          type: BottomNavigationBarType.fixed,
        ),
        body: _buildBody(context));
  }

  Widget _buildBody(context) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 0,
          right: 0,
        ),
        child: Center(
          heightFactor: 1.1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(
                  //   width: 16,
                  //   height: 30,
                  // ),
                  Image.asset(
                    'assets/images/icici.png',
                    width: 50.w,
                    height: 50.h,
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Text("ICICI Prudential Technology \nDirect Plan SM",
                      style: TextStyle(
                          color:Get.isDarkMode? Colors.white: Colors.black,
                          fontSize: 16.sm,
                          fontWeight: FontWeight.w600)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Equity Sectorial / Thematic",
                    style: TextStyle(color:Get.isDarkMode? Colors.white: Colors.grey, fontSize: 12.sm),
                  ),
                ],
              ),
              SizedBox(
                height: 48.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35.w,
                    height: 40.h,
                    child: TextButton(
                      onPressed: () {
                       _isstartselected = true;
                       _isoneselected =  false;
                        Get.off(()=>CartPI());
                      },
                      style: ButtonStyle(
                        backgroundColor: _isstartselected
                            ? MaterialStateProperty.all<Color>(
                                Color(0xFF008083),
                              )
                            : MaterialStateProperty.all<Color>(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side:  BorderSide(
                              width: 2.w,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      // child: GestureDetector(
                      //   onTap: (){
                      //     Navigator.push(context,
                      //      MaterialPageRoute(builder: ((context) => CartPI())));
                      //   },
                      child: Text(
                        "Start SIP",
                        style: blackStyle(context).copyWith(
                            fontSize: 20.sm,
                            color:
                                _isstartselected ? Colors.white : Colors.black),
                      ),
                     // ),
                    ),
                  ),
                  SizedBox(
                    width: 25.w,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35.w,
                    height: 40.h,
                    child: TextButton(
                      onPressed: () {
                       setState(() {
                          _isoneselected = true;
                          _isstartselected = false;
                       });

                      },
                      style: ButtonStyle(
                        backgroundColor: _isoneselected
                            ? MaterialStateProperty.all<Color>(
                                Color(0xFF008083),
                              )
                            : MaterialStateProperty.all<Color>( Color(0xFF008083)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side:  BorderSide(
                              width: 2.w,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      child: Text(
                        "One Time",
                        style: blackStyle(context).copyWith(
                            fontSize: 20.sm,
                            color:
                                _isoneselected ? Colors.white : Colors.white),
                      ),
                      
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "₹ 60000",
                    style: TextStyle(
                      color:Get.isDarkMode? Colors.white: Colors.black,
                      fontSize: 35.sm,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
              Divider(
                thickness: 2,
                color: Get.isDarkMode? Colors.grey: Colors.grey,
              ),
              SizedBox(
                height: 12.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25.w,
                    height: 40.h,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _is500selected = true;
                          _is10000selected = false;
                          _is15000selected = false;
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: _is500selected
                            ? MaterialStateProperty.all<Color>(
                                Color(0xFF008083),
                              )
                            : MaterialStateProperty.all<Color>(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side:  BorderSide(
                              width: 2.w,
                              color: Color(0xFF008083),
                            ),
                          ),
                        ),
                      ),
                      child: Text(
                        "+ ₹500",
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: _is500selected
                                ? Colors.white
                                : Color(0xFF008083)),
                        //  blackStyle(context).copyWith(
                        //     fontSize: 14,
                        //     color:
                        //         _is500selected ? Colors.white : Color(0xFF008083)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.29.w,
                    height: 40.h,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                             _is10000selected = true;
                        _is500selected = false;
                        _is15000selected = false;
                        });
                     
                      },
                      style: ButtonStyle(
                        backgroundColor: _is10000selected
                            ? MaterialStateProperty.all<Color>(
                                Color(0xFF008083),
                              )
                            : MaterialStateProperty.all<Color>(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side:  BorderSide(
                              width: 2.w,
                              color: Color(0xFF008083),
                            ),
                          ),
                        ),
                      ),
                      child: Text(
                        "+ ₹10000",
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: _is10000selected
                                ? Colors.white
                                : Color(0xFF008083)),
                        // blackStyle(context).copyWith(
                        //     fontSize: 20,
                        //     color:
                        //         _is10000selected ? Colors.white :  Color(0xFF008083)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.29.w,
                    height: 40.h,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                         _is15000selected = true;
                        _is500selected = false;
                        _is10000selected = false;
                        });
              
                      },
                      style: ButtonStyle(
                        backgroundColor: _is15000selected
                            ? MaterialStateProperty.all<Color>(
                                Color(0xFF008083),
                              )
                            : MaterialStateProperty.all<Color>(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side:  BorderSide(
                              width: 2.w,
                              color: Color(0xFF008083),
                            ),
                          ),
                        ),
                      ),
                      child: Text(
                        "+ ₹15000",
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: _is15000selected
                                ? Colors.white
                                : Color(0xFF008083)),
                        // blackStyle(context).copyWith(
                        //     fontSize: 20,
                        //     color:
                        //         _is15000selected ? Colors.white :  Color(0xFF008083)),
                      ),
                    ),
                  ),
                ],
              ),
              
              SizedBox(
                height: 320.h,
              ),
            SizedBox(
              width: 350.w,
              child: CustomNextButton(
                text: "Continue",
                ontap: (){
                  
                },
                ),
            ) 
            ],
          ),
        ),
      ),
    );
  }
}
