
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


 class LoadingPageCKYCCheck extends StatefulWidget {
   const LoadingPageCKYCCheck({Key? key}) : super(key: key);

   @override
   State<LoadingPageCKYCCheck> createState() => _LoadingPageCKYCCheckState();
 }


class _LoadingPageCKYCCheckState extends State<LoadingPageCKYCCheck> {
  Map<String, dynamic>? idno = {};
  @override
  void initState() {
    Map<String, dynamic> updata = Database().restorePanAndDob();
    idno = {"id_no": updata['pan_no']};
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: CKYCMethods().CkycCheck(idno!),
        builder: (ctx, snapshot) {
          if (snapshot.data == null) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Checking for CKYC"),
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
            if (CkycStatus!['status']) {
              Future.microtask(() => Get.offAllNamed('/digi_locker',
                  arguments: {"kra_ckyc_verified": true}));
            } else {
              print("else condition");
              Future.microtask(() => Get.offAllNamed('/digi_locker_start'));
            }
          }
          return _buildbody(
            context,
          );
        },
      ),
    );
  }



