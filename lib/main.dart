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

import 'package:piadvisory/Profile/CustomRiskAssessment.dart';

import 'package:piadvisory/Profile/KYC/AddIncomeAndExpense.dart';
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
import 'package:piadvisory/mainnavigation.dart';
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
import 'package:get_storage/get_storage.dart';

import 'package:get/get.dart';
import 'package:piadvisory/themedata.dart';
import 'package:scgateway_flutter_plugin/scgateway_flutter_plugin.dart';

import 'Login/login.dart';
import 'Login/splash.dart';
import 'Profile/KYC/KYCMain.dart';

int bottomIndex = 0;


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
  final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // ConnectivityController connectivityController =
    //   Get.put(ConnectivityController());
    return
      // StreamProvider<ConnectivityStatus>.value(
      // initialData: ConnectivityStatus.Cellular,
      // value: ConnectivityService().connectionStatusController.stream,
      //child :
      StreamProvider<ConnectivityStatus>.value(
          value: ConnectivityService().connectionStatusController.stream,
          initialData:  ConnectivityStatus.Cellular,
          child: MaterialApp(
             debugShowCheckedModeBanner: false,
            home: NetworkSensitive(
              scaffoldKey: _scaffoldKey,
                child: MainNavigation()),
          ));
   // );
  }
}

  