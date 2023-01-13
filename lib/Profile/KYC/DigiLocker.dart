import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lottie/lottie.dart';
import 'package:piadvisory/Common/app_bar.dart';
import 'package:piadvisory/Profile/KYC/Repository/KYCDigilocker.dart';
import 'package:piadvisory/Profile/KYC/Repository/LoadingPageKYC.dart';
import 'package:piadvisory/Profile/KYC/web_view_stack.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

class DigiLocker extends StatefulWidget {
  const DigiLocker({Key? key}) : super(key: key);

  @override
  State<DigiLocker> createState() => _DigiLockerState();
}

class _DigiLockerState extends State<DigiLocker> {
  final controller =
      Completer<WebViewController>(); // Instantiate the controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          height: 50,
          decoration: const BoxDecoration(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,

        titleSpacing: 0,
        // centerTitle: true,
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
            "KYC Verification",
            softWrap: true,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Productsans',
              fontSize: 20.sm,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            // Get.toNamed('/loadingpagekyc');
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const LoadingPageKYC()));
            //KYCDigilocker().storeKycDetails();
          },
          icon: Icon(
            Icons.close,
          ),
          iconSize: 22.sm,
          color: Color(0xFF6B6B6B),
        ),
      ),
      body: FutureBuilder(
        future: KYCDigilocker().generateRequestID(),
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
          return WebViewStack(controller: controller);
        },
      ),
    );
  }
}
