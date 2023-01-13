import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lottie/lottie.dart';
import 'package:piadvisory/Profile/KYC/Repository/CKYCMethods.dart';
import 'package:piadvisory/Profile/KYC/Repository/KYCDigilocker.dart';
import '/Common/CustomNextButton.dart';
import '/Common/app_bar.dart';
import '/Profile/KYC/FamilyDetails.dart';
import '/Profile/KYC/UploadPanCard.dart';
import '/Utils/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoadingPageCKYCCheck extends StatefulWidget {
  const LoadingPageCKYCCheck({Key? key}) : super(key: key);

  @override
  State<LoadingPageCKYCCheck> createState() => _LoadingPageCKYCCheckState();
}

class _LoadingPageCKYCCheckState extends State<LoadingPageCKYCCheck> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: CKYCMethods().CkycCheck(updata),
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
            if (kycStatus['status'] == "approval_pending") {
              Future.microtask(() => Get.offAllNamed('/familydetails'));
            } else if (kycStatus['status'] == "requested") {
              Future.microtask(() => Get.offAllNamed('/profile'));
            } else {
              Future.microtask(() => Get.offAllNamed('/familydetails'));
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
