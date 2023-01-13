// ignore_for_file: non_constant_identifier_names, file_names

import 'package:get/get.dart';
import 'package:piadvisory/Common/VideoYoutube.dart';
import 'package:piadvisory/Utils/textStyles.dart';

import 'package:flutter/material.dart';

import '../Common/CustomNextButton.dart';
import '../HomePage/Homepage.dart';
import 'login.dart';

class GuidedTourWidget {
  Future<dynamic> GuidedTour(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      builder: (context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child: Text(
                  'Would you like a guided tour of our app?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: CustomNextButton(
                      text: "Yes",
                      ontap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => HomePage())));
                      },
                    )),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: CustomNextButton(
                      text: "No",
                      ontap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: ((context) => Login())));
                      },
                    )),
              ),
            ],
          ),
        );
      },
    );
  }

  buildVideoDialog(context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        insetPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        contentPadding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        // contentPadding:
        //     EdgeInsets.all(
        //         10),
        title: Text(
          "How Our piadvisoryy Works?",
          style: blackStyle(context).copyWith(fontWeight: FontWeight.bold, color:Get.isDarkMode? Colors.white: Colors.black,),
        ),
        content: VideoYoutube(),
      ),
    );
  }
}
