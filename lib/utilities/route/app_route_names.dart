enum AppRoute {
  splash,
  welcome,
  bottomNavigation,
  signUp,
  signIn,
  editProfile,
  workerVerificationScreen,
  forgotPassword,
  notification,
  filterData,
  bookingFormScreen,
  userProfile,
  personalInfoEdit,
  inReg,
  userScreenLog,
  allAdsScreen,
  workerPaymentMethod,
  userPaymentMethod,
  addPaymentMethod,
  userAddresses,
  addressHolder,
  updatePasswordScreen,
  settingsScreen,
  securityScreen,
  updateEmailScreen,
  updatePhoneScreen,
}

extension AppRouteNamesExtension on AppRoute {
  String get path {
    switch (this) {
      case AppRoute.splash:
        return '/splash';
      case AppRoute.welcome:
        return '/welcome';
      case AppRoute.bottomNavigation:
        return "/bottomNavigation";
      case AppRoute.signUp:
        return "/signUp";
      case AppRoute.signIn:
        return "/signIn";
      case AppRoute.editProfile:
        return "/editProfile";
      case AppRoute.workerVerificationScreen:
        return "/workerVerificationScreen";
      case AppRoute.forgotPassword:
        return "/forgotPassword";
      case AppRoute.notification:
        return "/notification";
      case AppRoute.filterData:
        return "/filterData";
      case AppRoute.bookingFormScreen:
        return "/bookingFormScreen";
      case AppRoute.userProfile:
        return "/userProfile";
      case AppRoute.personalInfoEdit:
        return "/personalInfoEdit";
      case AppRoute.inReg:
        return "/inReg";
      case AppRoute.userScreenLog:
        return "/userScreenLog";
      case AppRoute.allAdsScreen:
        return "/allAdsScreen";
      case AppRoute.userPaymentMethod:
        return "/userPaymentScreen";
      case AppRoute.workerPaymentMethod:
        return "/workerPaymentScreen";
      case AppRoute.addPaymentMethod:
        return "/addPaymentMethod";
      case AppRoute.userAddresses:
        return "/userAddresses";
      case AppRoute.addressHolder:
        return "/addressHolder";
      case AppRoute.updatePasswordScreen:
        return "/updatePasswordScreen";
      case AppRoute.settingsScreen:
        return "/settingsScreen";
      case AppRoute.securityScreen:
        return "/securityScreen";
      case AppRoute.updateEmailScreen:
        return "/updateEmailScreen";
      case AppRoute.updatePhoneScreen:
        return "/updatePhoneScreen";
    }
  }
}
