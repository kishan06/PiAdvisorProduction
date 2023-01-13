import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:piadvisory/Common/CustomTextFormFields.dart';
import 'package:piadvisory/Profile/KYC/CKYCpage2.dart';
import 'package:piadvisory/Profile/KYC/Repository/storebasickycuserdetails.dart';
import 'package:piadvisory/Profile/KYC/proofIdentity.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../Utils/base_manager.dart';
import '/Common/CustomNextButton.dart';
import '/Profile/KYC/KYCDigiLocker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/Utils/Dialogs.dart';
import '../../Common/app_bar.dart';
import '../../Utils/textStyles.dart';

class CKYC2 extends StatefulWidget {
  const CKYC2({Key? key}) : super(key: key);

  @override
  State<CKYC2> createState() => _CKYC2State();
}

class _CKYC2State extends State<CKYC2> {
  
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController residence = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController countrycode = TextEditingController();
  TextEditingController taxidentification = TextEditingController();
  TextEditingController place = TextEditingController();
  TextEditingController birth = TextEditingController();
  TextEditingController address = TextEditingController();
  
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titleTxt: "CKYC", bottomtext: true, ),
      body:  SingleChildScrollView(
        child:
        //  Column(
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //      Text(
              
        //           "Steps to check for Clients other than Resident Individual ",
        //           style: Theme.of(context).textTheme.headline5,
                  
        //           //  blackStyle(context).copyWith(
        //           //   fontSize: 16.sm,
        //           //   fontWeight: FontWeight.w600,
        //           // ),
        //         ),     
              Padding(
              padding: const EdgeInsets.only(
              top: 30,
              left: 20,
              right: 20,
              ),
               child: Form(
              key: _form,
               child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Residence for Tax Purposes in Jurisdiction(s) Outside India (FATCA/CRS information) ",
                  style: Theme.of(context).textTheme.headline2,
                 // textAlign: TextAlign.center
                  //  blackStyle(context).copyWith(
                  //   fontSize: 16.sm,
                  //   fontWeight: FontWeight.w600,
                  // ),
                ),
                const SizedBox(
                 height: 11,
                ),
                CustomTextFormField(
                controller: residence,
                 hint: "Answer",
                 errortext: "Enter Answer",
                 ),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  "Country of Jurisdiction of Residence",
                  style: Theme.of(context).textTheme.headline2,
                ),
                const SizedBox(
                 height: 11,
                ),
                CustomTextFormField(
                controller: country,
                 hint: "Answer",
                 errortext: "Enter Country of Jurisdiction",
                 ),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  "Country Code of Jurisdiction of Residence",
                  style: Theme.of(context).textTheme.headline2,
                ),
                const SizedBox(
                 height: 11,
                ),
                CustomTextFormField(
                controller: countrycode,
                 hint: "Answer",
                 errortext: "Enter Country Code of Jurisdiction",
                 ),
                SizedBox(
                  height: 30.h,
                ),
                 Text(
                  "Tax Identification Number or equivalent (if issued by jurisdiction)",
                  style: Theme.of(context).textTheme.headline2,
                ),
                const SizedBox(
                 height: 11,
                ),
                CustomTextFormField(
                controller: taxidentification,
                 hint: "Answer",
                 errortext: "Enter Tax Identification Number",
                 ),
                 SizedBox(
                  height: 30.h,
                ),
                Text(
                  "Place / City of Birth",
                  style: Theme.of(context).textTheme.headline2,
                ),
                const SizedBox(
                 height: 11,
                ),
                CustomTextFormField(
                controller: place,
                 hint: "Answer",
                 errortext: "Enter Place/City of Birth ",
                 ),
                 SizedBox(
                  height: 30.h,
                ),
                Text(
                  "Country of Birth",
                  style: Theme.of(context).textTheme.headline2,
                ),
                const SizedBox(
                 height: 11,
                ),
                CustomTextFormField(
                controller: birth,
                 hint: "Answer",
                 errortext: "Enter Country of Birth",
                 ),
                 SizedBox(
                  height: 30.h,
                ),
                 Text(
                  "Address",
                  style: Theme.of(context).textTheme.headline2,
                ),
                const SizedBox(
                 height: 11,
                ),
                CustomTextFormField( maxlines: 4,
                controller: address,
                 hint: "Answer",
                 errortext: "Enter Address",
                 ),
                 SizedBox(
                  height: 40.h,
                ),
                SizedBox(
                  width: double.infinity,
                  child: CustomNextButton(
                    form: _form,
                      text: "Continue",
                      ontap: () {
                          final isValid = _form.currentState?.validate();
                             if (isValid!) {
                      Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProofIdentity()
                                )
                                );
                    } else {}    
                    }
                    ),
                ),
                 SizedBox(
                  height: 50.h,
                ),
                ],
               ),
              ),
             ),
           //],
         //),
    ),
    );
  }
}


