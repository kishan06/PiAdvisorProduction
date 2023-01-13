import '/SideMenu/Subscribe/SubscriptionPlans.dart';
import 'package:flutter/material.dart';

class Subscrptionplan {
  String? title;
  String? subtitle;

  List<PlanPoints> list1 = [];

  Subscrptionplan({
    this.title,
    this.subtitle,
    required this.list1,
  });
}
