import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:month_year_picker/month_year_picker.dart';

import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:piadvisory/Common/SubscriptionLoadingPage.dart';
import 'package:piadvisory/Common/ThankYouPage.dart';
import 'package:piadvisory/Common/connectivity.dart';
import 'package:piadvisory/Common/sfCalendarView.dart';

import 'package:piadvisory/HomePage/Homepage.dart';
import 'package:piadvisory/HomePage/Notifications/Notification.dart';
import 'package:piadvisory/HomePage/Stock/StockGraph.dart';
import 'package:piadvisory/Login/ForgotOTP.dart';
import 'package:piadvisory/Login/ForgotPassword.dart';
import 'package:piadvisory/Login/Repository/Resetpassword.dart';
import 'package:piadvisory/Login/ResetPassword.dart';
import 'package:piadvisory/Login/SplashSlider.dart';
import 'package:piadvisory/Login/forgotPIN2.dart';
import 'package:piadvisory/Login/pindialog.dart';
import 'package:piadvisory/PaymentSuccess.dart';
import 'package:piadvisory/Profile/AddBankDetails.dart';

import 'package:piadvisory/Profile/CustomRiskAssessment.dart';

import 'package:piadvisory/Profile/KYC/AddIncomeAndExpense.dart';
import 'package:piadvisory/Profile/KYC/FamilyDetails.dart';
import 'package:piadvisory/Profile/KYC/KYCthankyou.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:piadvisory/Profile/KYC/Repository/LoadingPageKYC.dart';
import 'package:piadvisory/Profile/KYC/SchduleAppointment.dart';

import 'package:piadvisory/Profile/KYC/SelectTimeAndDate.dart';
import 'package:piadvisory/Profile/PersonalProfile.dart';
import 'package:piadvisory/Profile/Personalprofilerepository/Model/familybasicdetails.dart';
import 'package:piadvisory/Profile/add-goal.dart';
import 'package:piadvisory/SideMenu/CartPi.dart';
import 'package:piadvisory/SideMenu/CartPi2.dart';
import 'package:piadvisory/Utils/database.dart';
import 'package:piadvisory/payment-failed.dart';
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
import 'package:get_storage/get_storage.dart';

import 'package:get/get.dart';
import 'package:piadvisory/themedata.dart';
import 'package:scgateway_flutter_plugin/scgateway_flutter_plugin.dart';

import 'Login/login.dart';
import 'Login/splash.dart';
import 'Profile/KYC/KYCMain.dart';

AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'msg_channel', // id
    'High Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  //WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();
  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);

    var swAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
    var swInterceptAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);

    if (swAvailable && swInterceptAvailable) {
      AndroidServiceWorkerController serviceWorkerController =
          AndroidServiceWorkerController.instance();

      await serviceWorkerController
          .setServiceWorkerClient(AndroidServiceWorkerClient(
        shouldInterceptRequest: (request) async {
          print(request);
          return null;
        },
      ));
    }
  }

  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
  await Get.put(Database()).initStorage();

  //smallcase
  ScgatewayFlutterPlugin.setConfigEnvironment(
    GatewayEnvironment.PRODUCTION,
    'pi-advisors',
    false,
    [],
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(MyApp()));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Razorpay _razorpay = Razorpay();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ConnectivityController connectivityController =
      Get.put(ConnectivityController());
    return ScreenUtilInit(
      builder: (BuildContext context, Widget? child) => GetMaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          MonthYearPickerLocalizations.delegate
        ],
        // darkTheme: AppTheme.dark(),
        // themeMode: ThemeServices().theme,
        theme: AppTheme.light(),
        debugShowCheckedModeBanner: false,
        title: 'PI Advisor',
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
          GetPage(name: '/stock_graph', page: () => StockGraph())
        ],
      ),
      designSize: Size(390, 844),
    );
  }
}
