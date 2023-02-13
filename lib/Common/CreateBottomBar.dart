import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piadvisory/Common/ConnectivityService.dart';
import 'package:piadvisory/Common/GlobalFuntionsVariables.dart';
import 'package:piadvisory/Common/NetworkSensitive.dart';
import 'package:piadvisory/Common/ResumableState.dart';
import 'package:piadvisory/HomePage/Homepage.dart';
import 'package:piadvisory/HomePage/Stock/stock.dart';
import 'package:piadvisory/Profile/KYC/SchduleAppointment.dart';
import 'package:piadvisory/SideMenu/Subscribe/Mysubscription.dart';
import 'package:piadvisory/smallcase_api_methods.dart';
import 'package:provider/provider.dart';
import '../../main.dart';


class CreateBottomBar extends StatefulWidget {
  StreamController<bool> stateBottomNav;
  String fromScreen="";
  BuildContext mainContext;

  CreateBottomBar(this.stateBottomNav,this.fromScreen,this.mainContext);

  @override
  State<StatefulWidget> createState() {
    return _CustomBottomBarState();
  }
}

class _CustomBottomBarState extends ResumableState<CreateBottomBar> {
  final GlobalKey globalKey = new GlobalKey(debugLabel: 'btm_app_bar');
   GlobalKey connectivitykey = new GlobalKey(debugLabel: 'internet_key');
  var selectedIndex_bottom = 0;
  StreamController _sessionController = StreamController.broadcast();
  String fromScreen="";
  @override
  void initState() {
    fromScreen = widget.fromScreen;
    super.initState();
  }
  @override
  void onPause() {
    connectivitykey.currentState?.deactivate();
    //socketController.deleteIndex();
  }
  @override
  void onResume(){
    connectivitykey.currentState?.activate();
  }
  @override
  void onReady(){
    _scaffoldKey.currentState?.deactivate();
  }
  @override
  void dispose() {
    _sessionController.close();
    super.dispose();
  }
  final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        key: globalKey,
        elevation: 5,
        backgroundColor: Theme.of(context).bottomAppBarColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: bottomIndex,
        unselectedLabelStyle: TextStyle(color: Colors.grey),
        selectedLabelStyle: TextStyle(color:  Color(0xFFF78104)),
        items: getBottomBarList(),
        unselectedItemColor:Colors.grey,
        selectedItemColor:  Color(0xFFF78104),
        onTap: onTabTapped);
  }

  void onTabTapped(int index) {
    _goTo(index);
  }

  getBottomBarList() {
    List<BottomNavigationBarItem> bottomItemsList = [];
    List<Icon> bottomiconslist = [];
    var bottomItem;
    var text;
    for (int i = 0; i < bottomList.length; i++) {
      var iconname = bottomList[i];
      for(int j =0; j < iconlist.length; j++){
        text = iconlist[j];
        bottomiconslist.add(text);
      }
      bottomItem = BottomNavigationBarItem(
          icon: bottomNavigationIcon(bottomiconslist.elementAt(i)),
          activeIcon: bottomiconslist.elementAt(i), //colorCode.primaryColor),
          label: iconname);
      bottomItemsList.add(bottomItem);
    }
    return bottomItemsList;
  }

  static bottomNavigationIcon(image) {
    return image ;
  }

  _goTo(int index) async {
    var name = bottomList[index].toString().toLowerCase();
    if(isFromScreen()){
      switch (name) {
        case 'home':
          {
            if(fromScreen == "BottombarHomepage"){
              return;
            }
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: ((context) => HomePage())));
            bottomIndex = index;
          }
          break;
        case 'explore':
          {
            if(fromScreen == "Bottombarstocks"){
              return;
            }
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: ((context) => Stocks(
                      selectedPage: 0,
                    ))));
            bottomIndex = index;
          }
          break;

        case 'subscribe':
          {
            if(fromScreen == "Bottombarsubscribe"){
              return;
            }
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: ((context) => Mysubscription())));
            bottomIndex = index;
          }
          break;
        case 'calendar':
          {
            if(fromScreen == "Bottombarcalender"){
              return;
            }
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: ((context) => SchduleAppointment())));
            bottomIndex = index;
          }
          break;
        case 'dashboard':
          {
            if(fromScreen == "Bottombardashboard"){
              return;
            }
            openDashboardPage(context);
            bottomIndex = index;
          }
          break;
        default:
          {
            throw Error();
          }
      }
    }
  }

  bool isFromScreen() {
    return fromScreen != null && fromScreen != "";
  }
}
