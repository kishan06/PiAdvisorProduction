import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:piadvisory/Utils/custom_icons_icons.dart';

StreamController<bool> stateBottomNav = StreamController.broadcast();



List bottomList = [
  "Home",
  "Explore",
  "Subscribe",
  "Calendar",
  "Dashboard",
];

List<Icon> iconlist = [
  Icon(CustomIcons.path_3177),
  Icon(CustomIcons.path_4346,),
  Icon(CustomIcons.group_2369),
  Icon(CustomIcons.date_range),
  Icon(CustomIcons.bottombarbagicon),
];