import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:piadvisory/Common/ConnectivityService.dart';
import 'package:piadvisory/Common/NetworkSensitive.dart';
import 'package:piadvisory/Common/SubscriptionLoadingPage.dart';
import 'package:piadvisory/Common/ThankYouPage.dart';
import 'package:piadvisory/HomePage/Homepage.dart';
import 'package:piadvisory/HomePage/Notifications/Notification.dart';
import 'package:piadvisory/HomePage/Stock/StockGraph.dart';
import 'package:piadvisory/Login/ForgotOTP.dart';
import 'package:piadvisory/Login/ForgotPassword.dart';
import 'package:piadvisory/Login/ResetPassword.dart';
import 'package:piadvisory/Login/SplashSlider.dart';
import 'package:piadvisory/Login/forgotPIN2.dart';
import 'package:piadvisory/Login/pindialog.dart';
import 'package:piadvisory/PaymentSuccess.dart';
import 'package:piadvisory/Profile/AddBankDetails.dart';
import 'package:piadvisory/Profile/Assets/Fixdeposit.dart';
import 'package:piadvisory/Profile/Assets/Mutualfund.dart';
import 'package:piadvisory/Profile/Assets/Realestate.dart';
import 'package:piadvisory/Profile/KYC/DigiLocker.dart';
import 'package:piadvisory/Profile/KYC/FamilyDetails.dart';
import 'package:piadvisory/Profile/KYC/KYCDigiLocker.dart';
import 'package:piadvisory/Profile/KYC/KYCthankyou.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:piadvisory/Profile/KYC/LoadingPageCKYCCheck.dart';
import 'package:piadvisory/Profile/KYC/LoadingPageKRACheck.dart';

import 'package:piadvisory/Profile/KYC/Repository/LoadingPageKYC.dart';
import 'package:piadvisory/Profile/KYC/SchduleAppointment.dart';

import 'package:piadvisory/Profile/KYC/SelectTimeAndDate.dart';
import 'package:piadvisory/Profile/Liabilities/CarLoan.dart';
import 'package:piadvisory/Profile/Liabilities/Homeloan.dart';
import 'package:piadvisory/Profile/Liabilities/PersonalLoan.dart';
import 'package:piadvisory/Profile/PersonalProfile.dart';
import 'package:piadvisory/Profile/Personalprofilerepository/Model/familybasicdetails.dart';
import 'package:piadvisory/Profile/add-goal.dart';
import 'package:piadvisory/SideMenu/CartPi.dart';
import 'package:piadvisory/SideMenu/CartPi2.dart';
import 'package:piadvisory/Utils/database.dart';
import 'package:piadvisory/payment-failed.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:piadvisory/Profile/ProfileMain.dart';
import 'package:piadvisory/SideMenu/Subscribe/Mysubscription.dart';
import 'package:piadvisory/Signup/PhoneVerification.dart';
import 'package:piadvisory/Signup/SecurityFirst.dart';
import 'package:piadvisory/Signup/SecurityQuestions.dart';
import 'package:piadvisory/Signup/SignupPage.dart';
import 'package:piadvisory/Signup/VerifyPhoneNumber.dart';
import 'package:piadvisory/Signup/otpPhoneVerification.dart';
import 'package:piadvisory/Signup/touch_id.dart';

import 'package:get/get.dart';
import 'package:piadvisory/themedata.dart';

import 'Login/login.dart';
import 'Login/splash.dart';
import 'Profile/KYC/KYCMain.dart';

class MainNavigation extends StatefulWidget {

  @override
  State<MainNavigation> createState() => _MainNavigation();
}

class _MainNavigation extends State<MainNavigation>{
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (BuildContext context, Widget? child) => GetMaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
          MonthYearPickerLocalizations.delegate
        ],
        // darkTheme: AppTheme.dark(),
        // themeMode: ThemeServices().theme,
        theme: AppTheme.light(),
        debugShowCheckedModeBanner: false,
        title: 'Pi',
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => Splash()),
          GetPage(name: '/pindialog', page: () => PinDialog()),
          GetPage(name: '/login', page: () => Login()),
          GetPage(name: '/home', page: () => HomePage()),
          GetPage(name: '/splashslider', page: () => Splashslider()),
          GetPage(name: '/phoneverification', page: () => PhoneVerification()),
          GetPage(name: '/forgotpassword', page: () => ForgotPassword()),
          GetPage(name: '/signupforfree', page: () => VerifyPhoneNumber()),
          GetPage(name: '/resetPassword', page: () => ResetPassword()),
          GetPage(name: '/forgototp', page: () => ForgotOTP()),
          GetPage(
              name: '/RegistrationOTPverification',
              page: () => otpPhoneVerification()),
          GetPage(name: '/signup2', page: () => SignUpPage()),
          GetPage(name: '/security_questions', page: () => SecurityQuestions()),
          GetPage(name: '/security_first', page: () => SecurityFirst()),
          GetPage(name: '/notification', page: () => Notify()),
          GetPage(name: '/profile', page: () => ProfileMain()),
          GetPage(name: '/touchid', page: () => TouchId()),
          GetPage(name: '/forgotpin2', page: () => ForgotPIN2()),
          GetPage(name: '/mysubscription', page: () => Mysubscription()),
          GetPage(name: '/paymentsuccessfull', page: () => PaymentSuccess()),
          GetPage(name: '/paymentfailed', page: () => PaymentFailed()),
          GetPage(
              name: '/select_time_and_date', page: () => SelectTimeAndDate()),
          GetPage(name: '/kycmain', page: () => KYCMain()),
          GetPage(name: '/familydetails', page: () => FamilyDetails()),
          GetPage(name: '/loadingpagekyc', page: () => LoadingPageKYC()),
          GetPage(name: '/thankyou', page: () => ThankYouPage()),
          GetPage(name: '/KYCThankyou', page: () => KYCThankYouPage()),
          GetPage(
              name: '/schduleAppointment', page: () => SchduleAppointment()),
          GetPage(name: '/personalProfile', page: () => PersonalProfile()),
          GetPage(name: '/addgoals', page: () => AddGoals()),
          GetPage(name: '/addBankDetails', page: () => AddBankDetails()),
          GetPage(
              name: '/subscription_loading_page',
              page: () => SubscriptionLoadingPage()),
          GetPage(name: '/cartpi', page: () => CartPI()),
          GetPage(name: '/cartpi2', page: () => CartPI2()),
          GetPage(name: '/stock_graph', page: () => StockGraph()),
          GetPage(name: '/loading_kra', page: () => LoadingPageKRACheck()),
          GetPage(name: '/loading_ckyc', page: () => LoadingPageCKYCCheck()),
          GetPage(name: '/digi_locker', page: () => DigiLocker()),
          GetPage(name: '/digi_locker_start', page: () => KYCDigiLocker()),

          GetPage(name: '/editMutualfund', page: () => Mutualfund()),
          GetPage(name: '/editFixdeposit', page: () => FixDeposit()),
          GetPage(name: '/editRealestate', page: () => RealEstate()),
          GetPage(name: '/editHomeloan', page: () => Homeloan()),
          GetPage(name: '/editPersonalloan', page: () => PersonalLoan()),
          GetPage(name: '/editCarloan', page: () => CarLoan()),
        ],


      ),
      designSize: Size(390, 844),
    );
  }

}