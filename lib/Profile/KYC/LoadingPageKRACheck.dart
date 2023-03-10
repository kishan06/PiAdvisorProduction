import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lottie/lottie.dart';
import 'package:piadvisory/Profile/KYC/Repository/CKYCMethods.dart';
import 'package:piadvisory/Profile/KYC/Repository/KYCDigilocker.dart';
import 'package:piadvisory/Utils/database.dart';
import '/Common/CustomNextButton.dart';
import '/Common/app_bar.dart';
import '/Profile/KYC/FamilyDetails.dart';
import '/Profile/KYC/UploadPanCard.dart';
import '/Utils/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoadingPageKRACheck extends StatefulWidget {
  const LoadingPageKRACheck({Key? key}) : super(key: key);

  @override
  State<LoadingPageKRACheck> createState() => _LoadingPageKRACheckState();
}

class _LoadingPageKRACheckState extends State<LoadingPageKRACheck> {
  Map<String, dynamic>? updata = {};
  @override
  void initState() {
    updata = Database().restorePanAndDob();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: CKYCMethods().KRACheck(updata!),
        builder: (ctx, snapshot) {
          if (snapshot.data == null) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Checking for KRA"),
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
            if (kraStatus?['status'] == "KRA Verified") {
              Future.microtask(() => Get.offAllNamed('/digi_locker',
                  arguments: {"kra_ckyc_verified": true}));
            } else {
              Future.microtask(() => Get.offAllNamed('/loading_ckyc'));
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
    return Container();
  }
}
