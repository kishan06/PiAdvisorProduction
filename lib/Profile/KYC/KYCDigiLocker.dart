// ignore_for_file: file_names

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:piadvisory/Profile/KYC/CKYCpage.dart';
import 'package:piadvisory/Profile/KYC/CKYCpage2.dart';
import 'package:piadvisory/Profile/KYC/DigiLocker.dart';
import 'package:piadvisory/Profile/KYC/Repository/KYCDigilocker.dart';

import '/Common/CustomNextButton.dart';
import '/Common/app_bar.dart';
import '/Profile/KYC/FamilyDetails.dart';
import '/Profile/KYC/UploadPanCard.dart';
import '/Utils/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class KYCDigiLocker extends StatefulWidget {
  const KYCDigiLocker({Key? key}) : super(key: key);

  @override
  State<KYCDigiLocker> createState() => _KYCDigiLockerState();
}

class _KYCDigiLockerState extends State<KYCDigiLocker> {
  buildAllowCamerapopup() {
    return showDialog(
      context: context,
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AlertDialog(
            insetPadding: EdgeInsets.symmetric(vertical: 35, horizontal: 35),
            backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
            contentPadding: EdgeInsets.fromLTRB(24, 30, 24, 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              side: BorderSide(
                  color: Get.isDarkMode ? Colors.grey : Colors.white),
            ),
            // contentPadding:
            //     EdgeInsets.all(
            //         10),
            //   title: ,
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          child: Text(
                            textAlign: TextAlign.center,
                            "Please allow all app permissions",
                            style: blackStyle(context).copyWith(
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                                //fontWeight: FontWeight.bold,
                                fontSize: 18.sm),
                          ),
                        ),
                        Icon(
                          Icons.camera_alt_outlined,
                          size: 22,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: CustomNextButton(
                    text: "Continue",
                    ontap: () async {},
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const CustomAppBar(titleTxt: "Personal Profile", bottomtext: false),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            Text(
              "KYC Powered by Digilocker",
              style: Theme.of(context).textTheme.headline1,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "You will need your Aadhaar card linked to a mobile number to continue with Digilocker",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 199,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFF034698).withOpacity(0.05),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 27,
                    ),
                    SvgPicture.asset(
                      "assets/images/Layer 1.svg",
                      height: 32,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      "Why Digilocker?",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Text(
                      "Digilocker is a government initiative to store documents and certificates in a digital format. It is a safe and secure way to store and share documents. It is also a convenient way to access documents from any location.",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 93,
            ),
            // Text(
            //   "Haven't linked your Aadhaar to a mobile number?",
            //   style: Theme.of(context).textTheme.bodyText2,
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: ((context) => CKYCMain())));
            //   },
            //   child: Text(
            //     "Upload your documents manually",
            //     style: blackStyle(context).copyWith(
            //         fontSize: 20,
            //         decoration: TextDecoration.underline,
            //         color: const Color(
            //           0xFF008083,
            //         )),
            //   ),
            // ),
            const SizedBox(
              height: 70,
            ),
            SizedBox(
                height: 60,
                width: double.infinity,
                child: CustomNextButton(
                  text: "Proceed for KYC",
                  ontap: () async {
                    // KYCDigilocker().generateRequestID();
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const DigiLocker()));

                    // var status = await Permission.;
                    // if (status.isGranted) {
                    //   print("granted");
                    //   // We didn't ask for permission yet or the permission has been denied before but not permanently.
                    // }
                    Map<Permission, PermissionStatus> statuses = await [
                      Permission.camera,
                      Permission.storage,
                    ].request();
                    if (statuses[Permission.storage]!.isGranted &&
                        statuses[Permission.camera]!.isGranted) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DigiLocker()));
                    }
                  },
                )),
          ],
        ),
      )),
    );
  }
}
