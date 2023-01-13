//Payment successful check button for kyc

// ignore_for_file: prefer_const_constructors, unused_import, file_names, camel_case_types, must_call_super

import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lottie/lottie.dart';
import 'package:piadvisory/SideMenu/Subscribe/Repository/razorpay.dart';

import '/Profile/KYC/KYCMain.dart';
import '/TellUsAboutYourself.dart';
import '/Utils/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';

import 'Common/CustomNextButton.dart';
import 'Common/app_bar.dart';
import 'Profile/ProfileRepository/ProfileMethods.dart';

class PaymentSuccess extends StatefulWidget {
  const PaymentSuccess({Key? key}) : super(key: key);

  @override
  State<PaymentSuccess> createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccess> {
  late final Future? myFuture;
  @override
  void initState() {
    RazorpayMethods().storeSubsTemp();
    myFuture = ProfileMethods().getUpdateStatus();
    // var one = Get.arguments;
    // if (one != null)
    //   Map<String, dynamic> updata = {
    //     'orderID': one[0]['orderID'],
    //     'paymentID': one[1]['paymentID'],
    //     'signature': one[2]['signature']
    //   };
    // print("updata is $updata");
    // myFuture = RazorpayMethods().postpaymentverification(updata);
  }

  void _onShare(BuildContext context) async {
    // A builder is used to retrieve the context immediately
    // surrounding the ElevatedButton.
    //
    // The context's `findRenderObject` returns the first
    // RenderObject in its descendent tree when it's not
    // a RenderObjectWidget. The ElevatedButton's RenderObject
    // has its position and size after it's built.
    final box = context.findRenderObject() as RenderBox?;

    await Share.share("Share Transaction",
        subject: "subject",
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            // Padding(
            //   padding: const EdgeInsets.all(15),
            //   child: GestureDetector(
            //     onTap: () {
            //       _onShare(context);
            //     },
            //     child: Text(
            //       "Share",
            //       style: blackStyle(context)
            //           .copyWith(fontSize: 14, color: Color(0xFF008083)),
            //     ),
            //   ),
            // )
          ],
          flexibleSpace: Container(
            height: 50,
            decoration: const BoxDecoration(),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: //SingleChildScrollView(child: _buildBody(context)
            FutureBuilder(
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
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 50),
        child: Column(
          children: [
            Center(
              child: Lottie.asset(
                "assets/images/120978-payment-successful.json",
                repeat: false,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            // Text(
            //   "₹199",
            //   style: blackStyle(context).copyWith(
            //     fontSize: 40,
            //   ),
            // ),
            // SizedBox(
            //   height: 23,
            // ),
            Text(
              "Thank you!",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            // Text(
            //   "Lorem ipsum dolor sit amet, consectetuer adipiscing \nelit, sed diam nonummy nibh euismod tincid ut \nlaoreet dolore magna aliquam erat volutpat.",
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //     color: Color(0xFF6B6B6B),
            //     fontSize: 14,
            //   ),
            // ),
        kycsbool! ? SizedBox(height: 2,)  :   SizedBox(
              height: 129,
            ),
            kycsbool!
                ? SizedBox()
                : SizedBox(
                    width: double.infinity,
                    child: CustomNextButton(
                      text: "Update Your KYC",
                      ontap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const KYCMain()));
                      },
                    ),
                  ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TellUsAboutYourself()));
              },
              child: Text(
                "Continue",
                style: blackStyle(context).copyWith(
                  fontSize: 15,
                  //fontWeight: FontWeight.bold,
                  color: Colors.black,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
