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
    }
  }
}
