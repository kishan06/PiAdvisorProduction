import 'dart:async';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lottie/lottie.dart';
import 'package:piadvisory/Profile/KYC/Repository/KYCDigilocker.dart';
import 'package:piadvisory/SideMenu/Subscribe/Repository/fetchNewUserStatus.dart';
import 'package:piadvisory/SideMenu/Subscribe/Repository/razorpay.dart';
import 'package:piadvisory/Utils/base_manager.dart';
import 'package:piadvisory/Utils/database.dart';
import 'package:piadvisory/payment-failed.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '/Common/CustomNextButton.dart';
import '/Common/app_bar.dart';
import '/Profile/KYC/FamilyDetails.dart';
import '/Profile/KYC/UploadPanCard.dart';
import '/Utils/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/Utils/Dialogs.dart';

class SubscriptionLoadingPage extends StatefulWidget {
  const SubscriptionLoadingPage({Key? key}) : super(key: key);

  @override
  State<SubscriptionLoadingPage> createState() =>
      _SubscriptionLoadingPageState();
}

class _SubscriptionLoadingPageState extends State<SubscriptionLoadingPage>
    with SingleTickerProviderStateMixin {
  Razorpay _razorpay = Razorpay();
  Map<String, dynamic> planDetails = {};
  Map<String, dynamic> userdetails = {};
  Map<String, dynamic> options = {};
  late AnimationController lottieController;
  bool _showPaymentStatus = false;
  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    setState(() {
      planDetails = Get.find<Database>().restorePriceAndPlanName();
      print("planDetails is $planDetails");
      planDetails = planDetails;
      userdetails = Get.find<Database>().restoreUserDetails();
      print("user details $userdetails");
    });
    Timer(Duration(seconds: 3), () {
      setState(() {
        _showPaymentStatus = true;
      });
    });
    super.initState();
  }

  setOptions() {
    options = {
      'key': 'rzp_test_ryPoiSUUJmfLXB',
      'amount': planDetails['amount'], //in the smallest currency sub-unit.
      'name': planDetails['planName'],
      'order_id': orderID, // Generate order_id using Orders API
      'description': 'Fine T-Shirt',
      'timeout': 60, // in seconds
      'prefill': {
        'contact': userdetails['number'],
        'email': userdetails['email']
      }
    };
  }

  void UploadData(orderId, paymentID, signature) async {
    Map<String, dynamic> updata = {
      'orderID': orderId,
      'paymentID': paymentID,
      'signature': signature
    };

    final data = await RazorpayMethods().postpaymentverification(updata);
    if (data.status == ResponseStatus.SUCCESS) {
      Get.toNamed('/paymentsuccessfull', arguments: [
        {"orderID": orderId},
        {"paymentID": paymentID},
        {"signature": signature}
      ]);
    } else {
      return utils.showToast(data.message);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    RazorpayMethods().getPaymentDetails(response.orderId!);

    // Get.toNamed('/paymentsuccessfull', arguments: [
    //   {"orderID": response.orderId},
    //   {"paymentID": response.paymentId},
    //   {"signature": response.signature}
    // ]);

    UploadData(response.orderId, response.paymentId, response.signature);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    RazorpayMethods().getPaymentDetails(orderID);
    print("PAYMENT ERROR");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
    print(response.walletName);
  }

  @override
  void dispose() {
    lottieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
                Get.toNamed("/mysubscription");
              //Navigator.pop(context);
            },
            icon: Icon(Icons.close)),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Center(
          child: const Text(
            "",
            style: TextStyle(
              fontFamily: 'Helvetica',
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: fetchNewUserStatus().getNewUserStatus(),
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
            if (userStatus['status'] == 1) {
              Future.microtask(() => Get.offAllNamed('/thankyou'));
              ;
            } else {
              try {
                setOptions();
                _razorpay.open(options);
              } catch (e) {
                print("razor error " + e.toString());
              }
            }
          }
          return _buildbody(
            context,
          );
        },
      ),
    );
  }

  Widget _buildbody(context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          Lottie.asset(
            "assets/images/44834-payment-processing.json",
            repeat: true,
            height: 300,
            width: 300,
            //   controller: lottieController, onLoaded: (composition) {
            // lottieController.duration = composition.duration;
            // lottieController.forward();
            //}
          ),
          _showPaymentStatus
              ? const Center(
                  child: Text(
                    "Payment Failed",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                )
              : Center(child: Text("")),
          const SizedBox(height: 21),
        ]);
  }
}
