class ApiConstant {
  static const String base = "https://app.piadvisors.in/";

  static const String basetesting = "https://pi.betadelivery.com/pi_advisors/";

  static const String loginAPI = base + 'api/loginv2';

  static const String registerUser = base + 'api/register';
  static const String registerNumber = base + 'api/registernumber';
  static const String verifyotp = base + 'api/verifyotp';
  static const String sendotp = base + 'api/otp';
  static const String sendotpExotel = base + 'api/exotelsms';
  static const String getVerifiedStatus = base + 'api/isverified';
  static const String getOtpVerifiedStatus = base + 'api/isotpverified';
  static const String securityQuestions = base + 'api/security_questions';
  static const String securityAnswers = base + 'api/security_answers';
  static const String security_first = base + 'api/user_pin';
  static const String getSecurity_Questions =
      base + 'api/isecurityquestionverified';
  static const String getPinexist = base + 'api/check_pin_exist';
  static const String getFingerPrintStatus = base + 'api/getfingerprint';
  static const String postFingerPrintStatus = base + 'api/fingerprintstatus';
  static const String postPinStatus = base + 'api/pin_match';
  static const String mobileExist = base + 'api/mobileExists';
  static const String postResetPassword = base + 'api/resetPassword';
  static const String verifyotpWithoutToken =
      base + 'api/verifyotpWithoutToken';
  static const String postforgotPin2 = base + 'api/resetPin';
  static const String createOrder = base + 'api/createorder';
  static const String postpaymentverification =
      base + 'api/payment_verification';
  static const String riskQuestions = base + 'api/getAllRiskQuestions';
  static const String riskAnswers = base + 'api/getUsersRiskProfile';

  static const String storekycdetails = base + 'api/storekycdetails';
  static const String storeTransactionDetails =
      base + 'api/storeTransactionDetails';

  static const String getUpdateStatus = base + 'api/fetchkycstatus';
  static const String storeUserRiskProfile = base + 'api/createUserRiskProfile';

  static const String poststorebasickycuserdetails =
      base + 'api/storebasickycuserdetails';

  static const String postStorePersonalprofile =
      base + 'api/storepersonalprofiledetails';
  static const String poststorebankdetails = base + 'api/storebankdetails';
  static const String poststoregoaldetails = base + 'api/storegoals';
  static const String getbasickycdetails = base + 'api/getbasickycuserdetails';
  static const String poststorefamilydetails = base + 'api/storefamilydetails';
  static const String getfamilydetails = base + 'api/getfamilydetails';
  static const String getpersonalprofiledetails =
      base + 'api/get_personal_profile_details';
  static const String getbankdetails = base + 'api/getBankDetails';
  static const String poststorebasicaddincomeDetails =
      base + 'api/store_incomeandexpense';
  static const String getbasicaddincomeDetails =
      base + 'api/getincomeandexpense';
  static const String poststorecontactusdetails = base + 'api/storeContactUs';
  static const String getUserStatus = base + 'api/fetchNewUserstatus';
  static const String fetchslotDetails = base + 'api/fetchSlotDetails';
  static const String appointmentDetails = base + 'api/storeAppointments';
  static const String fetchAppointments = base + 'api/fetchAppointments';

  static const String gethomepagepopup = base + 'api/fetchSubscriptionstatus';

  static const String fetchAppointmentsDate =
      base + 'api/fetchAppointmentsByDate';
  static const String getSubsDetail = base + 'api/getSubscriptionWithDetails';

  static const String updatestatus = base + 'api/updatestatus';

  static const String poststoreadvisordetails =
      base + 'api/storeContactAdvisor';

  static const String postchangepassword =
      base + 'api/change_password_after_login';

  static const String postchangepin = base + 'api/update_mpin';

  static const String getGoals = base + 'api/get_goals';
  static const String updateGoals = base + 'api/updateGoals';

  static const String deleteGoals = base + 'api/delete_goals';
  static const String checkGoals = base + 'api/check_goal';
  static const String deleteBank = base + 'api/delete_bank';
  static const String updateBank = base + 'api/update_bank';

  static const String postupdatefingerstatus = base + 'api/update_fingerprint';

  static const String endlogoForDigio =
      'https://app.piadvisors.in/images/pilogo.png&theme={"PRIMARY_COLOR":"#008083","SECONDARY_COLOR":"#f78104"}';

  static const String getabout = base + 'api/get_about_us';

  static const String getFAQS = base + 'api/faq_que_ans';

  static const String getgeneralqueries =
      base + 'api/security_questions'; //change api
  static const String getfeescharges =
      base + 'api/security_questions'; // change api
  static const String getinvestment =
      base + 'api/security_questions'; // change api
  static const String getplanning =
      base + 'api/security_questions'; // change api

  static const String live_indices = base + 'api/live_indices';

  static const String top_gainers_losers = base + 'api/top_gainers_losers';

  static const String top_losers = base + 'api/top_losers';

  static const String active_by_value = base + 'api/active_by_value';
  static const String active_by_volume = base + 'api/active_by_volume';

  static const String getblogs = base + 'api/fetch_blogs';

  static const String getlicense = base + 'api/get_license';
  static const String getPiRecom = base + 'api/get_manage_advisors';

  static const String postStoretellusabout =
      base + 'api/tell_us_about_yourself';

  static const String piImages =
      'https://pi.betadelivery.com/pi_advisors/public/uploads/';

  static const String gettellusabout = base + 'api/get_ur_about_yourself_data';
  static const String pirecommeded = base + 'api/get_manage_advisors';

  static const String postAssetsformMF = base + 'api/user_mutual_fund_detail';
  static const String postAssetsformFD = base + 'api/user_fix_deposit';
  static const String postAssetsformRE = base + 'api/user_real_estate';

  static const String postLiabiltiesformHL = base + 'api/user_home_loan_details';
  static const String postLiabiltiesformPL = base + 'api/user_personal_loan_details';
  static const String postLiabiltiesformCL = base + 'api/user_car_loan_details';
}
