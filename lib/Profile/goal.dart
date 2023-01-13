// ignore_for_file: prefer_const_constructors, duplicate_ignore, camel_case_types

import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lottie/lottie.dart';
import 'package:piadvisory/Profile/GoalsRepository/Model/UserGoals.dart';
import 'package:piadvisory/Profile/GoalsRepository/storeGoals.dart';
import 'package:piadvisory/Utils/base_manager.dart';
import '/Utils/Dialogs.dart';
import '/Common/CustomNextButton.dart';
import '/Profile/add-goal.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Common/app_bar.dart';

List<Data>? globalGoals = [];

class goal extends StatefulWidget {
  const goal({Key? key}) : super(key: key);

  @override
  State<goal> createState() => _goalState();
}

class _goalState extends State<goal> {
  List<Data>? _goals = [];
  @override
  void initState() {
    Timer(Duration(seconds: 2), () {
      setState(() {});
    });
    super.initState();
  }

  void deleteGoal(int goalId) async {
    Map<String, dynamic> updata = {
      "goal_id": goalId,
    };
    print("updats is $updata");
    final data = await Storegoalsdetails().deleteGoals(updata);
    if (data.status == ResponseStatus.SUCCESS) {
    } else {
      return utils.showToast(data.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleTxt: "My Goals", bottomtext: false),
      body: FutureBuilder(
        future: Storegoalsdetails().getGoals(),
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
            _goals = userGoals.data!;
            globalGoals = _goals;

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occured',
                  style: TextStyle(fontSize: 18),
                ),
              );
            }
          }
          if (_goals != null && _goals!.isEmpty) {
            return _buildNodataBody(context);
          } else {
            return _buildBody(context, _goals);
          }
        },
      ),
    );
  }

  Widget _buildNodataBody(context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 114.h,
            ),
            Center(
              child: SvgPicture.asset(
                "assets/images/Group 5422.svg",
                width: 243.82,
                height: 248.95,
              ),
            ),
            SizedBox(
              height: 80,
            ),
            SizedBox(
              child: Text(
                "Set your financial goals to receive \ncustomized investment advice",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.sm,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 80.h,
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: CustomNextButton(
                text: 'Add Goal',
                ontap: () {
                  Get.toNamed("/addgoals");
                },
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBody(context, List<Data>? _goals) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            //  shrinkWrap: true,
            itemCount: _goals!.length,
            itemBuilder: (context, index) {
              return Dismissible(
                background: slideRightBackground(),
                key: UniqueKey(),
                onDismissed: (direction) {
                  setState(() {
                    deleteGoal(_goals[index].id!);
                    _goals.removeAt(index);
                  });
                  Flushbar(
                    message: "Goal deleted",
                    duration: const Duration(seconds: 3),
                  ).show(context);
                },
                child: Card(
                  elevation: 2,
                  child: ListTile(
                    title: Text('${_goals[index].type}'),
                    subtitle: Text(_goals[index].amount.toString()),
                    trailing: PopupMenuButton(
                      offset: const Offset(0, 50),
                      color: Color(0xFF6b6b6b),
                      tooltip: '',
                      icon: Icon(Icons.more_vert),
                      onSelected: (value) {
                        if (value == '/delete') {
                          setState(() {
                            deleteGoal(_goals[index].id!);
                            _goals.removeAt(index);
                            Flushbar(
                              message: "Goal deleted",
                              duration: const Duration(seconds: 3),
                            ).show(context);
                          });
                        } else if (value == "/edit") {
                          Get.toNamed("/addgoals", arguments: {
                            "id": _goals[index].id,
                            "goalName": _goals[index].type,
                            "targetAmt": _goals[index].amount,
                            "duration": _goals[index].duration
                          });
                        }
                      },
                      itemBuilder: (BuildContext bc) {
                        return [
                          const PopupMenuItem(
                            child: Text(
                              "Edit",
                              style: TextStyle(color: Colors.white),
                            ),
                            value: '/edit',
                          ),
                          const PopupMenuItem(
                            child: Text(
                              "Delete",
                              style: TextStyle(color: Colors.white),
                            ),
                            value: '/delete',
                          )
                        ];
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Center(
            child: SizedBox(
                width: double.infinity,
                child: CustomNextButton(
                  text: "Add New Goal",
                  ontap: () {
                    Get.toNamed("/addgoals");
                  },
                )),
          ),
        )
      ],
    );
  }

  Widget slideRightBackground() {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.close_outlined,
              color: Colors.white,
            ),
            Text(
              "Remove",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }
}
